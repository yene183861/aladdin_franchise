import 'package:aladdin_franchise/src/configs/app.dart';
import 'package:aladdin_franchise/src/configs/color.dart';
import 'package:aladdin_franchise/src/configs/text_style.dart';
import 'package:aladdin_franchise/src/features/pages/login/view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:aladdin_franchise/src/features/widgets/app_icon_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../generated/l10n.dart';

class AboutLineWidget extends ConsumerWidget {
  const AboutLineWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(
      visualDensity: const VisualDensity(vertical: -4, horizontal: -4),
      leading: const ResponsiveIconWidget(
          iconData: CupertinoIcons.info, color: AppColors.black),
      title: Text(
        S.current.version,
        style: AppTextStyle.regular(),
      ),
      subtitle: Text(
        "${AppConfig.appName} ${AppConfig.appVersion}",
        style: AppTextStyle.regular(),
      ),
    );
  }
}
