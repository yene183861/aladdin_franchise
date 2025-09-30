import 'dart:io';

import 'package:aladdin_franchise/generated/assets.dart';
import 'package:aladdin_franchise/src/configs/color.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CirleAppLogoWidget extends StatelessWidget {
  const CirleAppLogoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(100),
        child: Container(
          color: AppColors.mainColor,
          child: Image.asset(
            Assets.imagesLoading,
            width: Device.screenType == ScreenType.mobile ? 60.px : 120.px,
            color: AppColors.secondColor,
          ),
        ),
      ),
    );
  }
}
