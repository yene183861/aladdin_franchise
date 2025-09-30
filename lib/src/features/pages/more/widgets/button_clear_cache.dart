// import 'package:aladdin_orders/src/configs/style.dart';
// import 'package:aladdin_orders/src/core/storages/local.dart';
// import 'package:aladdin_orders/src/core/storages/provider.dart';
// import 'package:aladdin_orders/src/features/dialogs/confirm_action.dart';
// import 'package:aladdin_orders/src/features/pages/checkout/provider.dart';
// import 'package:aladdin_orders/src/utils/show_snackbar.dart';
// import 'package:aladdin_franchise/src/configs/text_style.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// import '../../../../../generated/l10n.dart';

// class ButtonClearCacheWidget extends ConsumerWidget {
//   const ButtonClearCacheWidget({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     return ListTile(
//       onTap: () {
//         showConfirmAction(context, title: S.current.deleteCache, message: S.current.deleteCacheInfo,
//             action: () async {
//           await LocalStorage.clearCache();
//           ref.invalidate(productsSelectingByOrderProvider);
//           ref.invalidate(checkoutProvider);
//           // ignore: use_build_context_synchronously
//           showDoneSnackBar(context: context, message: S.current.success);
//         });
//       },
//       leading: const Icon(
//         CupertinoIcons.bin_xmark,
//         color: Colors.blueGrey,
//       ),
//       title: Text(
//         S.current.deleteCache,
//         style: AppTextStyle.regular(),
//       ),
//     );
//   }
// }
