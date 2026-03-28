import 'package:aladdin_franchise/generated/l10n.dart';
import 'package:aladdin_franchise/src/features/dialogs/order/order_option_dialog.dart';
import 'package:aladdin_franchise/src/features/pages/home/provider.dart';
import 'package:aladdin_franchise/src/features/widgets/empty_data_widget.dart';
import 'package:aladdin_franchise/src/features/widgets/gap.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../action/barrel_btn.dart';
import 'pos_order_actions.dart';
import 'order_item_view.dart';

class DetailOrderPanel extends ConsumerWidget {
  const DetailOrderPanel({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          width: double.maxFinite,
          color: const Color(0xff292929),
          child: const Row(
            children: [
              Expanded(child: OrderDropdown()),
              Gap(12),
              OrderOptionBtn(),
            ],
          ),
        ),
        Consumer(
          builder: (context, ref, child) {
            var orderSelect = ref.watch(homeProvider.select((value) => value.orderSelect));

            return orderSelect != null
                ? Expanded(
                    child: LayoutBuilder(builder: (context, constrainst) {
                      return OrderItemsView(widthSection: constrainst.maxWidth);
                    }),
                  )
                : Expanded(
                    child: Center(
                      child: EmptyDataWidget(
                        message: S.of(context).noOrderSelect,
                      ),
                    ),
                  );
          },
        ),
        const PosOrderActions(),
        const Gap(2),
      ],
    );
  }
}

// class PosOrderActions1 extends ConsumerStatefulWidget {
//   const PosOrderActions1({super.key});

//   @override
//   ConsumerState<ConsumerStatefulWidget> createState() => _PosOrderActionsState();
// }

// class _PosOrderActionsState extends ConsumerState<PosOrderActions> {
//   bool expaned = true;
//   onToogle() {
//     setState(() {
//       expaned = !expaned;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     bool newUI = DevConfig.newUI;
//     final items = [
//       _MenuItem(Icons.monitor, 'MÀN HÌNH KH'),
//       _MenuItem(Icons.person, 'KHÁCH HÀNG'),
//       _MenuItem(Icons.receipt_long, 'HÓA ĐƠN'),
//     ];
//     final items2 = [
//       _MenuItem(Icons.local_offer, 'ƯU ĐÃI'),
//       _MenuItem(Icons.payments, 'THANH TOÁN', isHighlight: true),
//       _MenuItem(Icons.lock, 'CHỐT CA'),
//     ];

//     if (!newUI)
//       return Container(
//         padding: const EdgeInsets.all(12),
//         decoration: BoxDecoration(
//           // borderRadius: BorderRadius.circular(28),
//           // color: Colors.white,
//           gradient: const LinearGradient(
//             colors: [Color(0xFF0A1F44), Color(0xFF06142E)],
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//           ),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(0.5),
//               blurRadius: 20,
//               offset: const Offset(0, 10),
//             )
//           ],
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Visibility(
//               visible: expaned,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Row(
//                     children: [
//                       Expanded(child: _MenuCard(item: items[0])),
//                       const Gap(6),
//                       Expanded(child: _MenuCard(item: items[1])),
//                       const Gap(6),
//                       Expanded(child: _MenuCard(item: items[2])),
//                     ],
//                   ),
//                   const Gap(8),
//                   Row(
//                     children: [
//                       Expanded(child: _MenuCard(item: items2[0])),
//                       const Gap(6),
//                       Expanded(child: _MenuCard(item: items2[1])),
//                       const Gap(6),
//                       Expanded(child: _MenuCard(item: items2[2])),
//                     ],
//                   ),
//                   const Gap(12),
//                   // Container(
//                   //   height: 1,
//                   //   color: Colors.white.withOpacity(0.08),
//                   // ),
//                   // const Gap(8),
//                 ],
//               ),
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Consumer(builder: (context, ref, child) {
//                   var redisStatus = ref.watch(homeProvider.select((value) => value.realtimeStatus));
//                   return Row(
//                     children: [
//                       Icon(
//                         Icons.circle,
//                         size: 10,
//                         color: redisStatus ? Colors.greenAccent : Colors.red,
//                       ),
//                       const Gap(8),
//                       Text(
//                         'SYSTEM READY',
//                         style: TextStyle(color: Colors.white70, fontSize: 12),
//                       )
//                     ],
//                   );
//                 }),
//                 const Text(
//                   'v4.8.2 - LUMIERE',
//                   style: TextStyle(color: Colors.white38, fontSize: 11),
//                 )
//               ],
//             ),
//           ],
//         ),
//       );
//     return OrderFeatureButtonGroupWidget();
//   }
// }

// class _MenuCard extends StatelessWidget {
//   const _MenuCard({super.key, required this.item});
//   final _MenuItem item;

//   @override
//   Widget build(BuildContext context) {
//     bool isActive = false;

//     Color borderColor = isActive
//         ? Colors.orangeAccent
//         :
//         // Colors.white.withOpacity(0.08)
//         Colors.grey.withOpacity(0.08);
//     return Container(
//       padding: const EdgeInsets.symmetric(vertical: 12),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(16),
//         border: Border.all(color: borderColor),
//         color: Colors.white.withOpacity(0.04),
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Container(
//             padding: const EdgeInsets.all(12),
//             decoration: BoxDecoration(
//               shape: BoxShape.circle,
//               color:
//                   isActive ? Colors.orangeAccent.withOpacity(0.2) : Colors.white.withOpacity(0.05),
//             ),
//             child: Icon(
//               item.icon,
//               color: Colors.orangeAccent,
//               size: 16,
//             ),
//           ),
//           const Gap(10),
//           Text(
//             item.title,
//             textAlign: TextAlign.center,
//             style: const TextStyle(
//               color: Colors.white70,
//               fontSize: 12,
//               height: 1.3,
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }

// class _MenuItem {
//   final IconData icon;
//   final String title;
//   final bool isHighlight;

//   _MenuItem(this.icon, this.title, {this.isHighlight = false});
// }
