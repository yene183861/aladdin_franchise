import 'package:aladdin_franchise/generated/l10n.dart';
import 'package:aladdin_franchise/src/configs/app.dart';
import 'package:aladdin_franchise/src/configs/color.dart';
import 'package:aladdin_franchise/src/features/widgets/button/app_buton.dart';
import 'package:aladdin_franchise/src/utils/navigator.dart';
import 'package:flutter/material.dart';

class AppCloseButton extends StatelessWidget {
  const AppCloseButton({super.key, this.onPressed});
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return AppButton(
      textAction: S.current.close,
      textColor: AppColors.textColor,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: AppConfig.borderRadiusMain,
        side: const BorderSide(color: AppColors.mainColor),
      ),
      onPressed: onPressed ?? () => pop(context),
    );
  }
}
