import 'dart:math';

import 'package:aladdin_franchise/src/configs/app.dart';
import 'package:aladdin_franchise/src/configs/color.dart';
import 'package:aladdin_franchise/src/configs/text_style.dart';
import 'package:aladdin_franchise/src/data/model/o2o/o2o_config.dart';
import 'package:aladdin_franchise/src/features/widgets/button/app_buton.dart';
import 'package:aladdin_franchise/src/features/widgets/button/close_button.dart';
import 'package:aladdin_franchise/src/features/widgets/gap.dart';
import 'package:aladdin_franchise/src/features/widgets/textfield_simple.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<O2oConfigModel?> showO2oAutoProcessConfigDialog(
  BuildContext context,
  O2oConfigModel config,
) {
  return showDialog<O2oConfigModel?>(
    context: context,
    builder: (context) {
      return _O2oAutoProcessConfigDialog(
        enable: config.isEnabled,
        timeConfig: config.confirmTimeout,
      );
    },
  );
}

class _O2oAutoProcessConfigDialog extends ConsumerStatefulWidget {
  const _O2oAutoProcessConfigDialog({
    this.enable = false,
    this.timeConfig = 30,
  });
  final bool enable;
  final int timeConfig;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => __O2oAutoProcessConfigDialogState();
}

class __O2oAutoProcessConfigDialogState extends ConsumerState<_O2oAutoProcessConfigDialog> {
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
        color: AppColors.mainColor,
        borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
      ),
      child: Row(
        children: [
          const Icon(Icons.settings, color: Colors.white),
          const Gap(8),
          Expanded(
            child: Text(
              'Cấu hình tự động xác nhận đơn hàng',
              style: AppTextStyle.bold(
                color: Colors.white,
                rawFontSize: AppConfig.defaultRawTextSize + 0.5,
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
            maxLength: 3,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
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
          const AppCloseButton(),
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
