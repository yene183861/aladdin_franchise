import 'package:aladdin_franchise/src/configs/color.dart';
import 'package:flutter/material.dart';

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
