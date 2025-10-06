import 'package:aladdin_franchise/src/models/product.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'product_selecting.freezed.dart';
part 'product_selecting.g.dart';

@freezed
class ProductSelectingModel with _$ProductSelectingModel {
  @JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
  const factory ProductSelectingModel({
    required int orderId,
    required List<ProductModel> products,
  }) = _ProductSelectingModel;

  factory ProductSelectingModel.fromJson(Map<String, dynamic> json) =>
      _$ProductSelectingModelFromJson(json);
}
