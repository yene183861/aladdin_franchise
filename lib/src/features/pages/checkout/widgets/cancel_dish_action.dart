import 'package:aladdin_franchise/generated/l10n.dart';
import 'package:aladdin_franchise/src/features/pages/checkout/dialog/cancel_product_checkout.dart';
import 'package:aladdin_franchise/src/features/pages/checkout/provider_test.dart';
import 'package:aladdin_franchise/src/features/widgets/button/app_buton.dart';
import 'package:aladdin_franchise/src/features/widgets/gap.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../dialog/history_order_item.dart';

class CancelDishAction extends ConsumerWidget {
  const CancelDishAction({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var productCheckout = ref.watch(checkoutProvider.select((value) => value.productCheckout));

    var orderHistoryData = ref.watch(checkoutProvider.select((value) => value.orderHistory));
    if (orderHistoryData.isEmpty && productCheckout.isEmpty) return const SizedBox.shrink();
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(children: [
        if (orderHistoryData.isNotEmpty)
          AppButton(
            icon: Icons.history,
            textAction: S.current.order_history,
            color: Colors.orange,
            onPressed: () async {
              showHistoryOrderItemDialog(context);
            },
          ),
        const Spacer(),
        if (productCheckout.isNotEmpty) ...[
          const Gap(8),
          AppButton(
            textAction: S.current.cancel_dish,
            onPressed: () {
              showCancelProductCheckout(context);
            },
          ),
        ],
      ]),
    );
  }
}
