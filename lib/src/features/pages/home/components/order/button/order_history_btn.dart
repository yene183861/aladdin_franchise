import 'package:aladdin_franchise/generated/l10n.dart';
import 'package:aladdin_franchise/src/features/widgets/button/btn_with_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../checkout/dialog/history_order_item.dart';

class OrderHistoryBtn extends ConsumerWidget {
  const OrderHistoryBtn({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ButtonWithIconWidget(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      // shape: RoundedRectangleBorder(
      //   borderRadius: BorderRadius.circular(
      //     AppConfig.sizeBorderRadius,
      //   ),
      // ),
      onPressed: () {
        showHistoryOrderItemDialog(context);
      },
      textAction: S.of(context).order_history,
      iconWidget: const Icon(Icons.history),
      color: Colors.orange,
    );
  }
}
