/// Author: sondv
/// Created 23/02/2023 at 10:05

import 'package:aladdin_franchise/src/configs/app.dart';
import 'package:aladdin_franchise/src/configs/const.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'tag_product.freezed.dart';
part 'tag_product.g.dart';

@freezed
class TagProductModel with _$TagProductModel {
  @JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
  const factory TagProductModel({
    required int id,
    required String name,
    @Default('') String nameEn,
  }) = _TagProductModel;

  factory TagProductModel.fromJson(Map<String, dynamic> json) =>
      _$TagProductModelFromJson(json);

  const TagProductModel._();
  String getNameView() => kAppLanguageLocal == AppLanguageLocal.vietnamese
      ? name
      : nameEn.trim().isEmpty
          ? name
          : nameEn;

  static String getModelInterface() {
    return '''required int id,
    required String name,
    @Default('') String nameEn,
    ''';
  }
}
