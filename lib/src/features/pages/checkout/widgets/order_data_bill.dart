import 'package:aladdin_franchise/generated/l10n.dart';
import 'package:aladdin_franchise/src/features/pages/checkout/provider_test.dart';
import 'package:aladdin_franchise/src/features/pages/home/state.dart';
import 'package:aladdin_franchise/src/features/widgets/button/button_simple.dart';
import 'package:aladdin_franchise/src/features/widgets/gap.dart';
import 'package:aladdin_franchise/src/features/widgets/price_data_bill_preview.dart';
import 'package:aladdin_franchise/src/models/data_bill.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OrderDataBillWidget extends ConsumerWidget {
  const OrderDataBillWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var dataBill = ref.watch(checkoutProvider.select((value) => value.dataBill));
    var dataBillState = ref.watch(checkoutProvider.select((value) => value.dataBillState));
    switch (dataBillState.status) {
      case PageCommonState.loading:
        return const PriceDataBillPreview(dataBill: PriceDataBill(), isLoading: true);
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
              onPressed: ref.read(checkoutProvider.notifier).getDataBill,
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
