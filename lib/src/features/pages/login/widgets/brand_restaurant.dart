import 'package:aladdin_franchise/generated/l10n.dart';
import 'package:aladdin_franchise/src/configs/app.dart';
import 'package:aladdin_franchise/src/configs/color.dart';
import 'package:aladdin_franchise/src/configs/text_style.dart';
import 'package:aladdin_franchise/src/core/storages/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class BrandRestaurantWidget extends ConsumerWidget {
  const BrandRestaurantWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var restaurantName = AppConfig.appName;
    var restaurantSlogan = S.current.restaurant_slogan;
    final styleRef = ref.watch(styleAppProvider);
    switch (styleRef) {
      case RestaurantStyle.other:
        break;
      case RestaurantStyle.btqm:
        restaurantName = S.current.btqm;
        restaurantSlogan = S.current.btqmSlogan;
        break;
      case RestaurantStyle.longwang:
        restaurantName = S.current.longWang;
        restaurantSlogan = S.current.longWangSlogan;
        break;
      case RestaurantStyle.btap:
        restaurantName = S.current.btav;
        restaurantSlogan = S.current.btav_slogan;
        break;
      case RestaurantStyle.tianlong:
        restaurantName = S.current.tianLong;
        restaurantSlogan = S.current.tianLongSlogan;
        break;
      case RestaurantStyle.haiSuPotRice:
        restaurantName = S.current.hai_su_pot_rice;
        break;
    }

    return Column(
      children: [
        Text(
          restaurantName,
          textAlign: TextAlign.center,
          style: AppTextStyle.regular(
            fontWeight: FontWeight.w600,
            fontSize: 18.sp,
            color: AppColors.mainColor,
          ),
        ),
        Text(
          restaurantSlogan,
          textAlign: TextAlign.center,
          style: AppTextStyle.regular(
            fontWeight: FontWeight.w500,
            color: AppColors.secondColor,
          ),
        ),
      ],
    );
  }
}
