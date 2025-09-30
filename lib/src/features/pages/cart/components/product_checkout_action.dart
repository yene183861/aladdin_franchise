import 'package:aladdin_franchise/src/configs/app.dart';
import 'package:aladdin_franchise/src/configs/color.dart';
import 'package:aladdin_franchise/src/configs/text_style.dart';
import 'package:aladdin_franchise/src/features/pages/home/components/order/order_detail.dart';

import 'package:aladdin_franchise/src/features/pages/home/provider.dart';
import 'package:aladdin_franchise/src/features/pages/login/view.dart';

import 'package:aladdin_franchise/src/features/widgets/gap.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ProductCheckoutActionWidget extends ConsumerWidget {
  const ProductCheckoutActionWidget({
    super.key,
    this.padding,
  });
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var productCheckout =
        ref.watch(homeProvider.select((value) => value.productCheckout));

    var displayOrderHistory =
        ref.watch(homeProvider.select((value) => value.displayOrderHistory));
    return Padding(
      padding: padding ?? const EdgeInsets.all(8.0),
      child: Row(children: [
        InkWell(
          onTap: () {
            ref
                .read(homeProvider.notifier)
                .onChangeDisplayOrderHistory(!displayOrderHistory);
          },
          borderRadius: AppConfig.borderRadiusSecond,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: displayOrderHistory
                  ? AppColors.secondColor
                  : Colors.grey.shade200,
              borderRadius: AppConfig.borderRadiusSecond,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (displayOrderHistory) ...[
                  const ResponsiveIconWidget(iconData: Icons.check_rounded),
                  const Gap(2),
                ],
                Text(
                  'Xem lịch sử',
                  style: AppTextStyle.medium(fontSize: 12),
                ),
              ],
            ),
          ),
        ),
        const Spacer(),
        if (productCheckout.isNotEmpty) ...[
          const Gap(12),
          InkWell(
            onTap: () async {
              var state = ref.read(homeProvider);
              if (state.displayOrderHistory) return;
              await onPressedCancelItem(
                context,
                ref,
                productCancel: state.productCheckout,
              );
            },
            borderRadius: AppConfig.borderRadiusMain,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: AppColors.mainColor,
                borderRadius: AppConfig.borderRadiusMain,
              ),
              child: Text(
                'Xác nhận hủy',
                style: AppTextStyle.regular(
                  fontSize: 12.sp,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ]),
    );
  }
}
