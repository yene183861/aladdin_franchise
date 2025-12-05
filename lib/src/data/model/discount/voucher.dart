import 'package:aladdin_franchise/src/models/customer/customer_policy.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'voucher.freezed.dart';
part 'voucher.g.dart';

@freezed
class VoucherModel with _$VoucherModel {
  @JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
  const factory VoucherModel({
    dynamic id,
    @Default('') String name,
    @Default(0.0) double amount,
    dynamic type,
  }) = _VoucherModel;

  factory VoucherModel.fromJson(Map<String, dynamic> json) =>
      _$VoucherModelFromJson(json);
}
