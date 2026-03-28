import 'package:aladdin_franchise/generated/l10n.dart';
import 'package:aladdin_franchise/src/features/pages/cart/dialog/add_order_item.dart';
import 'package:aladdin_franchise/src/features/widgets/button/btn_with_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddItemToOrderBtn extends ConsumerWidget {
  const AddItemToOrderBtn({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ButtonWithIconWidget(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      onPressed: () {
        showAddOrderItemDialog(context);
      },
      textAction: S.of(context).send_to_the_kitchen,
    );
  }
}
