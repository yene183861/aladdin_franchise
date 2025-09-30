import 'package:aladdin_franchise/generated/l10n.dart';

class FieldValidationUtils {
  static String? checkRequired(String? value) {
    if (value == null || value.trim().isEmpty) {
      return S.current.not_be_empty;
    }
    return null;
  }

  static String? checkInputNumberInt(String? value) {
    if (value == null || value.trim().isEmpty) {
      return S.current.not_be_empty;
    }

    final result = int.tryParse(value);
    if (result == null) {
      return S.current.value_invalid;
    }

    return null;
  }

  static String? validateEmail(String? value) {
    const pattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,8}$';
    final regex = RegExp(pattern);

    if (value == null || value.trim().isEmpty) {
      return S.current.not_be_empty;
    }
    return regex.hasMatch(value) ? null : S.current.email_invalid;
  }

  static String? validatePhone(String? value) {
    String pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
    RegExp regex = RegExp(pattern);

    if (value == null || value.trim().isEmpty) {
      return S.current.not_be_empty;
    }

    return regex.hasMatch(value) ? null : S.current.phone_invalid;
  }
}
