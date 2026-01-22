import 'package:aladdin_franchise/src/configs/app.dart';
import 'package:aladdin_franchise/src/configs/text_style.dart';
import 'package:aladdin_franchise/src/features/widgets/gap.dart';
import 'package:flutter/material.dart';

import '../state.dart';

class StatusIndicator extends StatelessWidget {
  const StatusIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: TableStatusEnum.values
            .map((e) => _StatusItem(
                  label: e.title,
                  color: e.bgColor,
                ))
            .toList(),
      ),
    );
  }
}

class _StatusItem extends StatelessWidget {
  final String label;
  final Color color;

  const _StatusItem({
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Gap(12),
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
            border: Border.all(color: Colors.grey.shade300),
          ),
        ),
        const Gap(4),
        Text(
          label,
          style: AppTextStyle.regular(rawFontSize: AppConfig.defaultRawTextSize - 0.5),
        ),
      ],
    );
  }
}
