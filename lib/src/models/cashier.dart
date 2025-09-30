import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'cashier.freezed.dart';
part 'cashier.g.dart';

@freezed
class CashierModel with _$CashierModel {
  @JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
  const factory CashierModel({
    @Default(-1) int id,
    @Default('') String name,
    @Default('') String employeeCode,
  }) = _CashierModel;

  factory CashierModel.fromJson(Map<String, dynamic> json) =>
      _$CashierModelFromJson(json);
}
