/// Author: sondv
/// Created 23/02/2023 at 10:05
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'waiter.freezed.dart';
part 'waiter.g.dart';

@freezed
class WaiterModel with _$WaiterModel {
  @JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
  const factory WaiterModel({
    required int id,
    required String name,
    @Default("No name") String fullName,
    @Default("") @JsonKey(name: 'user_name') String username,
    @Default("") String password,
  }) = _WaiterModel;

  factory WaiterModel.fromJson(Map<String, dynamic> json) => _$WaiterModelFromJson(json);
}
