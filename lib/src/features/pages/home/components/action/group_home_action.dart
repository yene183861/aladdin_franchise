import 'package:aladdin_franchise/src/features/pages/home/components/menu/provider.dart';
import 'package:aladdin_franchise/src/features/widgets/gap.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'barrel_btn.dart';

class HomeAction extends ConsumerWidget {
  const HomeAction({
    super.key,
    this.showWhenTagsEmpty = false,
    this.showTypeOrderIconBtn = false,
  });
  final bool showWhenTagsEmpty;
  final bool showTypeOrderIconBtn;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var tags = ref.watch(menuProvider.select((value) => value.tags));
    if (tags.isNotEmpty == showWhenTagsEmpty) return const SizedBox.shrink();
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        if (showTypeOrderIconBtn) ...[
          const Gap(8),
          const TypeOrderIconBtn(),
        ],
        const Gap(8),
        const UpdateDataBtn(),
        const OrderToOnlineBtn(),
        const Gap(8),
        const NotificationBtn(),
      ],
    );
  }
}
