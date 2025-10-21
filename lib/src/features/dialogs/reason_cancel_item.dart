import 'package:aladdin_franchise/generated/l10n.dart';
import 'package:aladdin_franchise/src/configs/app.dart';
import 'package:aladdin_franchise/src/configs/color.dart';
import 'package:aladdin_franchise/src/configs/text_style.dart';
import 'package:aladdin_franchise/src/features/dialogs/message.dart';
import 'package:aladdin_franchise/src/features/widgets/button_cancel.dart';
import 'package:aladdin_franchise/src/features/widgets/button_simple.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ReasonCancelItemDialog extends ConsumerStatefulWidget {
  const ReasonCancelItemDialog({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ReasonCancelItemDialogState();
}

class _ReasonCancelItemDialogState extends ConsumerState<ReasonCancelItemDialog> {
  String? reason;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: AppConfig.borderRadiusMain),
      title: Text(
        S.current.reasonForCancellation,
        style: AppTextStyle.regular(
          rawFontSize: 15,
        ),
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: AppConfig.reasonCancelItem.map((e) {
            return RadioListTile<String>(
              value: e,
              groupValue: reason,
              onChanged: (value) {
                setState(() {
                  reason = value;
                });
              },
              title: Text(
                e,
                style: AppTextStyle.regular(),
              ),
            );
          }).toList(),
        ),
      ),
      actionsAlignment: MainAxisAlignment.spaceEvenly,
      actions: [
        ButtonCancelWidget(
          onPressed: () => Navigator.pop(context),
        ),
        ButtonSimpleWidget(
          onPressed: () async {
            if (reason == null) {
              showMessageDialog(context, message: 'Vui lòng chọn lí do hủy món!');
              return;
            }
            Navigator.pop(context, reason);
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
