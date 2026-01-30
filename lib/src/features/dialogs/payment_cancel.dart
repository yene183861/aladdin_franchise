import 'package:aladdin_franchise/src/configs/app.dart';
import 'package:aladdin_franchise/src/configs/text_style.dart';
import 'package:aladdin_franchise/src/features/widgets/button/app_buton.dart';
import 'package:aladdin_franchise/src/features/widgets/button/button_cancel.dart';
import 'package:aladdin_franchise/src/features/widgets/button/button_simple.dart';
import 'package:aladdin_franchise/src/features/widgets/button/close_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../generated/l10n.dart';

final cancelContentProvider = StateProvider.autoDispose<String>((ref) {
  return AppConfig.reasonCancelItem.first;
});

class PaymentCancelDialog extends ConsumerWidget {
  final Function(String content) onAction;
  const PaymentCancelDialog({
    Key? key,
    required this.onAction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: AppConfig.borderRadiusMain),
      title: Row(
        children: [
          Expanded(
            child: Text(
              S.current.reasonForCancellation,
              style: AppTextStyle.regular(
                rawFontSize: AppConfig.defaultRawTextSize + 1.0,
              ),
            ),
          ),
          CloseButton(),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: AppConfig.reasonCancelItem.map((e) {
          return RadioListTile(
            value: e,
            groupValue: ref.watch(cancelContentProvider),
            onChanged: (value) {
              ref.read(cancelContentProvider.state).state = value!;
            },
            title: Text(e),
          );
        }).toList(),
      ),
      actionsAlignment: MainAxisAlignment.spaceEvenly,
      actions: [
        AppCloseButton(
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        // ButtonCancelWidget(
        //   onPressed: () => Navigator.pop(context),
        // ),
        AppButton(
          onPressed: () async {
            var content = ref.read(cancelContentProvider);
            Navigator.pop(context);
            onAction.call(content);
          },
          textAction: S.current.confirm,
        ),
        // ButtonSimpleWidget(
        //   onPressed: () async {
        //     var content = ref.read(cancelContentProvider);
        //     Navigator.pop(context);
        //     onAction.call(content);
        //   },
        //   // color: AppColors.bgButtonMain,
        //   // textColor: AppColors.tcButtonMain,
        //   textAction: S.current.confirm,
        // )
      ],
    );
  }
}

Future<void> showPaymentCancelDialog(
  BuildContext context, {
  required Function(String content) onAction,
}) async {
  showDialog(
    context: context,
    useRootNavigator: false,
    barrierDismissible: false,
    builder: (context) => PaymentCancelDialog(
      onAction: onAction,
    ),
  );
}
