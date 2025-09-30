import 'package:aladdin_franchise/generated/l10n.dart';
import 'package:aladdin_franchise/src/configs/color.dart';
import 'package:aladdin_franchise/src/configs/text_style.dart';
import 'package:aladdin_franchise/src/features/widgets/app_error_simple.dart';
import 'package:flutter/material.dart';

/// Author: sondv
/// Created 15/11/24 at 08:11

class UpdateAppCheckErrorWidget extends StatelessWidget {
  const UpdateAppCheckErrorWidget({
    super.key,
    this.onTryAgain,
    this.infoError,
  });
  final VoidCallback? onTryAgain;
  final String? infoError;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.error,
          color: AppColors.redColor,
          size: 50,
        ),
        const SizedBox(height: 16),
        if (infoError != null)
          Text(
            infoError!,
            style: AppTextStyle.regular(
              color: Colors.red[700],
            ),
          ),
        const SizedBox(height: 16),
        AppErrorSimpleWidget(
          message: "${S.current.an_error_has_occurred}\n"
              "${S.current.sure_connected_network}",
          onTryAgain: () {
            onTryAgain?.call();
          },
        ),
      ],
    );
  }
}
