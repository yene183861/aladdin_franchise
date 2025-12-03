import 'package:aladdin_franchise/src/configs/app.dart';
import 'package:aladdin_franchise/src/configs/color.dart';
import 'package:aladdin_franchise/src/configs/text_style.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';

Future<List<DateTime?>?> showDatePickerDialog(
  BuildContext context, {
  List<DateTime?> value = const [],
  CalendarDatePicker2Type? calendarType,
  Size dialogSize = const Size(500, 450),
  Color? dialogBackgroundColor,
  bool Function(DateTime)? selectableDayPredicate,
}) async {
  final result = await showCalendarDatePicker2Dialog(
    context: context,
    config: CalendarDatePicker2WithActionButtonsConfig(
      calendarViewMode: DatePickerMode.day,
      centerAlignModePicker: true,
      controlsTextStyle: AppTextStyle.bold(
        color: Colors.black,
        rawFontSize: AppConfig.defaultRawTextSize + 1.0,
      ),
      dayTextStyle: AppTextStyle.regular(),
      todayTextStyle: AppTextStyle.regular(),
      selectedDayTextStyle: AppTextStyle.regular(color: Colors.white),
      weekdayLabelTextStyle: AppTextStyle.regular(color: Colors.grey.shade700),
      yearTextStyle: AppTextStyle.regular(),
      selectedYearTextStyle: AppTextStyle.regular(color: Colors.white),
      closeDialogOnCancelTapped: true,
      calendarType: calendarType ?? CalendarDatePicker2Type.single,
      currentDate: DateTime.now(),
      disabledDayTextStyle: AppTextStyle.regular(color: Colors.grey),
      customModePickerIcon: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.0),
        child: Icon(
          Icons.keyboard_arrow_down_rounded,
          size: 24,
          color: Colors.black,
        ),
      ),
      controlsHeight: 80,
      okButtonTextStyle: AppTextStyle.medium(color: AppColors.mainColor),
      cancelButtonTextStyle: AppTextStyle.medium(),
      buttonPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      selectableDayPredicate: selectableDayPredicate,
    ),
    dialogSize: dialogSize,
    value: value,
    borderRadius: BorderRadius.circular(AppConfig.sizeBorderRadiusMain),
    dialogBackgroundColor: dialogBackgroundColor,
  );
  return result;
}
