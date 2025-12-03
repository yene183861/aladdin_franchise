import 'package:aladdin_franchise/src/configs/color.dart';
import 'package:aladdin_franchise/src/configs/text_style.dart';
import 'package:aladdin_franchise/src/features/widgets/app_icon_widget.dart';
import 'package:aladdin_franchise/src/features/widgets/gap.dart';
import 'package:flutter/material.dart';

class CustomCheckbox extends StatelessWidget {
  const CustomCheckbox({
    super.key,
    required this.onChange,
    this.checked = false,
    this.enable = true,
  });
  final Function() onChange;
  final bool checked;
  final bool enable;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: enable ? onChange : null,
      child: Container(
        alignment: Alignment.center,
        height: 24,
        width: 24,
        decoration: BoxDecoration(
          color: checked ? AppColors.redColor : Colors.white,
          borderRadius: BorderRadius.circular(4),
          border: checked ? null : Border.all(color: Colors.grey),
        ),
        child: ResponsiveIconWidget(
          iconData: Icons.check,
          color: checked ? Colors.white : Colors.transparent,
          iconSize: 24,
        ),
      ),
    );
  }
}

class AppCheckbox extends StatelessWidget {
  const AppCheckbox({
    super.key,
    required this.onChange,
    this.checked = false,
    this.text,
    this.enable = true,
  });
  final Function() onChange;
  final bool checked;
  final String? text;
  final bool enable;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onChange,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomCheckbox(
            checked: checked,
            onChange: onChange,
            enable: enable,
          ),
          if (text != null) ...[
            const Gap(12),
            Flexible(
                child: Text(
              text!,
              style: AppTextStyle.regular(color: enable ? null : Colors.grey),
            )),
          ],
        ],
      ),
    );
  }
}
