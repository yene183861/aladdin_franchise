import 'package:flutter/material.dart';

class ResponsiveIconWidget extends StatelessWidget {
  const ResponsiveIconWidget({
    super.key,
    required this.iconData,
    this.color,
    this.iconSize = 22,
  });
  final IconData iconData;
  final double iconSize;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final textScaler = MediaQuery.textScalerOf(context);
    return Icon(
      iconData,
      size: textScaler.scale(iconSize),
      color: color,
    );
  }
}

class ResponsiveIconButtonWidget extends StatelessWidget {
  const ResponsiveIconButtonWidget({
    super.key,
    required this.iconData,
    this.color,
    this.onPressed,
    this.iconSize = 22,
  });
  final IconData iconData;
  final Color? color;
  final VoidCallback? onPressed;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
      onPressed: onPressed,
      icon: ResponsiveIconWidget(
        iconData: iconData,
        color: color,
        iconSize: iconSize,
      ),
    );
  }
}
