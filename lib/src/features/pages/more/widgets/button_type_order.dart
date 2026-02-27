import 'package:aladdin_franchise/src/configs/text_style.dart';
import 'package:aladdin_franchise/src/core/storages/local.dart';
import 'package:aladdin_franchise/src/core/storages/provider.dart';
import 'package:aladdin_franchise/src/features/dialogs/order_type_select.dart';
import 'package:aladdin_franchise/src/features/widgets/app_icon_widget.dart';
import 'package:aladdin_franchise/src/utils/show_snackbar.dart';
import 'package:aladdin_franchise/src/configs/color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../generated/l10n.dart';

class ButtonTypeOrder extends ConsumerStatefulWidget {
  const ButtonTypeOrder({
    super.key,
    this.canPop = false,
  });
  final bool canPop;
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ButtonTypeOrderState();
}

class _ButtonTypeOrderState extends ConsumerState<ButtonTypeOrder> {
  @override
  void initState() {
    super.initState();
    ref.refresh(typeOrderWaiterProvider);
  }

  @override
  Widget build(BuildContext context) {
    var enableOrderOnline = LocalStorage.getEnableOrderOnline();
    var typeOrder = ref.watch(typeOrderWaiterProvider);
    if (!enableOrderOnline) return const SizedBox.shrink();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTile(
          onTap: () async {
            if (widget.canPop) Navigator.pop(context);
            await showOrderTypeSelectDialog(
              context,
              showMessage: false,
            );
            if (context.mounted) {
              showDoneSnackBar(context: context, message: S.current.success);
              Navigator.pop(context);
            }
          },
          leading: const ResponsiveIconWidget(
            iconData: CupertinoIcons.cart,
            color: AppColors.mainColor,
          ),
          title: Text(
            "${S.current.orderSellType}: ${typeOrder.toUpperCase()}",
            style: AppTextStyle.bold(),
          ),
          subtitle: Text(
            S.current.orderSellTypeInfo,
            style: AppTextStyle.regular(),
          ),
        ),
        const Divider(),
      ],
    );
  }
}

// class ButtonTypeOrderWidget extends ConsumerWidget {
//   const ButtonTypeOrderWidget({
//     Key? key,
//     this.canPop = false,
//   }) : super(key: key);

//   final bool canPop;

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     var enableOrderOnline = LocalStorage.getEnableOrderOnline();
//     var typeOrder = ref.watch(typeOrderWaiterProvider);
//     if (!enableOrderOnline) return const SizedBox.shrink();
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         ListTile(
//           onTap: () async {
//             if (canPop) Navigator.pop(context);
//             await showOrderTypeSelectDialog(
//               context,
//               showMessage: false,
//             );
//             if (context.mounted) {
//               showDoneSnackBar(context: context, message: S.current.success);
//               Navigator.pop(context);
//             }
//           },
//           leading: const ResponsiveIconWidget(
//             iconData: CupertinoIcons.cart,
//             color: AppColors.mainColor,
//           ),
//           title: Text(
//             "${S.current.orderSellType}: ${typeOrder.toUpperCase()}",
//             style: AppTextStyle.bold(),
//           ),
//           subtitle: Text(
//             S.current.orderSellTypeInfo,
//             style: AppTextStyle.regular(),
//           ),
//         ),
//         const Divider(),
//       ],
//     );
//   }
// }
