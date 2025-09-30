/// Author: sondv
/// Created 06/01/2024 at 11:26

import 'package:aladdin_franchise/src/configs/app.dart';
import 'package:aladdin_franchise/src/configs/const.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'customer_rating.freezed.dart';
part 'customer_rating.g.dart';

typedef ListCustomerRating = List<CustomerRating>;

@freezed
class CustomerRating with _$CustomerRating {
  @JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
  const factory CustomerRating({
    @Default(-1) int key,
    @Default('') String name,
    @Default(0) int maxStar, // max_star
    @Default(0) int star,
    @Default('') String note,
    @Default('') String nameEn,
    @Default([]) ListCustomerRatingHint hints,
  }) = _CustomerRating;

  factory CustomerRating.fromJson(Map<String, dynamic> json) =>
      _$CustomerRatingFromJson(json);

  const CustomerRating._();

  bool isEmptyOrError() => key == -1 || (star == 0 && note.isEmpty);

  String getNameView() => kAppLanguageLocal == AppLanguageLocal.vietnamese
      ? name
      : nameEn.isEmpty
          ? name
          : nameEn;
}

typedef ListCustomerRatingHint = List<CustomerRatingHint>;

@freezed
class CustomerRatingHint with _$CustomerRatingHint {
  const factory CustomerRatingHint({
    @Default(0) int star,
    @Default('') String content,
  }) = _CustomerRatingHint;

  factory CustomerRatingHint.fromJson(Map<String, dynamic> json) =>
      _$CustomerRatingHintFromJson(json);
}

@freezed
class CustomerRatingSaveLocal with _$CustomerRatingSaveLocal {
  @JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
  const factory CustomerRatingSaveLocal({
    required int orderId,
    required ListCustomerRating customerRating,
  }) = _CustomerRatingSaveLocal;

  factory CustomerRatingSaveLocal.fromJson(Map<String, dynamic> json) =>
      _$CustomerRatingSaveLocalFromJson(json);
}
