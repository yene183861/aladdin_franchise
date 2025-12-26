import 'package:aladdin_franchise/src/configs/app.dart';
import 'package:aladdin_franchise/src/configs/const.dart';
import 'package:aladdin_franchise/src/utils/language.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'category.freezed.dart';
part 'category.g.dart';

@freezed
class CategoryModel with _$CategoryModel {
  @JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
  const factory CategoryModel({
    dynamic id,
    required String title,
    String? slug,
    String? description,
    String? image,
    List<SubCategoryModel>? children,
    @Default({}) Map<String, dynamic> language,
  }) = _CategoryModel;

  factory CategoryModel.fromJson(Map<String, dynamic> json) => _$CategoryModelFromJson(json);

  const CategoryModel._();
  String getNameView() {
    final result = AppLanguageUtils().getNameNormal(language);
    return result.isEmpty ? title : result;
  }
}

@freezed
class SubCategoryModel with _$SubCategoryModel {
  @JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
  const factory SubCategoryModel({
    required int id,
    required String title,
    String? slug,
    String? description,
    String? image,
    @Default('') String titleEn,
    @Default({}) Map<String, dynamic> language,
  }) = _SubCategoryModel;

  factory SubCategoryModel.fromJson(Map<String, dynamic> json) => _$SubCategoryModelFromJson(json);

  const SubCategoryModel._();

  String getNameView() {
    final result = AppLanguageUtils().getNameNormal(language);
    return result.isEmpty ? title : result;
  }

  static String getModelInterface() {
    return '''required int id,
    required String title,
    String? slug,
    String? description,
    String? image,
    @Default('') String titleEn,
    @Default({}) Map<String, dynamic> language,
    ''';
  }
}
