import 'package:aladdin_franchise/src/configs/app.dart';
import 'package:aladdin_franchise/src/configs/color.dart';
import 'package:aladdin_franchise/src/configs/text_style.dart';
import 'package:aladdin_franchise/src/features/pages/home/components/menu/list_product.dart';
import 'package:aladdin_franchise/src/features/pages/home/provider.dart';
import 'package:aladdin_franchise/src/features/pages/home/state.dart';
import 'package:aladdin_franchise/src/features/widgets/gap.dart';
import 'package:aladdin_franchise/src/models/tag_product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ListTagsWidget extends ConsumerWidget {
  const ListTagsWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var pageState = ref.watch(homeProvider.select((value) => value.productsState));
    final tags = ref.watch(homeProvider.select((value) => value.tags));

    switch (pageState.status) {
      case PageCommonState.loading:
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
      case PageCommonState.normal:
      case PageCommonState.error:
        return Container();
      case PageCommonState.success:
    }

    return ListView.separated(
      padding: const EdgeInsets.symmetric(vertical: 4),
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemBuilder: (BuildContext context, int index) {
        return _SubTagSelectWidget(tag: tags[index]);
      },
      separatorBuilder: (BuildContext context, int index) {
        return const SizedBox(width: 12);
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
    bool active = ref.watch(homeProvider.select((value) => value.tagSelect)) == tag;
    return InkWell(
      onTap: () {
        ref.read(homeProvider.notifier).changeTagSelect(active ? null : tag);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
        decoration: BoxDecoration(
          color: active ? AppColors.bgLineMenu : Colors.grey[200],
          borderRadius: AppConfig.borderRadiusSecond,
        ),
        alignment: Alignment.center,
        child: Text(
          tag.name,
          style: AppTextStyle.regular(
            color: active ? AppColors.white : AppColors.tcMenuSelect,
            rawFontSize: 12,
          ),
        ),
      ),
    );
  }
}
