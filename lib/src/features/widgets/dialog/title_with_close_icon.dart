import 'package:aladdin_franchise/src/configs/app.dart';
import 'package:aladdin_franchise/src/configs/text_style.dart';
import 'package:aladdin_franchise/src/features/widgets/gap.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TitleWithCloseIconDialog extends ConsumerWidget {
  const TitleWithCloseIconDialog({
    super.key,
    required this.title,
    this.icon,
    this.padding,
    this.onPressedCloseBtn,
  });
  final String title;
  final IconData? icon;
  final EdgeInsetsGeometry? padding;
  final void Function()? onPressedCloseBtn;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: Row(
        children: [
          if (icon != null) ...[
            Icon(icon),
            const Gap(8),
          ],
          Expanded(
              child: Text(
            title,
            style: AppTextStyle.bold(
              rawFontSize: AppConfig.defaultRawTextSize + 1.0,
            ),
          )),
          CloseButton(onPressed: onPressedCloseBtn),
        ],
      ),
    );
  }
}
