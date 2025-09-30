import 'package:aladdin_franchise/src/configs/text_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../../../generated/l10n.dart';
import '../../../../configs/app.dart';

class ButtonHelpWidget extends StatelessWidget {
  const ButtonHelpWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () async {
        if (kCheckAndroidPlatform) {
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //     builder: (context) => const HelpPage(),
          //   ),
          // );
        } else {
          await launchUrlString(appConfig.urlHelp);
        }
      },
      leading: const Icon(
        CupertinoIcons.question_circle,
        color: Colors.grey,
      ),
      title: Text(
        S.current.help,
        style: AppTextStyle.regular(),
      ),
    );
  }
}
