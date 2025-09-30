import 'package:aladdin_franchise/src/configs/color.dart';
import 'package:aladdin_franchise/src/configs/text_style.dart';
import 'package:flutter/material.dart';

class CustomButtonAction extends StatelessWidget {
  const CustomButtonAction({
    super.key,
    required this.title,
    this.onTap,
    this.bgColor,
    this.textColor,
    this.borderRadius,
    this.disable = false,
  });
  final String title;
  final VoidCallback? onTap;
  final Color? bgColor;
  final Color? textColor;
  final BorderRadius? borderRadius;
  final bool disable;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (disable) return;
        onTap?.call();
      },
      borderRadius: borderRadius ?? BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: disable
              ? Colors.grey.shade300
              : bgColor ?? Colors.blue.withOpacity(0.2),
          borderRadius: borderRadius ?? BorderRadius.circular(12),
        ),
        child: Text(
          title,
          style: AppTextStyle.medium(
              color: disable
                  ? Colors.grey.shade500
                  : textColor ?? Colors.blue.shade800),
        ),
      ),
    );
  }
}
