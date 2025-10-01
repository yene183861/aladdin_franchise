import 'package:aladdin_franchise/generated/l10n.dart';
import 'package:aladdin_franchise/src/configs/app.dart';
import 'package:aladdin_franchise/src/configs/color.dart';
import 'package:aladdin_franchise/src/core/network/provider.dart';
import 'package:aladdin_franchise/src/core/storages/local.dart';
import 'package:aladdin_franchise/src/core/storages/provider.dart';
import 'package:aladdin_franchise/src/features/pages/home/provider.dart';
import 'package:aladdin_franchise/src/features/pages/login/view.dart';
import 'package:aladdin_franchise/src/features/pages/order_to_online/view.dart';
import 'package:aladdin_franchise/src/utils/show_snackbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ButtonO2oData extends ConsumerWidget {
  const ButtonO2oData({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(typeOrderWaiterProvider);
    var useO2O = LocalStorage.getDataLogin()?.restaurant?.o2oStatus ?? false;
    if (!useO2O || kTypeOrder == AppConfig.orderOnlineValue) {
      return const SizedBox.shrink();
    }
    return Tooltip(
      message: 'Yêu cầu tại bàn',
      child: InkWell(
        onTap: () {
          var orderSelect = ref.read(homeProvider).orderSelect;
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => OrderToOnlinePage(
                    orderId: orderSelect?.id,
                  )));
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
    );
  }
}
