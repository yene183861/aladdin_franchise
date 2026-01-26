import 'package:aladdin_franchise/src/configs/app.dart';
import 'package:aladdin_franchise/src/configs/enums/type_order.dart';
import 'package:aladdin_franchise/src/configs/text_style.dart';
import 'package:aladdin_franchise/src/core/network/provider.dart';
import 'package:aladdin_franchise/src/core/storages/local.dart';
import 'package:aladdin_franchise/src/core/storages/provider.dart';
import 'package:aladdin_franchise/src/features/pages/home/provider.dart';
import 'package:aladdin_franchise/src/features/widgets/button/btn_with_icon.dart';
import 'package:aladdin_franchise/src/utils/app_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../generated/l10n.dart';

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
          content: _OrderTypeSelector(showMessage: showMessage),
          shape: RoundedRectangleBorder(borderRadius: AppConfig.borderRadiusMain),
        ),
      ),
    ),
  );
  await AppHelper.initTokenAndTypeOrder();
}

class _OrderTypeSelector extends ConsumerWidget {
  final bool showMessage;
  const _OrderTypeSelector({
    Key? key,
    this.showMessage = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var enableOnline = ref.watch(enableOrderOnlineProvider);
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
            kTypeOrder = TypeOrderEnum.offline.type;
            ref.refresh(typeOrderProvider);
            ref.read(homeProvider.notifier).initialize();
            ref.invalidate(printerByOrderProvider);
          },
        ),
        if (enableOnline) ...[
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
              kTypeOrder = TypeOrderEnum.online.type;
              ref.refresh(typeOrderProvider);
              ref.read(homeProvider.notifier).initialize();
              ref.invalidate(printerByOrderProvider);
            },
          ),
        ],
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
