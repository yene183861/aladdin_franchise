import 'package:aladdin_franchise/src/configs/app.dart';
import 'package:aladdin_franchise/src/configs/color.dart';
import 'package:aladdin_franchise/src/configs/text_style.dart';
import 'package:aladdin_franchise/src/features/pages/login/view.dart';
import 'package:flutter/material.dart';

import '../../../generated/l10n.dart';

class ButtonWithIconWidget extends StatelessWidget {
  final VoidCallback? onPressed;
  final String? textAction;
  final Color? color;
  final Color? textColor;
  final double? minWidth;
  final double? height;
  final IconData? icon;
  final EdgeInsetsGeometry? padding;
  final ShapeBorder? shape;
  final double? elevation;
  final Widget? iconWidget;
  const ButtonWithIconWidget({
    Key? key,
    this.onPressed,
    this.textAction,
    this.color,
    this.textColor,
    this.minWidth,
    this.height,
    this.icon,
    this.padding,
    this.shape,
    this.elevation,
    this.iconWidget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      elevation: elevation,
      minWidth: minWidth,
      height: height,
      color: color ?? AppColors.mainColor,
      textColor: textColor ?? Colors.white,
      onPressed: () {
        onPressed?.call();
      },
      shape: shape ??
          RoundedRectangleBorder(borderRadius: AppConfig.borderRadiusMain),
      child: Padding(
        padding: padding ?? const EdgeInsets.all(12),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            iconWidget ??
                (icon != null
                    ? ResponsiveIconWidget(iconData: icon!)
                    : const SizedBox.shrink()),
            const SizedBox(width: 8),
            Text(
              textAction ?? S.current.confirm,
              style: AppTextStyle.regular(color: AppColors.tcButtonMain),
            ),
          ],
        ),
      ),
    );
  }
}
