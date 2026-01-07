import 'package:aladdin_franchise/src/configs/app.dart';
import 'package:aladdin_franchise/src/configs/color.dart';
import 'package:aladdin_franchise/src/configs/text_style.dart';
import 'package:aladdin_franchise/src/features/dialogs/order/transfer_order/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../state.dart';

class TransferOrderTab extends ConsumerWidget {
  const TransferOrderTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var tabSelect = ref.watch(transferOrderProvider.select((value) => value.tabSelect));
    return Container(
      clipBehavior: Clip.hardEdge,
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(AppConfig.sizeBorderRadiusMain),
      ),
      child: Row(
        children: TransferOrderTabEnum.values.map((e) {
          var selected = e == tabSelect;
          return Expanded(
            child: GestureDetector(
              onTap: () {
                ref.read(transferOrderProvider.notifier).onChangeTabSelect(e);
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                  color: selected ? AppColors.mainColor : null,
                  borderRadius: BorderRadius.circular(AppConfig.sizeBorderRadiusSecond),
                ),
                child: Center(
                  child: Text(
                    e.title,
                    style: AppTextStyle.bold(
                      color: selected ? Colors.white : null,
                    ),
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
