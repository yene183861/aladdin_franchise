import 'package:aladdin_franchise/generated/assets.dart';
import 'package:aladdin_franchise/generated/l10n.dart';
import 'package:aladdin_franchise/src/configs/app.dart';
import 'package:aladdin_franchise/src/features/dialogs/order/order_option_dialog.dart';
import 'package:aladdin_franchise/src/features/widgets/button/btn_with_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

class OrderOptionBtn extends ConsumerWidget {
  const OrderOptionBtn({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ButtonWithIconWidget(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          AppConfig.sizeBorderRadiusSecond,
        ),
      ),
      onPressed: () {
        showOrderOptionDialog(context);
      },
      textAction: S.of(context).selectOrder,
      iconWidget: SvgPicture.asset(
        Assets.iconsPlatform,
        width: 24,
        height: 24,
      ),
    );
  }
}
