import 'package:aladdin_franchise/src/configs/text_style.dart';
import 'package:flutter/material.dart';

class TitleSettingsWidget extends StatelessWidget {
  const TitleSettingsWidget({super.key, required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Text(
        title,
        style: AppTextStyle.semiBold(),
      ),
    );
  }
}

class SubTitleSettingsWidget extends StatelessWidget {
  const SubTitleSettingsWidget({super.key, required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12),
      child: Text(
        title,
        style: AppTextStyle.medium(),
      ),
    );
  }
}
