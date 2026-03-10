import 'package:aladdin_franchise/generated/l10n.dart';
import 'package:aladdin_franchise/src/features/pages/cart/provider.dart';

import 'package:aladdin_franchise/src/features/widgets/price_data_bill_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CartPreviewPriceWidget extends ConsumerWidget {
  const CartPreviewPriceWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var productsSelecting = ref.watch(cartPageProvider.select((value) => value.productsSelecting));
    var totalSelecting = productsSelecting.fold(
      0.0,
      (previousValue, e) =>
          previousValue + (double.tryParse(e.unitPrice) ?? 0.0) * e.numberSelecting,
    );
    return LineInfoPaymentQRWidget(
      title: S.current.totalAmountSelecting,
      value: totalSelecting,
      isLoading: false,
    );
  }
}
