import 'dart:io';

import 'package:aladdin_franchise/src/configs/api.dart';
import 'package:aladdin_franchise/src/features/pages/update_app/android/view.dart';
import 'package:aladdin_franchise/src/features/pages/update_app/windows/view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:aladdin_franchise/src/configs/app.dart';
import 'package:aladdin_franchise/src/configs/text_style.dart';
import 'package:aladdin_franchise/src/core/storages/provider.dart';

class LoginAppInfoBottomWidget extends ConsumerWidget {
  const LoginAppInfoBottomWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var apiUrl = ref.watch(apiUrlProvider);
    Color infoTextColor = Colors.black26;
    Color dividerColor = Colors.black;
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Flexible(
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Platform.isAndroid
                        ? const UpdateAppAndroidPage()
                        : const UpdateAppWindowsPage(),
                  ),
                );
              },
              child: Text(
                '${AppConfig.appName} ${AppConfig.appVersion.toLowerCase()}',
                style: AppTextStyle.regular(color: infoTextColor),
              ),
            ),
          ),
          Expanded(
            child: Text.rich(
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              TextSpan(
                children: [
                  const TextSpan(text: "  |  "),
                  TextSpan(
                    text: apiUrl,
                    style: AppTextStyle.regular(color: infoTextColor),
                  ),
                ],
                style: AppTextStyle.regular(color: dividerColor),
              ),
            ),
          ),

          // TextButton(
          //   onPressed: () async {
          //     if (kCheckAndroidPlatform) {
          //       // Navigator.push(
          //       //   context,
          //       //   MaterialPageRoute(
          //       //     builder: (context) => const HelpPage(),
          //       //   ),
          //       // );
          //     } else {
          //       await launchUrlString(appConfig.urlHelp);
          //     }
          //   },
          //   child: Row(
          //     children: [
          //       const Icon(CupertinoIcons.question_circle),
          //       const SizedBox(width: 6),
          //       Text(
          //         S.current.help,
          //         style: AppTextStyle.regular(),
          //       ),
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }
}
