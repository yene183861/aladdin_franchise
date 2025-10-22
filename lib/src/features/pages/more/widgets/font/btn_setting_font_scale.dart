import 'package:aladdin_franchise/src/configs/text_style.dart';
import 'package:aladdin_franchise/src/core/storages/local.dart';
import 'package:aladdin_franchise/src/core/storages/provider.dart';
import 'package:aladdin_franchise/src/features/widgets/app_icon_widget.dart';
import 'package:aladdin_franchise/src/features/widgets/button_simple.dart';
import 'package:aladdin_franchise/src/utils/size_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ButtonSettingFontScale extends ConsumerWidget {
  const ButtonSettingFontScale({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final useFontScale = ref.watch(appSettingProvider.select((value) => value.useFontScale));
    final scale = ref.watch(appSettingProvider.select((value) => value.fontScale));
    bool isSmallDevice = AppDeviceSizeUtil.checkSmallDevice(context);
    if (!useFontScale) return const SizedBox.shrink();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
            title: Text(
              'Cỡ chữ hiện tại: ${(scale * 100).toInt()}%',
            ),
            leading: const ResponsiveIconWidget(
              iconData: Icons.format_size_rounded,
            ),
            subtitle: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Slider(
                        value: scale,
                        min: 0.6,
                        max: 1.5,
                        label: '${(scale * 100).toInt()}%',
                        onChanged: (v) async {
                          var setting = ref.read(appSettingProvider);
                          try {
                            await LocalStorage.setAppSetting(setting.copyWith(fontScale: v));

                            ref.refresh(appSettingProvider);
                          } catch (ex) {
                            //
                          }
                        },
                      ),
                    ),
                    if (!isSmallDevice) const _FontScaleDefault(),
                  ],
                ),
                if (isSmallDevice) const _FontScaleDefault(),
              ],
            )),
        const Divider(),
      ],
    );
  }
}

class _FontScaleDefault extends ConsumerWidget {
  const _FontScaleDefault();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ButtonSimpleWidget(
      textAction: 'Mặc định',
      onPressed: () async {
        var setting = ref.read(appSettingProvider);
        try {
          await LocalStorage.setAppSetting(setting.copyWith(fontScale: 1.0));
          ref.refresh(appSettingProvider);
        } catch (ex) {
          //
        }
      },
    );
  }
}
