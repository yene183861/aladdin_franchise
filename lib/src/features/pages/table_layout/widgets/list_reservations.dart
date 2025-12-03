// import 'package:aladdin_receptionist/src/configs/text_style.dart';
// import 'package:aladdin_receptionist/src/data/model/reservation/reservation.dart';
// import 'package:aladdin_receptionist/src/features/pages/home/provider.dart';
// import 'package:aladdin_receptionist/src/features/pages/reservation/update_reservation/view.dart';
// import 'package:aladdin_receptionist/src/features/pages/table_layout/provider.dart';
// import 'package:aladdin_receptionist/src/features/pages/table_layout/state.dart';
// import 'package:aladdin_receptionist/src/features/widgets/app_icon.dart';
// import 'package:aladdin_receptionist/src/features/widgets/button/btn_with_icon.dart';
// import 'package:aladdin_receptionist/src/features/widgets/gap.dart';
// import 'package:aladdin_receptionist/src/utils/app_log.dart';
// import 'package:aladdin_receptionist/src/utils/singleton.dart';
// import 'package:aladdin_receptionist/src/utils/time_util.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// class ListReservationsDialog extends ConsumerWidget {
//   const ListReservationsDialog({super.key, this.item});
//   final LayoutItemModel? item;

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     var reservationTimeCheck =
//         ref.watch(tableLayoutPageProvider.select((value) => value.reservationTimeCheck));
//     var reservationsData = ref.watch(homeProvider.select((value) => value.reservations));

//     var today = DateTime.now().date;

//     var reservations = ((reservationsData[today]?['data'] ?? []) as List)
//         .map((e) => e as ReservationModel)
//         .toList();
//     var reservationsOfTable = ref.read(tableLayoutPageProvider.notifier).getReservationsOfTable(
//           reservations: reservations,
//           table: item?.table,
//           reservationTimeCheck: reservationTimeCheck,
//         );
//     showLogs(reservationsOfTable, flags: 'reservationsOfTable');
//     return Dialog(
//       clipBehavior: Clip.hardEdge,
//       shape: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(20),
//         borderSide: BorderSide.none,
//       ),
//       child: CustomScrollView(
//         slivers: [
//           SliverAppBar(
//             pinned: true,
//             automaticallyImplyLeading: false,
//             title: Row(
//               children: [
//                 const ResponsiveIconWidget(
//                   iconData: Icons.calendar_today,
//                 ),
//                 const Gap(16),
//                 Expanded(
//                   child: Text(
//                     'Danh sách lịch đặt bàn',
//                     style:
//                         Theme.of(context).dialogTheme.titleTextStyle?.copyWith(color: Colors.white),
//                   ),
//                 ),
//               ],
//             ),
//             actions: [
//               CloseButton(
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                 },
//               ),
//             ],
//           ),
//           reservationsOfTable.isEmpty
//               ? SliverToBoxAdapter(
//                   child: Padding(
//                     padding: const EdgeInsets.only(top: 200),
//                     child: Center(
//                       child: Text(
//                         'Danh sách trống',
//                         style: AppTextStyle.regular(color: Colors.grey.shade500),
//                       ),
//                     ),
//                   ),
//                 )
//               : SliverList.separated(
//                   itemBuilder: (context, index) {
//                     if (index == 0) {
//                       return Padding(
//                         padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
//                         child: Row(
//                           children: [
//                             Expanded(
//                               child: Text(
//                                 'Tên KH',
//                                 style: AppTextStyle.bold(),
//                               ),
//                             ),
//                             Expanded(
//                               child: Text(
//                                 'SĐT',
//                                 style: AppTextStyle.bold(),
//                               ),
//                             ),
//                             Expanded(
//                               child: Text(
//                                 'Thời gian',
//                                 style: AppTextStyle.bold(),
//                               ),
//                             ),
//                             Container(
//                               margin: const EdgeInsets.only(left: 20),
//                               width: 150,
//                             ),
//                           ],
//                         ),
//                       );
//                     }
//                     var reser = reservationsOfTable[index - 1];
//                     return Padding(
//                       padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
//                       child: Row(
//                         children: [
//                           Expanded(
//                             child: Text(reser.customer?.name ?? ''),
//                           ),
//                           Expanded(
//                             child: Text(reser.customer?.phoneNumber ?? ''),
//                           ),
//                           Expanded(
//                             child: Text(
//                                 '${TimeUtil.parseStringFromTimeOfDay(timeOfDay: reser.startTimeOfDay, format: DateTimePattern.timeFormatDefault)}'
//                                 ' - ${TimeUtil.parseStringFromTimeOfDay(timeOfDay: reser.endTimeOfDay, format: DateTimePattern.timeFormatDefault)}'),
//                           ),
//                           Container(
//                             margin: const EdgeInsets.only(left: 20),
//                             width: 120,
//                             alignment: Alignment.center,
//                             child: AppButtonWithIconWidget(
//                               icon: Icons.calendar_today,
//                               textAction: 'Chi tiết',
//                               color: Colors.blue.shade400,
//                               onPressed: () async {
//                                 await showDialog(
//                                   context: context,
//                                   useRootNavigator: false,
//                                   barrierDismissible: false,
//                                   builder: (context) => UpdateReservationDialog(reservation: reser),
//                                 );
//                                 AppSingleton.instance.onChangeStatus(
//                                   openLogs: false,
//                                   openNotiPage: false,
//                                   openUpdateReserPage: false,
//                                 );
//                               },
//                             ),
//                           ),
//                         ],
//                       ),
//                     );
//                   },
//                   separatorBuilder: (context, index) => const Divider(height: 2),
//                   itemCount: reservationsOfTable.length + 1,
//                 ),
//         ],
//       ),
//     );
//   }
// }
