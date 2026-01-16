import 'package:aladdin_franchise/generated/l10n.dart';
import 'package:aladdin_franchise/src/configs/text_style.dart';
import 'package:aladdin_franchise/src/features/widgets/button/btn_with_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AppErrorSimpleWidget extends ConsumerWidget {
  final VoidCallback onTryAgain;
  final String? message;
  final String? textButton;
  const AppErrorSimpleWidget({
    Key? key,
    required this.onTryAgain,
    this.message,
    this.textButton,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          message ?? S.current.an_error_occurred,
          style: AppTextStyle.regular(),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        ButtonWithIconWidget(
          icon: Icons.settings_suggest,
          textAction: textButton ?? S.current.tryAgain,
          onPressed: () {
            onTryAgain.call();
          },
        ),
      ],
    );
  }
}
