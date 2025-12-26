import 'package:aladdin_franchise/src/models/order.dart';
import 'package:aladdin_franchise/src/models/table.dart';
import 'package:aladdin_franchise/src/models/waiter.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'order.freezed.dart';
part 'order.g.dart';

@freezed
class OrdersResponseData with _$OrdersResponseData {
  @JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
  const factory OrdersResponseData({
    required List<TableModel> notUse,
    required List<TableModel> using,
    required List<OrderModel> userUsing,
    List<WaiterModel>? waiters,
    dynamic ipOrder,
  }) = _OrdersResponseData;

  factory OrdersResponseData.fromJson(Map<String, dynamic> json) =>
      _$OrdersResponseDataFromJson(json);
}
