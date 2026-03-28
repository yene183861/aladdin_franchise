import 'package:aladdin_franchise/generated/assets.dart';
import 'package:aladdin_franchise/generated/l10n.dart';
import 'package:aladdin_franchise/src/configs/app.dart';
import 'package:aladdin_franchise/src/configs/color.dart';
import 'package:aladdin_franchise/src/configs/enums/type_order.dart';
import 'package:aladdin_franchise/src/core/storages/local.dart';
import 'package:aladdin_franchise/src/core/storages/provider.dart';
import 'package:aladdin_franchise/src/features/pages/home/provider.dart';
import 'package:aladdin_franchise/src/features/widgets/button/btn_with_icon.dart';
import 'package:aladdin_franchise/src/features/widgets/button/icon_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TypeOrderBtn extends ConsumerWidget {
  const TypeOrderBtn({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(typeOrderWaiterProvider);
    var enableOnline = ref.watch(enableOrderOnlineProvider);

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

class TypeOrderIconBtn extends ConsumerWidget {
  const TypeOrderIconBtn({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(typeOrderWaiterProvider);
    var enableOnline = ref.watch(enableOrderOnlineProvider);
    return Padding(
      padding: EdgeInsets.only(left: 0),
      child: AppIconButton(
        onTap: () async {
          var type = LocalStorage.getTypeOrderWaiter();
          if (!enableOnline && type == AppConfig.orderOfflineValue) return;
          await LocalStorage.setTypeOrderWaiter(type == AppConfig.orderOnlineValue
              ? AppConfig.orderOfflineValue
              : AppConfig.orderOnlineValue);
          ref.refresh(typeOrderWaiterProvider);
          ref.read(homeProvider.notifier).initialize();
        },
        // svgPath: kTypeOrder == AppConfig.orderOfflineValue ? Assets.iconsTray,
        iconColor: AppColors.mainColor,
        svgPath:
            kTypeOrder == AppConfig.orderOfflineValue ? Assets.iconsTray : Assets.iconsTakeAway,
      ),
    );
  }
}
