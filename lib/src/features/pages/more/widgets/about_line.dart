import 'package:aladdin_franchise/src/configs/app.dart';
import 'package:aladdin_franchise/src/configs/color.dart';
import 'package:aladdin_franchise/src/configs/text_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../generated/l10n.dart';

class AboutLineWidget extends ConsumerWidget {
  const AboutLineWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(
      leading: const Icon(CupertinoIcons.info, color: AppColors.black),
      title: Text(S.current.version),
      subtitle: const Text("${AppConfig.appName} ${AppConfig.appVersion}"),
    );
  }
}
