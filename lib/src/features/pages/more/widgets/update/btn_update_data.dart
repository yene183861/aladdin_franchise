import 'package:aladdin_franchise/src/configs/color.dart';
import 'package:aladdin_franchise/src/configs/text_style.dart';
import 'package:aladdin_franchise/src/core/network/provider.dart';
import 'package:aladdin_franchise/src/features/pages/home/provider.dart';
import 'package:aladdin_franchise/src/features/widgets/app_icon_widget.dart';
import 'package:aladdin_franchise/src/utils/navigator.dart';
import 'package:aladdin_franchise/src/utils/show_snackbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../generated/l10n.dart';

class ButtonUpdateData extends ConsumerWidget {
  const ButtonUpdateData({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(
      onTap: () async {
        pop(context);
        ref.read(homeProvider.notifier).initialize();
        ref.invalidate(tablesAndOrdersProvider);
        showDoneSnackBar(context: context, message: S.current.success);
      },
      leading: const ResponsiveIconWidget(
        iconData: CupertinoIcons.cloud_download,
        color: AppColors.secondColor,
      ),
      title: Text(S.current.updateData),
      subtitle: Text(S.current.updateDataInfo),
    );
  }
}
