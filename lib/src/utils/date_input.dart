import 'dart:math';

import 'package:aladdin_franchise/generated/l10n.dart';
import 'package:flutter/services.dart';

class DateTextFormatter extends TextInputFormatter {
  static const _maxChars = 8;

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    String separator = '/';
    var text = _format(
      newValue.text,
      oldValue.text,
      separator,
    );

    return newValue.copyWith(
      text: text,
      selection: updateCursorPosition(
        oldValue,
        text,
      ),
    );
  }

  String _format(
    String value,
    String oldValue,
    String separator,
  ) {
    var isErasing = value.length < oldValue.length;
    var isComplete = value.length > _maxChars + 2;

    if (!isErasing && isComplete) {
      return oldValue;
    }

    value = value.replaceAll(separator, '');
    final result = <String>[];

    for (int i = 0; i < min(value.length, _maxChars); i++) {
      result.add(value[i]);
      if ((i == 1 || i == 3) && i != value.length - 1) {
        result.add(separator);
      }
    }

    return result.join();
  }

  TextSelection updateCursorPosition(
    TextEditingValue oldValue,
    String text,
  ) {
    var endOffset = max(
      oldValue.text.length - oldValue.selection.end,
      0,
    );

    var selectionEnd = text.length - endOffset;

    return TextSelection.fromPosition(TextPosition(offset: selectionEnd));
  }
}

String? checkInputDate(String value) {
  try {
    var data = value.split('/');
    var day = int.parse(data[0]);
    var month = int.parse(data[1]);
    var year = int.parse(data[2]);
    if (day < 0 ||
        day > 31 ||
        month < 0 ||
        month > 12 ||
        year <= 1911 ||
        year > 2200) {
      return S.current.invalid_date;
    }
    return null;
  } catch (ex) {
    return S.current.not_correct_format;
  }
}

class DateText2Formatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final oldValueLength = oldValue.text.length;
    final newValueLength = newValue.text.length;

    if (newValueLength > 0 && newValueLength > oldValueLength) {
      const maxLengthIncludeHyphen = 10;
      if (newValueLength > maxLengthIncludeHyphen) {
        return oldValue;
      }
      if (newValueLength == 2) {
        return newValue.copyWith(
          text: '${newValue.text}/',
          selection: const TextSelection.collapsed(offset: 3),
        );
      }
      if (newValueLength == 5) {
        return newValue.copyWith(
          text: '${newValue.text}/',
          selection: const TextSelection.collapsed(offset: 6),
        );
      }
    }
    return newValue;
  }
}
