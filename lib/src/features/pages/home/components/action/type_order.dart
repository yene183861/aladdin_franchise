import 'package:aladdin_franchise/generated/l10n.dart';
import 'package:aladdin_franchise/src/configs/app.dart';
import 'package:aladdin_franchise/src/configs/enums/type_order.dart';
import 'package:aladdin_franchise/src/core/storages/local.dart';
import 'package:aladdin_franchise/src/core/storages/provider.dart';
import 'package:aladdin_franchise/src/features/pages/home/provider.dart';
import 'package:aladdin_franchise/src/features/widgets/button_with_icon.dart';
import 'package:aladdin_franchise/src/utils/app_log.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TypeOrderWidget extends ConsumerWidget {
  const TypeOrderWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var typeOrder = ref.watch(typeOrderWaiterProvider);
    var enableOnline = ref.watch(enableOrderOnlineProvider);

    showLogs(enableOnline, flags: 'enableOnline');
    return ButtonWithIconWidget(
      padding: const EdgeInsets.all(6),
      color: convertToTypeOrderEnum(LocalStorage.getTypeOrderWaiter()).color,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          AppConfig.sizeBorderRadiusSecond,
        ),
      ),
      onPressed: () async {
        var type = LocalStorage.getTypeOrderWaiter();
        if (!enableOnline && type == AppConfig.orderOfflineValue) return;
        await LocalStorage.setTypeOrderWaiter(type == AppConfig.orderOnlineValue
            ? AppConfig.orderOfflineValue
            : AppConfig.orderOnlineValue);
        ref.refresh(typeOrderWaiterProvider);
        ref.read(homeProvider.notifier).initialize();
      },
      textAction: kTypeOrder == AppConfig.orderOfflineValue
          ? S.of(context).orderOffline
          : S.of(context).orderOnline,
      icon: CupertinoIcons.cart,
    );
  }
}
