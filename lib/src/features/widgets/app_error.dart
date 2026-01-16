// import 'package:aladdin_franchise/generated/assets.dart';
import 'package:aladdin_franchise/generated/assets.dart';
import 'package:aladdin_franchise/src/configs/app.dart';
import 'package:aladdin_franchise/src/configs/text_style.dart';
import 'package:aladdin_franchise/src/features/dialogs/confirm_action.dart';
// import 'package:aladdin_franchise/src/features/dialogs/confirm_action.dart';
import 'package:aladdin_franchise/src/features/pages/home/provider.dart';
import 'package:aladdin_franchise/src/features/widgets/button/btn_with_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../generated/l10n.dart';

/// Khi tải dữ liệu bị lỗi sẽ sử dụng widget này
///
/// [enableLogout]: Bật/tắt nút đăng xuất
///
///
class AppErrorWidget extends ConsumerWidget {
  final VoidCallback onTryAgain;
  final bool enableLogout;
  final bool enableProfile;
  final String? errorMessage;
  const AppErrorWidget({
    Key? key,
    required this.onTryAgain,
    this.enableLogout = false,
    this.errorMessage,
    this.enableProfile = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Stack(
        children: [
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  Assets.imagesError,
                  width: 220,
                ),
                Text(errorMessage ?? S.current.an_error_occurred),
                const SizedBox(height: 16),
                ButtonWithIconWidget(
                  icon: Icons.settings_suggest,
                  textAction: S.current.tryAgain,
                  onPressed: () {
                    onTryAgain.call();
                  },
                ),
              ],
            ),
          ),
          if (enableLogout)
            Align(
              alignment: Alignment.topRight,
              child: ButtonWithIconWidget(
                icon: Icons.logout,
                textAction: S.current.logout,
                onPressed: () {
                  showConfirmAction(context,
                      title: S.current.logout, message: S.current.logoutConfirm, action: () {
                    ref.read(homeProvider.notifier).logout();
                  });
                },
              ),
            ),
          if (enableProfile)
            Align(
              alignment: Alignment.topLeft,
              child: ButtonWithIconWidget(
                icon: Icons.person,
                textAction: S.current.personal,
                onPressed: () {
                  // showModalBottomSheet(
                  //   context: context,
                  //   isScrollControlled: true,
                  //   builder: (context) {
                  //     return const FractionallySizedBox(
                  //       heightFactor: 0.9,
                  //       child: MorePage(),
                  //     );
                  //   },
                  // );
                },
              ),
            )
        ],
      ),
    );
  }
}

class ErrorLineWidget extends ConsumerWidget {
  final String? message;
  final String? textAction;
  final VoidCallback? onRefresh;
  const ErrorLineWidget({
    Key? key,
    this.message,
    this.textAction,
    this.onRefresh,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Wrap(
      alignment: WrapAlignment.center,
      children: [
        Text(
          message ?? NetworkMessageConfig.unexpected,
          style: AppTextStyle.regular(),
        ),
        const SizedBox(width: 8),
        FilledButton(
          onPressed: () {
            onRefresh?.call();
          },
          child: Text(
            textAction ?? S.current.tryAgain,
            style: AppTextStyle.regular(),
          ),
        ),
      ],
    );
  }
}
