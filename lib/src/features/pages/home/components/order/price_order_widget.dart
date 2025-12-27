// import 'package:aladdin_franchise/generated/l10n.dart';
// import 'package:aladdin_franchise/src/features/pages/home/provider.dart';
// import 'package:aladdin_franchise/src/features/pages/home/state.dart';
// import 'package:aladdin_franchise/src/features/widgets/button_simple.dart';
// import 'package:aladdin_franchise/src/features/widgets/gap.dart';
// import 'package:aladdin_franchise/src/features/widgets/price_data_bill_preview.dart';
// import 'package:aladdin_franchise/src/models/data_bill.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// class OrderPriceWidget extends ConsumerWidget {
//   const OrderPriceWidget({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     ref.watch(homeProvider.select((value) => value.dataBill));
//     var dataBillState =
//         ref.watch(homeProvider.select((value) => value.dataBillState));

//     final productCheckout =
//         ref.watch(homeProvider.select((value) => value.productCheckout));
//     switch (dataBillState.status) {
//       case PageCommonState.loading:
//         return const PriceDataBillPreviewWidget(
//             dataBill: PriceDataBill(), isLoading: true);
//       case PageCommonState.error:
//         if (productCheckout.isEmpty) {
//           return const PriceDataBillPreviewWidget(dataBill: PriceDataBill());
//         }
//         return Center(
//             child: Row(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Flexible(
//               child: Text(dataBillState.messageError),
//             ),
//             const Gap(4),
//             ButtonSimpleWidget(
//               textAction: S.current.tryAgain,
//               onPressed: ref.read(homeProvider.notifier).getDataBill,
//             ),
//           ],
//         ));

//       case PageCommonState.success:
//         return PriceDataBillPreviewWidget(
//             dataBill: ref.read(homeProvider.notifier).getFinalPaymentPrice);

//       default:
//     }

//     return const SizedBox.shrink();
//   }
// }
