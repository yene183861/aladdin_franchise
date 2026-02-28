import 'package:aladdin_franchise/src/features/pages/table_layout/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'table_layout_setting.freezed.dart';
part 'table_layout_setting.g.dart';

@freezed
class TableLayoutSettingModel with _$TableLayoutSettingModel {
  @JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
  const factory TableLayoutSettingModel({
    @Default(0) int topChairs,
    @Default(0) int bottomChairs,
    @Default(0) int leftChairs,
    @Default(0) int rightChairs,
    // @Default(1) int floor,
    @Default(40.0) double chairWidth,
    @Default(12.0) double chairHeight,
    @Default(12.0) double chairToChairSpacing,
    @Default(6.0) double chairToTableSpacing,
    @Default(16.0) double tableEdge,
    @Default(200.0) double minTableHeight,
    @Default(250.0) double minTableWidth,
    @Default(4294967295) int availableTableColor,
    @Default(4294221325) int usingTableColor,
    @Default(4279179051) int reservedTableColor,
    @Default(8) double borderRadius,
    @Default(-1) int restaurantId,
  }) = _TableLayoutSettingModel;

  factory TableLayoutSettingModel.fromJson(Map<String, dynamic> json) =>
      _$TableLayoutSettingModelFromJson(json);

  const TableLayoutSettingModel._();

  Map<TableColorEnum, Color> get colorMap => {
        TableColorEnum.available: Color(availableTableColor),
        TableColorEnum.reserved: Color(reservedTableColor),
        TableColorEnum.using: Color(usingTableColor),
      };
}
