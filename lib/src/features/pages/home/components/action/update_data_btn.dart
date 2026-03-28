import 'package:aladdin_franchise/generated/l10n.dart';
import 'package:aladdin_franchise/src/configs/color.dart';
import 'package:aladdin_franchise/src/core/network/provider.dart';
import 'package:aladdin_franchise/src/features/pages/home/provider.dart';
import 'package:aladdin_franchise/src/features/widgets/button/icon_button.dart';
import 'package:aladdin_franchise/src/utils/show_snackbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UpdateDataBtn extends ConsumerWidget {
  const UpdateDataBtn({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppIconButton(
      icon: CupertinoIcons.cloud_download,
      onTap: () {
        ref.read(homeProvider.notifier).initialize();
        ref.invalidate(tablesAndOrdersProvider);
        showDoneSnackBar(context: context, message: 'Cập nhật dữ liệu thành công');
      },
      iconColor: AppColors.secondColor,
      backgroundColor: AppColors.secondColor.withOpacity(0.1),
      tooltip: S.current.updateData,
    );
  }
}
