// ignore_for_file: use_build_context_synchronously

// import 'package:flutter_riverpod/flutter_riverpodpackage:responsive_sizer/responsive_sizer.dart';
//
// import '../../../generated/l10n.dart';
//
// final confirmCodeProvider = StateProvider.autoDispose<bool>((ref) => false);
//
// class ConfirmCodeDialog extends ConsumerStatefulWidget {
//   final VoidCallback? action;
//   final VoidCallback? cancelAction;
//   const ConfirmCodeDialog({
//     Key? key,
//     this.action,
//     this.cancelAction,
//   }) : super(key: key);
//
//   @override
//   ConsumerState createState() => _ConfirmCodeDialogState();
// }
//
// class _ConfirmCodeDialogState extends ConsumerState<ConfirmCodeDialog> {
//   bool isProcessing = false;
//   late TextEditingController ctrlCode;
//   @override
//   void initState() {
//     super.initState();
//     ctrlCode = TextEditingController(
//         text: !kReleaseMode ? appConfig.codeVerifyDefault : '');
//   }
//
//   @override
//   void dispose() {
//     ctrlCode.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return PopScope(
//       canPop: false,
//       child: ref.watch(confirmCodeProvider)
//           ? ProcessingWidget(
//               message: S.current.verifying,
//             )
//           : AlertDialog(
//               shape: RoundedRectangleBorder(
//                   borderRadius: AppConfig.borderRadiusMain),
//               title: Text(
//                 S.current.verificationCodes,
//                 // style: AppTextStyle.regular(fontSize: 16.sp),
//                 style: AppTextStyle.regular(fontSize: 16),
//               ),
//               content: TextField(
//                 controller: ctrlCode,
//                 obscureText: true,
//                 keyboardType: TextInputType.number,
//                 decoration: InputDecoration(
//                   hintText: S.current.enterAuthCode,
//                 ),
//                 style: AppTextStyle.regular(),
//               ),
//               actionsAlignment: MainAxisAlignment.spaceEvenly,
//               actions: [
//                 ButtonCancelWidget(
//                   onPressed: () {
//                     Navigator.pop(context, false);
//                     widget.cancelAction?.call();
//                   },
//                 ),
//                 const GapW(8),
//                 ButtonSimpleWidget(
//                   onPressed: () async {
//                     ref.read(confirmCodeProvider.state).state = true;
//                     String code = ctrlCode.text.trim();
//                     var result =
//                         await ref.read(homeProvider.notifier).checkCode(code);
//                     if (result == null) {
//                       Navigator.pop(context, false);
//                       widget.action?.call();
//                     } else {
//                       showMessageDialog(context, message: result);
//                     }
//                     ref.read(confirmCodeProvider.state).state = false;
//                   },
//                   textAction: S.current.confirm,
//                 ),
//               ],
//             ),
//     );
//   }
// }
//
// Future<void> showConfirmCodeDialog(
//   BuildContext context,
//   WidgetRef ref, {
//   required Function()? action,
//   bool isRequired = false,
//   VoidCallback? cancelAction,
// }) async {
//   if (ref.watch(homeProvider).ignoreCheckCodeWaiter && !isRequired) {
//     action?.call();
//   } else {
//     await showDialog(
//       context: context,
//       useRootNavigator: true,
//       barrierDismissible: false,
//       builder: (context) => ConfirmCodeDialog(
//         action: action,
//         cancelAction: cancelAction,
//       ),
//     );
//   }
// }
