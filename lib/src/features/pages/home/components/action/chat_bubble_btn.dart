import 'package:aladdin_franchise/generated/assets.dart';
import 'package:aladdin_franchise/src/configs/app.dart';
import 'package:aladdin_franchise/src/configs/color.dart';
import 'package:aladdin_franchise/src/core/storages/local.dart';
import 'package:aladdin_franchise/src/features/pages/home/provider.dart';
import 'package:aladdin_franchise/src/features/widgets/button/icon_button.dart';
import 'package:float_bubble/float_bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ChatBubbleBtn extends ConsumerWidget {
  const ChatBubbleBtn({super.key, this.onTap, required this.bubbleKey});

  final VoidCallback? onTap;
  final GlobalKey bubbleKey;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool useO2o = LocalStorage.getDataLogin()?.restaurant?.o2oStatus ?? false;
    final orderSelect = ref.watch(homeProvider.select((value) => value.orderSelect));

    bool smallDevice = ResponsiveBreakpoints.of(context).smallerOrEqualTo(MOBILE);
    bool hideChatBubble =
        !useO2o || orderSelect == null || kTypeOrder == AppConfig.orderOnlineValue;
    return hideChatBubble
        ? const SizedBox.shrink()
        : FloatBubble(
            show: true,
            initialAlignment: smallDevice ? Alignment(1, (140 / 100.w) - 1) : Alignment.topRight,
            child: AppIconButton(
              key: bubbleKey,
              svgPath: Assets.iconsChat,
              iconColor: AppColors.secondColor,
              iconSize: 30,
              padding: const EdgeInsets.all(16),
              onTap: onTap,
            ),
          );
  }
}
