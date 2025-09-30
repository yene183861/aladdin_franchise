import 'package:aladdin_franchise/src/configs/color.dart';
import 'package:flutter/material.dart';

class CustomCheckbox extends StatelessWidget {
  const CustomCheckbox({
    super.key,
    required this.onChange,
    this.checked = false,
  });
  final Function() onChange;
  final bool checked;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onChange,
      child: Container(
        alignment: Alignment.center,
        height: 20,
        width: 20,
        decoration: BoxDecoration(
          color: checked ? AppColors.redColor : Colors.white,
          borderRadius: BorderRadius.circular(4),
          border: checked ? null : Border.all(color: Colors.grey),
        ),
        child: Icon(
          Icons.check,
          color: checked ? Colors.white : Colors.transparent,
          size: 18,
        ),
      ),
    );
  }
}
