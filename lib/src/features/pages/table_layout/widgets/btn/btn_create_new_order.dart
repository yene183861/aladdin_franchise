import 'package:aladdin_franchise/generated/l10n.dart';
import 'package:aladdin_franchise/src/configs/app.dart';
import 'package:aladdin_franchise/src/configs/color.dart';
import 'package:aladdin_franchise/src/features/dialogs/order/create_new/view.dart';
import 'package:aladdin_franchise/src/features/pages/home/provider.dart';
import 'package:aladdin_franchise/src/features/pages/table_layout/provider.dart';
import 'package:aladdin_franchise/src/features/widgets/app_icon_widget.dart';
import 'package:aladdin_franchise/src/models/table.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BtnCreateNewOrder extends ConsumerWidget {
  const BtnCreateNewOrder({super.key, this.tableSelectInit = const {}});

  final Set<TableModel> tableSelectInit;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Tooltip(
      message: S.current.createNewOrder,
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
          final result = await showCreateNewOrderDialog(
            context,
            tableSelectInit: tableSelectInit,
          );

          if (result.orderId != null) {
            var typeOrder = result.typeOrder ?? kTypeOrder;

            ref.read(tableLayoutPageProvider.notifier).getOrderHistory(to: DateTime.now());
            try {
              await ref.read(homeProvider.notifier).loadingChangeOrderSelect(
                    result.orderId!,
                    reservationCrmId: result.reservation?.id,
                    typeOrder: typeOrder,
                  );
            } catch (ex) {
              //
            }
          }
        },
      ),
    );
  }
}
