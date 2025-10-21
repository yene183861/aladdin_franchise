import 'package:aladdin_franchise/generated/l10n.dart';
import 'package:aladdin_franchise/src/configs/app.dart';
import 'package:aladdin_franchise/src/configs/text_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

/// Author: sondv
/// Created 15/11/24 at 08:09

class UpdateAppVersionIsLatesetWidget extends StatelessWidget {
  const UpdateAppVersionIsLatesetWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(
          CupertinoIcons.checkmark_shield,
          size: 50,
          color: Colors.green,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            AppConfig.appVersion,
            style: AppTextStyle.bold(rawFontSize: 15),
          ),
        ),
        Text(S.current.using_lastest_version),
      ],
    );
  }
}
