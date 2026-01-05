import 'package:aladdin_franchise/src/configs/app.dart';
import 'package:aladdin_franchise/src/configs/color.dart';
import 'package:aladdin_franchise/src/configs/text_style.dart';
import 'package:aladdin_franchise/src/features/dialogs/order/create_new/provider.dart';
import 'package:aladdin_franchise/src/features/dialogs/order/create_new/state.dart';
import 'package:aladdin_franchise/src/features/widgets/gap.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'reservation_count_widget.dart';

class CreateNewOrderTabWidget extends ConsumerWidget {
  const CreateNewOrderTabWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var tabSelect = ref.watch(createNewOrderDialogProvider.select((value) => value.tabSelect));
    return Container(
      clipBehavior: Clip.hardEdge,
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(AppConfig.sizeBorderRadiusMain),
      ),
      child: Row(
        children: CreateNewOrderTabEnum.values.map((e) {
          var selected = e == tabSelect;
          return Expanded(
            child: GestureDetector(
              onTap: () {
                ref.read(createNewOrderDialogProvider.notifier).onChangeTabSelect(e);
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                  color: selected ? AppColors.mainColor : null,
                  borderRadius: BorderRadius.circular(AppConfig.sizeBorderRadiusSecond),
                ),
                child: Center(
                    child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      child: Text(
                        e.title,
                        style: AppTextStyle.bold(
                          color: selected ? Colors.white : null,
                        ),
                      ),
                    ),
                    if (e == CreateNewOrderTabEnum.reservation) ...[
                      const Gap(4),
                      const SelectedTableReservationCountWidget(),
                    ],
                  ],
                )),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
