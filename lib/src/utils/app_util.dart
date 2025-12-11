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
}
