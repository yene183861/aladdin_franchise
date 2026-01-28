import 'package:aladdin_franchise/src/data/model/restaurant/printer.dart';
import 'package:aladdin_franchise/src/features/pages/home/state.dart';
import 'package:aladdin_franchise/src/models/product_checkout.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:io';

import 'package:aladdin_franchise/src/core/network/repository/responses/data_bill.dart';
import 'package:aladdin_franchise/src/data/enum/discount_type.dart';
import 'package:aladdin_franchise/src/data/model/notification.dart';
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

enum CheckoutEvent {
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

@freezed
class CheckoutPageState with _$CheckoutPageState {
  const factory CheckoutPageState({
    @Default(CheckoutEvent.normal) CheckoutEvent event,
    @Default('') String message,
    @Default([]) List<ProductCheckoutModel> productsCheckout,
    @Default({}) Set<PrinterModel> printerSelect,
    @Default(false) bool useDefaultPrinters,

    //
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
    @Default([]) List<OrderHistory> orderHistory,
    @Default(DiscountTypeEnum.vnd) DiscountTypeEnum discountTypeSelect,
  }) = _CheckoutPageState;
}
