/// Author: sondv
/// Created 23/02/2023 at 10:05

import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'check_food.freezed.dart';
part 'check_food.g.dart';

@freezed
class CheckFoodModel with _$CheckFoodModel {
  @JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
  const factory CheckFoodModel({
    required int orderId,
    required int productId,
  }) = _CheckFoodModel;

  factory CheckFoodModel.fromJson(Map<String, dynamic> json) => _$CheckFoodModelFromJson(json);
}
