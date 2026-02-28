import 'package:aladdin_franchise/src/configs/color.dart';
import 'package:aladdin_franchise/src/data/model/floor.dart';
import 'package:aladdin_franchise/src/data/model/table_layout_item.dart';
import 'package:aladdin_franchise/src/data/model/table_layout_setting.dart';
import 'package:aladdin_franchise/src/features/pages/table_layout/widgets/setting.dart';
import 'package:aladdin_franchise/src/features/widgets/app_icon_widget.dart';
import 'package:aladdin_franchise/src/models/table.dart';
import 'package:aladdin_franchise/src/utils/app_log.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../provider.dart';

void onSettingLayoutItem(BuildContext context, WidgetRef ref, itemId) async {
  var items = ref.read(tableLayoutPageProvider).items;
  var itemChange = items.firstWhereOrNull((e) => e.id == itemId);
  if (itemChange == null) return;
  var res = await showModalBottomSheet<
      ({
        TableLayoutSettingModel? setting,
        TableModel? table,
        FloorModel? floor,
      })?>(
    context: context,
    backgroundColor: Colors.white,
    isScrollControlled: true,
    useSafeArea: true,
    builder: (context) {
      return ItemSettingBottomSheet(
        initSetting: ref.read(tableLayoutPageProvider).itemSetting,
        title: 'Thiết lập',
        item: itemChange,
      );
    },
  );
  if (res != null) {
    ref.read(tableLayoutPageProvider.notifier).onChangeLayoutItem(
          itemId: itemChange.id,
          floor: res.floor,
          table: res.table,
          setting: res.setting,
        );
  }
}

class BtnSettingLayoutItem extends ConsumerWidget {
  const BtnSettingLayoutItem({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var itemSelect = ref.watch(tableLayoutPageProvider.select((value) => value.itemSelect));
    if (itemSelect.length != 1) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Tooltip(
        message: 'Thiết lập',
        child: ResponsiveIconButtonWidget(
          buttonStyle: ButtonStyle(
            backgroundColor:
                WidgetStatePropertyAll(itemSelect.isNotEmpty ? Colors.white : Colors.grey.shade100),
            padding: const WidgetStatePropertyAll(EdgeInsets.all(12)),
            shape: WidgetStatePropertyAll(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
                side: BorderSide(color: Colors.grey.shade400),
              ),
            ),
          ),
          iconData: Icons.settings,
          iconSize: 28,
          color: itemSelect.isNotEmpty ? AppColors.mainColor : Colors.grey.shade400,
          onPressed: () {
            onSettingLayoutItem(context, ref, itemSelect.firstOrNull);
          },
        ),
      ),
    );
  }
}
