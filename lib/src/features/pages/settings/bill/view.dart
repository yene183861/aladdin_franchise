import 'dart:math';

import 'package:aladdin_franchise/src/configs/app.dart';
import 'package:aladdin_franchise/src/configs/color.dart';
import 'package:aladdin_franchise/src/configs/enums/bill_setting.dart';
import 'package:aladdin_franchise/src/configs/text_style.dart';
import 'package:aladdin_franchise/src/core/network/provider.dart';
import 'package:aladdin_franchise/src/core/storages/local.dart';
import 'package:aladdin_franchise/src/data/model/o2o/o2o_config.dart';
import 'package:aladdin_franchise/src/features/dialogs/confirm_action.dart';
import 'package:aladdin_franchise/src/features/dialogs/message.dart';
import 'package:aladdin_franchise/src/features/pages/home/provider.dart';
import 'package:aladdin_franchise/src/features/pages/settings/provider.dart';
import 'package:aladdin_franchise/src/features/widgets/button/app_buton.dart';
import 'package:aladdin_franchise/src/features/widgets/gap.dart';
import 'package:aladdin_franchise/src/features/widgets/textfield_simple.dart';
import 'package:aladdin_franchise/src/utils/app_log.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../widgets/dialog/o2o_auto_process_config.dart';
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
    var o2oConfig = ref.watch(o2oConfigProvider).when(
          data: (data) => data,
          error: (error, stackTrace) => O2oConfigModel(),
          loading: () => O2oConfigModel(),
        );
    return Container(
      color: Colors.grey.shade100,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Consumer(builder: (context, ref, child) {
          //   var o2oConfig = ref.watch(o2oConfigProvider).when(
          //         data: (data) => data,
          //         error: (error, stackTrace) => O2oConfigModel(),
          //         loading: () => O2oConfigModel(),
          //       );
          //   return Row(
          //     children: [
          //       Padding(
          //         padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          //         child: AppButton(
          //           textAction: 'Cấu hình xác nhận yêu cầu gọi món tại bàn',
          //           onPressed: () async {
          //             var config = await showO2oAutoProcessConfigDialog(
          //               context,
          //               o2oConfig,
          //             );
          //             showLogs(config, flags: 'config');
          //             if (config != null) {
          //               var result =
          //                   await ref.read(homeProvider.notifier).saveO2oAutoProcessConfig(config);
          //               if (result != null) {
          //                 showMessageDialog(context, message: result);
          //               }
          //             }
          //           },
          //         ),
          //       ),
          //     ],
          //   );
          // }),

          SwitchListTile(
            title: Text(
              "Cấu hình là thiết bị in",
              style: AppTextStyle.bold(),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            controlAffinity: ListTileControlAffinity.leading,
            value: o2oConfig.printerDeviceId == kDeviceId,
            onChanged: (value) async {
              var result = await ref.read(homeProvider.notifier).savePrintDevice(value);
              if (result != null) {
                showMessageDialog(context, message: result);
              }
            },
          ),
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

class AutoConfirmConfigDialog extends StatefulWidget {
  const AutoConfirmConfigDialog({
    super.key,
    this.enable = false,
    this.timeConfig = 30,
  });
  final bool enable;
  final int timeConfig;

  @override
  State<AutoConfirmConfigDialog> createState() => _AutoConfirmConfigDialogState();
}

class _AutoConfirmConfigDialogState extends State<AutoConfirmConfigDialog> {
  late TextEditingController _timeController;
  bool enable = true;

  @override
  void initState() {
    super.initState();
    enable = widget.enable;
    _timeController = TextEditingController(
      text: max(0, widget.timeConfig).toString(),
    );
  }

  @override
  void dispose() {
    _timeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: SizedBox(
        width: 480,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildHeader(),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildInfoBox(),
                  const SizedBox(height: 20),
                  _buildSwitch(),
                  const SizedBox(height: 16),
                  _buildTimeInput(),
                  const SizedBox(height: 6),
                ],
              ),
            ),
            _buildActions(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: const BoxDecoration(
        color: Color(0xFF6C7CF5),
        borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
      ),
      child: Row(
        children: [
          const Icon(Icons.settings, color: Colors.white),
          const SizedBox(width: 8),
          const Expanded(
            child: Text(
              'Cấu hình tự động xác nhận đơn hàng',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.close, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          )
        ],
      ),
    );
  }

  Widget _buildInfoBox() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF4FC3F7),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.info_outline, color: Colors.white),
          SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Thông tin tính năng',
                  style: AppTextStyle.bold(color: Colors.white),
                ),
                SizedBox(height: 4),
                Text(
                  'Tính năng này sẽ tự động xác nhận hoặc từ chối đơn hàng '
                  'khi khách hàng đặt lần thứ 2 trở đi, dựa trên trạng thái '
                  'của lần đặt trước đó.',
                  style: AppTextStyle.regular(
                    color: Colors.white,
                    rawFontSize: AppConfig.defaultRawTextSize - 1.0,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSwitch() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Bật tính năng tự động xác nhận',
          style: AppTextStyle.bold(),
        ),
        Switch(
          value: enable,
          onChanged: (v) {
            setState(() => enable = v);
          },
        )
      ],
    );
  }

  Widget _buildTimeInput() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Thời gian đếm ngược (giây)',
                style: AppTextStyle.regular(),
              ),
              Text(
                'Đặt thời gian từ 10 đến 300 giây',
                style: AppTextStyle.regular(
                  color: Colors.grey,
                  rawFontSize: AppConfig.defaultRawTextSize - 2.0,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          width: 80,
          child: AppTextFormField(
            contentPadding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
            textController: _timeController,
            textInputType: TextInputType.number,
            textAlign: TextAlign.center,
          ),
        )
      ],
    );
  }

  Widget _buildActions() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          AppButton(
            textAction: 'Đóng',
            color: Colors.grey.shade300,
            textColor: AppColors.textColor,
            onPressed: () {
              Navigator.pop(context, null);
            },
          ),
          const Gap(12),
          AppButton(
            textAction: 'Lưu cấu hình',
            onPressed: () {
              Navigator.pop(
                context,
                O2oConfigModel(
                    isEnabled: enable,
                    confirmTimeout: int.tryParse(_timeController.text.trim()) ?? 30),
              );
            },
          ),
        ],
      ),
    );
  }
}
