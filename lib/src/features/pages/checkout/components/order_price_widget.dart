import 'package:aladdin_franchise/generated/l10n.dart';
import 'package:aladdin_franchise/src/features/pages/checkout/provider.dart';
import 'package:aladdin_franchise/src/features/pages/home/provider.dart';
import 'package:aladdin_franchise/src/features/pages/home/state.dart';
import 'package:aladdin_franchise/src/features/widgets/button/button_simple.dart';
import 'package:aladdin_franchise/src/features/widgets/gap.dart';
import 'package:aladdin_franchise/src/features/widgets/price_data_bill_preview.dart';
import 'package:aladdin_franchise/src/models/data_bill.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// checked
class OrderPriceWidget extends ConsumerWidget {
  const OrderPriceWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var dataBill =
        ref.watch(checkoutPageProvider.select((value) => value.dataBill));
    var dataBillState =
        ref.watch(checkoutPageProvider.select((value) => value.dataBillState));
    switch (dataBillState.status) {
      case PageCommonState.loading:
        return const PriceDataBillPreview(
            dataBill: PriceDataBill(), isLoading: true);
      case PageCommonState.error:
        return Center(
            child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: Text(dataBillState.messageError),
            ),
            const Gap(4),
            ButtonSimpleWidget(
              textAction: S.current.tryAgain,
              onPressed: ref.read(checkoutPageProvider.notifier).getDataBill,
            ),
          ],
        ));

      case PageCommonState.success:
        return PriceDataBillPreview(dataBill: dataBill.price);

      default:
    }

    return const SizedBox.shrink();
  }
}
