import 'package:aladdin_franchise/generated/l10n.dart';
import 'package:aladdin_franchise/src/configs/color.dart';
import 'package:aladdin_franchise/src/configs/text_style.dart';
import 'package:aladdin_franchise/src/core/network/provider.dart';
import 'package:aladdin_franchise/src/features/widgets/line_payment_result.dart';
import 'package:aladdin_franchise/src/models/data_bill.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app_error_simple.dart';
import 'app_loading_simple.dart';

/// Author: sondv
/// Created 22/03/2024 at 13:54
// class TotalAmountPaymentPreviewWidget extends ConsumerWidget {
//   final int orderId;
//   final bool isCart;
//   const TotalAmountPaymentPreviewWidget({
//     super.key,
//     required this.orderId,
//     this.isCart = false,
//   });

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final dataBillRef = ref.watch(dataBillOrderPreviewProvider);
//     return dataBillRef.when(
//       skipLoadingOnRefresh: false,
//       data: (data) {
//         final price = data.price;
//         return PriceDataBillPreviewWidget(
//           price: price,
//           isCart: isCart,
//         );
//       },
//       error: (_, __) {
//         return Center(
//           child: AppErrorSimpleWidget(
//             // message: "${S.current.error_loading_invoice_data}\n"
//             //     "${S.current.ex_problem}: ${_.toString()}",
//             onTryAgain: () {
//               ref.refresh(dataBillOrderPreviewProvider);
//             },
//           ),
//         );
//       },
//       loading: () {
//         return const AppLoadingSimpleWidget();
//       },
//     );
//   }
// }

// class PriceDataBillPreviewWidget extends StatelessWidget {
//   const PriceDataBillPreviewWidget({
//     super.key,
//     required this.price,
//     this.isCart = false,
//   });
//   final PriceDataBill price;
//   final bool isCart;
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         LinePaymentResultWidget(
//           // title: isCart ? S.current.total_amount_dish_selected : S.current.total_amount,
//           number: price.totalPrice,
//         ),
//         LinePaymentResultWidget(
//           // title: S.current.discount_money,
//           number: price.totalPriceVoucher,
//           colorNumber: AppColors.tcPriceDiscount,
//           isNegative: true,
//         ),
//         LinePaymentResultWidget(
//           // title: S.current.tax_money,
//           number: price.totalPriceTax,
//         ),
//         LinePaymentResultWidget(
//           // title: S.current.totalAmountPayment,
//           number: price.totalPriceFinal,
//           colorNumber: Colors.black,
//         ),
//       ],
//     );
//   }
// }
