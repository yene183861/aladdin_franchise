/// Author: sondv
/// Created 23/02/2023 at 10:05

import 'package:aladdin_franchise/src/models/data_bill.dart';
import 'package:aladdin_franchise/src/models/payment_method/payment_method.dart';
import 'package:aladdin_franchise/src/models/policy_result.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'data_bill.freezed.dart';
part 'data_bill.g.dart';

@freezed
class DataBillResponse with _$DataBillResponse {
  @JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
  const factory DataBillResponse({
    required DataBillResponseData data,
  }) = _DataBillResponse;

  factory DataBillResponse.fromJson(Map<String, dynamic> json) =>
      _$DataBillResponseFromJson(json);
}

@freezed
class DataBillResponseData with _$DataBillResponseData {
  const factory DataBillResponseData({
    @Default(PriceDataBill()) PriceDataBill price,
    @Default(OrderDataBill()) OrderDataBill order,
    @Default([]) List<LineItemDataBill> orderLineItems,
    @Default([]) List<HistoryPolicyResultModel> vouchers,
    @Default('') String description,
    DataBillPrint? print,
    DataBillSale? sale,
  }) = _DataBillResponseData;

  factory DataBillResponseData.fromJson(Map<String, dynamic> json) =>
      _$DataBillResponseDataFromJson(json);
}

@freezed
class DataBillPrint with _$DataBillPrint {
  const factory DataBillPrint({
    OrderPrintModel? order,
    DataBillInfoPrintModel? infoPrint,
    @Default([]) List<LineItemDataBill> orderLineItems,
    @Default([]) List<HistoryPolicyResultModel> vouchers,
    @Default('') String description,

    /// payment_method: 'Payment SHOPEE'
    @Default('') @JsonKey(name: 'payment_method') String paymentMethod,
    @Default([])
    @JsonKey(name: 'list_payment_method')
    List<PaymentMethod> listPaymentMethod,
    PriceDataBill? price,
  }) = _DataBillPrint;

  factory DataBillPrint.fromJson(Map<String, dynamic> json) =>
      _$DataBillPrintFromJson(json);
}

@freezed
class DataBillSale with _$DataBillSale {
  const factory DataBillSale({
    @Default('') @JsonKey(name: 'e_sale_code') String eSaleCode,
    @Default('') @JsonKey(name: 'e_sale_name') String eSaleName,
  }) = _DataBillSale;

  factory DataBillSale.fromJson(Map<String, dynamic> json) =>
      _$DataBillSaleFromJson(json);
}

@freezed
class DataBillInfoPrintModel with _$DataBillInfoPrintModel {
  const factory DataBillInfoPrintModel({
    @Default('') String ip,
    @Default(-1) int port,
  }) = _DataBillInfoPrintModel;

  factory DataBillInfoPrintModel.fromJson(Map<String, dynamic> json) =>
      _$DataBillInfoPrintModelFromJson(json);
}

@freezed
class OrderPrintModel with _$OrderPrintModel {
  @JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
  const factory OrderPrintModel({
    @Default('') String code,
    @Default('') String tableName,
    DateTime? createdAt,
    DateTime? timeCompleted,
    @Default('') String cashierCompleted,
    @Default('') String cashierPrint,
    @Default('') String phoneNumber,
    @Default(0) int amountPeople,
    @Default(0) int amountChildren,
    @Default(0) int amountAdult,
    @Default(false) bool isPrintPeople,
    @Default(0) int numberPrintCompleted,
    @Default(0) int numberPrintTemporary,
  }) = _OrderPrintModel;

  factory OrderPrintModel.fromJson(Map<String, dynamic> json) =>
      _$OrderPrintModelFromJson(json);
}
