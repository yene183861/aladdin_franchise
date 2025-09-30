import 'package:aladdin_franchise/src/configs/text_style.dart';
import 'package:aladdin_franchise/src/core/storages/provider.dart';
import 'package:aladdin_franchise/src/features/dialogs/order_type_select.dart';
import 'package:aladdin_franchise/src/utils/show_snackbar.dart';
import 'package:aladdin_franchise/src/configs/color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../generated/l10n.dart';

class ButtonTypeOrderWidget extends ConsumerWidget {
  const ButtonTypeOrderWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var typeOrder = ref.watch(typeOrderWaiterProvider);
    return ListTile(
      onTap: () async {
        await showOrderTypeSelectDialog(
          context,
          showMessage: false,
        );
        if (context.mounted) {
          showDoneSnackBar(context: context, message: S.current.success);
          Navigator.pop(context);
        }
      },
      leading: const Icon(
        CupertinoIcons.cart,
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
    );
  }
}
