import 'package:aladdin_franchise/src/configs/text_style.dart';
import 'package:aladdin_franchise/src/core/storages/local.dart';
import 'package:aladdin_franchise/src/core/storages/provider.dart';
import 'package:aladdin_franchise/src/features/widgets/app_icon_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ButtonUseFontScale extends ConsumerWidget {
  const ButtonUseFontScale({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final useFontScale =
        ref.watch(appSettingProvider.select((value) => value.useFontScale));
    return ListTile(
      title: Text(
        'Sử dụng tăng giảm cỡ chữ',
        style: AppTextStyle.medium(),
      ),
      leading: const ResponsiveIconWidget(
        iconData: Icons.format_size_rounded,
      ),
      trailing: Switch(
        value: useFontScale,
        onChanged: (value) async {
          var setting = ref.read(appSettingProvider);
          await LocalStorage.setAppSetting(
              setting.copyWith(useFontScale: !setting.useFontScale));
          ref.refresh(appSettingProvider);
        },
      ),
    );
  }
}
