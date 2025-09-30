import 'package:aladdin_franchise/generated/l10n.dart';
import 'package:aladdin_franchise/src/configs/app.dart';
import 'package:aladdin_franchise/src/configs/color.dart';
import 'package:aladdin_franchise/src/configs/text_style.dart';
import 'package:aladdin_franchise/src/features/pages/ticket/components/dialog.dart';
import 'package:aladdin_franchise/src/features/widgets/button_simple.dart';
import 'package:aladdin_franchise/src/features/widgets/button_with_icon.dart';
import 'package:aladdin_franchise/src/features/widgets/gap.dart';
import 'package:aladdin_franchise/src/utils/size_util.dart';
import 'package:aladdin_franchise/src/utils/take_screenshot.dart';
import 'package:flutter/material.dart';

Future<void> showErrorDialog(
  BuildContext context, {
  String message = "Error",
  String? textAction,
  String? titleMessage,
  String? titleTicket,
  bool isNotifier = false,
}) async {
  await showDialog(
    context: context,
    useRootNavigator: false,
    barrierDismissible: false,
    builder: (context) => _ErrorDialogWidget(
      message: message,
      textAction: textAction,
      titleMessage: titleMessage,
      titleTicket: titleTicket,
      isNotifier: isNotifier,
    ),
  );
}

class _ErrorDialogWidget extends StatelessWidget {
  const _ErrorDialogWidget({
    super.key,
    this.textAction,
    this.titleMessage,
    this.message = "Error",
    this.titleTicket,
    this.titleTop,
    this.isNotifier = false,
  });
  final String message;
  final String? textAction;
  final String? titleMessage;
  final String? titleTicket;
  final String? titleTop;
  final bool isNotifier;

  @override
  Widget build(BuildContext context) {
    bool isSmallDevice = AppDeviceSizeUtil.checkSmallDevice(context);
    return PopScope(
      canPop: false,
      child: AlertDialog(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              isNotifier ? S.current.notification : S.current.error,
              style: AppTextStyle.bold(
                // fontSize: 14.sp,
                color: isNotifier ? null : AppColors.redColor,
              ),
            ),
          ],
        ),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (titleMessage != null)
              Text(
                titleMessage!,
                style: AppTextStyle.bold(),
              ),
            if (titleMessage != null) const GapH(6),
            Text(
              message,
              style: AppTextStyle.regular(),
            ),
            const Gap(26),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (!isSmallDevice) ...[
                  ButtonWithIconWidget(
                    onPressed: () async {
                      final data = await AppTakeScreenshot().takeFileScreenshotError();
                      await showCreateTicket(
                        context,
                        title: titleMessage ?? titleTicket,
                        content: message,
                        attachFile: data == null ? null : [data],
                      );
                    },
                    textAction: S.current.submit_error_ticket,
                    minWidth: 250,
                    color: Colors.grey,
                    icon: Icons.outgoing_mail,
                  ),
                ] else ...[
                  ButtonWithIconWidget(
                    onPressed: () async {
                      final data = await AppTakeScreenshot().takeFileScreenshotError();
                      await showCreateTicket(
                        context,
                        title: titleMessage ?? titleTicket,
                        content: message,
                        attachFile: data == null ? null : [data],
                      );
                    },
                    minWidth: 100,
                    textAction: 'Gửi ticket',
                    color: Colors.grey,
                    icon: Icons.outgoing_mail,
                  ),
                ],
                Gap(isSmallDevice ? 12 : 36),
                ButtonSimpleWidget(
                  onPressed: () => Navigator.pop(context),
                  minWidth: isSmallDevice ? 100 : 250,
                  textAction: textAction ?? S.current.close,
                ),
              ],
            )
          ],
        ),
        shape: RoundedRectangleBorder(borderRadius: AppConfig.borderRadiusMain),
      ),
    );
  }
}
