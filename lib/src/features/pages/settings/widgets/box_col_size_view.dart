// import 'package:aladdin_franchise/src/configs/app.dart';
// import 'package:aladdin_franchise/src/configs/color.dart';
// import 'package:aladdin_franchise/src/configs/text_style.dart';
// import 'package:aladdin_franchise/src/features/pages/settings/provider.dart';
// import 'package:aladdin_franchise/src/features/pages/settings/widgets/title_setting.dart';
// import 'package:aladdin_franchise/src/features/widgets/gap.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:intl/intl.dart';
// import 'package:responsive_sizer/responsive_sizer.dart';

// /// Author: sondv
// /// Created 27/11/2023 at 13:56

// class BoxColSizeViewWidget extends ConsumerStatefulWidget {
//   const BoxColSizeViewWidget({super.key});
//   static const dish = [
//     "Há Cảo Sò Điệp",
//     "Nấm Đông Cô Nhân Sò Điệp",
//     "Bánh Bao Nấm",
//     "Cá Cơm Đậu Phộng Rang Mắm Tỏi",
//     "Tim Heo",
//     "Thăn Ngoại Bò Aukobe",
//     "Cá Chình Hấp Tiêu",
//     "Tôm Sú Nhảy",
//     "Nấm Đùi Gà",
//     "Cháo Wang 0 Đồng"
//   ];
//   @override
//   ConsumerState createState() => _BoxColSizeViewWidgetState();
// }

// class _BoxColSizeViewWidgetState extends ConsumerState<BoxColSizeViewWidget> {
//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final sizeBox = ref.watch(
//         settingsPageProvider.select((value) => value.appSettings.boxSizeView));
//     return Container(
//       color: Colors.grey.shade100,
//       child: ListView(
//         children: [
//           Row(
//             children: [
//               const TitleSettingsWidget(title: "Kích thước hiển thị"),
//               TextButton(
//                 onPressed: () {
//                   ref
//                       .read(settingsProvider.notifier)
//                       .onChangeSetting(boxSizeView: kBoxSizeView);
//                 },
//                 child: const Text("Đặt lại"),
//               ),
//             ],
//           ),
//           Align(
//             alignment: Alignment.centerLeft,
//             child: FractionallySizedBox(
//               widthFactor: 0.5,
//               child: Row(
//                 children: [
//                   Expanded(
//                     child: Slider(
//                       value: sizeBox,
//                       min: 100,
//                       max: 1000,
//                       label: "$sizeBox",
//                       onChanged: (value) {
//                         ref
//                             .read(settingsProvider.notifier)
//                             .onChangeSetting(boxSizeView: value);
//                       },
//                     ),
//                   ),
//                   Text("${sizeBox.toInt()}", style: AppTextStyle.bold()),
//                 ],
//               ),
//             ),
//           ),
//           const _DemoViewByRowWidget(),
//           const _DemoViewByColumnWidget(),
//         ],
//       ),
//     );
//   }
// }

