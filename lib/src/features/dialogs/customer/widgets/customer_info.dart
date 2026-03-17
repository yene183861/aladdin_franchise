import 'package:aladdin_franchise/generated/assets.dart';
import 'package:aladdin_franchise/generated/l10n.dart';
import 'package:aladdin_franchise/src/configs/app.dart';
import 'package:aladdin_franchise/src/configs/color.dart';
import 'package:aladdin_franchise/src/configs/dev_config.dart';
import 'package:aladdin_franchise/src/configs/text_style.dart';
import 'package:aladdin_franchise/src/features/dialogs/confirm_action.dart';
import 'package:aladdin_franchise/src/features/dialogs/message.dart';
import 'package:aladdin_franchise/src/features/pages/checkout/provider.dart';
import 'package:aladdin_franchise/src/features/widgets/gap.dart';
import 'package:aladdin_franchise/src/models/customer/customer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomerInfoCard extends ConsumerWidget {
  final CustomerModel customer;
  final bool canAction;

  final bool showRank;
  const CustomerInfoCard({
    Key? key,
    required this.customer,
    this.canAction = true,
    this.showRank = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            elevation: 0,
            color: Colors.grey[100],
            shape: RoundedRectangleBorder(borderRadius: AppConfig.borderRadiusMain),
            child: ListTile(
              visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
              leading: _AvatarCustomerWidget(
                gender: customer.gender,
              ),
              title: Text(
                customer.name,
                style: AppTextStyle.bold(color: AppColors.mainColor),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(CupertinoIcons.sunrise),
                      const Gap(8),
                      Expanded(
                        child: Text(customer.dob == null ||
                                ['', '0000-00-00'].contains(customer.dob!.trim().toLowerCase())
                            ? S.current.noBOD
                            : appConfig.dateFormatDDMMYYYY.format(DateTime.parse(customer.dob!))),
                      ),
                    ],
                  ),
                  const Gap(4),
                  Row(
                    children: [
                      const Icon(CupertinoIcons.phone),
                      const Gap(8),
                      Expanded(
                        child: Text(customer.phoneNumber),
                      ),
                    ],
                  ),
                  if (showRank) ...[
                    const Gap(4),
                    FittedBox(
                      child: Row(
                        children: [
                          const Icon(CupertinoIcons.star),
                          const Gap(8),
                          Text(
                            "${S.current.rank}: ${customer.level ?? S.current.notAvailableYet} "
                            "${customer.levelApprove == null ? '' : "(${appConfig.dateFormatDDMMYYYYHhMmSs.format(customer.levelApprove!)})"}",
                          ),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
              trailing: canAction
                  ? IconButton(
                      onPressed: () {
                        showConfirmAction(
                          context,
                          action: () async {
                            final result =
                                await ref.read(checkoutProvider.notifier).removeCustomer();
                            if (result != null) {
                              if (context.mounted) {
                                showMessageDialog(
                                  context,
                                  message: result.toString(),
                                );
                              }
                            } else {
                              if (DevConfig.useCoupon) {
                                // xoá khách xong thì áp dụng lại giảm giá
                                await ref
                                    .read(checkoutProvider.notifier)
                                    .applyCustomerPolicy(requireApply: true);
                              }
                            }
                          },
                          message: S.current.removeCustomer,
                        );
                      },
                      color: AppColors.redColor,
                      icon: const Icon(CupertinoIcons.clear),
                    )
                  : null,
            ),
          ),
        ],
      ),
    );
  }
}

class _AvatarCustomerWidget extends StatelessWidget {
  final String? gender;
  const _AvatarCustomerWidget({
    Key? key,
    this.gender,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var genderCheck = gender?.toLowerCase();
    String assetsIcon = Assets.iconsGenderUnknow;
    if (genderCheck == appConfig.gender[0]) {
      assetsIcon = Assets.iconsMan;
    } else if (genderCheck == appConfig.gender[1]) {
      assetsIcon = Assets.iconsWoman;
    } else {
      assetsIcon = Assets.iconsGenderUnknow;
    }
    return Image.asset(
      assetsIcon,
      width: 24,
    );
  }
}
