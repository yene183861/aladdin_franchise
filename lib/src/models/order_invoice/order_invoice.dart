/// Author: sondv
/// Created 12/03/2024 at 14:42

import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'order_invoice.freezed.dart';
part 'order_invoice.g.dart';

/// [isValidate]: Bỏ bắt buộc các trường nếu dùng MST cố định không lấy hoá đơn
@freezed
class OrderInvoice with _$OrderInvoice {
  @JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
  const factory OrderInvoice({
    @Default(true) bool isValidate,
    @Default('') String name,
    @Default('') String taxCode,
    @Default('') String companyName,
    @Default('') String address,
    @Default('') String email,
    @Default('') String bank,
    @Default('') String accountNumber,
    @Default('') String phone,
    @Default('') String maDvqhns,
    @Default('') String cccdan,
  }) = _OrderInvoice;

  factory OrderInvoice.fromJson(Map<String, dynamic> json) =>
      _$OrderInvoiceFromJson(json);

  const OrderInvoice._();

  bool isEmpty() =>
      companyName.isEmpty && address.isEmpty && email.isEmpty && phone.isEmpty;
}
