import 'package:aladdin_franchise/src/configs/color.dart';
import 'package:aladdin_franchise/src/configs/text_style.dart';
import 'package:aladdin_franchise/src/features/pages/settings/bill/view.dart';
import 'package:aladdin_franchise/src/features/pages/settings/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SettingsPage extends ConsumerStatefulWidget {
  const SettingsPage({super.key});

  @override
  ConsumerState createState() => _SettingsPageState();
}

class _SettingsPageState extends ConsumerState<SettingsPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(settingsPageProvider.notifier).initialize();
    });
  }

  var views = [
    Container(),
    // AudioNoticeWidget(),
    Container(),
    // BoxColSizeViewWidget(),
    BillSettingsWidget(),
    Container(),
    // ColorSettingPage(),
  ];
  @override
  Widget build(BuildContext context) {
    final menuView = ref.watch(settingsPageProvider.select((value) => value.menuSelect));
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Cài đặt',
          style: AppTextStyle.bold(
            color: AppColors.white,
            rawFontSize: 15,
          ),
        ),
      ),
      body: Row(
        children: [
          // const MenuSettingWidget(),
          // Expanded(child: views[menuView.index]),
          Expanded(child: views[2]),
        ],
      ),
    );
  }
}
