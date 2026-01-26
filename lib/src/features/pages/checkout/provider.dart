import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:aladdin_franchise/generated/l10n.dart';
import 'package:aladdin_franchise/src/configs/app.dart';
import 'package:aladdin_franchise/src/configs/const.dart';
import 'package:aladdin_franchise/src/core/network/provider.dart';
import 'package:aladdin_franchise/src/core/network/repository/coupon/coupon_repository.dart';
import 'package:aladdin_franchise/src/core/network/repository/customer/customer_repository.dart';
import 'package:aladdin_franchise/src/core/network/repository/invoice/invoice_repository.dart';
import 'package:aladdin_franchise/src/core/network/repository/o2o/o2o_repository.dart';
import 'package:aladdin_franchise/src/core/network/repository/order/order_repository.dart';
import 'package:aladdin_franchise/src/core/network/repository/reservation/reservation_repository.dart';
import 'package:aladdin_franchise/src/core/network/repository/responses/customer.dart';
import 'package:aladdin_franchise/src/core/network/repository/restaurant/restaurant_repository.dart';
import 'package:aladdin_franchise/src/core/network/repository/user/user_repository.dart';
import 'package:aladdin_franchise/src/data/enum/discount_type.dart';
import 'package:aladdin_franchise/src/data/enum/payment_status.dart';
import 'package:aladdin_franchise/src/data/enum/print_type.dart';
import 'package:aladdin_franchise/src/data/enum/printer_type.dart';
import 'package:aladdin_franchise/src/data/enum/receipt_type.dart';
import 'package:aladdin_franchise/src/data/enum/windows_method.dart';
import 'package:aladdin_franchise/src/data/model/restaurant/printer.dart';
import 'package:aladdin_franchise/src/data/request/payment_receipt_print.dart';
import 'package:aladdin_franchise/src/features/pages/home/components/menu/provider.dart';
import 'package:aladdin_franchise/src/features/pages/home/provider.dart';
import 'package:aladdin_franchise/src/features/pages/home/state.dart';
import 'package:aladdin_franchise/src/models/atm_pos.dart';
import 'package:aladdin_franchise/src/models/customer/customer.dart';
import 'package:aladdin_franchise/src/models/customer/customer_policy.dart';
import 'package:aladdin_franchise/src/models/data_bill.dart';
import 'package:aladdin_franchise/src/models/ip_order.dart';
import 'package:aladdin_franchise/src/models/minvoice/minvoice.dart';
import 'package:aladdin_franchise/src/models/order.dart';
import 'package:aladdin_franchise/src/models/order_invoice/order_invoice.dart';
import 'package:aladdin_franchise/src/models/param_family/bank_param.dart';
import 'package:aladdin_franchise/src/models/payment_method/payment_method.dart';
import 'package:aladdin_franchise/src/models/product.dart';
import 'package:aladdin_franchise/src/models/product_checkout.dart';
import 'package:aladdin_franchise/src/models/user_bank.dart';
import 'package:aladdin_franchise/src/utils/app_log.dart';
import 'package:aladdin_franchise/src/utils/app_printer/app_printer_common.dart';
import 'package:aladdin_franchise/src/utils/app_util.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'state.dart';

final checkoutPageProvider =
    StateNotifierProvider.autoDispose<CheckoutPageNotifier, CheckoutPageState>((ref) {
  return CheckoutPageNotifier(
    ref,
    ref.read(orderRepositoryProvider),
    ref.read(invoiceRepositoryProvider),
    ref.read(userRepositoryProvider),
    ref.read(customerRepositoryProvider),
    ref.read(couponRepositoryProvider),
    ref.read(restaurantRepositoryProvider),
    ref.read(o2oRepositoryProvider),
    ref.read(reservationRepositoryProvider),
  );
});

class CheckoutPageNotifier extends StateNotifier<CheckoutPageState> {
  CheckoutPageNotifier(
    this.ref,
    this._orderRepository,
    this._invoiceRepository,
    this._userRepository,
    this._customerRepository,
    this._couponRepository,
    this._restaurantRepository,
    this._o2oRepository,
    this._reservationRepository,
  ) : super(const CheckoutPageState());
  final Ref ref;
  final OrderRepository _orderRepository;
  final InvoiceRepository _invoiceRepository;
  final UserRepository _userRepository;
  final CustomerRepository _customerRepository;
  final CouponRepository _couponRepository;
  final RestaurantRepository _restaurantRepository;

  final OrderToOnlineRepository _o2oRepository;
  final ReservationRepository _reservationRepository;

  OrderModel? getOrderSelect() {
    return ref.read(homeProvider).orderSelect;
  }

  Future<void> checkOrderSelect() async {
    var order = getOrderSelect();
    if (order == null) throw S.current.noOrderSelect;
  }

