/// Author: sondv
/// Created 23/02/2023 at 10:05
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'restaurant_config.freezed.dart';
part 'restaurant_config.g.dart';

@freezed
class RestaurantConfigModel with _$RestaurantConfigModel {
  @JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
  const factory RestaurantConfigModel({
    required String address,
    required String ip,
    required String name,
    required bool orderOnline,
    required int style,
    bool? isLocal,
    bool? active,
    @Default('') String tags,
  }) = _RestaurantConfigModel;

  factory RestaurantConfigModel.fromJson(Map<String, dynamic> json) =>
      _$RestaurantConfigModelFromJson(json);
}

@freezed
class RestaurantFeatureConfigModel with _$RestaurantFeatureConfigModel {
  @JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
  const factory RestaurantFeatureConfigModel({
    @Default(false) bool useKds,
    @Default(false) bool useReception,
    @Default(false) bool autoOrder,
  }) = _RestaurantFeatureConfigModel;

  factory RestaurantFeatureConfigModel.fromJson(Map<String, dynamic> json) =>
      _$RestaurantFeatureConfigModelFromJson(json);
}
