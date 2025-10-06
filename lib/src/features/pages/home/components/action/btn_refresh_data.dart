import 'package:aladdin_franchise/generated/l10n.dart';
import 'package:aladdin_franchise/src/configs/color.dart';
import 'package:aladdin_franchise/src/core/network/provider.dart';
import 'package:aladdin_franchise/src/features/pages/home/provider.dart';
import 'package:aladdin_franchise/src/features/pages/login/view.dart';
import 'package:aladdin_franchise/src/utils/show_snackbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:aladdin_franchise/src/features/widgets/app_icon_widget.dart';

class ButtonRefreshData extends ConsumerWidget {
  const ButtonRefreshData({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Tooltip(
      message: S.current.updateData,
      child: InkWell(
        onTap: () {
          ref.read(homeProvider.notifier).initialize();
          ref.invalidate(tablesAndOrdersProvider);
          showDoneSnackBar(context: context, message: S.current.success);
        },
        borderRadius: BorderRadius.circular(50),
        child: const Padding(
          padding: EdgeInsets.all(4.0),
          child: ResponsiveIconWidget(
            iconData: CupertinoIcons.cloud_download,
            color: AppColors.secondColor,
          ),
        ),
      ),
    );
  }
}
