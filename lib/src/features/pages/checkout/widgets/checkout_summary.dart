import 'package:aladdin_franchise/generated/l10n.dart';
import 'package:aladdin_franchise/src/configs/app.dart';
import 'package:aladdin_franchise/src/configs/color.dart';
import 'package:aladdin_franchise/src/configs/dev_config.dart';
import 'package:aladdin_franchise/src/configs/text_style.dart';
import 'package:aladdin_franchise/src/features/pages/checkout/provider.dart';
import 'package:aladdin_franchise/src/features/pages/home/state.dart';
import 'package:aladdin_franchise/src/features/widgets/gap.dart';
import 'package:aladdin_franchise/src/features/widgets/price_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CheckoutSummary extends ConsumerWidget {
  const CheckoutSummary({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var price = ref.watch(checkoutProvider.select((value) => value.dataBill.price));
    var dataBillState = ref.watch(checkoutProvider.select((value) => value.dataBillState));
    bool loading = false;
    bool error = false;
    switch (dataBillState.status) {
      case PageCommonState.loading:
        loading = true;
        break;
      case PageCommonState.error:
      case PageCommonState.normal:
        error = true;
        break;
      default:
    }

    bool newUI = DevConfig.newUI;
    return Container(
      margin: const EdgeInsets.only(right: 12),
      decoration: newUI
          ? null
          : BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: AppConfig.borderRadiusMain,
            ),
      padding: const EdgeInsets.all(16),
      child: error
          ? _CheckoutPriceError(
              onRetry: ref.read(checkoutProvider.notifier).getDataBill,
              message: dataBillState.messageError,
            )
          : Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                PriceInfoLine(
                  title: S.of(context).total_amount,
                  amount: price.totalPrice,
                  loading: loading,
                ),
                const Gap(4),
                PriceInfoLine(
                  title: S.of(context).discount_money,
                  amount: price.totalPriceVoucher,
                  isDiscount: true,
                  loading: loading,
                ),
                const Gap(4),
                PriceInfoLine(
                  title: S.of(context).tax_money,
                  amount: price.totalPriceTax,
                  loading: loading,
                ),
                if (newUI) const Divider(height: 20) else const Gap(4),
                PriceInfoLine(
                  title: S.of(context).totalAmountPayment,
                  amount: price.totalPriceFinal,
                  loading: loading,
                  titleTextStyle: AppTextStyle.bold(
                      rawFontSize: newUI ? AppConfig.defaultRawTextSize + 1.5 : null),
                  amountTextStyle: AppTextStyle.bold(
                    rawFontSize: newUI ? AppConfig.defaultRawTextSize + 1.5 : null,
                    color: Colors.deepOrange,
                  ),
                ),
                if ((price.receivedAmount ?? 0) > 0) ...[
                  const Gap(8),
                  PriceInfoLine(
                    title: S.of(context).payment_received,
                    amount: price.receivedAmount,
                  ),
                  if (((price.receivedAmount ?? 0) - price.totalPriceFinal) > 0) ...[
                    const Gap(4),
                    PriceInfoLine(
                      title: S.of(context).change_returned,
                      amount: (price.receivedAmount ?? 0) - price.totalPriceFinal,
                    ),
                  ],
                ],
              ],
            ),
    );
  }
}

class _CheckoutPriceError extends ConsumerWidget {
  const _CheckoutPriceError({
    super.key,
    this.onRetry,
    this.message,
    this.title,
  });
  final VoidCallback? onRetry;

  final String? message;
  final String? title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: double.maxFinite,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppColors.redColor.withOpacity(0.08),
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.error_outline, color: AppColors.redColor, size: 28),
        ),
        const Gap(12),
        Text(
          title ?? "Không thể tính tiền",
          style: AppTextStyle.bold(
            rawFontSize: AppConfig.defaultRawTextSize + 1.0,
          ),
        ),
        if ((message?.trim() ?? '').isNotEmpty) ...[
          const Gap(6),
          Text(
            message ?? '',
            style: AppTextStyle.bold(rawFontSize: AppConfig.defaultRawTextSize, color: Colors.grey),
            textAlign: TextAlign.center,
          ),
        ],
        if (onRetry != null) ...[
          const Gap(12),
          // SizedBox(
          //   height: 36,
          //   child: OutlinedButton.icon(
          //     onPressed: onRetry,
          //     style: OutlinedButton.styleFrom(
          //       padding: const EdgeInsets.symmetric(horizontal: 12),
          //       shape: RoundedRectangleBorder(
          //         borderRadius: BorderRadius.circular(8),
          //       ),
          //     ),
          //     icon: const Icon(Icons.refresh, size: 16),
          //     label: const Text("Thử lại"),
          //   ),
          // ),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: onRetry,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFB12A00),
                    minimumSize: const Size.fromHeight(45),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    "Thử lại",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          )
        ],
      ],
    );
  }
}
