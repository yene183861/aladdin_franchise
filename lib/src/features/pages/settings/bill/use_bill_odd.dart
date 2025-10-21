import 'package:aladdin_franchise/src/core/storages/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../configs/text_style.dart';
import '../provider.dart';

class SettingBillUseBillOdd extends ConsumerWidget {
  const SettingBillUseBillOdd({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final printSetting = ref.watch(printSettingProvider);
    return Column(
      children: [
        SwitchListTile(
          title: Text(
            "Gọi món có in bill lẻ",
            style: AppTextStyle.bold(),
          ),
          value: printSetting.billReturnSetting.useOddBill,
          controlAffinity: ListTileControlAffinity.leading,
          onChanged: (value) {
            ref.read(settingsPageProvider.notifier).onChangeSetting(
                  billReturnSetting: printSetting.billReturnSetting.copyWith(useOddBill: value),
                );
          },
        ),
        // if (appSettings.billReturnSetting.useOddBill)
        //   SwitchListTile(
        //     title: Text(
        //       "Các món đã in bill lẻ lúc gọi món, khi trả đồ có in bill lẻ không?",
        //       style: AppTextStyle.regular(),
        //     ),
        //     value: appSettings.billReturnSetting.useOddBillForItemHasOddBill,
        //     controlAffinity: ListTileControlAffinity.leading,
        //     onChanged: (value) {
        //       ref.read(settingsPageProvider.notifier).onChangeSetting(
        //             billReturnSetting: appSettings.billReturnSetting.copyWith(
        //               useOddBillForItemHasOddBill: value,
        //             ),
        //           );
        //     },
        //   ),
      ],
    );
  }
}
