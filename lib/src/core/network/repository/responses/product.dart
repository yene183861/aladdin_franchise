import 'package:aladdin_franchise/src/models/product.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'product.freezed.dart';
part 'product.g.dart';

@freezed
class ProductResponse with _$ProductResponse {
  @JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
  const factory ProductResponse({
    required ProductResponseData data,
  }) = _ProductResponse;

  factory ProductResponse.fromJson(Map<String, dynamic> json) => _$ProductResponseFromJson(json);
}

@freezed
class ProductResponseData with _$ProductResponseData {
  @JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
  const factory ProductResponseData({
    required int status,
    List<ProductModel>? data,
  }) = _ProductResponseData;

  factory ProductResponseData.fromJson(Map<String, dynamic> json) =>
      _$ProductResponseDataFromJson(json);
}