// class _DemoViewByRowWidget extends ConsumerWidget {
//   const _DemoViewByRowWidget({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final ScrollController scrollController = ScrollController();
//     final sizeBox = ref.watch(
//         settingsProvider.select((value) => value.appSettings.boxSizeView));
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const SubTitleSettingsWidget(title: 'View theo Hàng'),
//         SizedBox(
//           height: 220,
//           child: RawScrollbar(
//             mainAxisMargin: 12,
//             radius: const Radius.circular(12),
//             thumbColor: AppColors.secondColor,
//             scrollbarOrientation: ScrollbarOrientation.top,
//             thumbVisibility: true,
//             controller: scrollController,
//             child: ListView.builder(
//               controller: scrollController,
//               scrollDirection: Axis.horizontal,
//               shrinkWrap: true,
//               itemCount: BoxColSizeViewWidget.dish.length,
//               padding: const EdgeInsets.all(12),
//               itemBuilder: (BuildContext context, int index) {
//                 return SizedBox(
//                   width: sizeBox,
//                   child: Card(
//                     child: Column(
//                       children: [
//                         ListTile(
//                           dense: true,
//                           tileColor: AppColors.titleOrderTimeFinishColor,
//                           textColor: Colors.white,
//                           title: Text(
//                             'Bàn: ${index + 1}',
//                             style: AppTextStyle.bold(
//                               color: Colors.white,
//                             ),
//                           ),
//                           trailing: Chip(
//                             padding: const EdgeInsets.all(4),
//                             backgroundColor: Colors.white,
//                             labelStyle: AppTextStyle.regular(
//                               color: AppColors.mainColor,
//                             ),
//                             label: const Text("1"),
//                           ),
//                         ),
//                         ListTile(
//                           dense: true,
//                           leading: const VerticalDivider(
//                             thickness: 2,
//                             width: 0,
//                             color: AppColors.secondColor,
//                           ),
//                           title: Text(
//                             "#1",
//                             style: AppTextStyle.bold(),
//                           ),
//                           trailing: Row(
//                             mainAxisSize: MainAxisSize.min,
//                             children: [
//                               Text(
//                                 DateFormat("HH:mm").format(DateTime.now()),
//                                 style: AppTextStyle.bold(),
//                               ),
//                               const GapW(6),
//                               BoxTimeDelayWidget(time: DateTime.now()),
//                             ],
//                           ),
//                           contentPadding: const EdgeInsets.fromLTRB(0, 0, 8, 0),
//                           tileColor: Colors.green.shade50,
//                           minLeadingWidth: 0,
//                         ),
//                         ListTile(
//                           dense: true,
//                           leading: RichText(
//                             text: TextSpan(
//                               style: AppTextStyle.bold().copyWith(
//                                 color: Colors.black,
//                               ),
//                               children: [
//                                 TextSpan(
//                                   text: "1",
//                                   style: AppTextStyle.bold().copyWith(
//                                     color: Colors.green,
//                                   ),
//                                 ),
//                                 const TextSpan(text: "/1"),
//                               ],
//                             ),
//                           ),
//                           title: Text(
//                             BoxColSizeViewWidget.dish[index],
//                             style: AppTextStyle.regular(),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }

// class _DemoViewByColumnWidget extends ConsumerWidget {
//   const _DemoViewByColumnWidget({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final ScrollController scrollController = ScrollController();
//     final sizeBox = ref.watch(
//         settingsProvider.select((value) => value.appSettings.boxSizeView));
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const SubTitleSettingsWidget(title: 'View theo Cột'),
//         SizedBox(
//           height: 350,
//           child: RawScrollbar(
//             mainAxisMargin: 8,
//             radius: const Radius.circular(12),
//             thumbColor: AppColors.secondColor,
//             scrollbarOrientation: ScrollbarOrientation.left,
//             thumbVisibility: true,
//             controller: scrollController,
//             child: GridView.builder(
//               controller: scrollController,
//               shrinkWrap: true,
//               itemCount: BoxColSizeViewWidget.dish.length,
//               padding: const EdgeInsets.all(12),
//               itemBuilder: (BuildContext context, int index) {
//                 var dish = BoxColSizeViewWidget.dish[index];
//                 return Card(
//                   child: Column(
//                     children: [
//                       ListTile(
//                         dense: true,
//                         tileColor: AppColors.titleOrderTimeFinishColor,
//                         textColor: Colors.white,
//                         title: Text(
//                           dish,
//                           style: AppTextStyle.bold(
//                             color: Colors.white,
//                           ),
//                         ),
//                         trailing: Chip(
//                           padding: const EdgeInsets.all(4),
//                           backgroundColor: AppColors.titleOrderTimeCookingColor
//                               .withOpacity(0.9),
//                           labelStyle: AppTextStyle.regular(
//                             color: Colors.white,
//                           ),
//                           label: Text(
//                             "1/1",
//                             style: AppTextStyle.regular(color: Colors.white),
//                           ),
//                         ),
//                       ),
//                       ListTile(
//                         dense: true,
//                         title: FittedBox(
//                           alignment: Alignment.centerLeft,
//                           fit: BoxFit.scaleDown,
//                           child: Text(
//                             "Bàn ${index + 1} (#${index + 1})",
//                             style: AppTextStyle.regular(),
//                           ),
//                         ),
//                         leading: RichText(
//                           text: TextSpan(
//                             style: AppTextStyle.bold().copyWith(
//                               color: Colors.black,
//                             ),
//                             children: [
//                               TextSpan(
//                                 text: "1",
//                                 style: AppTextStyle.bold().copyWith(
//                                   color: Colors.green,
//                                 ),
//                               ),
//                               const TextSpan(text: "/1"),
//                             ],
//                           ),
//                         ),
//                         trailing: BoxTimeDelayWidget(
//                           time: DateTime.now(),
//                           backgroundColor: Colors.transparent,
//                         ),
//                       ),
//                     ],
//                   ),
//                 );
//               },
//               gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
//                 maxCrossAxisExtent: sizeBox,
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
