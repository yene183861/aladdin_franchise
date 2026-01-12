import 'package:aladdin_franchise/src/configs/color.dart';
import 'package:flutter/material.dart';

class CustomCheckbox extends StatelessWidget {
  const CustomCheckbox({
    super.key,
    required this.onChange,
    this.checked = false,
    this.checkedColor,
  });
  final Function() onChange;
  final bool checked;

  final Color? checkedColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 36,
      padding: const EdgeInsets.only(right: 12),
      child: InkWell(
        onTap: onChange,
        child: Container(
          alignment: Alignment.center,
          height: 24,
          width: 24,
          decoration: BoxDecoration(
            color: checked ? (checkedColor ?? AppColors.redColor) : Colors.white,
            borderRadius: BorderRadius.circular(4),
            border: checked ? null : Border.all(color: Colors.grey),
          ),
          child: Icon(
            Icons.check,
            color: checked ? Colors.white : Colors.transparent,
            size: 24,
          ),
        ),
      ),
    );
  }
}
