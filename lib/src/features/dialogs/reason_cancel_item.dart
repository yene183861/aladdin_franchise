import 'package:aladdin_franchise/generated/l10n.dart';
import 'package:aladdin_franchise/src/configs/app.dart';
import 'package:aladdin_franchise/src/configs/color.dart';
import 'package:aladdin_franchise/src/configs/text_style.dart';
import 'package:aladdin_franchise/src/data/enum/reason_cancel_item.dart';
import 'package:aladdin_franchise/src/features/dialogs/message.dart';
import 'package:aladdin_franchise/src/features/widgets/button/button_cancel.dart';
import 'package:aladdin_franchise/src/features/widgets/button/button_simple.dart';
import 'package:aladdin_franchise/src/features/widgets/button/close_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ReasonCancelItemDialog extends ConsumerStatefulWidget {
  const ReasonCancelItemDialog({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ReasonCancelItemDialogState();
}

class _ReasonCancelItemDialogState extends ConsumerState<ReasonCancelItemDialog> {
  ReasonCancelItemEnum? reason;
  @override
  Widget build(BuildContext context) {
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
          const CloseButton(),
        ],
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: ReasonCancelItemEnum.values.map((e) {
            return RadioListTile<ReasonCancelItemEnum>(
              value: e,
              groupValue: reason,
              onChanged: (value) {
                setState(() {
                  reason = value;
                });
              },
              title: Text(
                e.title,
                style: AppTextStyle.regular(),
              ),
            );
          }).toList(),
        ),
      ),
      actionsAlignment: MainAxisAlignment.spaceEvenly,
      actions: [
        const AppCloseButton(),
        // ButtonCancelWidget(
        //   onPressed: () => Navigator.pop(context),
        // ),
        ButtonSimpleWidget(
          onPressed: () async {
            if (reason == null) {
              showMessageDialog(context, message: S.current.please_select_reason_cancel_item);
              return;
            }
            Navigator.pop(context, reason?.key);
          },
          color: AppColors.bgButtonMain,
          textColor: AppColors.tcButtonMain,
          textAction: S.current.confirm,
        )
      ],
    );
  }
}

Future<String?> showReasonCancelItemDialog(BuildContext context) async {
  return showDialog(
    context: context,
    useRootNavigator: false,
    barrierDismissible: false,
    builder: (context) => const ReasonCancelItemDialog(),
  );
}
