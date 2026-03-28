import 'package:aladdin_franchise/generated/l10n.dart';
import 'package:aladdin_franchise/src/configs/app.dart';
import 'package:aladdin_franchise/src/configs/dev_config.dart';
import 'package:aladdin_franchise/src/configs/text_style.dart';
import 'package:aladdin_franchise/src/features/pages/cart/provider.dart';
import 'package:aladdin_franchise/src/features/widgets/price_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CartPriceSummary extends ConsumerWidget {
  const CartPriceSummary({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var productsSelecting = ref.watch(cartPageProvider.select((value) => value.productsSelecting));
    var totalSelecting = productsSelecting.fold(
      0.0,
      (previousValue, e) =>
          previousValue + (double.tryParse(e.unitPrice) ?? 0.0) * e.numberSelecting,
    );
    bool newUI = DevConfig.newUI;
    if (totalSelecting <= 0) return const SizedBox.shrink();
    return Container(
      margin: const EdgeInsets.fromLTRB(8, 0, 8, 0),
      decoration: newUI
          ? null
          : BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: AppConfig.borderRadiusMain,
            ),
      padding: const EdgeInsets.all(16),
      child: PriceInfoLine(
        title: S.of(context).totalAmountSelecting,
        amount: totalSelecting,
        amountTextStyle: AppTextStyle.bold(
          rawFontSize: newUI ? AppConfig.defaultRawTextSize + 1.5 : null,
        ),
      ),
    );
  }
}
