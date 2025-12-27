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
    @Default([]) List<TableModel> notUse,
    @Default([]) List<TableModel> using,
    @Default([]) List<OrderModel> userUsing,
    List<WaiterModel>? waiters,
    dynamic ipOrder,
  }) = _OrdersResponseData;

  factory OrdersResponseData.fromJson(Map<String, dynamic> json) =>
      _$OrdersResponseDataFromJson(json);
}
