import 'package:aladdin_franchise/generated/l10n.dart';
import 'package:aladdin_franchise/src/configs/app.dart';
import 'package:aladdin_franchise/src/configs/enums/enums.dart';
import 'package:aladdin_franchise/src/configs/text_style.dart';
import 'package:aladdin_franchise/src/features/widgets/gap.dart';
import 'package:flutter/material.dart';

/// Author: sondv
/// Created 07/05/2024 at 10:28
/// Chuyển đổi giữa firebase và aladdinWeb để lấy dữ liệu cấu hình nhà hàng và upgrade

class ChangeServerConfigWidget extends StatelessWidget {
  final ConfigServerRestaurantData value;
  final Function(ConfigServerRestaurantData) onChangeValue;
  const ChangeServerConfigWidget({
    super.key,
    required this.value,
    required this.onChangeValue,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          "${S.current.server}: ",
          style: AppTextStyle.medium(),
        ),
        const GapW(12),
        Flexible(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 200),
            child: DropdownButtonFormField<ConfigServerRestaurantData>(
              value: value,
              items: [ConfigServerRestaurantData.aladdinWeb]
                  .map(
                    (e) => DropdownMenuItem<ConfigServerRestaurantData>(
                      value: e,
                      child: Text(
                        e.getNameView(),
                        style: AppTextStyle.regular(),
                      ),
                    ),
                  )
                  .toList(),
              onChanged: (value) {
                onChangeValue(value!);
              },
            ),
          ),
        ),
      ],
    );
  }
}

class AppUpdateServerMessageWidget extends StatelessWidget {
  const AppUpdateServerMessageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 0.65,
      child: Card(
        elevation: 0,
        color: Colors.grey.shade100,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text.rich(
            TextSpan(
              text: "${S.current.attention.toUpperCase()}: ",
              style: AppTextStyle.bold(
                color: Colors.red,
              ),
              children: [
                TextSpan(
                  text: S.current.note_update_process_note_work,
                  style: AppTextStyle.regular(
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                TextSpan(
                  text: " pos.aladdin-jsc.com",
                  style: AppTextStyle.bold(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
