import 'package:aladdin_franchise/src/configs/const.dart';
import 'package:aladdin_franchise/src/models/customer/cusomter_portrait.dart';
import 'package:aladdin_franchise/src/models/customer/customer_rating.dart';
import 'package:aladdin_franchise/src/models/restaurant.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../models/user.dart';

part 'login.freezed.dart';
part 'login.g.dart';

@freezed
class LoginResponse with _$LoginResponse {
  @JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
  const factory LoginResponse({
    required int? status,
    String? message,

    /// pendding
    @JsonKey(name: 'data') UserModel? user,
    String? token,
    RestaurantModel? restaurant,
    int? waiterId,
    @Default([]) ListCustomerRating questionRatings,
    @Default([])
    @JsonKey(name: 'portraits')
    List<CustomerPortrait> customerPortraits,
    @Default(kRedisPortDefault) int redisPort,
  }) = _LoginResponse;

  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(json);
  static String getModelInterface() {
    return '''required int? status,
    String? message,
    dynamic data,
    String? token,
    RestaurantModel? restaurant,
    int? waiterId,
    @Default([]) ListCustomerRating questionRatings
    @Default([]) @JsonKey(name: 'portraits') List<CustomerPortrait> customerPortraits,
    ''';
  }
}