  void initialize() {
    var order = getOrderSelect();
    state = const CheckoutPageState();
    if (order != null) {
      showLogs(null, flags: 'checkoutPageProvider init get order info');
      getProductCheckouts();
      getDataBill();
      getInvoice();
    }
  }

  void updateEvent([CheckoutEvent? event]) {
    state = state.copyWith(event: event ?? CheckoutEvent.normal);
  }

  Future<String?> getProductCheckouts({
    bool showLoading = false,
  }) async {
    if (showLoading) updateEvent(CheckoutEvent.getProductCheckout);
    state = state.copyWith(
      productCheckoutState: const PageState(status: PageCommonState.loading),
    );
    try {
      var order = getOrderSelect();
      if (order != null) {
        final data = await _orderRepository.getProductCheckout(order);
        final pc = List<ProductCheckoutModel>.from(data.data?.first.orderItem ?? []);
        final coupons = List<CustomerPolicyModel>.from(data.coupons ?? []);
        final customer = data.customer;
        var orderHistory = data.data?.first.orderHistory ?? [];
        state = state.copyWith(
          coupons: coupons,
          customer: customer,
          numberOfAdults: max(data.numberOfAdults, 1),
          orderHistory: orderHistory,
          productsCheckout: pc,
        );
      } else {
        state = const CheckoutPageState();
      }
      for (var e in [
        WindowsMethodEnum.customer,
        WindowsMethodEnum.productCheckout,
      ]) {
        ref.read(homeProvider.notifier).syncInfoCustomerPage(method: e);
      }
      if (showLoading) updateEvent();
      state = state.copyWith(
        productCheckoutState: const PageState(status: PageCommonState.success),
      );
      return null;
    } catch (ex) {
      if (showLoading) updateEvent();
      state = state.copyWith(
        productCheckoutState: PageState(
          status: PageCommonState.error,
          messageError: ex.toString(),
        ),
      );
      return ex.toString();
    }
  }

  Future<String?> getDataBill({
    bool showLoading = false,
  }) async {
    if (showLoading) updateEvent(CheckoutEvent.getDataBill);
    state = state.copyWith(dataBillState: const PageState(status: PageCommonState.loading));
    try {
      var order = getOrderSelect();
      if (order != null) {
        final data = await _orderRepository.getDataBill(orderId: order.id);
        state = state.copyWith(dataBill: data);
      } else {
        state = const CheckoutPageState();
      }
      if (showLoading) updateEvent();
      state = state.copyWith(
        dataBillState: const PageState(status: PageCommonState.success),
      );

      ref.read(homeProvider.notifier).syncInfoCustomerPage(method: WindowsMethodEnum.price);
      return null;
    } catch (ex) {
      state = state.copyWith(
        dataBillState: PageState(
          status: PageCommonState.error,
          messageError: ex.toString(),
        ),
      );
      if (showLoading) updateEvent();
      return ex.toString();
    }
  }

  /// invoice

  Future<String?> getInvoice({
    bool showLoading = false,
  }) async {
    state = state.copyWith(orderInvoiceState: const PageState(status: PageCommonState.loading));
    try {
      var order = getOrderSelect();
      if (order != null) {
        final data = await _invoiceRepository.getOrderInvoice(order.id);
        state = state.copyWith(
          invoice: data.isEmpty() ? null : data,
        );
      } else {
        state = const CheckoutPageState();
      }
      state = state.copyWith(
        orderInvoiceState: const PageState(status: PageCommonState.success),
      );

      return null;
    } catch (ex) {
      state = state.copyWith(
        orderInvoiceState: PageState(
          status: PageCommonState.error,
          messageError: ex.toString(),
        ),
      );
      return ex.toString();
    }
  }

  Future<bool> onUpdateOrderInvoice(
    OrderInvoice invoice, {
    bool isUpdate = false,
  }) async {
    updateEvent(isUpdate ? CheckoutEvent.updateInvoice : CheckoutEvent.insertInvoice);
    try {
      var order = getOrderSelect();
      if (order == null) throw S.current.noOrderSelect;
      await _invoiceRepository.updateOrderInvoice(
        orderId: order.id,
        orderInvoice: invoice,
      );

      state = state.copyWith(
        event: CheckoutEvent.processed,
        invoice: invoice,
      );
      return true;
    } catch (ex) {
      //     _lockOrder(ex);
      state = state.copyWith(
        event: CheckoutEvent.processError,
        message: ex.toString(),
      );
      return false;
    }
  }

  Future<({MInvoiceInfo? mInvoiceInfo, String? error})> searchTaxCodeInfo(String taxCode) async {
    try {
      updateEvent(CheckoutEvent.findingTaxCode);
      final result = await _invoiceRepository.getMInvoiceTaxInfo(taxCode);
      updateEvent();
      return (mInvoiceInfo: result, error: null);
    } catch (ex) {
      updateEvent();
      return (mInvoiceInfo: null, error: ex.toString());
    }
  }

