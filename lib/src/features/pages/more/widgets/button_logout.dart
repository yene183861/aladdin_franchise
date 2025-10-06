import 'package:aladdin_franchise/src/configs/text_style.dart';
import 'package:aladdin_franchise/src/core/storages/local.dart';
import 'package:aladdin_franchise/src/features/dialogs/confirm_action.dart';
import 'package:aladdin_franchise/src/features/pages/home/provider.dart';
import 'package:aladdin_franchise/src/features/pages/login/view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:aladdin_franchise/src/features/widgets/app_icon_widget.dart';

import '../../../../../generated/l10n.dart';

class ButtonLogoutWidget extends ConsumerWidget {
  const ButtonLogoutWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(
      onTap: () {
        showConfirmAction(
          context,
          title: S.current.logout,
          message: S.current.logoutConfirm,
          action: () async {
            Navigator.pop(context);
            await ref.read(homeProvider.notifier).logout();
          },
        );
      },
      leading: ResponsiveIconWidget(
        iconData: CupertinoIcons.square_arrow_right,
        color: Colors.red[700],
      ),
      title: Text(
        S.current.logout,
        style: AppTextStyle.regular(),
      ),
    );
  }
}
