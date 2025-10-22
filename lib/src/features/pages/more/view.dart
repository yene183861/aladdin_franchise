import 'package:aladdin_franchise/src/configs/app.dart';
import 'package:aladdin_franchise/src/configs/color.dart';
import 'package:aladdin_franchise/src/configs/text_style.dart';
import 'package:aladdin_franchise/src/features/pages/more/widgets/about_device.dart';
import 'package:aladdin_franchise/src/features/pages/more/widgets/about_line.dart';
import 'package:aladdin_franchise/src/features/pages/more/widgets/button_check_printer.dart';
import 'package:aladdin_franchise/src/features/pages/more/widgets/button_logout.dart';
import 'package:aladdin_franchise/src/features/pages/more/widgets/button_type_order.dart';
import 'package:aladdin_franchise/src/features/pages/more/widgets/update/btn_update_app.dart';
import 'package:aladdin_franchise/src/features/pages/more/widgets/update/btn_update_data.dart';
import 'package:aladdin_franchise/src/features/pages/more/widgets/profile_line.dart';
import 'package:aladdin_franchise/src/features/widgets/title_line.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../generated/l10n.dart';
import '../../../core/storages/local.dart';
import 'widgets/font/btn_setting_font_scale.dart';
import 'widgets/font/btn_use_font_scale.dart';

class MorePage extends ConsumerWidget {
  const MorePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppConfig.appName,
          style: AppTextStyle.bold(color: AppColors.white),
        ),
        elevation: 0,
      ),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ListView(
              children: [
                TitleLineWidget(title: S.current.personal),
                const ProfileLineWidget(),
                const Divider(),
                const ButtonTypeOrderWidget(),
                const ButtonUpdateData(),
                const ButtonCheckPrinterWidget(),
                const ButtonUseFontScale(),
                const Divider(),
                const ButtonSettingFontScale(),
                const ButtonLogoutWidget(),
              ],
            ),
          ),
          VerticalDivider(
            color: Colors.grey.shade300,
            width: 0,
          ),
          Expanded(
            child: ListView(
              children: [
                TitleLineWidget(title: S.current.software),
                const AboutLineWidget(),
                if (kCheckAndroidPlatform) const AboutDeviceWidget(),
                if (kCheckAndroidPlatform) const Divider(),
                // const ButtonViewOrderOfflineWidget(),
                // const Divider(),
                // const ButtonHelpWidget(),
                // const Divider(),
                // const ButtonTicketWidget(),
                // const Divider(),
                // const ButtonHistoryTicketWidget(),
                // const Divider(),
                const ButtonUpdateApp(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
