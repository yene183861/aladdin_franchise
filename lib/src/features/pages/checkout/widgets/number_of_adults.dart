import 'package:aladdin_franchise/generated/l10n.dart';
import 'package:aladdin_franchise/src/configs/app.dart';
import 'package:aladdin_franchise/src/configs/text_style.dart';
import 'package:aladdin_franchise/src/features/pages/checkout/provider.dart';
import 'package:aladdin_franchise/src/features/pages/home/provider.dart';
import 'package:aladdin_franchise/src/features/widgets/gap.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinbox/material.dart';

class NumberOfAdultsWidget extends ConsumerWidget {
  const NumberOfAdultsWidget({super.key, this.isPaymenting = false});
  final bool isPaymenting;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var lockedOrder = ref.watch(homeProvider.select((value) => value.lockedOrder));
    var coupons = ref.watch(checkoutProvider.select((value) => value.coupons));
    bool enable = !lockedOrder;

    String message = '';
    if (coupons.any((e) => e.isType == 6)) {
      message =
          'Đơn bàn có sử dụng mã giảm giá theo số khách, vui lòng bấm áp dụng sau khi thay đổi số khách';
      if (isPaymenting) {
        message = 'Đơn bàn có sử dụng mã giảm giá theo số khách, '
            'vui lòng vào mục Ưu đãi để thay đổi số khách trước khi tiếp tục thanh toán';
      }
    }
    if (!isPaymenting && lockedOrder) {
      message = 'Đơn bàn đã tạm khóa';
    } else if (message.trim().isNotEmpty) {
      enable = true;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _NumberOfAdultsSelector(enable: enable),
        if (message.trim().isNotEmpty) ...[
          const Gap(4),
          Row(
            children: [
              const Icon(Icons.info_outline_rounded, color: Colors.red),
              const Gap(4),
              Expanded(
                child: Text(
                  message,
                  style: AppTextStyle.regular(
                    rawFontSize: AppConfig.defaultRawTextSize - 1.5,
                    color: Colors.red,
                  ),
                ),
              )
            ],
          ),
        ],
      ],
    );
  }
}

class _NumberOfAdultsSelector extends ConsumerWidget {
  const _NumberOfAdultsSelector({
    super.key,
    this.labelText,
    this.enable = true,
  });
  final String? labelText;
  final bool enable;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SpinBox(
      min: 1,
      max: 200,
      enabled: enable,
      incrementIcon: const Icon(CupertinoIcons.add),
      decrementIcon: const Icon(CupertinoIcons.minus),
      textStyle: AppTextStyle.bold(),
      value: ref.watch(checkoutProvider.select((value) => value.numberOfAdults)).toDouble(),
      decoration: InputDecoration(
        label: Text.rich(
          TextSpan(
            text: labelText ?? S.current.number_of_guest,
            children: [
              if (labelText == null)
                TextSpan(
                  text: ' (${S.current.number_of_adults})',
                  style: AppTextStyle.regular(),
                ),
            ],
            style: AppTextStyle.bold(),
          ),
        ),
      ),
      onChanged: (value) {
        // bool requiredApplyPolicy = ref.read(homeProvider).coupons.any((e) => e.isType == 6);
        // ref.read(homeProvider.notifier).changeNumberOfPeople(
        //       numberOfAdults: value.toInt(),
        //       //  applyPolicy: false
        //     );
      },
    );
  }
}
