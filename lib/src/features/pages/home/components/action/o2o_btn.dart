import 'package:aladdin_franchise/generated/assets.dart';
import 'package:aladdin_franchise/generated/l10n.dart';
import 'package:aladdin_franchise/src/configs/app.dart';
import 'package:aladdin_franchise/src/configs/color.dart';
import 'package:aladdin_franchise/src/core/network/provider.dart';
import 'package:aladdin_franchise/src/core/storages/local.dart';
import 'package:aladdin_franchise/src/core/storages/provider.dart';
import 'package:aladdin_franchise/src/features/pages/order_to_online/view.dart';
import 'package:aladdin_franchise/src/features/widgets/button/icon_button.dart';
import 'package:aladdin_franchise/src/utils/navigator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OrderToOnlineBtn extends ConsumerWidget {
  const OrderToOnlineBtn({super.key, this.paddingLeft = 8.0});
  final double paddingLeft;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(typeOrderWaiterProvider);
    var useO2O = LocalStorage.getDataLogin()?.restaurant?.o2oStatus ?? false;
    if (!useO2O || kTypeOrder == AppConfig.orderOnlineValue) {
      return const SizedBox.shrink();
    }
    final orderToOnline = ref.watch(orderToOnlineProvider);
    int? count = orderToOnline.when(
      data: (data) => data.values.fold(
        0,
        (previousValue, element) => (previousValue ?? 0) + ((element['count'] as int?) ?? 0),
      ),
      error: (error, stackTrace) => null,
      loading: () => null,
    );
    return Padding(
      padding: EdgeInsets.only(left: paddingLeft),
      child: AppIconButton(
        onTap: () {
          push(context, const OrderToOnlinePage());
        },
        tooltip: S.current.order_to_online,
        svgPath: Assets.iconsTray,
        iconColor: AppColors.mainColor,
        count: count ?? 0,
      ),
    );
  }
}
