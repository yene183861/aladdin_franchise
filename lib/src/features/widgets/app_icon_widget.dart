import 'package:aladdin_franchise/src/core/storages/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ResponsiveIconWidget extends ConsumerWidget {
  const ResponsiveIconWidget({
    super.key,
    this.iconData,
    this.svgPath,
    this.color,
    this.iconSize = 22,
  });
  final IconData? iconData;
  final String? svgPath;
  final double iconSize;
  final Color? color;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textScaler = MediaQuery.textScalerOf(context);
    var useFontScale = ref.watch(appSettingProvider.select((value) => value.useFontScale));
    var size = useFontScale ? textScaler.scale(iconSize) : iconSize;
    if (iconData != null) {
      return Icon(
        iconData,
        size: size,
        color: color,
      );
    } else if (svgPath != null) {
      return SvgPicture.asset(
        svgPath!,
        width: size,
        height: size,
        color: color,
      );
    } else {
      return const SizedBox.shrink();
    }
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