  /// customer
  Future<FindCustomerStatus> findCustomer(
    String phone, {
    bool loadingHome = true,
    bool retry = false,
  }) async {
    try {
      if (loadingHome) updateEvent(CheckoutEvent.findingCustomer);
      var order = getOrderSelect();
      if (order == null) {
        throw S.current.noOrderSelect;
      }
      int countRetry = 0;
      CustomerResponseData? result;
      do {
        try {
          result = await _customerRepository.findCustomer(phoneNumber: phone, order: order);
          break;
        } catch (ex) {
          countRetry++;
          if (countRetry >= (retry ? 1 : 3)) {
            rethrow;
          }
        }
      } while (countRetry < (retry ? 1 : 3));

      if (loadingHome) updateEvent(null);
      if (result == null) throw S.current.no_data;
      if (result.customer is List<dynamic> == false) {
        CustomerModel customer = CustomerModel.fromJson(result.customer);
        state = state.copyWith(customer: customer);
        ref.read(homeProvider.notifier).syncInfoCustomerPage(method: WindowsMethodEnum.customer);
        return FindCustomerStatus.success;
      }
      state = state.copyWith(message: "${S.current.find_customer_not_found} ($phone)");
      return FindCustomerStatus.notFound;
    } catch (ex) {
      if (loadingHome) updateEvent(null);
      state = state.copyWith(message: ex.toString());
      return FindCustomerStatus.error;
    }
  }

  Future<String?> createCustomer({
    required String phone,
    required String firstName,
    required String lastName,
    required String birthday,
    required String? gender,
    String? idCardNumber,
    String? address,
    required bool noBOD,
  }) async {
    try {
      var order = getOrderSelect();
      if (order == null) return S.current.noOrderSelect;
      if (phone.isEmpty ||
          firstName.isEmpty ||
          lastName.isEmpty ||
          (noBOD ? false : birthday.isEmpty)) {
        return S.current.miss_information;
      }
      updateEvent(CheckoutEvent.createCustomer);
      await _customerRepository.createCustomer(
        phone: phone,
        firstName: firstName,
        lastName: lastName,
        birthday: birthday,
        gender: gender,
        order: order,
        idCardNumber: idCardNumber,
        address: address,
      );

      updateEvent(null);
      return null;
    } catch (ex) {
      updateEvent(null);
      return "${S.current.unable_add_customer}\n${ex.toString()}";
    }
  }

  Future<String?> deleteCustomer() async {
    try {
      var order = getOrderSelect();
      if (order == null) return S.current.noOrderSelect;
      state = state.copyWith(event: CheckoutEvent.removeCustomer);
      await _customerRepository.deleteCustomer(order.id);
      state = state.copyWith(event: CheckoutEvent.normal, customer: null);
      ref.read(homeProvider.notifier).syncInfoCustomerPage(method: WindowsMethodEnum.customer);
      return null;
    } catch (ex) {
      state = state.copyWith(event: CheckoutEvent.normal);
      return "${S.current.error_remove_customer_order}\n${ex.toString()}";
    }
  }

  /// discount
  void onChangeDiscountTypeSelect(DiscountTypeEnum value) {
    state = state.copyWith(discountTypeSelect: value);
  }

  // tiền giảm hoặc % giảm
  Future<String?> deleteVoucher({
    required CustomerPolicyModel coupon,
    bool showLoading = true,
    bool applyPolicy = true,
  }) async {
    try {
      if (showLoading) updateEvent(CheckoutEvent.removeCoupon);
      await _couponRepository.deleteVoucher(coupon.id);
      if (showLoading) updateEvent();
      var coupons = List<CustomerPolicyModel>.from(state.coupons);
      coupons.removeWhere((e) => e.id == coupon.id);
      state = state.copyWith(coupons: coupons);
      getDataBill(showLoading: false);
      return null;
    } catch (ex) {
      if (showLoading) updateEvent();
      return ex.toString();
    }
  }

