import 'package:aladdin_franchise/src/configs/color.dart';
import 'package:aladdin_franchise/src/configs/text_style.dart';
import 'package:flutter/material.dart';

void showDoneSnackBar(
    {required BuildContext context, required String message, IconData? icon}) {
  const Duration snackBarDisplayDuration = Duration(milliseconds: 1000);
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        backgroundColor: AppColors.secondColor,
        duration: snackBarDisplayDuration,
        content: Row(
          children: [
            Icon(
              icon ?? Icons.check,
              color: Colors.white,
            ),
            const SizedBox(width: 8),
            Text(
              message,
              style: AppTextStyle.regular(color: AppColors.white),
            ),
          ],
        ),
      ),
    );
}
