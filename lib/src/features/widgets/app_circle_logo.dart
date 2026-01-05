import 'package:aladdin_franchise/generated/assets.dart';
import 'package:aladdin_franchise/src/configs/color.dart';
import 'package:flutter/material.dart';

class CirleAppLogoWidget extends StatelessWidget {
  const CirleAppLogoWidget({super.key, this.size = 120});
  final double size;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(100),
        child: Container(
          color: AppColors.mainColor,
          child: Image.asset(
            Assets.imagesLoading,
            width: size,
            color: AppColors.secondColor,
          ),
        ),
      ),
    );
  }
}
