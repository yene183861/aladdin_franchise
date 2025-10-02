import 'dart:async';
import 'dart:math';

import 'package:aladdin_franchise/generated/l10n.dart';
import 'package:aladdin_franchise/src/configs/app.dart';
import 'package:aladdin_franchise/src/core/network/order/order_repository.dart';
import 'package:aladdin_franchise/src/core/network/provider.dart';
import 'package:aladdin_franchise/src/core/network/responses/data_bill.dart';
import 'package:aladdin_franchise/src/core/services/task_queue.dart';
import 'package:aladdin_franchise/src/core/storages/local.dart';
import 'package:aladdin_franchise/src/features/dialogs/confirm_action.dart';
import 'package:aladdin_franchise/src/features/dialogs/message.dart';
import 'package:aladdin_franchise/src/features/dialogs/payment/edit_tax_dialog.dart';
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
      // await Future.delayed(const Duration(seconds: 1));
      // state = state.copyWith(event: HistoryOrderEvent.normal);
      // return (error: null, refreshData: true);
      bool requireCompleteBill = historyOrderSelect.status == OrderStatusEnum.waiting;
      bool isOnline = historyOrderSelect.orderType == AppConfig.orderOnlineValue;
      var order = OrderModel(
        id: historyOrderSelect.orderExcute.order,
        // orderCode: historyOrderSelect.orderCode,
        name: historyOrderSelect.tableName,
        misc: '{"order_code":"${historyOrderSelect.orderCode}","remarks":""}',
        typeOrder: historyOrderSelect.orderType,
      );

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
          EmployeeSaleModel? sale =
              dataBill.sale ?? LocalStorage.getEmployeeSaleForOrder(order: order);
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

          // if (sale == null) {
          //   if (context.mounted) {
          //     sale = await showEmployeeSaleListDialog(context);
          //   }
          //   if (sale == null) {
          //     state = state.copyWith(event: HistoryOrderEvent.normal);
          //     return (error: null, refreshData: refreshData);
          //   }

          //   try {
          //     await LocalStorage.saveEmployeeSaleForOrder(
          //         order: order, sale: sale);
          //   } catch (ex) {
          //     //
          //   }
          // }

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
                  listPaymentMethods =
                      await ref.read(restaurantRepositoryProvider).getPaymentMethod(
                            orderId: order.id,
                          );
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

          if (requireCompleteBill && isOnline) {
            var homeState = ref.read(homeProvider);
            if (kTypeOrder == AppConfig.orderOnlineValue &&
                homeState.productsState.status == PageCommonState.success) {
              onlineProducts = List<ProductModel>.from(homeState.products);
            } else {
              if (onlineProducts.isEmpty) {
                int retry = 0;
                while (retry < 3) {
                  try {
                    var res = await ref
                        .read(productRepositoryProvider)
                        .getProduct(null, typeOrder: AppConfig.orderOnlineValue);
                    onlineProducts = List<ProductModel>.from(res.data.data ?? []);
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

            var checkTax = _checkValidTaxItemsPrint(
              requireUpdateTax: paymentMethodSelect.requireEditTax,
              itemsPrint: itemsPrint,
              products: onlineProducts,
            );

            var tax = Map<int, double>.from(checkTax.tax);

            if (!checkTax.valid) {
              // dialog sửa thuế
              if (context.mounted) {
                List<ProductCheckoutModel> productCheckouts = itemsPrint.map((e) {
                  return ProductCheckoutModel(
                    id: e.id,
                    name: e.name,
                    nameEn: e.nameEn,
                    quantity: e.count,
                    unit: e.unit,
                    codeProduct: e.codeProduct,
                    tax: e.getTax1(),
                    unitPrice: e.price.toString(),
                    totalOrdered: e.count * (double.tryParse(e.price.toString()) ?? 0),
                  );
                }).toList();
                bool editTax = false;

                await showConfirmActionWithChild(
                  context,
                  noTitle: true,
                  title: S.current.edit_tax_information,
                  closeDialog: true,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: EditTaxDialog(
                        products: onlineProducts,
                        productCheckouts: productCheckouts,
                        onSave: (List<ProductCheckoutModel> changedPc) {
                          productCheckouts = changedPc;
                        }),
                  ),
                  onCheckAction: () {
                    bool useDefaultTax = !(paymentMethodSelect?.requireEditTax ?? false);
                    var check = true;
                    for (var pc in productCheckouts) {
                      if (useDefaultTax) {
                        if (tax[pc.id] != pc.tax) {
                          check = false;
                          break;
                        }
                      } else {
                        // phải sửa thuế khác 0
                        if (pc.tax == 0) {
                          check = false;
                          break;
                        }
                      }
                    }
                    if (!check) {
                      showMessageDialog(context,
                          canPop: false,
                          message: useDefaultTax
                              ? 'Vui lòng chọn thuế mặc định của món để cập nhật lại hóa đơn!'
                              : S.current.error_edit_tax);
                      return false;
                    }

                    return check;
                  },
                  action: () async {
                    var resultUpdateTax = await updateTax(
                      paymentMethod: paymentMethodSelect!,
                      item: productCheckouts,
                      order: order,
                    );
                    if (resultUpdateTax.error != null) {
                      if (context.mounted) {
                        await showMessageDialog(context,
                            message: 'Phân bổ thuế không thành công\n${resultUpdateTax.error}');
                      }
                      editTax = false;
                    } else {
                      refreshData = true;
                      editTax = true;
                    }
                  },
                  actionCancel: () {
                    editTax = false;
                  },
                  actionTitle: 'Cập nhật',
                );
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
          }

          /// - đơn đang chờ thanh toán => đơn đã thanh toán
          /// - concept HS (thanh toán trước khi ăn) (bên anh TA in nên k cần in local nữa)
          ///
          if (requireCompleteBill || !AppConfig.useFranchise) {
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
                eSaleName: sale?.fullName ?? '',
                eSaleCode: sale?.employeeCode ?? '',
                arrMethod: ['${paymentMethodSelect.key}--$paymentAmount']);
            if (requireCompleteBill) {
              refreshData = true;
            }
          }
          if (AppConfig.useFranchise) {
            // check here: check máy in trước khi in
            String? resPrint;
            try {
              var check = await AppPrinterCommon.checkPrinter(
                  IpOrderModel(ip: infoPrinter.ip, port: infoPrinter.port, type: 1));
              if (check != null) {
                throw check;
              }
              PrinterTaskQueue.instance.addTask(
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
                      printers: [
                        IpOrderModel(
                            ip: infoPrinter?.ip ?? '', port: infoPrinter?.port ?? 9100, type: 1),
                      ],
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
                    );
                    if (bytes.isEmpty) {
                      return <int>[];
                    } else {
                      return bytes;
                    }
                  } catch (ex) {
                    debugPrint("⚠️ getReceptBillContent ex");
                    rethrow;
                  }
                },
                onComplete: (success, error) {
                  if (success) {
                    showLogs("✅ In thành công");
                  } else {
                    showLogs("❌ In thất bại");
                    if (error != null) {
                      showMessageDialog(context, message: 'Không thể in phiếu thanh toán\n$error');
                    }
                  }
                },
              );
            } catch (ex) {
              resPrint = ex.toString();
              showLogs(ex.toString(), flags: 'in hoàn thành lỗi');
            }

            if (resPrint != null) {
              throw 'Không thể in phiếu thanh toán\n$resPrint';
            }
          }
          try {
            await LocalStorage.deleteEmployeeSaleForOrder(order: order);
          } catch (ex) {
            //
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
      var sale = result.data.sale;

      var print = result.data.print;

      var paymentMethodKey = result.data.order.paymentMethod;
      return (
        error: null,
        itemsPrint: result.data.orderLineItems,
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
      final productCheckout = result.data?.first.orderItem ?? [];
      final coupons = result.coupons;
      final customer = result.customer;
      DataBillResponse? billInfo;
      if (historyOrderSelect.orderItems.isNotEmpty) {
        billInfo = await _orderRepository.getDataBill(orderId: order.id);
      }
      state = state.copyWith(
        getOrderDetailState: const PageState(status: PageCommonState.success),
        customer: customer,
        coupons: coupons ?? [],
        productCheckout: productCheckout,
        dataBill: billInfo?.data,
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
        var res = await _orderRepository.updateTax(
          order: order,
          pc: item,
          paymentMethod: paymentMethod,
        );
        state = state.copyWith(event: HistoryOrderEvent.normal);
        return (error: null, pc: res);
      } catch (ex) {
        retry++;
        error = ex.toString();
      }
    }
    state = state.copyWith(event: HistoryOrderEvent.normal);
    return (error: error, pc: <ProductCheckoutUpdateTaxModel>[]);
  }
}