  // tiền giảm hoặc % giảm
  Future<({String? error, String? titleError})> addVoucher({
    double value = 0,
    bool loadingHome = true,
    bool applyPolicy = true,
    DiscountTypeEnum? discountType,
  }) async {
    try {
      if (loadingHome) updateEvent(CheckoutEvent.addCoupon);
      var order = getOrderSelect();
      if (order == null) throw S.current.noOrderSelect;
      final result = await _couponRepository.addVoucher(
        order: order,
        totalBill: state.dataBill.price.totalPrice * 1.0,
        amount: value,
        type: discountType ?? state.discountTypeSelect,
      );

      if (loadingHome) updateEvent();

      state = state.copyWith(
        coupons: [
          CustomerPolicyModel(
            id: result.id,
            name: result.name,
            type: null,
            isType: 3,
            discount: [
              DiscountPolicy(
                id: null,
                name: null,
                // do response trả về lại là số tiền giảm nên type sẽ là DiscountTypeEnum.vnd
                // getProductCheckouts sẽ ghi đè lại thông in mã giảm
                type: DiscountTypeEnum.vnd.key,
                amount: result.amount,
              ),
            ],
          ),
          ...state.coupons
        ],
      );
      getProductCheckouts();
      getDataBill();
      return (error: null, titleError: null);
    } catch (ex) {
      if (loadingHome) updateEvent();
      bool isPercent = state.discountTypeSelect == DiscountTypeEnum.percent;
      return (
        error: ex.toString(),
        titleError: '${S.current.failed_apply_discount_code} '
            '(${isPercent ? AppUtils.getPercentValue(value) : AppUtils.formatCurrency(symbol: '', value: value)} ${isPercent ? '%' : 'đ'})',
      );
    }
  }

  /// payment
  ///
  void onChangeAtmPosSelect(AtmPosModel? pos) {
    state = state.copyWith(atmPosSelect: pos);
  }

  void getListAtmPos() async {
    try {
      state = state.copyWith(
        atmPosSelect: null,
        listAtmPosState: const PageState(status: PageCommonState.loading),
      );
      var order = getOrderSelect();
      if (order == null) throw S.current.noOrderSelect;
      final result = await _restaurantRepository.getListAtmPos(
        orderId: order.id,
        totalBill: state.dataBill.price.totalPriceFinal,
      );

      state = state.copyWith(
        listAtmPosState: const PageState(status: PageCommonState.success),
        listAtmPos: result,
      );
    } catch (ex) {
      state = state.copyWith(
        listAtmPosState: PageState(status: PageCommonState.error, messageError: ex.toString()),
      );
    }
  }

  Future<
      ({
        HomePaymentError? errorType,
        String msg,
        List<IpOrderModel> tmpPrinters,
        PaymentReceiptPrintRequest? requestPrint,
      })> onPayment(BuildContext context) async {
    List<IpOrderModel> printers = [];
    try {
      updateEvent(CheckoutEvent.paymentProcess);
      ref.read(homeProvider.notifier).syncInfoCustomerPage(
            method: WindowsMethodEnum.payment,
            arguments: PaymentStatusEnum.loading.name,
          );

      int retryTempPayment = 0;
      int timesTempPayment = 3;
      // in tạm tính
      while (retryTempPayment < timesTempPayment) {
        try {
          var order = getOrderSelect();
          if (order == null) {
            updateEvent(null);
            ref.read(homeProvider.notifier).syncInfoCustomerPage(
                  method: WindowsMethodEnum.payment,
                  arguments: PaymentStatusEnum.cancel.name,
                );
            return (
              errorType: HomePaymentError.temp,
              msg: S.current.noOrderSelect,
              tmpPrinters: <IpOrderModel>[],
              requestPrint: null,
            );
          }
          if (printers.isEmpty) {
            final resultPrinter = await _orderRepository.getPrinterBill(order, [1]);

            printers = List.from(resultPrinter ?? []);
          }

          // // Kiểm tra tình trạng máy in
          for (var ipPrinter in printers) {
            var checkPrinterAvailable = await AppPrinterCommon.checkPrinter(ipPrinter);
            if (checkPrinterAvailable != null) {
              throw checkPrinterAvailable;
            }
          }

          var price = state.dataBill.price;
          var checkoutState = ref.read(checkoutPageProvider);

          await _orderRepository.payment(
            order: order,
            infoPrint: printers,
            products: checkoutState.productsCheckout,
            vouchers: state.coupons,
            createVouchers: state.createVouchers,
            comment: null,
            numberOfAdults: state.numberOfAdults,
            numberOfChildren: state.numberOfChildren,
            note: state.completeNote,
            flagInvoice: !(state.invoice?.isEmpty() ?? true),
            customerRatings: [],
            imageBills: state.imageBills,
            paymentMethod: state.paymentMethodSelected?.key,
            customerPortrait: state.customerPortraitSelect,
            statusPaymentCompleted: state.statusPaymentGateway,
            totalPaymentCompleted:
                state.statusPaymentGateway ? state.totalPaymentGateway : price.totalPriceFinal,
          );

          break;
        } catch (ex) {
          retryTempPayment++;
          if (retryTempPayment >= timesTempPayment) {
            state = state.copyWith(event: CheckoutEvent.normal);
            ref.read(homeProvider.notifier).syncInfoCustomerPage(
                  method: WindowsMethodEnum.payment,
                  arguments: PaymentStatusEnum.cancel.name,
                );
            return (
              errorType: HomePaymentError.temp,
              msg: ex.toString(),
              tmpPrinters: <IpOrderModel>[],
              requestPrint: null,
            );
          }
        }
      }

      // hoàn thành đơn
      var completeStatus = await completeBill(
        loadingHome: false,
        context: context,
        printers: printers,
      );
      ref.read(homeProvider.notifier).syncInfoCustomerPage(
            method: WindowsMethodEnum.payment,
            arguments: PaymentStatusEnum.success.name,
          );

      if (completeStatus.error != null) {
        updateEvent(null);
        return (
          errorType: HomePaymentError.complete,
          msg: completeStatus.error!,
          tmpPrinters: printers,
          requestPrint: completeStatus.requestPrint,
        );
      }
      clearImageBill();
      if (completeStatus.errorSendPrint != null) {
        updateEvent(null);
        return (
          errorType: HomePaymentError.printCompleteError,
          msg: completeStatus.errorSendPrint!,
          tmpPrinters: printers,
          requestPrint: completeStatus.requestPrint,
        );
      }
      updateEvent(null);
      return (
        errorType: null,
        msg: '',
        tmpPrinters: printers,
        requestPrint: null,
      );
    } catch (ex) {
      updateEvent(null);
      return (
        errorType: HomePaymentError.temp,
        msg: ex.toString(),
        tmpPrinters: <IpOrderModel>[],
        requestPrint: null,
      );
    }
  }

