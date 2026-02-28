import 'package:aladdin_franchise/src/configs/color.dart';
import 'package:aladdin_franchise/src/features/dialogs/order/create_new/view.dart';
import 'package:aladdin_franchise/src/features/widgets/app_icon_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BtnCreateNewOrder extends ConsumerWidget {
  const BtnCreateNewOrder({super.key, this.tableIdInit = const {}});

  final Set<int> tableIdInit;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Tooltip(
      message: 'Tạo đơn bàn mới',
      child: ResponsiveIconButtonWidget(
        buttonStyle: ButtonStyle(
          backgroundColor: const WidgetStatePropertyAll(Colors.white),
          padding: const WidgetStatePropertyAll(EdgeInsets.all(12)),
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
              side: BorderSide(color: Colors.grey.shade400),
            ),
          ),
        ),
        iconData: Icons.add,
        iconSize: 28,
        color: AppColors.mainColor,
        onPressed: () async {
          await showCreateNewOrderDialog(
            context,
            tableIdSelect: tableIdInit,
          );
        },
      ),
    );
  }
}
