import 'package:intl/intl.dart';

class ParsingUtils {
  static int parseInt(dynamic value) {
    if (value == null) {
      return 0;
    }
    if (value is String) {
      return int.parse(value);
    }
    return value;
  }

  static bool parseBool(dynamic value) {
    if (value == null) {
      return false;
    }
    if (value is String) {
      return bool.parse(value);
    }
    return value;
  }

  static List<int> parseListInt(dynamic value) {
    if (value == null) {
      return [];
    }
    if (value is String) {
      final data = value.replaceAll('[', '').replaceAll(']', '');
      if (data.trim().isEmpty) return [];
      return data.split(',').map((e) => int.parse(e)).toList();
    }
    return List<int>.from(value);
  }

  static String formatDateTime(DateTime value) {
    return DateFormat('yyyy-MM-dd').format(value);
  }
}
