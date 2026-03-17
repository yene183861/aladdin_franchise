import 'package:aladdin_franchise/generated/l10n.dart';
import 'package:aladdin_franchise/src/data/model/notification.dart';
import 'package:aladdin_franchise/src/models/order.dart';
import 'package:aladdin_franchise/src/models/order_invoice/order_invoice.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:aladdin_franchise/src/data/model/o2o/chat_message_model.dart';

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

  addCustomerToOrder,
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
        return S.current.selecting_dish;
      case OrderTabEnum.ordered:
        return S.current.selected_dish;
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

    // tự động cuộn xuống cuối danh sách món đang gọi
    @Default(true) bool autoScrollProducts,
    // id của sản phẩm được thay đổi gần nhất
    int? changedProductId,
    @Default(false) bool pinnedOrder,
    @Default(OrderTabEnum.ordered) OrderTabEnum orderTabSelect,
    @Default([OrderTabEnum.ordering, OrderTabEnum.ordered])
    List<OrderTabEnum> orderTabs,
    @Default([]) List<ChatMessageModel> chatMessages,
    @Default(PageState(status: PageCommonState.loading))
    PageState getChatMessageState,
    @Default([]) List<NotificationModel> notifications,
  }) = _HomeState;
}
