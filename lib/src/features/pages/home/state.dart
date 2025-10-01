import 'dart:io';

import 'package:aladdin_franchise/src/core/network/responses/data_bill.dart';
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
import 'package:aladdin_franchise/src/models/reservation/reservation.dart';
import 'package:aladdin_franchise/src/models/tag_product.dart';
import 'package:aladdin_franchise/src/models/user_bank.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:aladdin_franchise/src/models/o2o/chat_message_model.dart';
import 'package:aladdin_franchise/src/models/o2o/o2o_order_model.dart';

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
  updateReservation,

  findingCustomer,
  createCustomer,
  checkTicket,
  removeTicket,
  findingTaxCode,
  updateInvoice,
  insertInvoice,
  unlockOrder,
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
}

enum PageCommonState {
  normal,
  loading,
  success,
  error,
}

enum OrderTabEnum {
  all,
  ordering,
  ordered,
}

extension OrderTabEnumEx on OrderTabEnum {
  String get title {
    switch (this) {
      case OrderTabEnum.all:
        return 'Tất cả';
      case OrderTabEnum.ordering:
        return 'Đang chọn';
      case OrderTabEnum.ordered:
        return 'Đã gọi';
    }
  }

  int get indexValue {
    switch (this) {
      case OrderTabEnum.all:
        return 0;
      case OrderTabEnum.ordering:
        return 1;
      case OrderTabEnum.ordered:
        return 2;
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

    /// danh mục, món
    @Default(PageState(status: PageCommonState.loading)) PageState productsState,
    @Default([]) List<CategoryModel> categories,
    @Default([]) List<ProductModel> products,
    @Default([]) List<TagProductModel> tags,
    CategoryModel? categorySelect,
    SubCategoryModel? subCategorySelect,
    TagProductModel? tagSelect,

    ///
    @Default('') String search,
    @Default(true) bool ignoreCheckCodeWaiter,

    /// đơn bàn
    OrderModel? orderSelect,
    @Default(false) bool lockedOrder,

    /// danh sách món trong đơn hiện tại (các món đã gọi + các món đang gọi)
    @Default([]) List<ProductModel> currentOrderItems,

    /// các món đang gọi
    @Default([]) List<ProductModel> productsSelecting,

    /// các món đã chọn (map từ ProductCheckoutModel -> ProductModel)
    @Default([]) List<ProductModel> productsSelected,
    // các món đã gọi
    @Default([]) List<ProductCheckoutModel> productCheckout,
    @Default(PageState()) PageState productCheckoutState,
    //
    @Default(true) bool isOrderSaved,
    // tự động lưu món đang chọn vào DB
    @Default(false) bool autoSaveOrder,

    /// khách hàng
    CustomerModel? customer,

    /// mã giảm giá
    @Default([]) List<CustomerPolicyModel> coupons,
    // danh sách vourcher sau khi áp mã giảm giá
    @Default([]) List<PolicyResultModel> vouchers,
    dynamic createVouchers,

    /// các mã only cần xóa đi áp dụng lại
    @Default([]) List<CustomerPolicyModel> needApplyAgainOnlyCoupons,
    @Default(PageState(status: PageCommonState.success)) PageState applyPolicyState,

    /// phương thức thanh toán
    @Default([]) List<PaymentMethod> paymentMethods,
    @Default(PageState()) PageState paymentMethodState,
    PaymentMethod? paymentMethodSelected,
    // trạng thái thanh toán payoo
    @Default(false) bool statusPaymentGateway,

    // tiền nhận được từ payoo
    @Default(0.0) double totalPaymentGateway,

    // bank
    @Default([]) List<UserBankModel> banks,
    @Default(PageState()) PageState banksState,
    UserBankModel? bankSelect,

    // số tiền mặt khách đưa (áp dụng cho phương thức Tiền mặt)
    @Default(0) double cashReceivedAmount,

    // danh sách máy pos ATM
    @Default(PageState()) PageState listAtmPosState,
    @Default([]) List<AtmPosModel> listAtmPos,
    AtmPosModel? atmPosSelect,

    /// hoá đơn
    OrderInvoice? invoice,
    @Default(PageState()) PageState orderInvoiceState,
    //
    @Default(false) bool checkReloadWhenHiddenApp,

    /// thông tin tiền
    @Default(DataBillResponseData()) DataBillResponseData dataBill,
    @Default(PageState(status: PageCommonState.normal)) PageState dataBillState,

    /// pc sau khi phân bổ lại thuế
    @Default([]) List<ProductCheckoutUpdateTaxModel> productCheckoutUpdateTax,

    /// hoàn thành bill
    @Default([]) List<File> imageBills,
    @Default(1) int numberOfAdults,
    @Default(0) int numberOfChildren,
    @Default('') String kitchenNote,
    // nhóm chân dung KH
    CustomerPortrait? customerPortraitSelect,
    @Default([]) List<CustomerPortrait> customerPortraits,
    @Default('') String completeNote,
    // nv sale
    EmployeeSaleModel? employeeSaleSelect,
    @Default([]) List<EmployeeSaleModel> employeeSales,
    @Default(PageState()) PageState employeeSaleState,
    @Default(false) bool printNumberOfPeople,

    ///
    // tự động cuộn xuống cuối danh sách món đang gọi
    @Default(true) bool autoScrollProducts,

    /// id của sản phẩm được thay đổi gần nhất
    int? changedProductId,
    @Default(false) bool pinnedOrder,
    @Default(OrderTabEnum.ordering) OrderTabEnum orderTabSelect,
    @Default([OrderTabEnum.all]) List<OrderTabEnum> orderTabs,
    @Default(false) bool displayOrderHistory,
    @Default(false) bool cancelOrderItem,
    @Default([]) List<OrderHistory> orderHistory,
    // o2o
    @Default({}) Map<O2OOrderModel, Map<String, dynamic>> o2oData,
    @Default(PageState()) PageState getO2ODataState,
    @Default([]) List<ChatMessageModel> chatMessages,
    @Default(PageState(status: PageCommonState.loading)) PageState getChatMessageState,

    /// reservation
    @Default(PageState()) PageState getReservationsState,
    @Default([]) List<ReservationModel> reservations,
  }) = _HomeState;
}
