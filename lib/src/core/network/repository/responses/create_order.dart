import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_order.freezed.dart';
part 'create_order.g.dart';

@freezed
class CreateOrderResponse with _$CreateOrderResponse {
  @JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
  const factory CreateOrderResponse({
    int? status,
    dynamic message,
    int? orderId,
  }) = _CreateOrderResponse;

  factory CreateOrderResponse.fromJson(Map<String, dynamic> json) =>
      _$CreateOrderResponseFromJson(json);
}
