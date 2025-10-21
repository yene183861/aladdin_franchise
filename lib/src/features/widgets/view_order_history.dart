// import 'package:aladdin_franchise/generated/l10n.dart';
// import 'package:aladdin_franchise/src/configs/app.dart';
// import 'package:aladdin_franchise/src/configs/color.dart';
// import 'package:aladdin_franchise/src/configs/enums/enums.dart';
// import 'package:aladdin_franchise/src/configs/text_style.dart';
// import 'package:aladdin_franchise/src/core/network/provider.dart';
// import 'package:aladdin_franchise/src/core/storages/provider.dart';
// import 'package:aladdin_franchise/src/features/widgets/app_error.dart';
// import 'package:aladdin_franchise/src/features/widgets/empty.dart';
// import 'package:aladdin_franchise/src/features/widgets/gap.dart';
// import 'package:aladdin_franchise/src/models/order_history.dart';
// import 'package:aladdin_franchise/src/utils/product_helper.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:responsive_sizer/responsive_sizer.dart';

// /// Author: sondv
// /// Created 17/02/2024 at 11:55

// class ViewOrderHistoryWidget extends ConsumerWidget {
//   final List<OrderHistory> orderHistory;
//   const ViewOrderHistoryWidget({
//     super.key,
//     required this.orderHistory,
//   });

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     var orderHistoryView = List<OrderHistory>.from(orderHistory);
//     final useKDS = ref.watch(checkUseKDSProvider);
//     orderHistoryView.sort((a, b) => b.timesOrder.compareTo(a.timesOrder));
//     if (orderHistoryView.isEmpty) {
//       return EmptyWidget(
//         message: S.current.no_data,
//       );
//     }
//     return Material(
//       color: Colors.white,
//       child: ListView.builder(
//         padding: const EdgeInsets.all(16),
//         itemCount: orderHistoryView.length,
//         itemBuilder: (BuildContext context, int index) {
//           final orderTime = orderHistoryView[index];
//           bool isCancel = orderTime.products.any((element) => element.cancel);
//           return Card(
//             elevation: 0,
//             shadowColor: Colors.white,
//             color: Colors.grey.shade50,
//             shape: RoundedRectangleBorder(
//               borderRadius: AppConfig.borderRadiusMain,
//             ),
//             child: Column(
//               children: [
//                 ListTile(
//                   leading: const Icon(Icons.tag),
//                   tileColor:
//                       isCancel ? Colors.red.shade50 : Colors.blueGrey.shade50,
//                   title: Text(
//                     "${S.current.turn} ${orderTime.timesOrder} ${isCancel ? " - ${S.current.cancelDish}" : ""}",
//                     style: AppTextStyle.regular(),
//                   ),
//                   subtitle:
//                       orderTime.notes.isEmpty ? null : Text(orderTime.notes),
//                   trailing: Text(
//                     appConfig.dateFormatHhMmSsDDMMYYYY
//                         .format(orderTime.createdAt),
//                     style: AppTextStyle.regular(fontSize: 13),
//                   ),
//                 ),
//                 ...orderTime.products.map(
//                   (e) => Padding(
//                     padding: const EdgeInsets.only(left: 8.0),
//                     child: Row(
//                       children: [
//                         Expanded(
//                           flex: 2,
//                           child: ListTile(
//                             title: Text(e.getNameView()),
//                             subtitle: e.notes.isEmpty ? null : Text(e.notes),
//                             trailing: Text(
//                               "${S.current.quantityCut}: ${e.quantity}",
//                               style: AppTextStyle.regular(),
//                             ),
//                           ),
//                         ),
//                         useKDS
//                             ? Expanded(
//                                 flex: 1,
//                                 child: Row(
//                                   mainAxisAlignment: MainAxisAlignment.end,
//                                   children: [
//                                     Text(
//                                       e.cancel
//                                           ? S.current.cancel
//                                           : appConfig.getNameByStatus(e.status),
//                                       style: AppTextStyle.regular(),
//                                     ),
//                                     const GapW(12),
//                                   ],
//                                 ),
//                               )
//                             : Container(),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

// class ButtonSwitchViewProductSelectedWidget extends ConsumerWidget {
//   final ViewProductSelected viewProductSelected;
//   final Function(bool value) onChange;
//   const ButtonSwitchViewProductSelectedWidget({
//     super.key,
//     required this.viewProductSelected,
//     required this.onChange,
//   });

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     return Padding(
//       padding: const EdgeInsets.fromLTRB(16, 0, 0, 8),
//       child: Row(
//         children: [
//           Text(
//             S.current.view_order_and_cancel_history,
//             style: AppTextStyle.bold(),
//           ),
//           const GapW(12),
//           Switch(
//             value: viewProductSelected == ViewProductSelected.orderHistory,
//             onChanged: (value) {
//               onChange.call(value);
//             },
//             activeTrackColor: AppColors.mainColor,
//             inactiveTrackColor: Colors.black12,
//             trackOutlineWidth: MaterialStateProperty.all(2),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class ProductHistoryWidget extends ConsumerWidget {
//   final int productId;
//   const ProductHistoryWidget({super.key, required this.productId});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final productCheckout = ref.watch(productCheckoutProvider);
//     return productCheckout.when(
//       data: (data) {
//         final orderHistory = data?.orderHistory ?? [];
//         final history = ProductHelper.getHistory(orderHistory, productId);
//         if (history.isEmpty) {
//           return Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Text(
//               S.current.no_data,
//               style: AppTextStyle.regular(),
//             ),
//           );
//         } else {
//           return ListView(
//             shrinkWrap: true,
//             physics: const NeverScrollableScrollPhysics(),
//             children: history.map((e) {
//               return Card(
//                 elevation: 0,
//                 color: Colors.grey[50],
//                 shape: RoundedRectangleBorder(
//                   borderRadius: AppConfig.borderRadiusSecond,
//                 ),
//                 child: ListTile(
//                   leading: Text(
//                     "#${e.timesOrder}",
//                     style: AppTextStyle.medium(),
//                   ),
//                   title: Text(
//                     e.cancel
//                         ? "${S.current.cancelRequest} ${e.quantity.abs()}"
//                         : "${S.current.callMore} ${e.quantity}",
//                     style: AppTextStyle.regular(),
//                   ),
//                   subtitle: e.notes.isEmpty ? null : Text(e.notes),
//                   trailing: e.timeByOrderHistory == null
//                       ? null
//                       : Text(
//                           appConfig.dateFormatHhMmSsDDMMYYYY
//                               .format(e.timeByOrderHistory!),
//                           style: AppTextStyle.regular(fontSize: 13),
//                         ),
//                 ),
//               );
//             }).toList(),
//           );
//         }
//       },
//       error: (_, __) {
//         return ErrorLineWidget(
//           onRefresh: () => ref.refresh(productCheckoutProvider),
//         );
//       },
//       loading: () => Container(),
//     );
//   }
// }
