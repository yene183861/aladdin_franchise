import 'package:aladdin_franchise/src/configs/app.dart';
import 'package:aladdin_franchise/src/configs/color.dart';
import 'package:aladdin_franchise/src/configs/text_style.dart';
import 'package:aladdin_franchise/src/features/widgets/gap.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// iconSize - default 24 với svgPath, theo theme setting nếu là  iconData
class AppIconButton extends StatelessWidget {
  const AppIconButton({
    super.key,
    this.onTap,
    this.icon,
    this.backgroundColor,
    this.textAction,
    this.borderRadius,
    this.iconColor,
    this.tooltip,
    this.svgPath,
    this.count = 0,
    this.padding,
    this.iconSize,
  }) : assert(icon != null || svgPath != null);
  final VoidCallback? onTap;
  final IconData? icon;
  final Color? backgroundColor;
  final String? textAction;
  final BorderRadius? borderRadius;
  final Color? iconColor;
  final String? tooltip;

  final String? svgPath;
  final int count;
  final EdgeInsetsGeometry? padding;
  final double? iconSize;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip ?? '',
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          IconButton(
            onPressed: onTap,
            padding: padding,
            icon: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (icon != null)
                  Icon(
                    icon,
                    color: iconColor,
                    size: iconSize,
                  )
                else if (svgPath != null)
                  SvgPicture.asset(
                    svgPath!,
                    color: iconColor,
                    width: iconSize ?? 24,
                    height: iconSize ?? 24,
                  )
                else
                  const SizedBox.shrink(),
                if (textAction != null) ...[
                  const Gap(4),
                  Flexible(
                    child: Text(textAction!),
                  ),
                ],
              ],
            ),
            style: ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(backgroundColor ?? Colors.grey.shade100),
              shape: WidgetStatePropertyAll(
                RoundedRectangleBorder(
                  borderRadius: borderRadius ?? BorderRadius.circular(50),
                ),
              ),
            ),
          ),
          if (count > 0)
            Positioned(
              top: -4,
              right: -4,
              child: Container(
                padding: EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: AppColors.redColor,
                  shape: BoxShape.circle,
                ),
                child: Text(
                  count > 99 ? '99+' : count.toString(),
                  style: AppTextStyle.bold(
                    color: Colors.white,
                    rawFontSize: AppConfig.defaultRawTextSize - 1.5,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
