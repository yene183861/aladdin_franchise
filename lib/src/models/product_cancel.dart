/// Author: sondv
/// Created 23/02/2023 at 10:05

import 'package:aladdin_franchise/src/configs/app.dart';
import 'package:aladdin_franchise/src/configs/const.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'product_cancel.freezed.dart';
part 'product_cancel.g.dart';

@freezed
class ProductCancelModel with _$ProductCancelModel {
  @JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
  const factory ProductCancelModel({
    required int id,
    required int menuItemId,
    @Default(0) int quantity,
    @Default('') String name,
    @Default('') String note,
    @Default('') String nameEn,
  }) = _ProductCancelModel;

  factory ProductCancelModel.fromJson(Map<String, dynamic> json) =>
      _$ProductCancelModelFromJson(json);

  const ProductCancelModel._();
  String getNameView() => kAppLanguageLocal == AppLanguageLocal.vietnamese
      ? name
      : nameEn.trim().isEmpty
          ? name
          : nameEn;
}
