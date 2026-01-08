import 'package:aladdin_franchise/src/configs/app.dart';
import 'package:aladdin_franchise/src/configs/color.dart';
import 'package:aladdin_franchise/src/configs/text_style.dart';
import 'package:aladdin_franchise/src/data/enum/status.dart';
import 'package:aladdin_franchise/src/features/pages/home/components/menu/provider.dart';
import 'package:aladdin_franchise/src/features/widgets/gap.dart';
import 'package:aladdin_franchise/src/models/tag_product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'list_product.dart';

class ListTagsWidget extends ConsumerWidget {
  const ListTagsWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var productState = ref.watch(menuProvider.select((value) => value.productState));
    final tags = ref.watch(menuProvider.select((value) => value.tags));

    switch (productState.status) {
      case StatusEnum.loading:
        return ListView.separated(
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return AppShimmerLoading(
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 4),
                width: 70,
                height: 50,
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: AppConfig.borderRadiusSecond,
                ),
              ),
            );
          },
          separatorBuilder: (context, index) => const Gap(12),
          itemCount: 2,
        );
      case StatusEnum.normal:
      case StatusEnum.error:
        return Container();
      case StatusEnum.success:
    }

    return ListView.separated(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemBuilder: (BuildContext context, int index) {
        return _SubTagSelectWidget(tag: tags[index]);
      },
      separatorBuilder: (BuildContext context, int index) {
        return const SizedBox(width: 8);
      },
      itemCount: tags.length,
    );
  }
}

class _SubTagSelectWidget extends ConsumerWidget {
  final TagProductModel tag;
  const _SubTagSelectWidget({required this.tag});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool active = ref.watch(menuProvider.select((value) => value.tagSelect)) == tag;
    return InkWell(
      onTap: () {
        ref.read(menuProvider.notifier).changeTagSelect(active ? null : tag);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
        decoration: BoxDecoration(
          color: active ? AppColors.bgTagInProduct : Colors.grey[200],
          borderRadius: AppConfig.borderRadiusSecond,
        ),
        alignment: Alignment.center,
        child: Text(
          tag.getNameView(),
          style: AppTextStyle.regular(
            color: active ? AppColors.white : null,
            rawFontSize: AppConfig.defaultRawTextSize - 1.5,
          ),
        ),
      ),
    );
  }
}
