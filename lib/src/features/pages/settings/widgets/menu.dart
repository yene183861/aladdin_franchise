import 'package:aladdin_franchise/src/configs/color.dart';
import 'package:aladdin_franchise/src/configs/text_style.dart';
import 'package:aladdin_franchise/src/features/pages/login/view.dart';
import 'package:aladdin_franchise/src/features/pages/settings/provider.dart';
import 'package:aladdin_franchise/src/features/pages/settings/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MenuSettingWidget extends ConsumerWidget {
  const MenuSettingWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final menuView =
        ref.watch(settingsPageProvider.select((value) => value.menuSelect));
    return NavigationRail(
      selectedIndex: menuView.index,
      useIndicator: true,
      indicatorColor: Colors.white,
      labelType: NavigationRailLabelType.all,
      backgroundColor: Colors.grey.shade50,
      selectedLabelTextStyle: AppTextStyle.bold(color: AppColors.secondColor),
      unselectedLabelTextStyle: AppTextStyle.regular(color: Colors.grey),
      selectedIconTheme: const IconThemeData(color: AppColors.secondColor),
      unselectedIconTheme: const IconThemeData(color: Colors.grey),
      onDestinationSelected: (index) {
        ref
            .read(settingsPageProvider.notifier)
            .changeMenuSelect(SettingPageMenuEnum.values[index]);
      },
      destinations: const [
        NavigationRailDestination(
          icon: ResponsiveIconWidget(
              iconData: Icons.notifications_active_outlined),
          label: Text('Âm thanh'),
        ),
        NavigationRailDestination(
          icon: ResponsiveIconWidget(iconData: Icons.view_agenda_outlined),
          label: Text('Hiển thị'),
        ),
        NavigationRailDestination(
          icon: ResponsiveIconWidget(iconData: Icons.print_outlined),
          label: Text('Bill'),
        ),
        NavigationRailDestination(
          icon: ResponsiveIconWidget(iconData: Icons.color_lens_outlined),
          label: Text('Màu sắc'),
        ),
      ],
    );
  }
}
