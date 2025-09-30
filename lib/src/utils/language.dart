import '../configs/app.dart';
import '../configs/const.dart';

class AppLanguageUtils {
  AppLanguageUtils._();
  static final AppLanguageUtils _instance = AppLanguageUtils._();
  factory AppLanguageUtils() => _instance;

  String getNameNormal(Map<String, dynamic>? data) {
    if (data == null) return '';
    final fallback = data[AppLanguageLocal.vietnamese]?.toString() ?? '';
    final result = data[kAppLanguageLocal]?.toString();
    return _sanitizeNull(result, fallback);
  }

  String getNameComplex(Map<String, dynamic>? data) {
    if (data == null) return '';
    final fallback =
        (data[AppLanguageLocal.vietnamese] as Map?)?['name']?.toString() ?? '';
    final result = (data[kAppLanguageLocal] as Map?)?['name']?.toString();
    return _sanitizeNull(result, fallback);
  }

  String getUnitComplex(Map<String, dynamic>? data) {
    if (data == null) return '';
    final fallback =
        (data[AppLanguageLocal.vietnamese] as Map?)?['unit']?.toString() ?? '';
    final result = (data[kAppLanguageLocal] as Map?)?['unit']?.toString();
    return _sanitizeNull(result, fallback);
  }

  String _sanitizeNull(dynamic value, String fallback) {
    final str = value?.toString().toLowerCase();
    return (str == null || str == 'null') ? fallback : value.toString();
  }
}
