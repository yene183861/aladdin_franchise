import 'package:collection/collection.dart';
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
      return NumberFormat.currency(locale: locale, symbol: symbol).format(data ?? 0.0).trim();
    } catch (ex) {
      return '';
    }
  }

  /// [removeStringEmpty] bỏ qua chuỗi rỗng (nếu là List<String>
  /// do có những case  ''.split(',') => ['']
  static bool checkListEqualsIgnoreOrder(List<dynamic> a, List<dynamic> b,
      {bool removeStringEmpty = true}) {
    List<dynamic> firstList = List<dynamic>.from(a);
    List<dynamic> secondList = List<dynamic>.from(b);
    if (removeStringEmpty) {
      if (a is List<String>) {
        firstList = a.map((e) => e.trim()).where((e) => e.isNotEmpty).toList();
      }
      if (b is List<String>) {
        secondList = b.map((e) => e.trim()).where((e) => e.isNotEmpty).toList();
      }
    }
    var res = const UnorderedIterableEquality().equals(firstList, secondList);
    // const SetEquality().equals(Set<dynamic>.from(firstList), Set<dynamic>.from(secondList));
    return res;
  }
}
