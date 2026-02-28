import 'package:aladdin_franchise/src/configs/app.dart';
import 'package:aladdin_franchise/src/configs/color.dart';
import 'package:aladdin_franchise/src/configs/text_style.dart';
import 'package:aladdin_franchise/src/features/pages/table_layout_group/table_layout_new/state.dart';
import 'package:aladdin_franchise/src/features/widgets/gap.dart';
import 'package:aladdin_franchise/src/models/table.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TableCard extends ConsumerWidget {
  final TableModel item;
  final bool serving;
  final bool selected;

  final VoidCallback? onLongPress;
  final VoidCallback? onTap;

  const TableCard({
    super.key,
    required this.item,
    this.serving = false,
    this.selected = false,
    this.onLongPress,
    this.onTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var bgColor = TableStatusEnum.empty.bgColor;
    var textColor = TableStatusEnum.empty.textColor;
    if (serving) {
      bgColor = TableStatusEnum.serving.bgColor;
      textColor = TableStatusEnum.serving.textColor;
    }
    if (selected) {
      bgColor = TableStatusEnum.selected.bgColor;
      textColor = TableStatusEnum.selected.textColor;
    }

    return InkWell(
      borderRadius: AppConfig.borderRadiusMain,
      onLongPress: onLongPress,
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: AppConfig.borderRadiusMain,
          border: selected ? null : Border.all(color: Colors.grey.shade200),
          boxShadow: [
            if (selected)
              BoxShadow(
                color: bgColor,
                blurRadius: 12,
                spreadRadius: 2,
                offset: Offset.zero,
              ),
          ],
        ),
        child: Stack(
          alignment: Alignment.center,
          clipBehavior: Clip.hardEdge,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Bàn',
                  style: AppTextStyle.bold(color: textColor.withOpacity(0.7)),
                ),
                const Gap(4),
                Text(
                  item.name ?? '',
                  style: AppTextStyle.bold(
                    color: textColor,
                    rawFontSize: AppConfig.defaultRawTextSize + 2.0,
                  ),
                ),
                const Gap(4),
              ],
            ),
            if (serving) ...[
              Positioned(
                top: 20,
                right: 20,
                child: Badge(
                  backgroundColor: AppColors.redColor.withOpacity(0.7),
                  largeSize: 12,
                  smallSize: 12,
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  width: double.maxFinite,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                      color: selected ? AppColors.white : AppColors.redColor.withOpacity(0.1),
                      borderRadius: const BorderRadius.vertical(bottom: Radius.circular(12)),
                      border: Border.all(color: bgColor, width: 0.5)),
                  child: Text(
                    'ĐANG ĂN',
                    style: AppTextStyle.bold(
                      color: AppColors.redColor,
                      rawFontSize: AppConfig.defaultRawTextSize - 1.5,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
            if (onTap == null)
              Positioned.fill(
                  child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.4),
                  borderRadius: AppConfig.borderRadiusMain,
                ),
              )),
          ],
        ),
      ),
    );
  }
}
