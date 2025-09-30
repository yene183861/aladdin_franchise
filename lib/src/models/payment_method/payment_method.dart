/// Author: sondv
/// Created 29/03/2024 at 11:38

import 'package:aladdin_franchise/src/configs/app.dart';
import 'package:aladdin_franchise/src/configs/const.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'payment_method.freezed.dart';
part 'payment_method.g.dart';

/// [isVat] - PTTT được sử dụng khi =>  null: Tất cả | true: Lấy hoá đơn | false: Không lấy hoá đơn
///
///
@freezed
class PaymentMethod with _$PaymentMethod {
  @JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
  const factory PaymentMethod({
    @Default(-1) int key,
    @Default('Phương thức thanh toán') String name,
    @Default('Payment method') String nameEn,
    bool? isVat,
    @Default(false) bool isBank, // Sử dụng tài khoản ngân hàng
    @Default(false) bool isGateway, // Sử dụng cổng thanh toán
    @Default(false) bool isCash, // Tiền mặt
    @Default(false) bool isAtm, // Cà thẻ
    // bắt buộc chỉnh sửa thuế trước khi hoàn thành đơn
    // đơn MV + Grab, Shopee, ...
    @Default(false) bool requireEditTax,

    /// api get data bill
    dynamic paymentAmount,
    @Default(-1) int keyMethod,
    @Default('Phương thức thanh toán') String method,
  }) = _PaymentMethod;

  factory PaymentMethod.fromJson(Map<String, dynamic> json) =>
      _$PaymentMethodFromJson(json);

  const PaymentMethod._();
  String getNameView() => kAppLanguageLocal == AppLanguageLocal.vietnamese
      ? name
      : nameEn.trim().isEmpty
          ? name
          : nameEn;

  double getPaymentAmount() {
    if (paymentAmount == null) return 0.0;
    if (paymentAmount is String) {
      try {
        return double.tryParse(paymentAmount.trim()) ?? 0.0;
      } catch (ex) {
        return 0.0;
      }
    }
    if (paymentAmount is num) {
      return paymentAmount * 1.0;
    }
    return 0.0;
  }
}
