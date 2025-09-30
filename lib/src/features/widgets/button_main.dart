import 'package:aladdin_franchise/src/configs/app.dart';
import 'package:aladdin_franchise/src/configs/color.dart';
import 'package:aladdin_franchise/src/configs/text_style.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../generated/l10n.dart';

class ButtonMainWidget extends StatelessWidget {
  final double widthFactor;
  final Color? color;
  final Color? textColor;
  final String? textAction;
  final VoidCallback? onPressed;
  final VoidCallback? onLongPress;
  final ShapeBorder? shape;
  final double? fontSize;
  final EdgeInsetsGeometry? padding;
  const ButtonMainWidget({
    Key? key,
    this.widthFactor = 0.85,
    this.color,
    this.textAction,
    this.onPressed,
    this.shape,
    this.textColor,
    this.onLongPress,
    this.fontSize,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: widthFactor,
      child: MaterialButton(
        shape: shape ??
            RoundedRectangleBorder(borderRadius: AppConfig.borderRadiusMain),
        onPressed: () {
          onPressed?.call();
        },
        onLongPress: () {
          onLongPress?.call();
        },
        color: color ?? AppColors.bgButtonMain,
        textColor: Colors.white,
        child: Padding(
          padding: padding ?? const EdgeInsets.all(8.0),
          child: Text(
            textAction ?? S.current.confirm,
            style: AppTextStyle.semiBold(
              fontSize: fontSize,
              color: textColor ?? Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}

class AppButtonWidget extends StatelessWidget {
  const AppButtonWidget({
    super.key,
    this.textAction,
    this.fontSize,
    this.textColor,
    this.onTap,
    this.onLongPress,
    this.borderRadius,
    this.padding,
    this.width,
    this.color,
  });
  final String? textAction;
  final double? fontSize;
  final Color? textColor;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final BorderRadius? borderRadius;
  final EdgeInsets? padding;
  final double? width;

  final Color? color;

  @override
  Widget build(BuildContext context) {
    var br = borderRadius ?? AppConfig.borderRadiusMain;
    return InkWell(
      onTap: onTap,
      onLongPress: onLongPress,
      borderRadius: br,
      child: Container(
        width: width,
        padding:
            padding ?? const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          borderRadius: br,
          color: color ?? AppColors.mainColor,
        ),
        child: Text(
          textAction ?? S.current.confirm,
          style: AppTextStyle.semiBold(
            fontSize: fontSize,
            color: textColor ?? Colors.white,
          ),
        ),
      ),
    );
  }
}
