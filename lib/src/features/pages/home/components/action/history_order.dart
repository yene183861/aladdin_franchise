import 'package:aladdin_franchise/generated/assets.dart';
import 'package:aladdin_franchise/generated/l10n.dart';
import 'package:aladdin_franchise/src/configs/app.dart';
import 'package:aladdin_franchise/src/features/pages/history_order/view.dart';
import 'package:aladdin_franchise/src/features/widgets/button_with_icon.dart';
import 'package:aladdin_franchise/src/utils/navigator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

class ButtonHistoryOrderWidget extends ConsumerWidget {
  const ButtonHistoryOrderWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ButtonWithIconWidget(
      padding: const EdgeInsets.all(6),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          AppConfig.sizeBorderRadiusSecond,
        ),
      ),
      onPressed: () {
        push(context, const HistoryOrderPage());
      },
      textAction: S.of(context).table_order_history,
      iconWidget: SvgPicture.asset(Assets.iconsDocumentText),
    );
  }
}
