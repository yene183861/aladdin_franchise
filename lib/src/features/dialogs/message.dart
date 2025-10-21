import 'package:aladdin_franchise/src/configs/app.dart';
import 'package:aladdin_franchise/src/configs/text_style.dart';
import 'package:aladdin_franchise/src/features/widgets/button_simple.dart';
import 'package:aladdin_franchise/src/features/widgets/gap.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../generated/l10n.dart';

Future<void> showMessageDialog(
  BuildContext context, {
  String? title,
  String message = "Aladdin",
  String? textAction,
  String? titleMessage,
  bool canPop = true,
  bool showAction = true,
}) async {
  await showDialog(
    context: context,
    useRootNavigator: false,
    barrierDismissible: false,
    builder: (context) => PopScope(
      canPop: canPop,
      child: AlertDialog(
        title: Text(
          title ?? S.current.notification,
          style: AppTextStyle.medium(),
        ),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (titleMessage != null)
              Text(
                titleMessage,
                style: AppTextStyle.bold(),
              ),
            if (titleMessage != null) const GapH(6),
            Text(
              message,
              style: AppTextStyle.regular(),
            ),
          ],
        ),
        shape: RoundedRectangleBorder(borderRadius: AppConfig.borderRadiusMain),
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          if (showAction)
            ButtonSimpleWidget(
              onPressed: () => Navigator.pop(context),
              textAction: textAction ?? S.current.confirm,
            ),
        ],
      ),
    ),
  );
}
