import 'package:aladdin_franchise/src/configs/app.dart';
import 'package:aladdin_franchise/src/configs/color.dart';
import 'package:aladdin_franchise/src/configs/text_style.dart';
import 'package:aladdin_franchise/src/features/widgets/gap.dart';
import 'package:aladdin_franchise/src/models/customer/customer_policy.dart';
import 'package:aladdin_franchise/src/utils/app_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../generated/l10n.dart';

void showCouponDetailDialog(
  BuildContext context,
  CustomerPolicyModel coupon,
) {
  showDialog(
    context: context,
    useRootNavigator: false,
    barrierDismissible: true,
    builder: (context) => AlertDialog(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "${S.current.discountCode}: ${coupon.name}",
            style: Theme.of(context).dialogTheme.titleTextStyle,
          ),
          const CloseButton(color: AppColors.redColor),
        ],
      ),
      content: _CouponInfoWidget(coupon: coupon),
      shape: RoundedRectangleBorder(borderRadius: AppConfig.borderRadiusMain),
    ),
  );
}

class _CouponInfoWidget extends ConsumerWidget {
  final CustomerPolicyModel coupon;
  const _CouponInfoWidget({
    Key? key,
    required this.coupon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            S.current.coupon_condition_apply,
            style: AppTextStyle.bold(),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 12),
            child: coupon.conditionApplyMessage.isEmpty
                ? Text(S.current.no_conditions)
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ...coupon.conditionApplyMessage.map(
                        (e) => Text(
                          e,
                          style: AppTextStyle.regular(),
                        ),
                      )
                    ],
                  ),
          ),
          const Divider(),
          const Gap(12),
          Text(
            "${S.current.payment_method_does_not_apply} (${coupon.paymentNotAllowed.length})",
            style: AppTextStyle.bold(),
          ),
          coupon.paymentNotAllowed.isEmpty
              ? Text(
                  S.current.accept_all_payment_method,
                  style: AppTextStyle.regular(),
                )
              : Wrap(
                  spacing: 8,
                  children: [
                    ...coupon.paymentNotAllowed.map(
                      (e) => Chip(
                        label: Text(
                          e.getNameView(),
                          style: AppTextStyle.regular(),
                        ),
                      ),
                    ),
                  ],
                ),
          const Divider(),
          const Gap(12),
          ExpansionTile(
            tilePadding: EdgeInsets.zero,
            title: Text(
              "${S.current.applyProducts} (${coupon.discount.length})",
              style: AppTextStyle.bold(),
            ),
            subtitle: Text(
              "${coupon.applyComboItem ? S.current.yes : S.current.not} ${S.current.apply_with_combo_item}",
              style: AppTextStyle.regular(),
            ),
            children: [
              ...coupon.discount.map(
                (e) => ListTile(
                  dense: true,
                  title: Text(
                    e.name ?? S.current.billTotal,
                    style: AppTextStyle.regular(),
                  ),
                  trailing: e.type == 1
                      ? Text(
                          "-${AppUtils.getPercentValue(e.amount)}",
                          style: AppTextStyle.regular(),
                        )
                      : Text(
                          "-${AppUtils.formatCurrency(value: e.amount)
                          // AppConfig.formatCurrency().format(e.amount)
                          }",
                          style: AppTextStyle.regular(),
                        ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