  // update trùng sẽ xoá
  void updateImageBill(File image) {
    if (getOrderSelect() == null) return;
    var images = List<File>.from(state.imageBills);
    if (images.contains(image)) {
      images.remove(image);
      clearImageBill(files: [image]);
    } else {
      images.add(image);
    }
    state = state.copyWith(imageBills: images);
  }

  void clearImageBill({List<File>? files}) {
    try {
      if (Platform.isWindows) return;
      final fileCheck = files ?? state.imageBills;
      for (final file in fileCheck) {
        File(file.path).deleteSync();
      }
      // xoá toàn bộ
      if (files == null) {
        state = state.copyWith(imageBills: []);
      }
      showLog("done", flags: 'clearImageBill');
    } catch (ex) {
      showLog("error $ex", flags: 'clearImageBill');
    }
  }

  void changeNumberOfPeople({
    int? numberOfAdults,
    int? numberOfChildren,
  }) {
    state = state.copyWith(
      numberOfAdults: numberOfAdults ?? state.numberOfAdults,
      numberOfChildren: numberOfChildren ?? state.numberOfChildren,
    );
  }

  void updatePaymentGatewayInfo({
    bool? status,
    dynamic amount,
    bool usePriceDataBillForAmount = false,
  }) {
    state = state.copyWith(
      statusPaymentGateway: status ?? state.statusPaymentGateway,
      totalPaymentGateway: usePriceDataBillForAmount
          ? (state.dataBill.price.totalPriceFinal * 1.0)
          : amount ?? state.totalPaymentGateway,
    );
  }

