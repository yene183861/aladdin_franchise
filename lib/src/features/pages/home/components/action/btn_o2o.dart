import 'package:aladdin_franchise/generated/l10n.dart';
import 'package:aladdin_franchise/src/configs/app.dart';
import 'package:aladdin_franchise/src/configs/color.dart';
import 'package:aladdin_franchise/src/core/network/provider.dart';
import 'package:aladdin_franchise/src/core/storages/local.dart';
import 'package:aladdin_franchise/src/core/storages/provider.dart';
import 'package:aladdin_franchise/src/features/pages/home/provider.dart';
import 'package:aladdin_franchise/src/features/pages/order_to_online/view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:aladdin_franchise/src/features/widgets/app_icon_widget.dart';

class ButtonO2oData extends ConsumerWidget {
  const ButtonO2oData({super.key});

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
    return Tooltip(
      message: S.current.order_to_online,
      child: Stack(
        children: [
          InkWell(
            onTap: () {
              var orderSelect = ref.read(homeProvider).orderSelect;
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => OrderToOnlinePage(
                    orderId: orderSelect?.id,
                  ),
                ),
              );
            },
            borderRadius: BorderRadius.circular(50),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: AppConfig.borderRadiusSecond,
              ),
              padding: const EdgeInsets.all(4.0),
              child: const ResponsiveIconWidget(
                iconData: Icons.notifications_none_rounded,
                color: AppColors.mainColor,
              ),
            ),
          ),
          if ((count ?? 0) > 0)
            Badge.count(
              count: count ?? 0,
              backgroundColor: AppColors.redColor,
              padding: const EdgeInsets.all(8),
            )
        ],
      ),
    );
  }
}
