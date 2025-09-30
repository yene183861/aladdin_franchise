import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'order_time.freezed.dart';
part 'order_time.g.dart';

@freezed
class OrderTimeModel with _$OrderTimeModel {
  @JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
  const factory OrderTimeModel({
    required int orderId,
    required List<ProductOrderTimeModel> products,
  }) = _OrderTimeModel;

  factory OrderTimeModel.fromJson(Map<String, dynamic> json) => _$OrderTimeModelFromJson(json);
}

@freezed
class ProductOrderTimeModel with _$ProductOrderTimeModel {
  @JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
  const factory ProductOrderTimeModel({
    required int productId,
    required int numberOfProduct,
    required DateTime time,
    required String? note,
  }) = _ProductOrderTimeModel;

  factory ProductOrderTimeModel.fromJson(Map<String, dynamic> json) =>
      _$ProductOrderTimeModelFromJson(json);
}
