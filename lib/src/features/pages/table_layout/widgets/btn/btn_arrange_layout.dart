import 'package:aladdin_franchise/src/features/widgets/app_icon_widget.dart';
import 'package:aladdin_franchise/src/models/table.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../provider.dart';

class BtnArrangeDefaultLayout extends ConsumerWidget {
  const BtnArrangeDefaultLayout({super.key, this.allTables = const []});
  final List<TableModel> allTables;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var items = ref.watch(tableLayoutPageProvider.select((value) => value.items));
    var exists = items.where((e) => e.table != null).map((e) => e.table!.id).toList();
    var size = MediaQuery.of(context).size;

    var remainTables = allTables.where((e) => !exists.contains(e.id)).toList();
    if (remainTables.isEmpty) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Tooltip(
        message: 'Sắp xếp các bàn còn lại',
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
          iconData: Icons.auto_awesome_motion_outlined,
          iconSize: 28,
          color: Colors.black87,
          onPressed: () {
            ref.read(tableLayoutPageProvider.notifier).generateRemainTable(
                  tables: remainTables,
                  viewportWidth: 4000,
                  viewportHeight: size.height,
                );
          },
        ),
      ),
    );
  }
}
