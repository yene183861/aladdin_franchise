import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'employee_sale.freezed.dart';
part 'employee_sale.g.dart';

@freezed
class EmployeeSaleModel with _$EmployeeSaleModel {
  @JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
  const factory EmployeeSaleModel({
    @Default('') String employeeCode,
    @Default('') String fullName,

    /// 0 - tất cả, 2 - online, 1 - offline (ngược với hình thức bán hàng nhé)
    @Default(-1) int isOnline,
  }) = _EmployeeSaleModel;

  factory EmployeeSaleModel.fromJson(Map<String, dynamic> json) =>
      _$EmployeeSaleModelFromJson(json);
}
