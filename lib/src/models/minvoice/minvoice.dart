/// Author: sondv
/// Created 12/03/2024 at 09:23

import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'minvoice.freezed.dart';
part 'minvoice.g.dart';

/// [isValidate]: Bỏ bắt buộc các trường nếu dùng MST cố định không lấy hoá đơn
/// [ma_so_thue, ten_cty, dia_chi]: lấy theo key bên masothue
/// Các key khác sẵn...
@freezed
class MInvoiceInfo with _$MInvoiceInfo {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory MInvoiceInfo({
    @Default(true) bool isValidate,
    @Default('') String name,
    @Default('') @JsonKey(name: 'ma_so_thue') String taxCode,
    @Default('') @JsonKey(name: 'ten_cty') String companyName,
    @Default('') @JsonKey(name: 'dia_chi') String address,
    @Default('') String email,
    @Default('') String bank,
    @Default('') String accountNumber,
    @Default('') String phone,
  }) = _MInvoiceInfo;

  factory MInvoiceInfo.fromJson(Map<String, dynamic> json) => _$MInvoiceInfoFromJson(json);

  const MInvoiceInfo._();

  bool isEmpty() => taxCode.isEmpty;
}
