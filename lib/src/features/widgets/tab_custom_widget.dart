import 'package:aladdin_franchise/src/configs/color.dart';
import 'package:aladdin_franchise/src/configs/text_style.dart';
import 'package:flutter/material.dart';

class TabCustomWidget extends StatelessWidget {
  final bool active;
  final String title;
  const TabCustomWidget({
    Key? key,
    required this.active,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Tab(
      child: Container(
        width: double.maxFinite,
        height: double.maxFinite,
        decoration: BoxDecoration(
          color: active ? AppColors.bgTabSelect : AppColors.bgTabUnSelect,
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(0),
          ),
        ),
        child: Center(
          child: Text(
            title,
            style: AppTextStyle.regular(
              color: active ? Colors.white : Colors.grey,
            ),
          ),
        ),
      ),
    );
  }
}
