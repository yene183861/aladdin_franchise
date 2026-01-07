import 'package:aladdin_franchise/generated/l10n.dart';
import 'package:aladdin_franchise/src/configs/app.dart';
import 'package:aladdin_franchise/src/configs/color.dart';
import 'package:aladdin_franchise/src/configs/text_style.dart';
import 'package:aladdin_franchise/src/features/dialogs/message.dart';
import 'package:aladdin_franchise/src/features/dialogs/order/transfer_order/provider.dart';
import 'package:aladdin_franchise/src/features/pages/home/provider.dart';
import 'package:aladdin_franchise/src/features/widgets/title_line.dart';
import 'package:aladdin_franchise/src/models/table.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ListTableSection extends ConsumerWidget {
  const ListTableSection({
    super.key,
    required this.tablesAvailable,
    this.iconSize = 24,
  });

  final List<TableModel> tablesAvailable;

  final double iconSize;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var tableSelects = ref.watch(transferOrderProvider.select((value) => value.tableSelects));
    final orderSelect = ref.read(homeProvider.notifier).getOrderSelect();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FittedBox(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TitleLineWidget(
                  fontWeight: FontWeight.w500,
                  title:
                      '${S.current.table} [${orderSelect?.name}] -> ${tableSelects.isEmpty ? S.current.select_table_to_transfer : tableSelects.map((e) => e.name).toList()}'),
              IconButton(
                onPressed: () {
                  showMessageDialog(
                    context,
                    title: S.current.help,
                    message: S.current.content_help_move_table,
                    textAction: S.current.close,
                  );
                },
                color: AppColors.mainColor,
                icon: Icon(
                  CupertinoIcons.question_circle,
                  size: iconSize,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Center(
            child: tablesAvailable.isEmpty
                ? Text(
                    S.current.tableOff,
                    style: AppTextStyle.regular(),
                  )
                : SingleChildScrollView(
                    child: Center(
                      child: Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: tablesAvailable.map((e) {
                            bool isSelected = tableSelects.contains(e);
                            return InkWell(
                              borderRadius: AppConfig.borderRadiusMain,
                              onTap: () {
                                ref.read(transferOrderProvider.notifier).updateTableSelect(e);
                              },
                              child: Chip(
                                backgroundColor: isSelected
                                    ? AppColors.secondColor
                                    : Colors.grey.withOpacity(0.3),
                                label: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(e.name ?? "",
                                      style: AppTextStyle.regular(
                                        color: isSelected ? Colors.white : Colors.black,
                                      )),
                                ),
                              ),
                            );
                          }).toList()),
                    ),
                  ),
          ),
        ),
      ],
    );
  }
}
