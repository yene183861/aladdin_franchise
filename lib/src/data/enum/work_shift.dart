import 'package:aladdin_franchise/generated/l10n.dart';
import 'package:aladdin_franchise/src/utils/date_time.dart';
import 'package:flutter/material.dart';

enum WorkShiftEnum {
  all,
  morning,
  evening,
}

extension WorkShiftEnumExt on WorkShiftEnum {
  String get title {
    switch (this) {
      case WorkShiftEnum.all:
        return S.current.all;
      case WorkShiftEnum.morning:
        return S.current.morning_shift;
      case WorkShiftEnum.evening:
        return S.current.evening_shift;
    }
  }

  TimeOfDay get startTime {
    switch (this) {
      case WorkShiftEnum.all:
        return const TimeOfDay(hour: 0, minute: 0);
      case WorkShiftEnum.morning:
        return const TimeOfDay(hour: 0, minute: 0);
      case WorkShiftEnum.evening:
        return const TimeOfDay(hour: 15, minute: 0);
    }
  }

  TimeOfDay get endTime {
    switch (this) {
      case WorkShiftEnum.all:
        return const TimeOfDay(hour: 23, minute: 59);
      case WorkShiftEnum.morning:
        return const TimeOfDay(hour: 14, minute: 59);
      case WorkShiftEnum.evening:
        return const TimeOfDay(hour: 23, minute: 59);
    }
  }

  IconData? get icon {
    switch (this) {
      case WorkShiftEnum.morning:
        return Icons.sunny;
      case WorkShiftEnum.evening:
        return Icons.nights_stay;

      default:
        return null;
    }
  }

  ({DateTime start, DateTime end}) getDateTime({DateTime? date}) {
    var start = (date ?? DateTime.now())
        .onlyDate()
        .copyWith(hour: startTime.hour, minute: startTime.minute);
    var end =
        (date ?? DateTime.now()).onlyDate().copyWith(hour: endTime.hour, minute: endTime.minute);

    return (start: start, end: end);
  }

  String get startTimeStr {
    switch (this) {
      case WorkShiftEnum.all:
        return '00:00';
      case WorkShiftEnum.morning:
        return '00:00';
      case WorkShiftEnum.evening:
        return '15:00';
    }
  }

  String get endTimeStr {
    switch (this) {
      case WorkShiftEnum.all:
        return '23:59';
      case WorkShiftEnum.morning:
        return '14:59';
      case WorkShiftEnum.evening:
        return '23:59';
    }
  }
}
