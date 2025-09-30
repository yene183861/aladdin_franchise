/// Author: sondv
/// Created 17/02/2024 at 08:58
/// Dùng để hiển thị món đã gọi theo lượt

import 'package:aladdin_franchise/src/configs/app.dart';
import 'package:aladdin_franchise/src/configs/const.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'order_history.freezed.dart';
part 'order_history.g.dart';

@freezed
class OrderHistory with _$OrderHistory {
  @JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
  const factory OrderHistory({
    @Default(-1) int id,
    required DateTime createdAt,
    @Default(0) int timesOrder,
    @Default('') String notes,
    @Default([]) @JsonKey(name: 'line_items') List<ProductHistory> products,
  }) = _OrderHistory;

  factory OrderHistory.fromJson(Map<String, dynamic> json) =>
      _$OrderHistoryFromJson(json);
}

@freezed
class ProductHistory with _$ProductHistory {
  @JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
  const factory ProductHistory({
    @Default(-1) int id,
    @Default(-1) int orderTimeId,
    @Default(-1) int timesOrder,
    @Default(-1) int itemId,
    @Default('') String name,
    @Default('') String unit,
    @Default('') String notes,
    @Default(0) int quantity,
    @Default(0) int quantityCancel,
    @Default(0) int status,
    @Default(false) bool cancel,
    @Default('') String nameEn,
    // Auxiliary
    DateTime? timeByOrderHistory,
  }) = _ProductHistory;

  factory ProductHistory.fromJson(Map<String, dynamic> json) =>
      _$ProductHistoryFromJson(json);

  const ProductHistory._();
  String getNameView() => kAppLanguageLocal == AppLanguageLocal.vietnamese
      ? name
      : nameEn.trim().isEmpty
          ? name
          : nameEn;
}
