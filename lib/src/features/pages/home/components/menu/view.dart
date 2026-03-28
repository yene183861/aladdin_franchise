import 'dart:async';

import 'package:aladdin_franchise/src/configs/app.dart';
import 'package:aladdin_franchise/src/configs/text_style.dart';
import 'package:aladdin_franchise/src/data/enum/status.dart';
import 'package:aladdin_franchise/src/features/pages/home/components/menu/provider.dart';
import 'package:aladdin_franchise/src/features/widgets/app_error_simple.dart';
import 'package:aladdin_franchise/src/features/widgets/gap.dart';
import 'package:aladdin_franchise/src/features/widgets/shimmer_box.dart';
import 'package:aladdin_franchise/src/models/category.dart';
import 'package:aladdin_franchise/src/models/product.dart';
import 'package:aladdin_franchise/src/utils/app_log.dart';
import 'package:collection/collection.dart';
import 'package:diacritic/diacritic.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import 'state.dart';
import 'widgets/list_category.dart';
import 'widgets/product_box.dart';

class MenuSection extends ConsumerStatefulWidget {
  const MenuSection({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MenuSectionState();
}

class _MenuSectionState extends ConsumerState<MenuSection> {
  ItemScrollController categoryItemScrollController = ItemScrollController();
  ItemPositionsListener categoryItemPositionsListener = ItemPositionsListener.create();

  late ScrollController _productController;

  @override
  void initState() {
    super.initState();
    _productController = ScrollController();
    _productController.addListener(_onScrollProduct);
  }

  void _onScrollProduct() {
    try {
      var state = ref.read(menuProvider);
      var categorySelect = state.categorySelect;
      var subCategorySelect = state.subCategorySelect;
      var menuDataView = state.menuDataView;
      var keys = ref.read(menuProvider.notifier).categoryKeys;
      List<CategoryModel?> data = [];

      menuDataView.forEach(
        (key, value) {
          data.add(value.item);
        },
      );
      var reversed = data.reversed.toList();
      for (var item in reversed) {
        if (item == null) continue;
        bool isCategory = item.parentId == null;
        final ctx = keys[item.id]?.currentContext;
        if (ctx != null) {
          final box = ctx.findRenderObject();
          if (box is RenderBox) {
            final pos = box.localToGlobal(Offset.zero);
            if (pos.dy <= 250) {
              if (!isCategory && item.id != subCategorySelect?.id) {
                var cate = reversed.firstWhereOrNull((e) => e?.id == item.parentId);
                if (cate?.id != categorySelect?.id) {
                  ref.read(menuProvider.notifier).changeCategorySelect(cate);
                }
                ref.read(menuProvider.notifier).changeSubCategorySelect(item);
                _scrollCategoryBarTo(item, data);
              } else if (isCategory && item.id != categorySelect?.id) {
                ref.read(menuProvider.notifier).changeCategorySelect(item);
                _scrollCategoryBarTo(item, data);
              }

              break;
            }
          }
        }
      }
    } catch (ex) {
      showLogs(ex, flags: 'ex _onScrollProduct');
      //
    }
  }

  void _scrollCategoryBarTo(CategoryModel cate, List<CategoryModel?> data) {
    final visibleItems = categoryItemPositionsListener.itemPositions.value
        .where((position) => position.itemLeadingEdge < 1 && position.itemTrailingEdge > 0)
        .map((e) => e.index)
        .toList();
    try {
      var items = [];
      for (var i in visibleItems) {
        try {
          items.add(data[i]);
        } catch (ex) {
          //
        }
      }
      if (!items.contains(cate)) {
        var index = data.indexOf(cate);
        if (index != -1) {
          try {
            categoryItemScrollController.jumpTo(index: index);
          } catch (ex) {
            //
          }
        }
      }
    } catch (ex) {
      showLogs(ex, flags: 'ex _scrollCategoryBarTo');
    }
  }

  void _scrollToProduct(CategoryModel item) {
    var keys = ref.read(menuProvider.notifier).categoryKeys;
    BuildContext? ctx = keys[item.id]?.currentContext;
    if (ctx != null) {
      Scrollable.ensureVisible(
        ctx,
        duration: const Duration(milliseconds: 300),
        alignment: 0,
      );
    }
  }

  @override
  void dispose() {
    _productController.removeListener(_onScrollProduct);
    _productController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
        height: 56,
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 12),
        child: ListCategoryWidget(
          itemScrollController: categoryItemScrollController,
          itemPositionsListener: categoryItemPositionsListener,
          onTap: (item) async {
            _scrollToProduct(item);
            await Future.delayed(const Duration(milliseconds: 350));
            bool isCate = item.parentId == null;
            if (isCate) {
              ref.read(menuProvider.notifier).changeCategorySelect(item);
            } else {
              var state = ref.read(menuProvider);
              var cateSelect = state.categorySelect;
              if (cateSelect != item.parentId) {
                var menuDataView = state.menuDataView;
                var cate = menuDataView[item.parentId]?.item;
                ref.read(menuProvider.notifier).changeCategorySelect(cate);
              }
              ref.read(menuProvider.notifier).changeSubCategorySelect(item);
            }
          },
        ),
      ),
      Expanded(
        child: Consumer(
          builder: (context, ref, child) {
            var spacing = 10.0;
            var productState = ref.watch(menuProvider.select((value) => value.productState));

            switch (productState.status) {
              case StatusEnum.normal:
              case StatusEnum.loading:
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(spacing, spacing * 1, spacing, spacing),
                      child: ShimmerBoxWidget(
                        child: Text(
                          'e.getNameView()',
                          style: AppTextStyle.bold(
                            rawFontSize: AppConfig.defaultRawTextSize + 1.5,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        padding: EdgeInsets.only(right: spacing),
                        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 180,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: spacing,
                          childAspectRatio: 0.75,
                        ),
                        itemBuilder: (BuildContext context, int index) {
                          return ProductBox(
                            product: const ProductModel(id: -1),
                            marginLeft: spacing,
                            loading: true,
                          );
                        },
                        itemCount: 12,
                      ),
                    ),
                  ],
                );
              case StatusEnum.error:
                return AppErrorSimpleWidget(
                  onTryAgain: () {
                    ref.read(menuProvider.notifier).getProducts();
                  },
                  message: productState.message,
                );
              case StatusEnum.success:
            }

            var data = ref.watch(menuProvider.select((value) => value.menuDataView));

            Map<dynamic, MenuDataView> menuDataView = Map<dynamic, MenuDataView>.from(data);
            var searchText = ref.watch(menuProvider.select((value) => value.search)).trim();
            var tagSelect = ref.watch(menuProvider.select((value) => value.tagSelect));

            String search = '';
            if (searchText.isNotEmpty) {
              search = removeDiacritics(searchText).toLowerCase();
            }
            var keys = ref.read(menuProvider.notifier).categoryKeys;
            List<dynamic> dataView = [];

            menuDataView.forEach(
              (key, value) {
                Set<ProductModel> products = {};

                for (var item in value.products) {
                  if (tagSelect != null && !(item.tags ?? []).contains(tagSelect.id)) {
                    continue;
                  }
                  if (search.isNotEmpty) {
                    var check = (item.getSearchName().toLowerCase()).contains(search) ||
                        (item.getSearchShortName().toLowerCase().contains(search));
                    if (check != true) continue;
                  }
                  products.add(item);
                }
                if (products.isEmpty) return;
                if (value.item != null) {
                  dataView.add(value.item);
                }
                if (products.isNotEmpty) {
                  dataView.add(products.toList());
                }
              },
            );

            return CustomScrollView(
              controller: _productController,
              slivers: [
                for (final e in dataView) ...[
                  if (e is CategoryModel)
                    SliverToBoxAdapter(
                        child: Padding(
                      padding: EdgeInsets.fromLTRB(spacing, spacing * 1.2, spacing, spacing),
                      child: Text(
                        key: keys[e.id],
                        e.getNameView(),
                        style: AppTextStyle.bold(
                          rawFontSize: AppConfig.defaultRawTextSize + 1.5,
                        ),
                      ),
                    )),
                  if (e is List<ProductModel>)
                    SliverPadding(
                      padding: EdgeInsets.only(right: spacing),
                      sliver: SliverGrid(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            return ProductBox(
                              product: e[index],
                              marginLeft: spacing,
                            );
                          },
                          childCount: e.length,
                        ),
                        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 180,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 0,
                          childAspectRatio: 0.75,
                        ),
                      ),
                    ),
                ],
                const SliverToBoxAdapter(child: Gap(50)),
              ],
            );
          },
        ),
      ),
    ]);
  }
}
