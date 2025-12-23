import 'dart:async';
import 'dart:math';

import 'package:aladdin_franchise/generated/l10n.dart';
import 'package:aladdin_franchise/src/configs/app.dart';
import 'package:aladdin_franchise/src/core/network/api/app_exception.dart';
import 'package:aladdin_franchise/src/core/network/repository/order/order_repository.dart';
import 'package:aladdin_franchise/src/core/network/provider.dart';
import 'package:aladdin_franchise/src/core/network/repository/responses/data_bill.dart';
import 'package:aladdin_franchise/src/core/services/print_queue.dart';
import 'package:aladdin_franchise/src/data/enum/receipt_type.dart';
import 'package:aladdin_franchise/src/features/dialogs/confirm_action.dart';
import 'package:aladdin_franchise/src/features/dialogs/message.dart';
import 'package:aladdin_franchise/src/features/dialogs/payment/edit_tax_dialog.dart';
import 'package:aladdin_franchise/src/features/dialogs/payment/payment_method_dialog.dart';
import 'package:aladdin_franchise/src/features/pages/home/provider.dart';
import 'package:aladdin_franchise/src/features/pages/home/state.dart';
import 'package:aladdin_franchise/src/models/data_bill.dart';
import 'package:aladdin_franchise/src/models/employee_sale.dart';
import 'package:aladdin_franchise/src/models/history_order.dart';
import 'package:aladdin_franchise/src/models/ip_order.dart';
import 'package:aladdin_franchise/src/models/order.dart';
import 'package:aladdin_franchise/src/models/payment_method/payment_method.dart';
import 'package:aladdin_franchise/src/models/policy_result.dart';
import 'package:aladdin_franchise/src/models/product.dart';
import 'package:aladdin_franchise/src/models/product_checkout.dart';
import 'package:aladdin_franchise/src/utils/app_log.dart';
import 'package:aladdin_franchise/src/utils/app_printer/app_printer_common.dart';
import 'package:aladdin_franchise/src/utils/app_printer/app_printer_html.dart';
import 'package:aladdin_franchise/src/utils/date_time.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'state.dart';

final historyOrderPageProvider =
    StateNotifierProvider.autoDispose<HistoryOrderNotifier, HistoryOrderState>((ref) {
  return HistoryOrderNotifier(ref, ref.read(orderRepositoryProvider));
});

class HistoryOrderNotifier extends StateNotifier<HistoryOrderState> {
  HistoryOrderNotifier(this.ref, this._orderRepository)
      : super(HistoryOrderState(
          startDate: DateTime.now().onlyDate(),
          endDate: DateTime.now().onlyDate(),
        ));
  final Ref ref;
  final OrderRepository _orderRepository;

  List<ProductModel> onlineProducts = [];
  List<ProductModel> offlineProducts = [];

  Future<void> onChangeHistoryOrderSelect(HistoryOrderModel? order) async {
    state = state.copyWith(
      historyOrderSelect: order,
      coupons: [],
      customer: null,
      productCheckout: [],
      dataBill: null,
    );
  }

