import 'package:aladdin_franchise/src/configs/color.dart';
import 'package:aladdin_franchise/src/configs/dev_config.dart';
import 'package:aladdin_franchise/src/configs/text_style.dart';
import 'package:aladdin_franchise/src/core/storages/provider.dart';
import 'package:aladdin_franchise/src/data/enum/status.dart';
import 'package:aladdin_franchise/src/features/pages/home/components/menu/widgets/list_product.dart';
import 'package:aladdin_franchise/src/features/pages/home/components/menu/provider.dart';
import 'package:aladdin_franchise/src/features/widgets/gap.dart';
import 'package:aladdin_franchise/src/models/category.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class ListCategoryWidget extends ConsumerWidget {
  const ListCategoryWidget({
    super.key,
    this.onTap,
    this.itemScrollController,
    this.itemPositionsListener,
  });
  final Function(CategoryModel item)? onTap;
  final ItemScrollController? itemScrollController;
  final ItemPositionsListener? itemPositionsListener;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(languageLocalProvider);
    var productState = ref.watch(menuProvider.select((value) => value.productState));
    var categorySelect = ref.watch(menuProvider.select((value) => value.categorySelect));
    var subCategorySelect = ref.watch(menuProvider.select((value) => value.subCategorySelect));
    var menuDataView = ref.watch(menuProvider.select((value) => value.menuDataView));
    var notifier = ref.read(menuProvider.notifier);
    switch (productState.status) {
      case StatusEnum.loading:
        return ListView.separated(
          padding: const EdgeInsets.only(left: 8),
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return const AppShimmerLoading(
              child: _CategoryCard(loading: true),
            );
          },
          separatorBuilder: (context, index) => const Gap(8),
          itemCount: 10,
        );
      case StatusEnum.error:
      case StatusEnum.normal:
        return const SizedBox.shrink();

      case StatusEnum.success:
    }

    var itemScrollController = notifier.categoryScrollController;
    var itemPositionsListener = notifier.categoryPositionsListener;
    List<CategoryModel?> categoryDataView = [];
    menuDataView.forEach(
      (key, value) {
        categoryDataView.add(value.item);
      },
    );
    if (categoryDataView.isEmpty) {
      return const SizedBox.shrink();
    }
    return ScrollablePositionedList.separated(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      scrollDirection: Axis.horizontal,
      itemScrollController: itemScrollController,
      itemPositionsListener: itemPositionsListener,
      itemCount: categoryDataView.length,
      separatorBuilder: (context, index) => const Gap(8),
      itemBuilder: (context, index) {
        var item = categoryDataView[index];
        bool selected =
            item != null && (categorySelect?.id == item.id || subCategorySelect?.id == item.id);
        if (item == null) {
          return const Icon(Icons.arrow_forward_ios_rounded, size: 18);
        }
        return _CategoryCard(
          item: item,
          selected: selected,
          onTap: () {
            onTap?.call(item);
          },
        );
      },
    );
  }
}

class _CategoryCard extends StatelessWidget {
  const _CategoryCard({
    this.selected = false,
    this.item,
    this.onTap,
    this.loading = false,
  });

  final bool selected;
  final CategoryModel? item;
  final VoidCallback? onTap;
  final bool loading;

  @override
  Widget build(BuildContext context) {
    var title = item?.getNameView() ?? (loading ? 'Category' : '');
    if (DevConfig.newUI) {
      return InkWell(
        borderRadius: BorderRadius.circular(50),
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeInOut,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: selected ? Color(0xFFD32F2F) : Colors.grey.shade100,
            borderRadius: BorderRadius.circular(50),
            border: Border.all(
              color: selected ? Color(0xFFD32F2F) : Colors.grey.shade300,
            ),
            gradient: selected
                ? const LinearGradient(
                    colors: [Color(0xFFE53935), Color(0xFFD32F2F)],
                  )
                : null,
            boxShadow: selected
                ? [
                    BoxShadow(
                      color: Color(0xFFD32F2F).withOpacity(0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 3),
                    )
                  ]
                : [],
          ),
          child: Text(title,
              style: selected ? AppTextStyle.bold(color: AppColors.white) : AppTextStyle.medium()),
        ),
      );
    }
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: loading ? 8 : 16),
        decoration: BoxDecoration(
          color: selected ? AppColors.mainColor : AppColors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.mainColor, width: 0.8),
        ),
        alignment: Alignment.center,
        child: Text(
          title,
          style: AppTextStyle.bold(
            color: selected ? AppColors.white : AppColors.mainColor,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
