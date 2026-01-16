import 'package:aladdin_franchise/src/configs/color.dart';
import 'package:aladdin_franchise/src/configs/text_style.dart';
import 'package:flutter/material.dart';

class ButtonCirMenuWidget extends StatelessWidget {
  final VoidCallback onPressed;
  final VoidCallback? onLongPressed;
  final Color? color;
  final double? radius;
  final IconData? icon;
  const ButtonCirMenuWidget({
    Key? key,
    required this.onPressed,
    this.icon,
    this.radius,
    this.color,
    this.onLongPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(100),
      onTap: () {
        onPressed.call();
      },
      onLongPress: () {
        onLongPressed?.call();
      },
      child: Padding(
        padding: const EdgeInsets.all(1.0),
        child: CircleAvatar(
          radius: radius ?? 22.5,
          backgroundColor: color ?? AppColors.bgButtonSquare,
          foregroundColor: Colors.white,
          child: Icon(
            icon,
            size: 26,
          ),
        ),
      ),
    );
  }
}
