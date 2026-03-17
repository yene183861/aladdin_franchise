import 'package:aladdin_franchise/src/configs/color.dart';
import 'package:aladdin_franchise/src/configs/text_style.dart';
import 'package:aladdin_franchise/src/core/storages/provider.dart';
import 'package:aladdin_franchise/src/features/widgets/gap.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NetworkInfoSection extends ConsumerWidget {
  const NetworkInfoSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final device = ref.watch(deviceProvider);
    return device.when(
      skipLoadingOnRefresh: false,
      data: (data) {
        return Material(
          textStyle: AppTextStyle.regular(
            color: Colors.black38,
          ),
          color: Colors.transparent,
          child: Row(
            children: [
              if (data[0] != null) ...[
                const Icon(
                  CupertinoIcons.device_phone_portrait,
                  color: Colors.grey,
                ),
                const Gap(8),
                Text(data[0].toString()),
                const Gap(12),
              ],
              const Icon(
                CupertinoIcons.antenna_radiowaves_left_right,
                color: Colors.grey,
              ),
              const Gap(8),
              Text((data[1] ?? '').toString()),
              const Gap(12),
              const Icon(
                CupertinoIcons.wifi,
                color: Colors.grey,
              ),
              const Gap(8),
              Text((data[2] ?? '').toString()),
            ],
          ),
        );
      },
      error: (_, __) {
        return const Icon(
          CupertinoIcons.info,
          color: AppColors.redColor,
        );
      },
      loading: () => const CupertinoActivityIndicator(),
    );
  }
}
