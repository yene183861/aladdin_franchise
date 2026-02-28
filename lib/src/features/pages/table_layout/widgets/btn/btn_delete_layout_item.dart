import 'package:aladdin_franchise/src/configs/color.dart';
import 'package:aladdin_franchise/src/data/model/table_layout_item.dart';
import 'package:aladdin_franchise/src/features/dialogs/confirm_action.dart';
import 'package:aladdin_franchise/src/features/widgets/app_icon_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../provider.dart';

class BtnDeleteLayoutItem extends ConsumerWidget {
  const BtnDeleteLayoutItem({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var itemSelect = ref.watch(tableLayoutPageProvider.select((value) => value.itemSelect));
    return
        // DragTarget<TableLayoutItemModel>(
        //   onAcceptWithDetails: (details) {
        //     // ref.read(tableLayoutPageProvider.notifier).removeItem(details.data);
        //   },
        //   builder: (_, __, ___) =>
        Tooltip(
      message: 'Xoá bàn',
      child: ResponsiveIconButtonWidget(
        buttonStyle: ButtonStyle(
          backgroundColor: WidgetStatePropertyAll(Colors.white),
          padding: const WidgetStatePropertyAll(EdgeInsets.all(16)),
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: BorderSide(color: Colors.grey.shade400),
            ),
          ),
        ),
        iconData: Icons.delete,
        iconSize: 28,
        color: Colors.black87,
        onPressed: () {
          showConfirmAction(
            context,
            message: itemSelect.isEmpty
                ? 'Bạn có chắc chắn muốn xoá tất cả các bàn thuộc tầng này?'
                : 'Bạn có chắc chắn muốn xoá các bàn đã chọn?',
            action: () {
              ref.read(tableLayoutPageProvider.notifier).onDeleteLayoutItem();
            },
          );
        },
        // ),
      ),
    );
  }
}
