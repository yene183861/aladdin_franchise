// import 'package:aladdin_franchise/generated/assets.dart';
import 'package:aladdin_franchise/src/configs/text_style.dart';
import 'package:aladdin_franchise/src/features/widgets/gap.dart';
import 'package:aladdin_franchise/src/features/widgets/refresh_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../generated/l10n.dart';

class EmptyWidget extends ConsumerWidget {
  final String? message;
  final VoidCallback? onRefresh;
  final bool viewTabOption;
  final Widget? emptyImage;
  const EmptyWidget({
    Key? key,
    this.onRefresh,
    this.message,
    this.viewTabOption = true,
    this.emptyImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return RefreshDataWidget(
      onRefresh: () {
        onRefresh?.call();
      },
      child: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                emptyImage ??
                    // Image.asset(
                    //   Assets.imagesProductEmpty,
                    //   width: 220,
                    // ),
                    const GapH(20),
                Text(
                  message ?? S.current.noProducts,
                  style: AppTextStyle.regular(),
                ),
              ],
            ),
          ),
          ListView(),
        ],
      ),
    );
  }
}
