import 'package:aladdin_franchise/generated/assets.dart';
import 'package:aladdin_franchise/src/configs/app.dart';
import 'package:aladdin_franchise/src/configs/color.dart';
import 'package:aladdin_franchise/src/configs/text_style.dart';
import 'package:aladdin_franchise/src/core/storages/provider.dart';
import 'package:aladdin_franchise/src/features/widgets/image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

// import '../../../generated/assets.dart';

class FlashInitWidget extends ConsumerWidget {
  const FlashInitWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userData = ref.watch(userInfoProvider);
    final imageUrl = userData.restaurant?.logo ?? " ";
    final restaurantName =
        userData.restaurant?.name?.toUpperCase() ?? AppConfig.appName;
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(220),
                  child: Container(
                    color: AppColors.secondColor,
                    child: AppImageCacheNetworkWidget(
                      width: 200,
                      height: 200,
                      imageUrl: imageUrl,
                      fit: BoxFit.cover,
                      // change here
                      errorWidget: Image.asset(
                        Assets.imagesLogo2,
                        color: AppColors.mainColor,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 12.sp),
                Text(
                  restaurantName,
                  style: AppTextStyle.regular(
                    fontSize: 15.sp,
                    color: AppColors.secondColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(12.sp),
            child: Text(
              "© ${AppConfig.companyName.toUpperCase()}",
              style: AppTextStyle.regular(
                color: AppColors.secondColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