  Future<
      ({
        String? error,
        String? errorSendPrint,
        PaymentReceiptPrintRequest? requestPrint,
      })> completeBill({
    required BuildContext context,
    bool loadingHome = true,
    List<IpOrderModel> printers = const [],
    bool printKitchenBill = false,
  }) async {
    try {
      PaymentReceiptPrintRequest? requestPrint;
      String? errorSendPrint;
      if (loadingHome) updateEvent(CheckoutEvent.completeBillAgain);

      int retry = 0;
      while (retry < 3) {
        try {
          PriceDataBill price = state.dataBill.price;
          var order = getOrderSelect();
          if (order == null) {
            if (loadingHome) updateEvent(null);
            return (error: S.current.noOrderSelect, errorSendPrint: null, requestPrint: null);
          }
          var paymentMethodSelected = state.paymentMethodSelected;
          if (paymentMethodSelected == null) {
            throw 'Chưa chọn phương thức thanh toán';
          }
          var result = await _orderRepository.completeBill(
            order: order,
            portrait: state.customerPortraitSelect?.key ?? '',
            amountAdult: state.numberOfAdults,
            amountChildren: state.numberOfChildren,
            description: state.completeNote,
            arrMethod: ['${paymentMethodSelected.key}--${price.totalPriceFinal}'],
            totalPrice: price.totalPrice,
            totalPriceFinal: price.totalPriceFinal,
            totalPriceTax: price.totalPriceTax,
            totalPriceVoucher: price.totalPriceVoucher,
            eSaleCode: '',
            eSaleName: '',
            isPrintPeople: state.printNumberOfPeople ? 1 : 0,
            // providerCode: state.bankSelect?.code,
          );

          List<LineItemDataBill> productPrint = [];
          for (var e in (state.dataBill.print?.orderLineItems ?? <LineItemDataBill>[])) {
            productPrint.add(LineItemDataBill(
              name: e.name,
              price: e.price,
              tax: e.tax,
              unit: e.unit,
              count: e.count,
            ));
            if (e.listItem.isNotEmpty) {
              for (var item in e.listItem) {
                productPrint.add(LineItemDataBill(
                  name: ' - ${item.name}',
                  price: '0',
                  tax: '0',
                  unit: '',
                  count: 0,
                ));
              }
            }
          }
          requestPrint = PaymentReceiptPrintRequest(
            order: order,
            price: price,
            receiptType: ReceiptTypeEnum.paymentReceipt,
            paymentMethod: state.paymentMethodSelected,
            paymentAmount: state.statusPaymentGateway
                ? (double.tryParse((state.totalPaymentGateway ?? 0.0).toString()) ?? 0.0)
                : price.totalPriceFinal * 1.0,
            numberPrintCompleted: 1,
            numberPrintTemporary: 0,
            orderLineItems: productPrint,
            vouchers: state.dataBill.print?.vouchers ?? [],
            note: state.completeNote,
            printNumberOfPeople: state.printNumberOfPeople,
            customerPhone: state.customer?.phoneNumber ?? '',
            numberOfPeople: state.numberOfAdults,
            cashierCompleted: '',
            cashierPrint: '',
            timeCompleted: DateTime.now(),
            timeCreatedAt: null,
            invoiceQr: result ?? '',
          );

          try {
            errorSendPrint = await ref.read(homeProvider.notifier).sendPrintData(
                  type: PrintTypeEnum.payment,
                  paymentData: requestPrint,
                  printers: printers
                      .map(
                        (e) => PrinterModel(
                            ip: e.ip,
                            port: e.port,
                            name: e.name,
                            type: e.type,
                            typeAreaLocation: e.typeAreaLocation),
                      )
                      .toList(),
                );
          } catch (ex) {
            errorSendPrint = ex.toString();
          }
          break;
        } catch (ex) {
          retry++;
          if (retry >= 3) {
            rethrow;
          }
        }
      }
      if (loadingHome) updateEvent(null);
      return (error: null, errorSendPrint: errorSendPrint, requestPrint: requestPrint);
    } catch (ex) {
      if (loadingHome) updateEvent(null);
      return (error: ex.toString(), errorSendPrint: null, requestPrint: null);
    }
  }

  void resetPaymentAndBank() {
    state = state.copyWith(
      imageBills: [],
      paymentMethodSelected: null,
      bankSelect: null,
      statusPaymentGateway: false,
      totalPaymentGateway: 0.0,
      cashReceivedAmount: 0,
      atmPosSelect: null,
    );
    for (var e in [
      WindowsMethodEnum.paymentMethod,
      WindowsMethodEnum.bank,
      WindowsMethodEnum.price,
    ]) {
      ref.read(homeProvider.notifier).syncInfoCustomerPage(method: e);
    }
  }

  void loadPaymentMethods() async {
    try {
      state = state.copyWith(
        paymentMethodState: const PageState(status: PageCommonState.loading),
        paymentMethodSelected: null,
      );
      ref.read(homeProvider.notifier).syncInfoCustomerPage(method: WindowsMethodEnum.paymentMethod);
      var order = getOrderSelect();
      if (order == null) throw S.current.noOrderSelect;
      final result = await _restaurantRepository.getPaymentMethod(orderId: order.id);

      state = state.copyWith(
        paymentMethodState: const PageState(status: PageCommonState.success),
        paymentMethods: result,
      );
    } catch (ex) {
      state = state.copyWith(
        paymentMethodState: PageState(
          status: PageCommonState.error,
          messageError: ex.toString(),
        ),
      );
    }
  }

  ({List<CustomerPolicyModel> coupons, String? error}) checkPaymentMethodSelect(
      PaymentMethod method) {
    try {
      updateEvent(CheckoutEvent.checkPaymentMethod);
      if (state.coupons.isEmpty) {
        updateEvent();
        return (coupons: [], error: null);
      }
      List<CustomerPolicyModel> couponInvalidResult = [];
      // kiểm tra với danh sách giảm giá đang có
      for (final c in state.coupons) {
        if (c.paymentNotAllowed.any((element) => element.key == method.key)) {
          couponInvalidResult.add(c);
        }
      }
      updateEvent();
      if (couponInvalidResult.isNotEmpty) {
        return (
          coupons: couponInvalidResult,
          error: S.current.msg_coupons_invalid_with_payment_method(
              couponInvalidResult.length.toString(),
              couponInvalidResult.join(','),
              method.name.toUpperCase()),
          // "Có ${couponInvalidResult.length} mã giảm giá ${couponInvalidResult.join(',')}"
          // " không được phép dùng với PTTT (${method.name.toUpperCase()}).\n"
          // " Vui lòng xoá bỏ mã hoặc chọn phương thức thanh toán khác!"
        );
      }
      return (coupons: [], error: null);
    } catch (ex) {
      updateEvent();
      return (coupons: [], error: "${S.current.can_not_check_payment_method}\n${ex.toString()}");
    }
  }

