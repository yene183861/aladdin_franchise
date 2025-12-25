import 'package:aladdin_franchise/src/configs/app.dart';
import 'package:aladdin_franchise/src/configs/color.dart';
import 'package:aladdin_franchise/src/configs/text_style.dart';
import 'package:aladdin_franchise/src/features/pages/home/components/menu/components/list_product.dart';
import 'package:aladdin_franchise/src/features/pages/home/components/menu/provider.dart';
import 'package:aladdin_franchise/src/features/pages/home/provider.dart';
import 'package:aladdin_franchise/src/features/pages/home/state.dart';
import 'package:aladdin_franchise/src/features/widgets/app_icon_widget.dart';
import 'package:aladdin_franchise/src/features/widgets/gap.dart';
import 'package:aladdin_franchise/src/models/category.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:popover/popover.dart';
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
    var productsState = ref.watch(menuProvider.select((value) => value.productsState));
    var categories = ref.watch(menuProvider.select((value) => value.categories));
    var categorySelect = ref.watch(menuProvider.select((value) => value.categorySelect));
    var subCategorySelect = ref.watch(menuProvider.select((value) => value.subCategorySelect));
    bool showMenuIcon = categories.any((e) => (e.children ?? []).isNotEmpty);
    switch (productsState.status) {
      case PageCommonState.loading:
        return ListView.separated(
          padding: const EdgeInsets.only(left: 8),
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return AppShimmerLoading(
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
      if (showMenuIcon) {
        if (selected) {
          dataView.add(selected ? item : null);
        } else {
          dataView.add(null);
        }
        if ((item.children ?? []).isNotEmpty) {
          if (selected) {
            // tượng trưng cho dấu mũi tên
            dataView.add(-1);
            dataView.addAll(item.children ?? []);
          } else {
            dataView.addAll(List.generate(
              (item.children ?? []).length + 1,
              (index) => null,
            ));
          }
        }
      } else {
        dataView.add(item);
      }
    }
    var itemScrollController = ref.read(homeProvider.notifier).categoryScrollController;
    var itemPositionsListener = ref.read(homeProvider.notifier).categoryPositionsListener;

    return Row(
      children: [
        if (showMenuIcon && categories.length >= 2) ...[
          const Gap(8),
          InkWell(
            onTap: () {
              showPopover(
                context: context,
                bodyBuilder: (context) => _ListCategoryPopup(
                  onTap: widget.onTap,
                ),
                direction: PopoverDirection.bottom,
                width: 200,
                height: 60 * 3,
                arrowHeight: 15,
                arrowWidth: 30,
              );
            },
            child: const ResponsiveIconWidget(iconData: Icons.menu_open_rounded),
          ),
        ],
        Expanded(
          child: ScrollablePositionedList.separated(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            scrollDirection: Axis.horizontal,
            itemScrollController: itemScrollController,
            itemPositionsListener: itemPositionsListener,
            itemCount: dataView.length,
            separatorBuilder: (context, index) => const Gap(0),
            itemBuilder: (context, index) {
              var item = dataView[index];
              if (item == null) {
                return const SizedBox.shrink();
              }
              if (item == -1) {
                return const Padding(
                  padding: EdgeInsets.only(right: 8),
                  child: Icon(Icons.arrow_forward_ios_rounded, size: 18),
                );
              }
              bool isCategorySelected = categorySelect?.id == item?.id;
              bool isSubCategorySelected = subCategorySelect?.id == item?.id;

              bool isSub = item is SubCategoryModel;
              bool selected = isSub ? isSubCategorySelected : isCategorySelected;
              return Padding(
                padding: const EdgeInsets.only(right: 8),
                child: InkWell(
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
                      style: AppTextStyle.bold(
                        color: selected ? AppColors.white : AppColors.mainColor,
                        rawFontSize: AppConfig.defaultRawTextSize - (isSub ? 1.0 : 0),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _ListCategoryPopup extends ConsumerWidget {
  const _ListCategoryPopup({Key? key, required this.onTap}) : super(key: key);

  final Function(dynamic item) onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categories = ref.watch(homeProvider.select((value) => value.categories));
    final categorySelect = ref.watch(homeProvider.select((value) => value.categorySelect));
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        itemBuilder: (context, index) {
          var item = categories[index];
          bool selected = categorySelect == item;
          return InkWell(
            onTap: () {
              Navigator.of(context).pop();
              onTap.call(item);
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              decoration: BoxDecoration(
                color: selected ? AppColors.mainColor : Colors.grey,
                borderRadius: AppConfig.borderRadiusMain,
              ),
              child: Center(
                child: Text(
                  item.title,
                  style: AppTextStyle.regular(color: AppColors.white),
                ),
              ),
            ),
          );
        },
        separatorBuilder: (context, index) => const Gap(8),
        itemCount: categories.length,
      ),
    );
  }
}
