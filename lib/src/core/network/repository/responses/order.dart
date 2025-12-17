import 'package:aladdin_franchise/src/models/order.dart';
import 'package:aladdin_franchise/src/models/table.dart';
import 'package:aladdin_franchise/src/models/waiter.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'order.freezed.dart';
part 'order.g.dart';

@freezed
class OrdersResponse with _$OrdersResponse {
  @JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
  const factory OrdersResponse({
    required int status,
    required OrdersResponseData data,
  }) = _OrdersResponse;

  factory OrdersResponse.fromJson(Map<String, dynamic> json) =>
      _$OrdersResponseFromJson(json);
  static String getModelInterface() {
    return '''required int status,
    required OrdersResponseData data,
    OrdersRepositoryData{
      required List<TableModel> notUse,
      required List<TableModel> using,
      required List<OrderModel> userUsing,
      dynamic ipOrder,
      @Default([]) List<OrderModel> waitingNotUse,
      ---
      TableModel{
        required int id,
        String? name,
        int? capacity,
        int? status,
        int? restaurantId,
      }
    }
    ''';
  }
}

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
