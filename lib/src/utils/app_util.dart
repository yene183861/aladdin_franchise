import 'package:intl/intl.dart';

class AppUtils {
  static double? convertToDouble(dynamic value) {
    if (value == null) return null;
    if (value is String) return double.tryParse(value);
    if (value is num) return value * 1.0;
    return null;
  }

  static String? getPercentValue(dynamic data, [bool showSymbol = true]) {
    var value = data is double ? data : convertToDouble(data);
    if (value == null) return null;
    return '${value.toInt()}${showSymbol ? '%' : ''}';
  }

  static String formatCurrency({String symbol = '', String locale = 'vi', dynamic value}) {
    try {
      var data = convertToDouble(value);
      return NumberFormat.currency(locale: locale, symbol: '').format(data ?? 0.0);
    } catch (ex) {
      return '';
    }
  }
}
