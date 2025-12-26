import 'package:aladdin_franchise/src/models/category.dart';
import 'package:aladdin_franchise/src/models/tag_product.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'category.freezed.dart';
part 'category.g.dart';

// @freezed
// class CategoryResponse with _$CategoryResponse {
//   @JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
//   const factory CategoryResponse({
//     required CategoryResponseData data,
//   }) = _CategoryResponse;

//   factory CategoryResponse.fromJson(Map<String, dynamic> json) => _$CategoryResponseFromJson(json);
// }

@freezed
class CategoryResponseData with _$CategoryResponseData {
  @JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
  const factory CategoryResponseData({
    required int status,
    required List<CategoryModel> data,
    List<TagProductModel>? tags,
  }) = _CategoryResponseData;

  factory CategoryResponseData.fromJson(Map<String, dynamic> json) =>
      _$CategoryResponseDataFromJson(json);
}
