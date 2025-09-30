import 'dart:io';

import 'package:aladdin_franchise/src/configs/color.dart';
import 'package:aladdin_franchise/src/configs/text_style.dart';
import 'package:aladdin_franchise/src/features/pages/update_app/android/view.dart';
import 'package:aladdin_franchise/src/features/pages/update_app/windows/view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../generated/l10n.dart';

class ButtonUpdateAppWidget extends ConsumerWidget {
  const ButtonUpdateAppWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(
      onTap: () {
        // ref.refresh();
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Platform.isAndroid
                ? const UpdateAppAndroidPage()
                : const UpdateAppWindowsPage(),
          ),
        );
      },
      leading: Icon(
        Icons.get_app,
        color: AppColors.mainColor,
      ),
      title: Text(
        S.current.checkForUpdate,
        style: AppTextStyle.regular(),
      ),
    );
  }
}