  void onChangeCashReceivedAmount(double amount) {
    state = state.copyWith(cashReceivedAmount: max(0.0, amount));
    ref.read(homeProvider.notifier).syncInfoCustomerPage(method: WindowsMethodEnum.price);
  }

  Future<void> loadBanksInfo() async {
    try {
      state = state.copyWith(
        banksState: const PageState(status: PageCommonState.loading),
        banks: [],
        bankSelect: null,
      );
      ref.read(homeProvider.notifier).syncInfoCustomerPage(method: WindowsMethodEnum.bank);
      var order = getOrderSelect();
      if (order == null) throw S.current.noOrderSelect;
      final apiBankParam = ApiBankParam(state.dataBill.order, state.dataBill.price.totalPriceFinal);
      final paymentMethodSelect = state.paymentMethodSelected;
      final result = await _restaurantRepository.getBanks(apiBankParam);

      var bankView = List<UserBankModel>.from(result ?? []);
      // Loại bỏ những bank không hỗ trợ PTTT
      bankView.removeWhere(
          (element) => element.listPaymentId.contains(paymentMethodSelect?.key) == false);

      if (bankView.length == 1) {
        state = state.copyWith(bankSelect: bankView.first);
        ref.read(homeProvider.notifier).syncInfoCustomerPage(method: WindowsMethodEnum.bank);
      }
      state = state.copyWith(
        banksState: const PageState(status: PageCommonState.success),
        banks: bankView,
      );
    } catch (ex) {
      state = state.copyWith(
        banksState: PageState(
          status: PageCommonState.error,
          messageError: ex.toString(),
        ),
      );
    }
  }

  void changeBankSelect(UserBankModel? bank) {
    state = state.copyWith(bankSelect: bank);
    ref.read(homeProvider.notifier).syncInfoCustomerPage(method: WindowsMethodEnum.bank);
  }

  void changePaymentMethod(PaymentMethod? paymentMethod) {
    state = state.copyWith(
      paymentMethodSelected: paymentMethod,
      statusPaymentGateway: false,
      totalPaymentGateway: 0.0,
      cashReceivedAmount: 0,
      bankSelect: null,
      atmPosSelect: null,
    );

    for (var e in [
      WindowsMethodEnum.paymentMethod,
      WindowsMethodEnum.bank,
      WindowsMethodEnum.price,
    ]) {
      ref.read(homeProvider.notifier).syncInfoCustomerPage(method: e);
    }
  }

  /// cà thẻ động
  Future<String?> dynamicAtmPosCallback() async {
    try {
      updateEvent(CheckoutEvent.dynamicPosCallback);
      if (state.atmPosSelect == null) {
        throw S.current.no_select_pos_machine;
      }
      await _restaurantRepository.atmPosCallback(
        orderId: state.dataBill.price.totalPriceFinal,
        urlPos: state.atmPosSelect!.url,
      );
      updateEvent(null);
      return null;
    } catch (ex) {
      updateEvent(null);
      return ex.toString();
    }
  }

  /// tax
  Future<
      ({
        List<ProductCheckoutUpdateTaxModel>? data,
        String? error,
      })> onUpdateTax(List<ProductCheckoutModel> pc) async {
    try {
      updateEvent(CheckoutEvent.updateTax);
      var order = getOrderSelect();
      if (order == null) throw S.current.noOrderSelect;
      var data = await _orderRepository.updateTax(order: order, pc: pc);
      updateEvent();
      await getDataBill(showLoading: true);
      return (data: data, error: null);
    } catch (ex) {
      updateEvent();
      return (data: null, error: ex.toString());
    }
  }

  ///
  void init(List<ProductCheckoutModel> products) async {
    state = state.copyWith(productsCheckout: products);
  }

  void changeCancelQuantity(ProductCheckoutModel item) {
    var productsCheckout = List<ProductCheckoutModel>.from(state.productsCheckout);

    var index = productsCheckout.indexWhere((e) => e.id == item.id);
    if (index != -1) {
      productsCheckout[index] = item;
    }
    state = state.copyWith(productsCheckout: productsCheckout);
  }

