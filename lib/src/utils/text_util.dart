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
}
