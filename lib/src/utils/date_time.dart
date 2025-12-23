import 'package:aladdin_franchise/generated/l10n.dart';
import 'package:aladdin_franchise/src/utils/app_log.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension AppDateTimeExtension on DateTime {
  bool compareToWithoutTime(DateTime otherDate) {
    return (year == otherDate.year && month == otherDate.month && day == otherDate.day);
  }

  DateTime onlyDate() => DateTime(year, month, day);
  DateTime get date => DateTime(year, month, day);
  DateTime get nextDate => DateTime(year, month, day).add(const Duration(days: 1));

  /// kiểm tra thời gian trong [start, end]
  bool checkInRangeTime({
    required DateTime start,
    required DateTime end,
    bool onlyDate = false,
    bool showDebugLog = false,
  }) {
    var startDate = onlyDate ? start.onlyDate() : start;
    var endDate = onlyDate ? end.nextDate.subtract(const Duration(milliseconds: 1)) : end;
    if (showDebugLog) {
      showLogs(onlyDate, flags: 'checkInRangeTime onlyDate');
      showLog('time check: $this, start: $start, end: $end', flags: 'input');
      showLog('startDate: $startDate, endDate: $endDate', flags: 'convert');
    }
    if (showDebugLog) {
      showLogs(onlyDate, flags: 'compare');
      showLog(isBefore(startDate), flags: 'isBefore(startDate)');
      showLog(isAfter(endDate), flags: 'isAfter(endDate)');
    }
    if (isBefore(startDate) || isAfter(endDate)) return false;
    return true;
  }
}

class DateTimeUtils {
  static final DateTimeUtils _instance = DateTimeUtils._();

  static DateTimeUtils get instance => _instance;

  DateTimeUtils._();

  final dateFormatYYYYMMDD = DateFormat("yyyy-MM-dd");
  final dateFormatDDMMYYYY = DateFormat("dd-MM-yyyy");
  final dateFormatHhMmSsDDMMYYYY = DateFormat("HH:mm:ss | dd-MM-yyyy");
  final dateFormatDDMMYYYYHhMmSs = DateFormat("dd-MM-yyyy HH:mm");
  final dateFormatHhMmSs = DateFormat("HH:mm:ss");

  static String formatToString({
    DateTime? time,
    String? newPattern,
  }) {
    if (time == null) return '';
    return DateFormat(newPattern ?? 'dd/MM/yyyy').format(time);
  }

  static DateTime parseToDateTimeFromHour({required String timeStr, DateTime? date}) {
    List<String> parts = timeStr.split(':');

    int hours = int.parse(parts[0]);
    int minutes = int.parse(parts[1]);

    return (date ?? DateTime.now()).onlyDate().copyWith(hour: hours, minute: minutes);
  }

  /// kiểm tra lịch đặt thuộc ca sáng (8h - 14h59) hay ca tối (15h -23h)
  ///
  /// timeCheck - thời gian kiểm tra
  ///
  /// referenceTime - thời gian làm mốc so sánh
  static bool checkInTimeShift({
    required DateTime timeCheck,
    DateTime? referenceTime,
  }) {
    var time = referenceTime ?? DateTime.now();
    final dateCheck = time.onlyDate();
    var startEveningTimeShift = dateCheck.copyWith(hour: 15);
    if (time.isBefore(startEveningTimeShift)) {
      return timeCheck.isAfter(dateCheck.copyWith(hour: 7, minute: 59, second: 59)) &&
          timeCheck.isBefore(startEveningTimeShift);
    }
    return !timeCheck.isBefore(startEveningTimeShift) &&
        timeCheck.isBefore(dateCheck.copyWith(hour: 23, minute: 0, second: 1));
  }

  static String calcElapsedTime(DateTime time) {
    var seconds = DateTime.now().difference(time).inSeconds;

    if (seconds < 60) {
      return S.current.just_done;
    }

    int minutes = seconds ~/ 60;
    if (minutes < 60) {
      return '$minutes ${S.current.minutes} ${S.current.time_before}';
    }
    int hours = seconds ~/ 3600;
    if (hours < 24) {
      return '$hours ${S.current.hours} ${S.current.time_before}';
    }
    int dates = seconds ~/ (3600 * 24);
    if (dates < 30) {
      return '$dates ${S.current.days} ${S.current.time_before}';
    }

    int months = dates ~/ 30;
    if (months < 12) {
      return '$months ${S.current.months} ${S.current.time_before}';
    } else {
      return '${months ~/ 12} ${S.current.years} ${S.current.time_before}';
    }
  }

  static DateTime parseDateTimeFromTimeOfDay(
      {required DateTime date, required TimeOfDay timeOfDay}) {
    return date.copyWith(
        hour: timeOfDay.hour, minute: timeOfDay.minute, second: 0, microsecond: 0, millisecond: 0);
  }
}

class DateTimePatterns {
  /// dd/MM/yyyy HH:mm:ss
  static const String dateTime = 'dd/MM/yyyy HH:mm:ss';

  /// yyyy-MM-dd HH:mm:ss
  static const String dateTime1 = 'yyyy-MM-dd HH:mm:ss';

  /// dd/MM/yyyy HH:mm
  static const String dateTimeNotSecond = 'dd/MM/yyyy HH:mm';

  /// dd/MM/yyyy
  static const String date = 'dd/MM/yyyy';

  /// HH:mm:ss | dd-MM-yyyy
  static const String dateTime2 = 'HH:mm:ss | dd-MM-yyyy';

  /// yyyy/MM/dd HH:mm:ss.SSSSSS
  static const String dateTime3 = 'yyyy/MM/dd HH:mm:ss.SSSSSS';
}
