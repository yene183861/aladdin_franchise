import 'package:aladdin_franchise/generated/l10n.dart';
import 'package:aladdin_franchise/src/configs/app.dart';
import 'package:aladdin_franchise/src/configs/text_style.dart';
import 'package:aladdin_franchise/src/features/widgets/gap.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EmptyDataWidget extends ConsumerWidget {
  const EmptyDataWidget({
    super.key,
    this.icon,
    this.message,
  });
  final IconData? icon;
  final String? message;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
        child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (icon != null) ...[
          Icon(
            icon!,
            color: Colors.grey,
          ),
          const Gap(4),
        ],
        Text(
          message ?? S.of(context).no_data,
          style: AppTextStyle.regular(
            color: Colors.grey,
            rawFontSize: AppConfig.defaultRawTextSize - 1.0,
          ),
        ),
      ],
    ));
  }
}
