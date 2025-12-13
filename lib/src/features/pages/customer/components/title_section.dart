import 'package:aladdin_franchise/src/configs/color.dart';
import 'package:aladdin_franchise/src/configs/text_style.dart';
import 'package:flutter/material.dart';

class TitleSection extends StatelessWidget {
  const TitleSection({
    super.key,
    required this.paddingHorizontal,
    required this.title,
    this.height = 50,
  });

  final double paddingHorizontal;
  final String title;

  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      padding: EdgeInsets.symmetric(
        horizontal: paddingHorizontal,
        vertical: 4,
      ),
      alignment: Alignment.centerLeft,
      width: double.maxFinite,
      color: const Color(0xff292929),
      child: Text(
        title,
        style: AppTextStyle.bold(color: AppColors.white),
      ),
    );
  }
}
