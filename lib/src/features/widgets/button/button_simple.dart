import 'package:aladdin_franchise/src/configs/app.dart';
import 'package:aladdin_franchise/src/configs/color.dart';
import 'package:aladdin_franchise/src/configs/text_style.dart';
import 'package:aladdin_franchise/src/features/widgets/gap.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../generated/l10n.dart';

class ButtonSimpleWidget extends StatelessWidget {
  final VoidCallback? onPressed;
  final String? textAction;
  final Color? color;
  final Color? textColor;
  final double? minWidth;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final double? textSize;
  final Widget? textWidget;
  final int? maxLines;

  final Widget? prefixIcon;
  const ButtonSimpleWidget({
    Key? key,
    this.onPressed,
    this.textAction,
    this.color,
    this.textColor,
    this.minWidth,
    this.height,
    this.padding,
    this.textSize,
    this.prefixIcon,
    this.textWidget,
    this.maxLines,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      minWidth: minWidth,
      height: height,
      color: color ?? AppColors.mainColor,
      textColor: textColor ?? Colors.white,
      onPressed: () {
        onPressed?.call();
      },
      shape: RoundedRectangleBorder(borderRadius: AppConfig.borderRadiusMain),
      child: Padding(
        padding: padding ?? const EdgeInsets.all(12),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (prefixIcon != null) ...[
              prefixIcon!,
              const Gap(4),
            ],
            Flexible(
              child: textWidget ??
                  Text(
                    textAction ?? S.current.confirm,
                    style: AppTextStyle.regular(
                      color: textColor ?? Colors.white,
                      rawFontSize: textSize,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: maxLines,
                    overflow: TextOverflow.ellipsis,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
