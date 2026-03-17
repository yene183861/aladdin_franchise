import 'dart:io';

import 'package:aladdin_franchise/src/core/network/repository/responses/data_bill.dart';
import 'package:aladdin_franchise/src/data/enum/discount_type.dart';
import 'package:aladdin_franchise/src/data/model/restaurant/printer.dart';
import 'package:aladdin_franchise/src/features/pages/home/state.dart';
import 'package:aladdin_franchise/src/models/atm_pos.dart';
import 'package:aladdin_franchise/src/models/customer/cusomter_portrait.dart';
import 'package:aladdin_franchise/src/models/customer/customer.dart';
import 'package:aladdin_franchise/src/models/customer/customer_policy.dart';
import 'package:aladdin_franchise/src/models/order_history.dart';
import 'package:aladdin_franchise/src/models/order_invoice/order_invoice.dart';
import 'package:aladdin_franchise/src/models/payment_method/payment_method.dart';
import 'package:aladdin_franchise/src/models/policy_result.dart';
import 'package:aladdin_franchise/src/models/product_checkout.dart';
import 'package:aladdin_franchise/src/models/user_bank.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'state.freezed.dart';

@freezed
class CheckoutPageState with _$CheckoutPageState {
  const factory CheckoutPageState({
    @Default([]) List<ProductCheckoutModel> productsCheckout,
    @Default('') String message,
    @Default({}) Set<PrinterModel> printerSelect,
    @Default(false) bool useDefaultPrinters,
  }) = _CheckoutPageState;
}

enum CheckoutEvent {
  normal,
  findingCustomer,
  removeCustomer,
  createCustomer,
  //
  addCoupon,
  removeCoupon,
  applyPolicy,
  // tax
  updateTax,
  // invoice
  updateInvoice,
  insertInvoice,
  processed,
  processError,
  //
  getDataBill,
  getProductCheckout,
  getInvoice,
  paymentProcess,
  completeBillAgain,

  dynamicPosCallback,
  getPaymentGateway,
}

@freezed
class CheckoutState with _$CheckoutState {
  const factory CheckoutState({
    @Default(CheckoutEvent.normal) CheckoutEvent event,
    @Default('') String message,
    //
    @Default([]) List<ProductCheckoutModel> productCheckout,
    @Default(PageState()) PageState productCheckoutState,
    CustomerModel? customer,
    @Default([]) List<OrderHistory> orderHistory,
    // invoice
    @Default(PageState()) PageState invoiceState,
    OrderInvoice? invoice,
    // data bill
    @Default(PageState()) PageState dataBillState,
    @Default(DataBillResponseData()) DataBillResponseData dataBill,
    // coupons + voucher
    @Default([]) List<CustomerPolicyModel> coupons,
    @Default([]) List<PolicyResultModel> vouchers,
    dynamic createVouchers,
    @Default(DiscountTypeEnum.vnd) DiscountTypeEnum discountTypeSelect,
    @Default(PageState(status: PageCommonState.success)) PageState applyPolicyState,

    /// guest
    @Default(1) int numberOfAdults,
    @Default(0) int numberOfChildren,

    /// payment
    // payment method
    @Default([]) List<PaymentMethod> paymentMethods,
    @Default(PageState()) PageState paymentMethodState,
    PaymentMethod? paymentMethodSelect,
    // banks
    @Default([]) List<UserBankModel> banks,
    @Default(PageState()) PageState banksState,
    UserBankModel? bankSelect,
    // atm
    @Default(PageState()) PageState listAtmPosState,
    @Default([]) List<AtmPosModel> listAtmPos,
    AtmPosModel? atmPosSelect,
    // gateway
    @Default(false) bool statusPaymentGateway,
    dynamic totalPaymentGateway,
    // cash payment
    @Default(0) double cashReceivedAmount,
    // other payment info
    @Default([]) List<File> imageBills,
    CustomerPortrait? customerPortraitSelect,
    @Default('') String completeNote,
    @Default(false) bool printNumberOfPeople,
  }) = _CheckoutState;
}
