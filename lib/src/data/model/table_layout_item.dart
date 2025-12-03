import 'package:aladdin_franchise/src/models/table.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'table_layout_item.freezed.dart';
part 'table_layout_item.g.dart';

@freezed
class TableLayoutItemModel with _$TableLayoutItemModel {
  @JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
  const factory TableLayoutItemModel({
    TableModel? table,
    @Default(0.0) double xPos,
    @Default(0.0) double yPos,
    @Default('') String id,
    @Default(2) int topChair,
    @Default(2) int bottomChair,
    @Default(1) int leftChair,
    @Default(1) int rightChair,
    @Default('') String floorId,
    @Default(-1) int restaurantId,
    @Default(2) int typeOrder,
  }) = _TableLayoutItemModel;

  factory TableLayoutItemModel.fromJson(Map<String, dynamic> json) =>
      _$TableLayoutItemModelFromJson(json);
}