  Future<({String? checkPrinters, String? error, String? resultSendPrintData})>
      cancelProductCheckout({
    List<ProductCheckoutModel> productCheckout = const [],
    String reason = '',
    Set<PrinterModel> printerSelect = const <PrinterModel>{},
    bool useDefaultPrinter = true,
    bool processOrder = true,
    bool ignorePrint = false,
  }) async {
    String? checkPrinters;
    String? resultSendPrintData;
    var order = ref.read(homeProvider).orderSelect;
    if (order == null) return (checkPrinters: null, error: null, resultSendPrintData: null);
    bool showLoading = processOrder || !ignorePrint;
    Set<PrinterModel> printers = <PrinterModel>{};
    Set<ProductModel> foods = <ProductModel>{}, drinks = <ProductModel>{};
    Set<ProductModel> productPrint = {};
    Set<PrinterModel> foodPrinterDefault = <PrinterModel>{}, barPrinterDefault = <PrinterModel>{};
    try {
      if (showLoading) {
        ref
            .read(homeProvider.notifier)
            .updateEvent(processOrder ? HomeEvent.cancelProductsCheckout : HomeEvent.sendPrintData);
      }
      if (!ignorePrint) {
        var menu = ref.read(menuProvider);
        for (var item in printerSelect) {
          switch (item.type) {
            case ProductPrinterType.drink:
              barPrinterDefault.add(item);
              break;
            case ProductPrinterType.food:
              foodPrinterDefault.add(item);
              break;
          }
        }
        for (var item in productCheckout) {
          var p = menu.products.firstWhereOrNull((e) => e.id == item.id);
          if (p != null) {
            var _product = p.copyWith(
              numberSelecting: item.quantityCancel,
              unitPrice: item.unitPrice,
            );
            productPrint.add(_product);
            switch (p.printerType) {
              case ProductPrinterType.drink:
                drinks.add(_product);
                break;
              case ProductPrinterType.food:
                foods.add(_product);
                break;
            }
          } else {
            var pChange = ProductModel(
              id: item.id,
              printerType: item.printerType,
              name: item.name,
              unit: item.unit,
              unitPrice: item.unitPrice,
              numberSelecting: item.quantityCancel,
            );
            productPrint.add(pChange);
            switch (item.printerType) {
              case ProductPrinterType.drink:
                drinks.add(pChange);
                break;
              case ProductPrinterType.food:
                foods.add(pChange);
                break;
            }
          }
        }
        if (useDefaultPrinter) {
          if (drinks.isNotEmpty) {
            printers.addAll(barPrinterDefault);
          }
          if (foods.isNotEmpty) {
            printers.addAll(foodPrinterDefault);
          }
        } else {
          printers = Set<PrinterModel>.from(printerSelect);
        }

        checkPrinters = await AppPrinterCommon.checkListPrintersStatus(printers.toList());
        if (checkPrinters != null) throw checkPrinters;
      }
      if (processOrder) {
        await _orderRepository.processOrderItem(
          order: order,
          total: 0,
          note: reason,
          cancel: true,
          productCheckout: productCheckout,
        );
        getProductCheckouts();
        getDataBill();
      }
      if (!ignorePrint) {
        if (useDefaultPrinter) {
          if (drinks.isNotEmpty) {
            resultSendPrintData = await ref.read(homeProvider.notifier).sendPrintData(
                  type: PrintTypeEnum.cancel,
                  note: reason,
                  products: drinks.toList(),
                  printers: barPrinterDefault.toList(),
                  timeOrder: 1,
                  printDirectly: !processOrder,
                  useDefaultPrinters: true,
                  totalBill: true,
                );
          }
          if (foods.isNotEmpty) {
            resultSendPrintData = await ref.read(homeProvider.notifier).sendPrintData(
                  type: PrintTypeEnum.cancel,
                  note: reason,
                  products: foods.toList(),
                  printers: foodPrinterDefault.toList(),
                  timeOrder: 1,
                  printDirectly: !processOrder,
                  useDefaultPrinters: true,
                  totalBill: true,
                );
          }
        } else {
          resultSendPrintData = await ref.read(homeProvider.notifier).sendPrintData(
                type: PrintTypeEnum.cancel,
                note: reason,
                products: productPrint.toList(),
                printers: printerSelect.toList(),
                timeOrder: 1,
                printDirectly: !processOrder,
                useDefaultPrinters: false,
                totalBill: true,
              );
        }
      }
      if (showLoading) ref.read(homeProvider.notifier).updateEvent(HomeEvent.normal);

      return (
        checkPrinters: checkPrinters,
        error: null,
        resultSendPrintData: resultSendPrintData,
      );
    } catch (ex) {
      if (showLoading) ref.read(homeProvider.notifier).updateEvent(HomeEvent.normal);

      return (
        checkPrinters: checkPrinters,
        error: ex.toString(),
        resultSendPrintData: resultSendPrintData
      );
    }
  }
}
