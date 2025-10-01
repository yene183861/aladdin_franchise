import 'package:aladdin_franchise/generated/l10n.dart';
import 'package:aladdin_franchise/src/configs/text_style.dart';
import 'package:aladdin_franchise/src/features/widgets/gap.dart';
import 'package:aladdin_franchise/src/utils/navigator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class TitleLineWidget extends StatelessWidget {
  final String title;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color? color;
  final TextStyle? textStyle;
  const TitleLineWidget({
    Key? key,
    required this.title,
    this.fontSize,
    this.fontWeight,
    this.color,
    this.textStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Text(
        title,
        style: textStyle ??
            AppTextStyle.bold(
              fontSize: fontSize,
              color: color,
            ),
      ),
    );
  }
}

class TitleDialogWithCloseWidget extends StatelessWidget {
  const TitleDialogWithCloseWidget({
    super.key,
    required this.title,
    this.onPressedClose,
    this.textCloseButton,
  });
  final String title;
  final String? textCloseButton;
  final VoidCallback? onPressedClose;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: AppTextStyle.bold(fontSize: 15),
          ),
        ),
        const GapW(16),
        FilledButton.tonal(
          onPressed: () {
            if (onPressedClose == null) {
              pop(context);
            } else {
              onPressedClose?.call();
            }
          },
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.red.shade100),
          ),
          child: Text(
            textCloseButton ?? S.current.close,
            style: AppTextStyle.bold(
              color: Colors.red.shade700,
            ),
          ),
        ),
      ],
    );
  }
}
