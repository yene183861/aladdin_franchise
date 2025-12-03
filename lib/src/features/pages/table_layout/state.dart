import 'package:aladdin_franchise/src/data/enum/status.dart';
import 'package:aladdin_franchise/src/data/model/floor.dart';
import 'package:aladdin_franchise/src/data/model/table_layout_item.dart';
import 'package:aladdin_franchise/src/data/model/table_layout_setting.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'state.freezed.dart';

enum ChairPositionEnum {
  top,
  right,
  bottom,
  left,
}

extension ChairPositionEnumEx on ChairPositionEnum {
  String get title {
    switch (this) {
      case ChairPositionEnum.top:
        return 'Trên';
      case ChairPositionEnum.bottom:
        return 'Dưới';
      case ChairPositionEnum.left:
        return 'Trái';
      case ChairPositionEnum.right:
        return 'Phải';
    }
  }

  int get quarterTurn {
    switch (this) {
      case ChairPositionEnum.top:
        return 0;
      case ChairPositionEnum.right:
        return 1;
      case ChairPositionEnum.bottom:
        return 2;
      case ChairPositionEnum.left:
        return 3;
    }
  }
}

// ChairPositionEnum convertChairPositionEnumFromQuarterTurn(int turn) {
//   switch (turn) {
//     case 0:
//       return ChairPositionEnum.top;
//     case 1:
//       return ChairPositionEnum.right;
//     case 2:
//       return ChairPositionEnum.bottom;
//     case 3:
//       return ChairPositionEnum.left;
//     default:
//       return ChairPositionEnum.top;
//   }
// }

enum TableColorEnum {
  available,
  reserved,
  using,
}

extension TableColorEnumEx on TableColorEnum {
  String get title {
    switch (this) {
      case TableColorEnum.available:
        return 'Trống';
      case TableColorEnum.reserved:
        return 'Đặt chỗ';
      case TableColorEnum.using:
        return 'Đang sử dụng';
    }
  }

  Color get color {
    switch (this) {
      case TableColorEnum.available:
        return Colors.white;
      case TableColorEnum.reserved:
        return Color(0xFF0f172b);
      case TableColorEnum.using:
        return Color(0xFFf49e0d);
    }
  }

  int get colorValue {
    switch (this) {
      case TableColorEnum.available:
        return 4294967295;
      case TableColorEnum.reserved:
        return 4279179051;
      case TableColorEnum.using:
        return 4294221325;
    }
  }

  Color get borderColor {
    switch (this) {
      case TableColorEnum.available:
        return Colors.grey.shade300;
      case TableColorEnum.reserved:
        return Colors.grey.shade300;
      case TableColorEnum.using:
        return Colors.grey.shade300;
    }
  }
}

@freezed
class TableLayoutPageState with _$TableLayoutPageState {
  const factory TableLayoutPageState({
    @Default([]) List<TableLayoutItemModel> items,
    @Default('') String message,
    @Default(StatusEnum.normal) StatusEnum status,
    @Default(TableLayoutSettingModel()) TableLayoutSettingModel itemSetting,
    @Default([]) List<FloorModel> floors,
    FloorModel? floorSelect,
    @Default(60) int reservationTimeCheck,
    required DateTime date,
    required TimeOfDay fromTime,
    required TimeOfDay toTime,
    @Default(false) bool enableDragLayout,
    @Default([]) List<TableLayoutItemModel> itemDelete,
  }) = _TableLayoutPageState;
}
