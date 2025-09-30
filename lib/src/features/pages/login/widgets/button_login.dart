import 'package:aladdin_franchise/src/configs/app.dart';
import 'package:aladdin_franchise/src/configs/color.dart';
import 'package:aladdin_franchise/src/configs/text_style.dart';
import 'package:aladdin_franchise/src/core/storages/provider.dart';
import 'package:aladdin_franchise/src/features/pages/login/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../generated/l10n.dart';

class ButtonLoginWidget extends ConsumerWidget {
  const ButtonLoginWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FractionallySizedBox(
      widthFactor: 0.5,
      child: MaterialButton(
        height: 56,
        shape: RoundedRectangleBorder(borderRadius: AppConfig.borderRadiusMain),
        onPressed: () async {
          await ref.read(loginProvider.notifier).onLogin();
          ref.invalidate(userInfoProvider);
        },
        color: AppColors.mainColor,
        textColor: Colors.white,
        child: Text(
          S.current.login,
          style: AppTextStyle.regular(
              fontWeight: FontWeight.bold, color: AppColors.white),
        ),
      ),
    );
  }
}
