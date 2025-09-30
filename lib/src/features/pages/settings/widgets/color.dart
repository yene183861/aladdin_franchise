// import 'package:aladdin_franchise/src/configs/color.dart';
// import 'package:aladdin_franchise/src/configs/text_style.dart';
// import 'package:aladdin_franchise/src/features/pages/settings/provider.dart';
// import 'package:aladdin_franchise/src/features/pages/settings/widgets/title_setting.dart';
// import 'package:aladdin_franchise/src/features/widgets/gap.dart';
// import 'package:aladdin_franchise/src/utils/app_log.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:intl/intl.dart';

// class ColorSettingPage extends ConsumerWidget {
//   const ColorSettingPage({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final backgroundColorSelect = ref.watch(settingsPageProvider
//         .select((value) => value.appSettings.backgroundColor));
//     return Scaffold(
//       backgroundColor: backgroundColorSelect.getColor(),
//       body: Column(
//         children: [
//           Row(
//             children: [
//               const TitleSettingsWidget(title: 'Màu sắc'),
//               TextButton(
//                 onPressed: () {
//                   ref.read(settingsProvider.notifier).onChangeSetting(
//                         backgroundColor:
//                             AppColors.colorSettingBackgroundDefault,
//                         lineSelectColor:
//                             AppColors.colorSettingLineSelectDefault,
//                       );
//                 },
//                 child: const Text("Đặt lại"),
//               ),
//             ],
//           ),
//           const Expanded(
//             child: Padding(
//               padding: EdgeInsets.all(8.0),
//               child: Row(
//                 children: [
//                   Expanded(child: _SettingColorWidget()),
//                   VerticalDivider(),
//                   _SettingColorPreviewWidget(),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class _SettingColorWidget extends ConsumerWidget {
//   const _SettingColorWidget({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final settingNotifier = ref.read(settingsProvider.notifier);
//     final backgroundColorSelect = ref.watch(
//         settingsProvider.select((value) => value.appSettings.backgroundColor));
//     final lineColorSelect = ref.watch(
//         settingsProvider.select((value) => value.appSettings.lineSelectColor));
//     return ListView(
//       children: [
//         _ColorTypeSettingWidget(
//           title: 'Màu nền',
//           colorSetting: backgroundColorSelect,
//           onChangeColor: (color) {
//             settingNotifier.onChangeSetting(
//               backgroundColor:
//                   backgroundColorSelect.copyWith(value: color.value),
//             );
//           },
//           onChangeOpacity: (opacity) {
//             settingNotifier.onChangeSetting(
//               backgroundColor: backgroundColorSelect.copyWith(opacity: opacity),
//             );
//           },
//         ),
//         const GapH(8),
//         _ColorTypeSettingWidget(
//           title: 'Dòng chọn món ăn',
//           colorSetting: lineColorSelect,
//           onChangeColor: (color) {
//             settingNotifier.onChangeSetting(
//               lineSelectColor: lineColorSelect.copyWith(value: color.value),
//             );
//           },
//           onChangeOpacity: (opacity) {
//             settingNotifier.onChangeSetting(
//               lineSelectColor: lineColorSelect.copyWith(opacity: opacity),
//             );
//           },
//         ),
//       ],
//     );
//   }
// }

// class _ColorTypeSettingWidget extends ConsumerWidget {
//   const _ColorTypeSettingWidget({
//     super.key,
//     required this.title,
//     required this.colorSetting,
//     required this.onChangeColor,
//     required this.onChangeOpacity,
//   });
//   final String title;
//   final ColorSetting colorSetting;
//   final Function(Color color) onChangeColor;
//   final Function(double opacity) onChangeOpacity;
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     return Card(
//       child: Padding(
//         padding: const EdgeInsets.all(12),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               title,
//               style: AppTextStyle.semiBold(),
//             ),
//             const GapH(8),
//             Wrap(
//               spacing: 8,
//               children: [
//                 ...AppColors.colorSettings.map(
//                   (e) => FilterChip(
//                     backgroundColor: e,
//                     selectedColor: e,
//                     selected: colorSetting.value == e.value,
//                     label: const Text('  '),
//                     onSelected: (value) {
//                       onChangeColor.call(e);
//                     },
//                   ),
//                 ),
//               ],
//             ),
//             const GapH(8),
//             Row(
//               children: [
//                 const Text("Cường độ"),
//                 Slider(
//                   min: 0,
//                   max: 1,
//                   value: colorSetting.opacity,
//                   onChanged: (value) {
//                     onChangeOpacity.call(value);
//                   },
//                 ),
//                 Text("${(colorSetting.opacity * 100).ceil()}%"),
//               ],
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }

// class _SettingColorPreviewWidget extends ConsumerWidget {
//   const _SettingColorPreviewWidget({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final sizeBox = ref.watch(
//         settingsProvider.select((value) => value.appSettings.boxSizeView));
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             "Mẫu hiển thị",
//             style: AppTextStyle.semiBold(),
//           ),
//           const GapH(12),
//           Expanded(
//             child: SizedBox(
//               width: sizeBox,
//               child: Card(
//                 child: Column(
//                   children: [
//                     ListTile(
//                       dense: true,
//                       tileColor: AppColors.titleOrderTimeFinishColor,
//                       textColor: Colors.white,
//                       title: Text(
//                         'Bàn: 101',
//                         style: AppTextStyle.bold(
//                           color: Colors.white,
//                         ),
//                       ),
//                       trailing: Chip(
//                         padding: const EdgeInsets.all(4),
//                         backgroundColor: Colors.white,
//                         labelStyle: AppTextStyle.regular(
//                           color: AppColors.mainColor,
//                         ),
//                         label: const Text("1"),
//                       ),
//                     ),
//                     ListTile(
//                       dense: true,
//                       leading: const VerticalDivider(
//                         thickness: 2,
//                         width: 0,
//                         color: AppColors.secondColor,
//                       ),
//                       title: Text(
//                         "#1",
//                         style: AppTextStyle.bold(),
//                       ),
//                       trailing: Row(
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           Text(
//                             DateFormat("HH:mm").format(DateTime.now()),
//                             style: AppTextStyle.bold(),
//                           ),
//                           const GapW(6),
//                           BoxTimeDelayWidget(time: DateTime.now()),
//                         ],
//                       ),
//                       contentPadding: const EdgeInsets.fromLTRB(0, 0, 8, 0),
//                       tileColor: Colors.green.shade50,
//                       minLeadingWidth: 0,
//                     ),
//                     const _LineDishWidget(),
//                     const _LineDishWidget(
//                       selected: true,
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class _LineDishWidget extends ConsumerWidget {
//   const _LineDishWidget({super.key, this.selected = false});
//   final bool selected;
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final colorSelect = ref.watch(
//         settingsProvider.select((value) => value.appSettings.lineSelectColor));
//     return ListTile(
//       dense: true,
//       tileColor: selected ? colorSelect.getColor() : null,
//       leading: RichText(
//         text: TextSpan(
//           style: AppTextStyle.bold().copyWith(
//             color: Colors.black,
//           ),
//           children: [
//             TextSpan(
//               text: "1",
//               style: AppTextStyle.bold().copyWith(
//                 color: Colors.green,
//               ),
//             ),
//             const TextSpan(text: "/1"),
//           ],
//         ),
//       ),
//       title: Text(
//         "Nấm Đông Cô Nhân Sò Điệp",
//         style: AppTextStyle.regular(),
//       ),
//     );
//   }
// }
