import 'package:aladdin_franchise/src/configs/app.dart';
import 'package:aladdin_franchise/src/configs/color.dart';
import 'package:aladdin_franchise/src/configs/text_style.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FetchListPrintersError extends ConsumerWidget {
  const FetchListPrintersError({
    super.key,
    required this.error,
    this.onRetry,
  });

  final String error;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Tooltip(
              message: 'Nhấn để thử lại',
              child: IconButton(
                onPressed: onRetry,
                icon: const Icon(
                  Icons.refresh,
                  color: AppColors.redColor,
                ),
              ),
            ),
            Text(
              'Không thể tải danh sách máy in',
              style: AppTextStyle.medium(
                rawFontSize: AppConfig.defaultRawTextSize,
                color: AppColors.redColor,
              ),
              textAlign: TextAlign.center,
            ),
            Text(
              error,
              style: AppTextStyle.regular(
                color: Colors.grey.shade500,
                rawFontSize: AppConfig.defaultRawTextSize - 1.0,
              ),
              maxLines: 10,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
