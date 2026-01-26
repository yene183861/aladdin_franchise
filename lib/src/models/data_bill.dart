/// Author: sondv
/// Created 23/02/2023 at 10:05

import 'package:aladdin_franchise/src/configs/app.dart';
import 'package:aladdin_franchise/src/configs/const.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'data_bill.freezed.dart';
part 'data_bill.g.dart';

@freezed
class PriceDataBill with _$PriceDataBill {
  @JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
  const factory PriceDataBill({
    @Default(0) dynamic totalPrice,
    @Default(0) dynamic totalPriceVoucher,
    @Default(0) dynamic totalPriceTax,
    @Default(0) dynamic totalPriceFinal,
    // số tiền mặt thu ngân nhận của khách
    @Default(0) double? receivedAmount,
  }) = _PriceDataBill;

  factory PriceDataBill.fromJson(Map<String, dynamic> json) => _$PriceDataBillFromJson(json);

  const PriceDataBill._();

  double getTotalPriceFinal() => double.tryParse(totalPriceFinal.toString()) ?? 0.0;
}

@freezed
class OrderDataBill with _$OrderDataBill {
  @JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
  const factory OrderDataBill({
    @Default(-1) int id,
    @Default('') String code,
    @Default('') String tableName,

    /// payment_method: 50
    int? paymentMethod,
    @Default(0) int amountChildren,
    @Default(0) int amountAdult,
    String? portrait,
    @Default(0) int numberPrintCompleted,
    @Default(0) int numberPrintTemporary,
    @Default([]) List<String> imageConfirms,
    @Default([]) List<dynamic> customerRatings,
    @Default([]) List<PaymentMethodDataBill> listPaymentMethod,
  }) = _OrderDataBill;

  factory OrderDataBill.fromJson(Map<String, dynamic> json) => _$OrderDataBillFromJson(json);

  const OrderDataBill._();

  String getInfoPayment() => code;
}

@freezed
class PaymentMethodDataBill with _$PaymentMethodDataBill {
  @JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
  const factory PaymentMethodDataBill({
    @Default(0) int keyMethod,
    @Default('') String method,
    @Default(0.0) double paymentAmount,
  }) = _PaymentMethodDataBill;

  factory PaymentMethodDataBill.fromJson(Map<String, dynamic> json) =>
      _$PaymentMethodDataBillFromJson(json);
}

///
/// [isChangeTax] - cấu hình món được sửa thuế (0 - k được sửa, 1 - được sửa)
@freezed
class LineItemDataBill with _$LineItemDataBill {
  @JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
  const factory LineItemDataBill({
    @Default(-1) int id,
    @Default('') String name,
    dynamic price,
    @Default(0) int count,
    @Default('_') String unit,
    dynamic tax,
    @Default('') String nameEn,
    @Default('') String codeProduct,
    @Default([]) List<SubLineItemDataBill> listItem,
    @Default(0) int isChangeTax,
    @Default({}) Map<String, dynamic> language,
  }) = _LineItemDataBill;

  factory LineItemDataBill.fromJson(Map<String, dynamic> json) => _$LineItemDataBillFromJson(json);

  const LineItemDataBill._();

  double getPriceNum() => double.tryParse(price.toString()) ?? 0;
  double getTaxView() {
    var taxValue = tax is num ? tax : (double.tryParse(tax) ?? 0);
    // final taxParse = double.parse(tax);
    return taxValue < 1 ? taxValue * 100 : taxValue;
  }

  double getTax() {
    return getTaxView() / 100;
  }

  String getNameView() => kAppLanguageLocal == AppLanguageLocal.vietnamese
      ? name
      : nameEn.trim().isEmpty
          ? name
          : nameEn;
}

@freezed
class SubLineItemDataBill with _$SubLineItemDataBill {
  @JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
  const factory SubLineItemDataBill({
    @Default(-1) int id,
    @Default('') String name,
    dynamic price,
    @Default(0) int count,
    @Default('_') String unit,
    dynamic tax,
    int? type,
  }) = _SubLineItemDataBill;

  factory SubLineItemDataBill.fromJson(Map<String, dynamic> json) =>
      _$SubLineItemDataBillFromJson(json);

  const SubLineItemDataBill._();
}

@freezed
class PaymentDataBillCheck with _$PaymentDataBillCheck {
  @JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
  const factory PaymentDataBillCheck({
    @Default('') String notes,
    @Default(0) double totalPayment,
    @Default(0) double paymentQrCode,
  }) = _PaymentDataBillCheck;

  factory PaymentDataBillCheck.fromJson(Map<String, dynamic> json) =>
      _$PaymentDataBillCheckFromJson(json);

  const PaymentDataBillCheck._();
}

@freezed
class ProductCheckoutUpdateTaxModel with _$ProductCheckoutUpdateTaxModel {
  @JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
  const factory ProductCheckoutUpdateTaxModel({
    @Default(0) int menuItemId,
    @Default('') String name,
    @Default('') String unit,
    @Default('') String codeProduct,
    @Default(0) double tax,
    @Default('') String unitPrice,
    @Default(0) double priceAfterDiscount,
    @Default('0') String quantity,
    @Default(0) double priceNew,
    @Default(0) double priceTax,
    @Default(0) double total,
    @Default(0) double discount,
  }) = _ProductCheckoutUpdateTaxModel;

  factory ProductCheckoutUpdateTaxModel.fromJson(Map<String, dynamic> json) =>
      _$ProductCheckoutUpdateTaxModelFromJson(json);

  const ProductCheckoutUpdateTaxModel._();

  String get taxView => (tax == tax.toInt() ? tax.toInt() : tax).toString();
}
