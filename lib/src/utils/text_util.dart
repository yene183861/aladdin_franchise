import 'package:aladdin_franchise/src/configs/text_style.dart';
import 'package:flutter/material.dart';

class TextUtil {
  static Size getTextSize({String text = '', TextStyle? textStyle}) {
    final textPainter = TextPainter(
      text: TextSpan(
        text: text,
        style: textStyle ?? AppTextStyle.regular(),
      ),
    );
    textPainter.textDirection = TextDirection.ltr;
    textPainter.layout(minWidth: 0, maxWidth: double.maxFinite);
    return textPainter.size;
  }

  static String convertPhone(String text) {
    var value = text.trim();
    if (value.startsWith('+')) {
      value = value.substring(1);
    }
    if (value.length >= 12) {
      var sb = value.substring(2);
      return sb;
    }
    if (value.startsWith('84')) {
      value = value.replaceFirst(RegExp('84'), '0');
    }
    return value;
  }
}
