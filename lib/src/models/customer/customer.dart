import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'customer.freezed.dart';
part 'customer.g.dart';

@freezed
class CustomerModel with _$CustomerModel {
  @JsonSerializable(explicitToJson: true)
  const factory CustomerModel({
    dynamic id,
    @Default('') String name,
    @Default('') String phoneNumber,
    @Default('') String phone,
    String? dob,
    int? point,
    String? level,
    int? exchange,
    String? gender,
    @Default(0) double accumulatedMoney,
    DateTime? levelApprove,
  }) = _CustomerModel;

  factory CustomerModel.fromJson(Map<String, dynamic> json) => _$CustomerModelFromJson(json);
}
