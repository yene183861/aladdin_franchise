import 'package:aladdin_franchise/generated/l10n.dart';
import 'package:aladdin_franchise/src/configs/app.dart';
import 'package:aladdin_franchise/src/configs/color.dart';
import 'package:aladdin_franchise/src/configs/text_style.dart';
import 'package:aladdin_franchise/src/features/widgets/app_icon_widget.dart';
import 'package:aladdin_franchise/src/features/widgets/gap.dart';
import 'package:flutter/material.dart';

class AppButtonWithIcon extends StatelessWidget {
  final VoidCallback? onPressed;
  final String? textAction;
  final Color? color;
  final Color? textColor;
  final double? minWidth;
  final double? height;
  final IconData? icon;
  final String? svgPath;
  final double? iconSize;
  final EdgeInsetsGeometry? padding;
  final BorderRadius? borderRadius;
  final Color? iconColor;
  final double? rawTextSize;

  const AppButtonWithIcon({
    super.key,
    this.onPressed,
    this.textAction,
    this.color,
    this.textColor,
    this.minWidth,
    this.height,
    this.icon,
    this.svgPath,
    this.iconSize,
    this.padding,
    this.borderRadius,
    this.iconColor,
    this.rawTextSize,
  });

  @override
  Widget build(BuildContext context) {
    var br = borderRadius ?? AppConfig.borderRadiusSecond;
    return InkWell(
      onTap: onPressed,
      borderRadius: br,
      child: Ink(
        decoration: BoxDecoration(
          color: color ?? AppColors.mainColor,
          borderRadius: br,
        ),
        child: Container(
          padding: padding ?? const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: color ?? Colors.transparent,
            borderRadius: br,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (icon != null || svgPath != null) ...[
                ResponsiveIconWidget(
                  iconData: icon,
                  color: iconColor ?? Colors.white,
                  svgPath: svgPath,
                  iconSize: iconSize ?? 22,
                ),
                const Gap(4),
              ],
              Flexible(
                child: Text(
                  textAction ?? '',
                  style: AppTextStyle.medium(
                    color: textColor ?? Colors.white,
                    rawFontSize: rawTextSize,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
