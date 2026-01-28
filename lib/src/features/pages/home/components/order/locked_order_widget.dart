import 'package:aladdin_franchise/generated/l10n.dart';
import 'package:aladdin_franchise/src/configs/color.dart';
import 'package:aladdin_franchise/src/features/pages/home/provider.dart';
import 'package:aladdin_franchise/src/features/widgets/button/button_simple.dart';
import 'package:aladdin_franchise/src/features/widgets/gap.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LockedOrderWidget extends ConsumerWidget {
  const LockedOrderWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final lockedOrder =
        ref.watch(homeProvider.select((value) => value.lockedOrder));
    if (!lockedOrder) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
      child: Row(
        children: [
          Expanded(
            child: Text(S.current.msg_locked_order),
          ),
          const Gap(8),
          InkWell(
            child: ButtonSimpleWidget(
              color: AppColors.secondColor,
              textAction: S.current.unlock,
              onPressed: () {
                ref.read(homeProvider.notifier).lockOrder(
                      messageError: S.current.msg_id_device_to_unlock_order,
                      lock: false,
                    );
              },
            ),
          ),
        ],
      ),
    );
  }
}
