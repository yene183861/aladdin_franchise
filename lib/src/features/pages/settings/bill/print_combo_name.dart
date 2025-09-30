import 'package:aladdin_franchise/src/features/pages/settings/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:aladdin_franchise/src/core/storages/provider.dart';
import 'package:aladdin_franchise/src/configs/text_style.dart';

class SettingBillPrintComboNameWidget extends ConsumerWidget {
  const SettingBillPrintComboNameWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appSettings = ref.watch(appSettingsProvider);
    return SwitchListTile(
      title: Text(
        "Gọi món in kèm tên Set/Combo (nếu là món thành phần)",
        style: AppTextStyle.regular(),
      ),
      value: appSettings.billReturnSetting.printComboNameInOddBill,
      controlAffinity: ListTileControlAffinity.leading,
      onChanged: (value) {
        ref.read(settingsPageProvider.notifier).onChangeSetting(
              billReturnSetting: appSettings.billReturnSetting.copyWith(
                printComboNameInOddBill: value,
              ),
            );
      },
    );
  }
}
