import 'dart:io';

import 'package:aladdin_franchise/src/core/network/repository/responses/data_bill.dart';
import 'package:aladdin_franchise/src/data/enum/discount_type.dart';
import 'package:aladdin_franchise/src/data/model/restaurant/printer.dart';
import 'package:aladdin_franchise/src/models/atm_pos.dart';
import 'package:aladdin_franchise/src/models/category.dart';
import 'package:aladdin_franchise/src/models/customer/cusomter_portrait.dart';
import 'package:aladdin_franchise/src/models/customer/customer.dart';
import 'package:aladdin_franchise/src/models/customer/customer_policy.dart';
import 'package:aladdin_franchise/src/models/data_bill.dart';
import 'package:aladdin_franchise/src/models/employee_sale.dart';
import 'package:aladdin_franchise/src/models/order.dart';
import 'package:aladdin_franchise/src/models/order_history.dart';
import 'package:aladdin_franchise/src/models/order_invoice/order_invoice.dart';
import 'package:aladdin_franchise/src/models/payment_method/payment_method.dart';
import 'package:aladdin_franchise/src/models/policy_result.dart';
import 'package:aladdin_franchise/src/models/product.dart';
import 'package:aladdin_franchise/src/models/product_checkout.dart';
import 'package:aladdin_franchise/src/models/tag_product.dart';
import 'package:aladdin_franchise/src/models/user_bank.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:aladdin_franchise/src/data/model/o2o/chat_message_model.dart';
import 'package:aladdin_franchise/src/data/model/o2o/o2o_order_model.dart';

part 'state.freezed.dart';

enum HomeEvent {
  normal,
  checkCode,
  createNewOrder,
  updateOrder,
  cancelOrder,
  loadingChangeOrderCurrent,
  transferOrder,
  processOrder,
  cancelDishInOrder,
  paymentProcess,
  checkLocalNetwork,
  updateTypeOrderWaiter,
  errorInfo,
  switchAccount,
  switchAccountError,
  switchAccountSuccess,

  findingCustomer,
  createCustomer,
  checkTicket,
  removeTicket,
  findingTaxCode,
  updateInvoice,
  insertInvoice,

  processed,
  processError,
  checkPaymentMethod,
  removeCustomer,
  applyPolicy,
  printProduct,
  completeBillAgain,
  cancelProductsCheckout,

  // ticket
  sendTicket,
  getPaymentGateway,

  dynamicPosCallback,
  // chốt ca
  closingShift,

  // cập nhật thuế
  updateTax,

  getDataBill,
  getProductCheckout,

  checkPrinter,
  // coupon
  removeCoupon,

  /// lock order
  lockOrder,
  unlockOrder,

  /// reservation
  updateReservation,
  updateOrderReservation,

  // coupon, voucher
  addCoupon,
  saveO2oConfig,
  sendPrintData,
}

enum PageCommonState {
  normal,
  loading,
  success,
  error,
}

enum OrderTabEnum {
  ordering,
  ordered,
}

extension OrderTabEnumEx on OrderTabEnum {
  String get title {
    switch (this) {
      case OrderTabEnum.ordering:
        return 'Đang chọn';
      case OrderTabEnum.ordered:
        return 'Đã gọi';
    }
  }

  int get indexValue {
    switch (this) {
      case OrderTabEnum.ordering:
        return 0;
      case OrderTabEnum.ordered:
        return 1;
    }
  }
}

@freezed
class PageState with _$PageState {
  const factory PageState({
    @Default(PageCommonState.normal) PageCommonState status,
    @Default('') String messageError,
  }) = _PageState;
}

@freezed
class HomeState with _$HomeState {
  const factory HomeState({
    @Default(HomeEvent.normal) HomeEvent event,
    @Default('') String messageError,
    @Default(false) bool realtimeStatus,
    @Default(false) bool reconnectRedis,
    @Default(true) bool ignoreCheckCodeWaiter,

    /// đơn bàn
    OrderModel? orderSelect,
    @Default(false) bool lockedOrder,
    // @Default([]) List<ProductModel> productsSelecting,
    // @Default([]) List<ProductModel> productsSelected,
    // @Default([]) List<ProductCheckoutModel> productCheckout,
    @Default(PageState()) PageState productCheckoutState,
    CustomerModel? customer,
    @Default([]) List<CustomerPolicyModel> coupons,
    @Default([]) List<PolicyResultModel> vouchers,
    dynamic createVouchers,
    @Default(PageState(status: PageCommonState.success)) PageState applyPolicyState,
    @Default([]) List<PaymentMethod> paymentMethods,
    @Default(PageState()) PageState paymentMethodState,
    PaymentMethod? paymentMethodSelected,
    @Default(false) bool statusPaymentGateway,
    dynamic totalPaymentGateway,
    @Default([]) List<UserBankModel> banks,
    @Default(PageState()) PageState banksState,
    UserBankModel? bankSelect,
    @Default(0) double cashReceivedAmount,
    @Default(PageState()) PageState listAtmPosState,
    @Default([]) List<AtmPosModel> listAtmPos,
    AtmPosModel? atmPosSelect,
    OrderInvoice? invoice,
    @Default(PageState()) PageState orderInvoiceState,
    @Default(DataBillResponseData()) DataBillResponseData dataBill,
    @Default(PageState(status: PageCommonState.normal)) PageState dataBillState,
    @Default([]) List<File> imageBills,
    @Default(1) int numberOfAdults,
    @Default(0) int numberOfChildren,
    @Default('') String kitchenNote,
    CustomerPortrait? customerPortraitSelect,
    @Default('') String completeNote,
    @Default(false) bool printNumberOfPeople,

    // tự động cuộn xuống cuối danh sách món đang gọi
    @Default(true) bool autoScrollProducts,
    // id của sản phẩm được thay đổi gần nhất
    int? changedProductId,
    @Default(false) bool pinnedOrder,
    @Default(OrderTabEnum.ordered) OrderTabEnum orderTabSelect,
    @Default([OrderTabEnum.ordering, OrderTabEnum.ordered]) List<OrderTabEnum> orderTabs,
    // @Default(false) bool displayOrderHistory,
    @Default([]) List<OrderHistory> orderHistory,
    // o2o
    // @Default({}) Map<O2OOrderModel, Map<String, dynamic>> o2oData,
    // @Default(PageState()) PageState getO2ODataState,
    @Default([]) List<ChatMessageModel> chatMessages,
    @Default(PageState(status: PageCommonState.loading)) PageState getChatMessageState,
    @Default(DiscountTypeEnum.vnd) DiscountTypeEnum discountTypeSelect,
    @Default([]) List<PrinterModel> printers,
    @Default(PageState(status: PageCommonState.loading)) PageState printerState,
  }) = _HomeState;
}
