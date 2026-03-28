import 'package:aladdin_franchise/generated/l10n.dart';
import 'package:aladdin_franchise/src/features/pages/checkout/dialog/cancel_product_checkout.dart';
import 'package:aladdin_franchise/src/features/widgets/button/btn_with_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CancelProductCheckoutBtn extends ConsumerWidget {
  const CancelProductCheckoutBtn({super.key});

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
        showCancelProductCheckout(context);
      },
      textAction: S.of(context).cancel_dish,
    );
  }
}
