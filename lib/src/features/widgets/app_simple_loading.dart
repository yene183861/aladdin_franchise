import 'package:aladdin_franchise/generated/l10n.dart';
import 'package:aladdin_franchise/src/configs/text_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// Author: sondv
/// Created 23/02/2023 at 10:05
class AppSimpleLoadingWidget extends StatelessWidget {
  final String? message;
  const AppSimpleLoadingWidget({
    Key? key,
    this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const CircularProgressIndicator(),
        const SizedBox(height: 12),
        Text(
          message ?? S.current.loading_data,
          style: AppTextStyle.regular(),
        ),
      ],
    );
  }
}
