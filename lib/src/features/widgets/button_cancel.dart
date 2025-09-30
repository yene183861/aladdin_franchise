import 'package:aladdin_franchise/src/configs/app.dart';
import 'package:aladdin_franchise/src/configs/color.dart';
import 'package:aladdin_franchise/src/configs/text_style.dart';
import 'package:flutter/material.dart';

import '../../../generated/l10n.dart';

class ButtonCancelWidget extends StatelessWidget {
  final VoidCallback? onPressed;
  final String? textAction;
  final Color? color;
  final Color? textColor;
  final double? minWidth;
  final double? height;
  final EdgeInsetsGeometry? padding;
  const ButtonCancelWidget({
    Key? key,
    this.onPressed,
    this.textAction,
    this.color,
    this.textColor,
    this.minWidth,
    this.height,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      minWidth: minWidth,
      height: height,
      color: color ?? AppColors.bgButtonSecond,
      textColor: textColor ?? AppColors.tcButtonSecond,
      onPressed: () {
        onPressed?.call();
      },
      shape: RoundedRectangleBorder(borderRadius: AppConfig.borderRadiusMain),
      child: Padding(
        padding: padding ?? const EdgeInsets.all(12),
        child: Text(
          textAction ?? S.current.cancel,
          style: AppTextStyle.regular(color: AppColors.white),
        ),
      ),
    );
  }
}
