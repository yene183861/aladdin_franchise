import 'package:aladdin_franchise/src/configs/app.dart';
import 'package:aladdin_franchise/src/configs/color.dart';
import 'package:aladdin_franchise/src/configs/enums/type_order.dart';
import 'package:aladdin_franchise/src/configs/text_style.dart';
import 'package:aladdin_franchise/src/core/storages/local.dart';
import 'package:aladdin_franchise/src/core/storages/provider.dart';
import 'package:aladdin_franchise/src/features/pages/home/provider.dart';
import 'package:aladdin_franchise/src/features/widgets/button_with_icon.dart';
import 'package:aladdin_franchise/src/utils/app_helper.dart';
import 'package:aladdin_franchise/src/utils/app_log.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../generated/l10n.dart';

class OrderTypeSelectWidget extends ConsumerWidget {
  final bool showMessage;
  const OrderTypeSelectWidget({
    Key? key,
    this.showMessage = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ButtonWithIconWidget(
          icon: CupertinoIcons.house,
          textAction: S.current.orderOffline.toUpperCase(),
          padding: const EdgeInsets.all(12),
          minWidth: 320,
          color: TypeOrderEnum.offline.color,
          onPressed: () async {
            if (context.mounted) Navigator.pop(context);
            await LocalStorage.setTypeOrderWaiter(AppConfig.orderOfflineValue);
            ref.refresh(typeOrderWaiterProvider);
            if (AppConfig.initHomeProvider) {
              ref.read(homeProvider.notifier).initialize();
            }
          },
        ),
        const SizedBox(height: 12),
        ButtonWithIconWidget(
          minWidth: 320,
          icon: CupertinoIcons.globe,
          textAction: S.current.orderOnline.toUpperCase(),
          padding: const EdgeInsets.all(12),
          color: TypeOrderEnum.online.color,
          onPressed: () async {
            if (context.mounted) Navigator.pop(context);
            await LocalStorage.setTypeOrderWaiter(AppConfig.orderOnlineValue);
            ref.refresh(typeOrderWaiterProvider);
            if (AppConfig.initHomeProvider) {
              ref.read(homeProvider.notifier).initialize();
            }
          },
        ),
        if (showMessage)
          Column(
            children: [
              const SizedBox(height: 12),
              SizedBox(
                width: 320,
                child: Text(
                  S.current.messageSelectTypeOrder,
                  style: AppTextStyle.regular(fontStyle: FontStyle.italic),
                  textAlign: TextAlign.justify,
                ),
              ),
            ],
          ),
      ],
    );
  }
}

/// Result order type
///
/// - OrderType.offline: đơn offline - tại nhà hàng
///
/// - OrderType.online: đơn online
///
/// - null: cancel
///
Future<void> showOrderTypeSelectDialog(
  BuildContext context, {
  bool showMessage = true,
}) async {
  await showDialog(
    context: context,
    useRootNavigator: false,
    barrierDismissible: false,
    builder: (context) => PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: AlertDialog(
          title: Text(S.current.orderSellType, style: AppTextStyle.bold()),
          content: OrderTypeSelectWidget(
            showMessage: showMessage,
          ),
          shape:
              RoundedRectangleBorder(borderRadius: AppConfig.borderRadiusMain),
        ),
      ),
    ),
  );
  await AppHelper.initTokenAndTypeOrder();
}
