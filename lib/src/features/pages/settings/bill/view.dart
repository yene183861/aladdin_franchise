import 'package:aladdin_franchise/src/configs/enums/bill_setting.dart';
import 'package:aladdin_franchise/src/configs/text_style.dart';
import 'package:aladdin_franchise/src/features/pages/settings/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'normal.dart';
import 'with_html.dart';

class BillSettingsWidget extends ConsumerStatefulWidget {
  const BillSettingsWidget({super.key});
  @override
  ConsumerState createState() => _BillSettingsWidgetState();
}

class _BillSettingsWidgetState extends ConsumerState<BillSettingsWidget> {
  @override
  Widget build(BuildContext context) {
    final typePrinter =
        ref.watch(settingsPageProvider.select((value) => value.printSetting.appPrinterType));
    return Container(
      color: Colors.grey.shade100,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Consumer(builder: (context, ref, child) {
            var autoAcceptO2o =
                ref.watch(settingsPageProvider.select((value) => value.printSetting.autoAcceptO2o));
            return SwitchListTile(
              title: Text(
                "Tự động duyệt yêu cầu gọi món tại bàn",
                style: AppTextStyle.bold(),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              controlAffinity: ListTileControlAffinity.leading,
              value: autoAcceptO2o,
              onChanged: (value) {
                ref
                    .read(settingsPageProvider.notifier)
                    .onChangeSetting(autoAcceptO2o: !autoAcceptO2o);
              },
            );
          }),
          SwitchListTile(
            title: Text(
              "Gọi món/ Hủy món - Bill Tiếng Việt có dấu",
              style: AppTextStyle.bold(),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            controlAffinity: ListTileControlAffinity.leading,
            value: typePrinter == AppPrinterSettingTypeEnum.withHtml,
            onChanged: (value) {
              final typePrinterNew =
                  value ? AppPrinterSettingTypeEnum.withHtml : AppPrinterSettingTypeEnum.normal;
              ref
                  .read(settingsPageProvider.notifier)
                  .onChangeSetting(appPrinterType: typePrinterNew);
            },
          ),
          Flexible(
            child: typePrinter == AppPrinterSettingTypeEnum.normal
                ? const BillSettingForNormalWidget()
                : const BillSettingForHtmlWidget(),
          ),
        ],
      ),
    );
  }
}
