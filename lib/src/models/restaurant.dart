import 'package:aladdin_franchise/src/configs/const.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'payment_method/redis_gateway_payment.dart';

part 'restaurant.freezed.dart';
part 'restaurant.g.dart';

@freezed
class RestaurantModel with _$RestaurantModel {
  @JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
  const factory RestaurantModel({
    required int id,
    String? name,
    String? description,
    String? address,
    int? tableStatus,
    String? currentStatus,
    String? image,
    String? logo,
    @Default(false) bool posStatus,
    @Default(AreaStatus.full) int areaStatus,
    @Default(false) bool o2oStatus,
    @Default('') String urlServerO2o,
    @Default(RedisGatewayPayment())
    @JsonKey(name: 'redis_production')
    RedisGatewayPayment redisGatewayPayment,
    @Default(false) bool reservationStatus,
  }) = _RestaurantModel;

  factory RestaurantModel.fromJson(Map<String, dynamic> json) =>
      _$RestaurantModelFromJson(json);
}
