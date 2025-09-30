// import 'package:aladdin_franchise/generated/l10n.dart';
// import 'package:aladdin_franchise/src/configs/color.dart';
// import 'package:aladdin_franchise/src/configs/text_style.dart';
// import 'package:aladdin_franchise/src/core/network/provider.dart';
// import 'package:aladdin_franchise/src/features/pages/home/provider.dart';
// import 'package:aladdin_franchise/src/features/widgets/app_error_simple.dart';
// import 'package:aladdin_franchise/src/features/widgets/app_loading_simple.dart';
// import 'package:aladdin_franchise/src/features/widgets/button_simple.dart';
// import 'package:aladdin_franchise/src/features/widgets/gap.dart';
// import 'package:aladdin_franchise/src/utils/app_log.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:qr_flutter/qr_flutter.dart';

// Future<void> showCreateCustomerZaloOADialog(
//   BuildContext context,
// ) async {
//   await showDialog(
//     context: context,
//     useRootNavigator: false,
//     barrierDismissible: false,
//     builder: (context) => const _CreateCustomerZaloOA(),
//   );
// }

// class _CreateCustomerZaloOA extends ConsumerWidget {
//   const _CreateCustomerZaloOA({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final linkRef = ref.watch(getLinkZaloOAProvider);
//     return AlertDialog(
//       title: Text(
//         S.current.register_customers_via_zalo_oa,
//         style: AppTextStyle.bold(),
//       ),
//       content: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           linkRef.when(
//             skipLoadingOnRefresh: false,
//             data: (link) {
//               WidgetsBinding.instance.addPostFrameCallback(
//                 (timeStamp) {
//                   ref
//                       .read(homeProvider.notifier)
//                       .sendQRForCreateCustomerByZaloOA(link);
//                 },
//               );
//               return Column(
//                 children: [
//                   SizedBox(
//                     width: 256,
//                     height: 256,
//                     child: QrImageView(
//                       data: link,
//                       eyeStyle: const QrEyeStyle(
//                         color: AppColors.mainColor,
//                         eyeShape: QrEyeShape.square,
//                       ),
//                     ),
//                   ),
//                   const GapH(8),
//                   Text(S.current.use_camera_zalo_to_scan_the_code),
//                   const GapH(8),
//                   Text(S.current.note_show_qr_register_zalo_oa),
//                 ],
//               );
//             },
//             error: (_, __) {
//               return AppErrorSimpleWidget(
//                 message: "${S.current.load_code_error} :'( \n$_",
//                 onTryAgain: () {
//                   ref.invalidate(getLinkZaloOAProvider);
//                 },
//               );
//             },
//             loading: () {
//               return AppLoadingSimpleWidget(
//                 message: "${S.current.generating_code}...",
//               );
//             },
//           ),
//         ],
//       ),
//       actionsAlignment: MainAxisAlignment.center,
//       actions: [
//         ButtonSimpleWidget(
//           textAction: S.current.close,
//           onPressed: () {
//             ref.read(homeProvider.notifier).sendQRForCreateCustomerByZaloOA('');
//             Navigator.pop(context);
//           },
//         ),
//       ],
//     );
//   }
// }
