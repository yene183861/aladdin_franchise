// import 'package:aladdin_franchise/src/configs/text_style.dart';
// import 'package:aladdin_franchise/src/features/pages/settings/provider.dart';
// import 'package:aladdin_franchise/src/features/pages/settings/widgets/title_setting.dart';
// import 'package:aladdin_franchise/src/features/widgets/button_cancel.dart';
// import 'package:aladdin_franchise/src/features/widgets/button_simple.dart';
// import 'package:aladdin_franchise/src/utils/app_log.dart';
// import 'package:aladdin_franchise/src/utils/navigator.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// class AudioNoticeWidget extends ConsumerWidget {
//   const AudioNoticeWidget({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final notifier = ref.read(settingsProvider.notifier);
//     final settings =
//         ref.watch(settingsProvider.select((value) => value.appSettings));
//     return Row(
//       children: [
//         Expanded(
//           child: ListView(
//             children: [
//               Row(
//                 children: [
//                   const TitleSettingsWidget(title: 'Âm thanh cảnh báo'),
//                   TextButton(
//                     onPressed: () {
//                       ref.read(settingsProvider.notifier).onChangeSetting(
//                             audioDishCancel: AudioService.noticeDefaultKey,
//                             audioDishConfirmLocation:
//                                 AudioService.noticeDefaultKey,
//                             audioKitchenDone: AudioService.orderDefaultKey,
//                           );
//                     },
//                     child: const Text("Đặt lại"),
//                   ),
//                 ],
//               ),
//               SwitchListTile(
//                 title: const Text("Yêu cầu huỷ món"),
//                 subtitle: _ButtonChangeAudioWidget(
//                   audioCurrent: settings.audioDishCancel,
//                   onChange: (audio) {
//                     notifier.onChangeSetting(audioDishCancel: audio);
//                   },
//                 ),
//                 value: settings.noticeKitchenCancel,
//                 onChanged: (value) {
//                   notifier.onChangeSetting(noticeCancel: value);
//                 },
//               ),
//               SwitchListTile(
//                 title: const Text("Món cần xác nhận khu vực"),
//                 subtitle: _ButtonChangeAudioWidget(
//                   audioCurrent: settings.audioDishConfirmLocation,
//                   onChange: (audio) {
//                     notifier.onChangeSetting(audioDishConfirmLocation: audio);
//                   },
//                 ),
//                 value: settings.noticeKitchenConfirmLocation,
//                 onChanged: (value) {
//                   notifier.onChangeSetting(noticeConfirmLocation: value);
//                 },
//               ),
//               SwitchListTile(
//                 title: const Text("Món nấu xong"),
//                 subtitle: _ButtonChangeAudioWidget(
//                   audioCurrent: settings.audioKitchenDone,
//                   onChange: (audio) {
//                     notifier.onChangeSetting(audioKitchenDone: audio);
//                   },
//                 ),
//                 value: settings.noticeKitchenDone,
//                 onChanged: (value) {
//                   notifier.onChangeSetting(noticeKitchenDone: value);
//                 },
//               ),
//             ],
//           ),
//         ),
//         const Spacer(),
//       ],
//     );
//   }
// }

// class _ButtonChangeAudioWidget extends ConsumerWidget {
//   const _ButtonChangeAudioWidget({
//     super.key,
//     required this.onChange,
//     required this.audioCurrent,
//   });
//   final Function(String audio) onChange;
//   final String audioCurrent;
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     return ListTile(
//       leading: FilledButton.icon(
//         onPressed: () async {
//           var result = await _showChoiceAudioDialog(context);
//           if (result != null) {
//             onChange.call(result);
//           }
//         },
//         icon: const Icon(Icons.music_note),
//         label: const Text("Chọn"),
//       ),
//       title: Text('$audioCurrent.mp3'),
//     );
//   }
// }

// Future<String?> _showChoiceAudioDialog(BuildContext context) async {
//   var result = await showDialog(
//     context: context,
//     builder: (context) {
//       return AlertDialog(
//         contentPadding: const EdgeInsets.fromLTRB(0, 12, 0, 12),
//         title: Text(
//           "Âm thanh cảnh báo",
//           style: AppTextStyle.bold(),
//         ),
//         content: const _ChoiceAudioWidget(),
//         actionsAlignment: MainAxisAlignment.center,
//         actionsPadding: EdgeInsets.zero,
//         actions: const [
//           CloseButton(),
//         ],
//       );
//     },
//   );
//   if (result == false) return null;
//   showLog(result, flags: 'result');
//   return result;
// }

// class _ChoiceAudioWidget extends ConsumerStatefulWidget {
//   const _ChoiceAudioWidget({super.key});

//   @override
//   ConsumerState createState() => __ChoiceAudioWidgetState();
// }

// class __ChoiceAudioWidgetState extends ConsumerState<_ChoiceAudioWidget> {
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         const Text('Nhấn để đặt âm thanh thông báo'),
//         Expanded(
//           child: SingleChildScrollView(
//             child: Column(
//               children: AudioService.audioData.map(
//                 (e) {
//                   return Card(
//                     color: Colors.grey.shade100,
//                     child: ListTile(
//                       onTap: () {
//                         pop(context, e);
//                       },
//                       leading: const Icon(Icons.music_note),
//                       title: Text(e),
//                       trailing: IconButton.filledTonal(
//                         onPressed: () {
//                           AudioService.playAudioByKey(e);
//                         },
//                         icon: const Icon(Icons.play_arrow_outlined),
//                       ),
//                     ),
//                   );
//                 },
//               ).toList(),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
