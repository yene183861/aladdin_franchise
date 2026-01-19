import 'package:aladdin_franchise/generated/l10n.dart';
import 'package:aladdin_franchise/src/configs/app.dart';
import 'package:aladdin_franchise/src/configs/color.dart';
import 'package:aladdin_franchise/src/configs/text_style.dart';
import 'package:aladdin_franchise/src/features/pages/home/provider.dart';
import 'package:aladdin_franchise/src/features/pages/notification/view.dart';
import 'package:aladdin_franchise/src/utils/navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:aladdin_franchise/src/features/widgets/app_icon_widget.dart';

class ButtonNotification extends ConsumerWidget {
  const ButtonNotification({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var notification = ref.watch(homeProvider.select((value) => value.notifications));
    var count = notification.where((e) => !e.viewed).toList().length;
    return Tooltip(
      message: S.current.notification,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          InkWell(
            onTap: () {
              push(context, const NotificationPage());
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
          if (count > 0)
            Positioned(
              top: -10,
              right: -10,
              child: InkWell(
                onTap: () {
                  push(context, const NotificationPage());
                },
                borderRadius: BorderRadius.circular(50),
                child: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: const BoxDecoration(
                    color: AppColors.redColor,
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    count > 99 ? '99+' : count.toString(),
                    style: AppTextStyle.bold(
                      color: Colors.white,
                      rawFontSize: AppConfig.defaultRawTextSize - 1.5,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
