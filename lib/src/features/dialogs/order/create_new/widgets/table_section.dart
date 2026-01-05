import 'package:aladdin_franchise/generated/l10n.dart';
import 'package:aladdin_franchise/src/configs/color.dart';
import 'package:aladdin_franchise/src/configs/enums/type_order.dart';
import 'package:aladdin_franchise/src/configs/text_style.dart';
import 'package:aladdin_franchise/src/features/dialogs/order/create_new/provider.dart';
import 'package:aladdin_franchise/src/models/table.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TableSection extends ConsumerWidget {
  const TableSection({super.key, this.tableNotUseAndType = const []});
  final List<dynamic> tableNotUseAndType;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var tableIds =
        ref.watch(createNewOrderDialogProvider.select((value) => value.tableIds)).toList();
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: tableNotUseAndType.map((e) {
          if (e is Widget) {
            return e;
          } else if (e is TypeOrderEnum) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20).copyWith(bottomLeft: Radius.zero),
                color: e.color,
              ),
              child: Text(
                e.title,
                style: AppTextStyle.bold(color: AppColors.white),
              ),
            );
          } else if (e is List<TableModel>) {
            if (e.isEmpty) {
              return Padding(
                  padding: const EdgeInsets.only(top: 50),
                  child: Center(
                    child: Text(
                      S.current.tableOff,
                      style: AppTextStyle.regular(),
                    ),
                  ));
            }
            return Wrap(
                spacing: 8,
                runSpacing: 8,
                children: e.map(
                  (e) {
                    bool isSelected = tableIds.contains(e.id);
                    return ChoiceChip(
                      padding: const EdgeInsets.all(12),
                      label: Text(
                        e.name ?? "",
                        style: AppTextStyle.regular(
                          color: isSelected ? Colors.white : Colors.black,
                        ),
                      ),
                      selected: isSelected,
                      selectedColor: AppColors.mainColor,
                      checkmarkColor: Colors.white,
                      onSelected: (value) {
                        ref.read(createNewOrderDialogProvider.notifier).onChangeTableSelect(
                              value: e,
                              onSelected: value,
                            );
                      },
                    );
                  },
                ).toList());
          }
          return const SizedBox.shrink();
        }).toList(),
      ),
    );
  }
}
