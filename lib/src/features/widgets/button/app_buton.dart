import 'package:aladdin_franchise/generated/l10n.dart';
import 'package:aladdin_franchise/src/configs/app.dart';
import 'package:aladdin_franchise/src/configs/color.dart';
import 'package:aladdin_franchise/src/configs/text_style.dart';
import 'package:aladdin_franchise/src/features/widgets/app_icon_widget.dart';
import 'package:aladdin_franchise/src/features/widgets/gap.dart';
import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final double? widthFactor;
  final Color? color;
  final Color? textColor;
  final String? textAction;
  final VoidCallback? onPressed;
  final VoidCallback? onLongPress;
  final ShapeBorder? shape;
  final double? height;
  final IconData? icon;
  final String? svgPath;
  final double? iconSize;
  final Color? iconColor;
  final EdgeInsets? padding;
  final Color? disabledColor;
  final double? minWidth;
  const AppButton({
    super.key,
    this.widthFactor,
    this.color,
    this.textAction,
    this.onPressed,
    this.shape,
    this.textColor,
    this.onLongPress,
    this.height,
    this.icon,
    this.svgPath,
    this.iconSize,
    this.iconColor,
    this.padding,
    this.disabledColor,
    this.minWidth,
  });

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: widthFactor,
      child: MaterialButton(
        visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
        minWidth: minWidth,
        height: height,
        shape: shape ?? RoundedRectangleBorder(borderRadius: AppConfig.borderRadiusMain),
        onPressed: onPressed,
        onLongPress: onLongPress,
        color: color ?? AppColors.mainColor,
        textColor: Colors.white,
        disabledColor: disabledColor ?? AppColors.mainColor,
        child: Padding(
          padding: padding ?? const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
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
                  textAction ?? S.current.confirm,
                  style: AppTextStyle.medium(color: textColor ?? Colors.white),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
