import 'package:aladdin_franchise/src/configs/color.dart';
import 'package:aladdin_franchise/src/configs/text_style.dart';
import 'package:aladdin_franchise/src/features/pages/home/components/menu/list_product.dart';
import 'package:aladdin_franchise/src/features/pages/home/provider.dart';
import 'package:aladdin_franchise/src/features/pages/home/state.dart';
import 'package:aladdin_franchise/src/features/widgets/gap.dart';
import 'package:aladdin_franchise/src/models/category.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class ListCategoryWidget extends ConsumerStatefulWidget {
  const ListCategoryWidget({
    super.key,
    required this.categoryScrollController,
    required this.onTap,
  });

  final ScrollController categoryScrollController;
  final Function(dynamic item) onTap;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ListCategoryWidgetState();
}

class _ListCategoryWidgetState extends ConsumerState<ListCategoryWidget> {
  @override
  Widget build(BuildContext context) {
    var productsState = ref.watch(homeProvider.select((value) => value.productsState));
    var categories = ref.watch(homeProvider.select((value) => value.categories));
    var categorySelect = ref.watch(homeProvider.select((value) => value.categorySelect));
    var subCategorySelect = ref.watch(homeProvider.select((value) => value.subCategorySelect));

    switch (productsState.status) {
      case PageCommonState.loading:
        return ListView.separated(
          padding: const EdgeInsets.only(left: 8),
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return ShimmerLoading(
              child: Container(
                width: 100,
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            );
          },
          separatorBuilder: (context, index) => const Gap(8),
          itemCount: 8,
        );
      case PageCommonState.error:
      case PageCommonState.normal:
        return const SizedBox.shrink();

      case PageCommonState.success:
    }
    if (categories.isEmpty) {
      return const SizedBox.shrink();
    }
    List<dynamic> dataView = [];
    for (var item in categories) {
      bool selected = item == categorySelect;
      dataView.add(item);
      if (selected && (item.children ?? []).isNotEmpty) {
        // tượng trưng cho dấu mũi tên
        dataView.add(null);
        dataView.addAll(item.children ?? []);
      }
    }
    var itemScrollController = ref.read(homeProvider.notifier).categoryScrollController;
    var itemPositionsListener = ref.read(homeProvider.notifier).categoryPositionsListener;

    return ScrollablePositionedList.separated(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        scrollDirection: Axis.horizontal,
        itemScrollController: itemScrollController,
        itemPositionsListener: itemPositionsListener,
        itemCount: dataView.length,
        separatorBuilder: (context, index) => const Gap(8),
        itemBuilder: (context, index) {
          var item = dataView[index];

          bool isCategorySelected = categorySelect?.id == item?.id;
          bool isSubCategorySelected = subCategorySelect?.id == item?.id;
          if (item == null) {
            return const Icon(Icons.arrow_forward_ios_rounded, size: 18);
          }
          bool isSub = item is SubCategoryModel;
          bool selected = isSub ? isSubCategorySelected : isCategorySelected;
          return InkWell(
            borderRadius: BorderRadius.circular(16),
            onTap: () {
              widget.onTap.call(item);
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.px),
              decoration: BoxDecoration(
                color: selected ? AppColors.mainColor : AppColors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.mainColor, width: 0.8),
              ),
              alignment: Alignment.center,
              child: Text(
                item.title,
                style: AppTextStyle.bold(color: selected ? AppColors.white : AppColors.mainColor),
                textAlign: TextAlign.center,
              ),
            ),
          );
        });
  }
}
