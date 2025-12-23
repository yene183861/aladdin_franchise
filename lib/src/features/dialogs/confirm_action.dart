import 'package:aladdin_franchise/src/configs/app.dart';
import 'package:aladdin_franchise/src/configs/color.dart';
import 'package:aladdin_franchise/src/configs/text_style.dart';
import 'package:aladdin_franchise/src/features/widgets/button_cancel.dart';
import 'package:aladdin_franchise/src/features/widgets/button_simple.dart';
import 'package:aladdin_franchise/src/features/widgets/gap.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../generated/l10n.dart';

Future<bool?> showConfirmAction(
  BuildContext context, {
  String? title,
  String message = "Aladdin",
  String? actionTitle,
  VoidCallback? action,
  bool notCancel = false,
  VoidCallback? actionCancel,
  String? textCancel,
  TextAlign? textAlign,
  bool closeBtn = false,
  List<Widget> extraAction = const [],
}) async {
  var result = await showDialog(
      context: context,
      useRootNavigator: false,
      barrierDismissible: false,
      builder: (contextDialog) {
        return PopScope(
          canPop: false,
          child: AlertDialog(
            title: Row(children: [
              Expanded(
                child: Text(
                  title ?? S.current.confirm,
                  style: AppTextStyle.medium(),
                ),
              ),
              if (closeBtn)
                CloseButton(onPressed: () {
                  Navigator.pop(contextDialog, null);
                }),
            ]),
            content: Text(
              message,
              style: AppTextStyle.regular(),
              textAlign: textAlign,
            ),
            shape: RoundedRectangleBorder(borderRadius: AppConfig.borderRadiusMain),
            actionsAlignment: notCancel ? MainAxisAlignment.center : MainAxisAlignment.spaceEvenly,
            actions: [
              if (!notCancel) ...[
                ButtonCancelWidget(
                  textAction: textCancel,
                  onPressed: () {
                    Navigator.pop(contextDialog, false);
                    actionCancel?.call();
                  },
                ),
                const GapW(16),
              ],
              if (extraAction.isNotEmpty) ...[
                ...extraAction,
                const GapW(16),
              ],
              ButtonSimpleWidget(
                color: AppColors.bgButtonMain,
                textColor: AppColors.tcButtonMain,
                textAction: actionTitle ?? S.current.agree,
                onPressed: () {
                  Navigator.pop(contextDialog, true);
                  action?.call();
                },
              ),
            ],
          ),
        );
      });
  return result;
}

Future<bool?> showConfirmActionWithChild(
  BuildContext context, {
  String? title,
  String? actionTitle,
  VoidCallback? action,
  VoidCallback? actionCancel,
  String? textCancel,
  Widget? child,
  bool notCancel = false,
  bool Function()? onCheckAction,

  /// đóng popup khi bấm button action
  bool closeDialog = true,
  bool noTitle = false,
  List<Widget> otherActions = const [],
}) async {
  final result = await showDialog(
      context: context,
      useRootNavigator: false,
      barrierDismissible: false,
      builder: (contextDialog) {
        return PopScope(
          canPop: false,
          child: AlertDialog(
            title: noTitle
                ? null
                : Text(
                    title ?? S.current.confirm,
                    style: AppTextStyle.semiBold(),
                  ),
            content: child,
            shape: RoundedRectangleBorder(borderRadius: AppConfig.borderRadiusMain),
            actionsAlignment: MainAxisAlignment.spaceEvenly,
            actions: [
              if (!notCancel)
                ButtonCancelWidget(
                  textAction: textCancel,
                  onPressed: () {
                    Navigator.pop(contextDialog, false);
                    actionCancel?.call();
                  },
                ),
              if (!notCancel) const GapW(16),
              if (otherActions.isNotEmpty) ...otherActions,
              ButtonSimpleWidget(
                color: AppColors.bgButtonMain,
                textColor: AppColors.tcButtonMain,
                textAction: actionTitle ?? S.current.agree,
                onPressed: () {
                  bool continueAction = true;
                  if (onCheckAction != null) {
                    continueAction = onCheckAction.call();
                  }
                  if (continueAction) {
                    if (closeDialog) Navigator.pop(contextDialog, true);
                    action?.call();
                  }
                },
              ),
            ],
          ),
        );
        // );
      });
  return result;
}