  Future<({String? error, bool refreshData})> printBillForCustomer(BuildContext context,
      {bool completeBillAction = false}) async {
    String? error;
    bool refreshData = false;
    try {
      state = state.copyWith(
          event: completeBillAction ? HistoryOrderEvent.completeBill : HistoryOrderEvent.printBill);
      var historyOrderSelect = state.historyOrderSelect;
      if (historyOrderSelect == null) {
        throw S.current.msg_select_order_before_print_receipt;
      }
      bool requireCompleteBill = historyOrderSelect.status == OrderStatusEnum.waiting;
      bool isOnline = historyOrderSelect.orderType == AppConfig.orderOnlineValue;
      var order = orderSelect;
      if (order == null) {
        state = state.copyWith(event: HistoryOrderEvent.normal);
        return (error: null, refreshData: refreshData);
      }

      var printBillResult = false;
      int retry = 0;

      List<PaymentMethod> listPaymentMethods = [];

      while (retry < 3) {
        try {
          var dataBill = await _getDataBill(orderId: order.id);
          if (dataBill.error != null) {
            throw dataBill.error!;
          }

          List<LineItemDataBill> itemsPrint = List<LineItemDataBill>.from(dataBill.itemsPrint);

          PriceDataBill price = dataBill.price;

          var infoPrinter = dataBill.infoPrinter;
          var orderPrint = dataBill.order;
          var portrait = dataBill.portrait;
          if (infoPrinter == null) {
            throw 'Không có thông tin máy in';
          }
          if (orderPrint == null) {
            throw 'Không có thông tin in';
          }

          PaymentMethod? paymentMethodSelect = dataBill.paymentMethod;
          double paymentAmount = max(-1.0, dataBill.paymentAmount);

          if (paymentMethodSelect == null) {
            throw 'Không thể tìm thấy phương thức thanh toán đã tạm tính với đơn bàn này';
          }

          /// chỉnh sửa thuế
          if (paymentAmount == -1.0 || (isOnline && requireCompleteBill)) {
            var _count = 0;
            String? errorGetPaymentMethods;
            while (_count < 3) {
              try {
                if (listPaymentMethods.isEmpty) {
                  var pm = await ref.read(restaurantRepositoryProvider).getPaymentMethod(
                        orderId: order.id,
                      );
                  if (!pm.isSuccess) {
                    throw AppException(
                      statusCode: pm.statusCode,
                      message: pm.error,
                    );
                  }
                  listPaymentMethods = pm.data ?? [];
                }
                errorGetPaymentMethods = null;
                break;
              } catch (ex) {
                _count++;
                errorGetPaymentMethods = ex.toString();
              }
            }

            if (errorGetPaymentMethods != null) {
              throw 'Không thể tải danh sách phương thức thanh toán';
            }
            paymentMethodSelect =
                listPaymentMethods.firstWhereOrNull((e) => e.key == paymentMethodSelect?.key);
          }

          if (paymentMethodSelect == null) {
            throw 'Không thể tìm thấy phương thức thanh toán đã tạm tính với đơn bàn này';
          }

          if (paymentAmount == -1.0) {
            if (paymentMethodSelect.isGateway) {
              paymentAmount = 0.0;
            } else {
              paymentAmount = double.tryParse(price.totalPriceFinal.toString()) ?? 0.0;
            }
          }

          if (requireCompleteBill) {
            var homeState = ref.read(homeProvider);
            List<ProductModel> products = [];
            if (isOnline) {
              if (kTypeOrder == AppConfig.orderOnlineValue &&
                  homeState.productsState.status == PageCommonState.success) {
                onlineProducts = List<ProductModel>.from(homeState.products);
              } else {
                if (onlineProducts.isEmpty) {
                  int retry = 0;
                  while (retry < 3) {
                    try {
                      var res = await ref
                          .read(menuRepositoryProvider)
                          .getProduct(null, typeOrder: AppConfig.orderOnlineValue);
                      onlineProducts = List<ProductModel>.from(res.data ?? []);
                      break;
                    } catch (ex) {
                      retry++;
                    }
                  }
                }

                if (onlineProducts.isEmpty) {
                  throw 'Không có thông tin món mang về!';
                }
              }
              products = List<ProductModel>.from(onlineProducts);
            } else {
              if (kTypeOrder == AppConfig.orderOfflineValue &&
                  homeState.productsState.status == PageCommonState.success) {
                offlineProducts = List<ProductModel>.from(homeState.products);
              } else {
                if (offlineProducts.isEmpty) {
                  int retry = 0;
                  while (retry < 3) {
                    try {
                      var res = await ref
                          .read(menuRepositoryProvider)
                          .getProduct(null, typeOrder: AppConfig.orderOfflineValue);
                      offlineProducts = List<ProductModel>.from(res.data ?? []);
                      break;
                    } catch (ex) {
                      retry++;
                    }
                  }
                }

                if (offlineProducts.isEmpty) {
                  throw 'Không có thông tin món bán tại nhà hàng!';
                }
              }
              products = List<ProductModel>.from(offlineProducts);
            }
            var checkTax = _checkValidTaxItemsPrint(
              requireUpdateTax: paymentMethodSelect.requireEditTax,
              itemsPrint: itemsPrint,
              products: products,
            );
            var tax = Map<int, Map<String, dynamic>>.from(checkTax.tax);

            if (!checkTax.valid) {
              // dialog sửa thuế
              if (context.mounted) {
                List<ProductCheckoutModel> productCheckouts = [];
                for (var e in itemsPrint) {
                  if (tax[e.id] != null) {
                    productCheckouts.add(ProductCheckoutModel(
                      id: e.id,
                      name: e.name,
                      nameEn: e.nameEn,
                      quantity: e.count,
                      unit: e.unit,
                      codeProduct: e.codeProduct,
                      tax: e.getTax1(),
                      unitPrice: e.price.toString(),
                      totalOrdered: e.count * (double.tryParse(e.price.toString()) ?? 0),
                    ));
                  }
                }

                bool editTax = false;

                var taxDialog = await showConfirmActionWithChild(
                  context,
                  noTitle: true,
                  title: '',
                  closeDialog: true,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: EditTaxDialog(
                        products: products,
                        productCheckouts: productCheckouts,
                        onSave: (List<ProductCheckoutModel> changedPc) {
                          productCheckouts = changedPc;
                        }),
                  ),
                  onCheckAction: () {
                    var check = true;
                    List<ProductCheckoutModel> pcMustDefaultTax = [];
                    List<ProductCheckoutModel> pcMustChangeTax = [];
                    for (var pc in productCheckouts) {
                      var taxProduct = tax[pc.id];
                      var useDefault = (taxProduct?['use_default'] ?? false) as bool;
                      var valueDefault = (taxProduct?['default'] ?? 0.0) as double;

                      if (useDefault) {
                        if (pc.tax != valueDefault) {
                          check = false;
                          pcMustDefaultTax.add(pc);
                        }
                      } else {
                        if (pc.tax == 0 && (paymentMethodSelect?.requireEditTax ?? false)) {
                          check = false;
                          pcMustChangeTax.add(pc);
                        }
                      }
                    }
                    if (!check) {
                      showMessageDialog(
                        context,
                        canPop: false,
                        message:
                            '${pcMustDefaultTax.isNotEmpty ? 'Các món ${pcMustDefaultTax.map((e) => e.name).join(', ')} không được phép sửa thuế. Hãy chọn về thuế mặc định của món!\n' : ''}'
                            '${pcMustChangeTax.isNotEmpty ? 'Các món ${pcMustChangeTax.map((e) => e.name).join(', ')} bắt buộc phải sửa thuế # 0.' : ''}',
                      );
                      return false;
                    }

                    return check;
                  },
                  action: () async {},
                  actionCancel: () {
                    editTax = false;
                  },
                  actionTitle: 'Cập nhật',
                );
                if (!(taxDialog ?? false)) {
                  state = state.copyWith(event: HistoryOrderEvent.normal);
                  return (error: null, refreshData: refreshData);
                }

                var resultUpdateTax = await updateTax(
                  paymentMethod: paymentMethodSelect,
                  item: productCheckouts,
                  order: order,
                );
                if (resultUpdateTax.error != null) {
                  state = state.copyWith(event: HistoryOrderEvent.normal);

                  return (
                    error: 'Chỉnh sửa thuế không thành công\n${resultUpdateTax.error}',
                    refreshData: refreshData
                  );
                } else {
                  refreshData = true;
                  editTax = true;
                }
                if (!editTax) {
                  state = state.copyWith(event: HistoryOrderEvent.normal);
                  return (error: null, refreshData: refreshData);
                }

                itemsPrint = [];
                dataBill = await _getDataBill(orderId: order.id);
                if (dataBill.error != null) {
                  throw dataBill.error!;
                }

                itemsPrint = List<LineItemDataBill>.from(dataBill.itemsPrint);

                price = dataBill.price;

                infoPrinter = dataBill.infoPrinter;
                orderPrint = dataBill.order;
                portrait = dataBill.portrait;
                if (infoPrinter == null) {
                  throw 'Không có thông tin máy in';
                }
                if (orderPrint == null) {
                  throw 'Không có thông tin in';
                }
              }
            }

            var checkItemBeforePrint = checkItemBeforeCompleteBill(
              orderLineItems: itemsPrint,
              paymentMethodSelect: paymentMethodSelect,
            );
            showLogs(checkItemBeforePrint, flags: 'checkItemBeforePrint');
            if (checkItemBeforePrint != null) {
              state = state.copyWith(event: HistoryOrderEvent.normal);

              return (
                error: '$checkItemBeforePrint\n'
                    'Vui lòng mở web thu ngân, chuyển trạng thái đơn bàn này sang "Đang xử lý"'
                    ' để có thể thay đổi danh sách món!',
                refreshData: refreshData
              );
            }
          }

          if (requireCompleteBill) {
            await _orderRepository.completeBill(
                order: order,
                description: dataBill.description,
                isPrintPeople: orderPrint.isPrintPeople ? 1 : 0,
                amountAdult: orderPrint.amountAdult,
                amountChildren: orderPrint.amountChildren,
                portrait: portrait,
                totalPrice: price.totalPrice,
                totalPriceTax: price.totalPriceTax,
                totalPriceVoucher: price.totalPriceVoucher,
                totalPriceFinal: price.totalPriceFinal,
                eSaleName: '',
                eSaleCode: '',
                arrMethod: ['${paymentMethodSelect.key}--$paymentAmount']);
            if (requireCompleteBill) {
              refreshData = true;
            }
          }
          String? resPrint;
          try {
            var check = await AppPrinterCommon.checkPrinter(
                IpOrderModel(ip: infoPrinter.ip, port: infoPrinter.port, type: 1));
            if (check != null) {
              throw check;
            }

            PrintQueue.instance.addTask(
              ip: infoPrinter.ip,
              port: infoPrinter.port,
              buildReceipt: (generator) async {
                List<int> bytes = [];
                List<LineItemDataBill> _itemsPrint = [];
                try {
                  for (var e in itemsPrint) {
                    _itemsPrint.add(LineItemDataBill(
                      name: e.name,
                      price: e.price,
                      tax: e.tax,
                      unit: e.unit,
                      count: e.count,
                    ));
                    if (e.listItem.isNotEmpty) {
                      for (var item in e.listItem) {
                        _itemsPrint.add(LineItemDataBill(
                          name: ' - ${item.name}',
                          price: '0',
                          tax: '0',
                          unit: '',
                          count: 0,
                        ));
                      }
                    }
                  }
                  bytes = await AppPrinterHtmlUtils.instance.getReceptBillContent(
                    order: order,
                    price: price,
                    receiptType: ReceiptTypeEnum.paymentReceipt,
                    paymentMethod: paymentMethodSelect,
                    paymentAmount: paymentAmount,
                    numberPrintCompleted: (orderPrint?.numberPrintCompleted ?? 0) + 1,
                    numberPrintTemporary: (orderPrint?.numberPrintTemporary ?? 0) + 1,
                    orderLineItems: _itemsPrint,
                    vouchers: dataBill.vouchers,
                    note: dataBill.description,
                    printNumberOfPeople: orderPrint?.isPrintPeople ?? false,
                    customerPhone: orderPrint?.phoneNumber ?? '',
                    numberOfPeople: orderPrint?.amountPeople ?? 0,
                    cashierCompleted: orderPrint?.cashierCompleted ?? '',
                    cashierPrint: orderPrint?.cashierPrint ?? '',
                    timeCompleted: orderPrint?.timeCompleted,
                    timeCreatedAt: orderPrint?.createdAt,
                    invoiceQr: AppConfig.useInvoiceQr ? '' : '',
                  );
                  if (bytes.isEmpty) {
                    return <int>[];
                  } else {
                    return bytes;
                  }
                } catch (ex) {
                  rethrow;
                }
              },
              onComplete: (success, error) {
                if (success) {
                  showLogs("✅ In thành công");
                } else {
                  resPrint = error;
                  showLogs("❌ In thất bại");

                  if (error != null) {
                    showMessageDialog(context, message: error);
                  }
                }
              },
            );
          } catch (ex) {
            resPrint = ex.toString();
            showLogs(ex.toString(), flags: 'in hoàn thành lỗi');
          }

          if (resPrint != null) {
            state = state.copyWith(event: HistoryOrderEvent.normal);
            return (
              error:
                  '${S.current.msg_error_print_receipt}${(resPrint ?? '').trim().isNotEmpty ? '\n${S.current.ex_problem}: $resPrint' : ''}',
              refreshData: refreshData
            );
          }
          printBillResult = true;
          error = null;
          break;
        } catch (ex) {
          retry++;
          printBillResult = false;
          error = ex.toString();
        }
      }

      state = state.copyWith(event: HistoryOrderEvent.normal);

      if (printBillResult == false) {
        return (
          error:
              '${S.current.msg_error_print_receipt}${(error ?? '').trim().isNotEmpty ? '\n${S.current.ex_problem}: $error' : ''}',
          refreshData: refreshData
        );
      }

      return (error: null, refreshData: refreshData);
    } catch (ex) {
      state = state.copyWith(event: HistoryOrderEvent.normal);
      return (error: ex.toString(), refreshData: refreshData);
    }
  }

  Future<
      ({
        String? error,
        List<LineItemDataBill> itemsPrint,
        EmployeeSaleModel? sale,
        DataBillInfoPrintModel? infoPrinter,
        PriceDataBill price,
        PaymentMethod? paymentMethod,
        List<PaymentMethod> listPaymentMethod,
        double paymentAmount,
        OrderPrintModel? order,
        String description,
        List<HistoryPolicyResultModel> vouchers,
        String portrait,
      })> _getDataBill({required int orderId}) async {
    try {
      var result = await _orderRepository.getDataBill(orderId: orderId);
      if (!result.isSuccess) {
        throw AppException(
          statusCode: result.statusCode,
          message: result.error,
        );
      }
      var data = result.data;
      if (data == null) {
        throw AppException(
          statusCode: result.statusCode,
          message: 'Không có dữ liệu',
        );
      }
      var sale = data.sale;

      var print = data.print;

      var paymentMethodKey = data.order.paymentMethod;
      return (
        error: null,
        itemsPrint: data.orderLineItems,
        sale: sale == null
            ? null
            : EmployeeSaleModel(
                fullName: sale.eSaleName,
                employeeCode: sale.eSaleCode,
              ),
        infoPrinter: print?.infoPrint,
        price: print?.price ?? const PriceDataBill(),
        paymentMethod: paymentMethodKey == null
            ? null
            : PaymentMethod(
                key: paymentMethodKey,
                keyMethod: paymentMethodKey,
                name: print?.paymentMethod ?? '',
                method: print?.paymentMethod ?? '',
              ),
        listPaymentMethod: print?.listPaymentMethod ?? [],
        paymentAmount: (print?.listPaymentMethod ?? []).isEmpty
            ? -1.0
            : (print?.listPaymentMethod ?? []).first.getPaymentAmount(),
        order: print?.order,
        description: '',
        vouchers: print?.vouchers ?? <HistoryPolicyResultModel>[],
        portrait: '',
      );
    } catch (ex) {
      return (
        error: ex.toString(),
        itemsPrint: <LineItemDataBill>[],
        sale: null,
        infoPrinter: null,
        price: const PriceDataBill(),
        paymentMethod: null,
        listPaymentMethod: <PaymentMethod>[],
        paymentAmount: -1.0,
        order: null,
        description: '',
        vouchers: <HistoryPolicyResultModel>[],
        portrait: '',
      );
    }
  }

  ({bool valid, Map<int, double> tax}) _checkValidTaxItemsPrint({
    required List<ProductModel> products,
    required List<LineItemDataBill> itemsPrint,
    bool requireUpdateTax = false,
  }) {
    bool valid = true;
    Map<int, double> tax = {};
    for (var item in itemsPrint) {
      tax[item.id] = item.getTax1();
      var p = products.firstWhereOrNull((e) => e.id == item.id);
      if (p != null) {
        tax[item.id] = p.getTax;
        if (requireUpdateTax) {
          if (item.getTax1() == 0) {
            valid = false;
          }
        } else {
          if (item.getTax1() != p.getTax) {
            valid = false;
          }
        }
      }
    }
    return (valid: valid, tax: tax);
  }

  void getDetailOrder() async {
    try {
      state = state.copyWith(getOrderDetailState: const PageState(status: PageCommonState.loading));
      var historyOrderSelect = state.historyOrderSelect;
      if (historyOrderSelect == null) {
        return;
      }
      var order = OrderModel(
        id: historyOrderSelect.orderExcute.order,
        // orderCode: historyOrderSelect.orderCode,
        name: historyOrderSelect.tableName,
        misc: '{"order_code":"${historyOrderSelect.orderCode}","remarks":""}',
      );

      final result = await _orderRepository.getProductCheckout(order);
      if (!result.isSuccess) {
        throw AppException(
          statusCode: result.statusCode,
          message: result.error,
        );
      }

      var data = result.data;
      final productCheckout = data?.data?.firstOrNull?.orderItem ?? [];
      final coupons = data?.coupons;
      final customer = data?.customer;
      DataBillResponseData? billInfo;
      if (historyOrderSelect.orderItems.isNotEmpty) {
        var bill = await _orderRepository.getDataBill(orderId: order.id);
        if (!bill.isSuccess) {
          throw AppException(
            statusCode: bill.statusCode,
            message: bill.error,
          );
        }
        billInfo = bill.data;
      }
      state = state.copyWith(
        getOrderDetailState: const PageState(status: PageCommonState.success),
        customer: customer,
        coupons: coupons ?? [],
        productCheckout: productCheckout,
        dataBill: billInfo,
      );
    } catch (ex) {
      state = state.copyWith(
          getOrderDetailState: PageState(
        status: PageCommonState.error,
        messageError: ex.toString(),
      ));
    }
  }

  void onChangeDate({
    required DateTime startDate,
    required DateTime endDate,
  }) {
    if (startDate == state.startDate && endDate == state.endDate) return;
    state = state.copyWith(startDate: startDate, endDate: endDate);
    ref.refresh(historyOrderProvider);
  }

  void onChangeTextSearch(String value) {
    state = state.copyWith(textSearch: value.trim());
  }

  void onChangeEmployeeSaleSelect(EmployeeSaleModel? sale) {
    state = state.copyWith(
      dataBill: state.dataBill?.copyWith(
        sale: sale == null
            ? null
            : DataBillSale(
                eSaleCode: sale.employeeCode,
                eSaleName: sale.fullName,
              ),
      ),
    );
  }

  Future<({String? error, List<ProductCheckoutUpdateTaxModel> pc})> updateTax({
    required PaymentMethod paymentMethod,
    required List<ProductCheckoutModel> item,
    required OrderModel order,
  }) async {
    int retry = 0;
    String? error;

    state = state.copyWith(event: HistoryOrderEvent.updateTax);
    while (retry < 3) {
      try {
        var result = await _orderRepository.updateTax(
          order: order,
          pc: item,
          paymentMethod: paymentMethod,
        );
        if (!result.isSuccess) {
          throw AppException(
            statusCode: result.statusCode,
            message: result.error,
          );
        }
        state = state.copyWith(event: HistoryOrderEvent.normal);
        return (error: null, pc: result.data ?? []);
      } catch (ex) {
        retry++;
        error = ex.toString();
      }
    }
    state = state.copyWith(event: HistoryOrderEvent.normal);
    return (error: error, pc: <ProductCheckoutUpdateTaxModel>[]);
  }

  OrderModel? get orderSelect {
    var historyOrderSelect = state.historyOrderSelect;
    if (historyOrderSelect == null) return null;
    return OrderModel(
      id: historyOrderSelect.orderExcute.order,
      name: historyOrderSelect.tableName,
      misc: '{"order_code":"${historyOrderSelect.orderCode}","remarks":""}',
      typeOrder: historyOrderSelect.orderType,
    );
  }
}
