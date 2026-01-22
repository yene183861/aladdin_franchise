import 'package:aladdin_franchise/src/configs/color.dart';
import 'package:aladdin_franchise/src/data/enum/status.dart';
import 'package:aladdin_franchise/src/data/model/floor.dart';
import 'package:aladdin_franchise/src/data/model/table_layout_item.dart';
import 'package:aladdin_franchise/src/data/model/table_layout_setting.dart';
import 'package:aladdin_franchise/src/features/common/process_state.dart';
import 'package:aladdin_franchise/src/models/history_order.dart';
import 'package:aladdin_franchise/src/models/table.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'state.freezed.dart';

enum TableStatusEnum {
  empty,
  serving,
  selected,
}

enum OrderActionEnum {
  transfer,
  update,
  none,
  cancel,
}

extension TableStatusEnumExt on TableStatusEnum {
  String get title {
    switch (this) {
      case TableStatusEnum.empty:
        return 'Trống';
      case TableStatusEnum.serving:
        return 'Đang ăn';
      case TableStatusEnum.selected:
        return 'Đang chọn';
    }
  }

  Color get bgColor {
    switch (this) {
      case TableStatusEnum.empty:
        return Colors.white;
      case TableStatusEnum.serving:
        return Colors.red.shade50;
      case TableStatusEnum.selected:
        return Colors.orange;
    }
  }

  Color get textColor {
    switch (this) {
      case TableStatusEnum.empty:
        return AppColors.textColor;
      case TableStatusEnum.serving:
        return AppColors.textColor;
      case TableStatusEnum.selected:
        return Colors.white;
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
    required DateTime fromDate,
    required DateTime toDate,
    @Default([]) List<HistoryOrderModel> historyOrder,
    @Default(ProcessState()) ProcessState historyOrderState,
    @Default({}) Set<TableModel> tableSelect,
  }) = _TableLayoutPageState;
}
