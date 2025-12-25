import 'dart:async';

import 'package:aladdin_franchise/src/configs/app.dart';
import 'package:aladdin_franchise/src/configs/color.dart';
import 'package:aladdin_franchise/src/configs/text_style.dart';
import 'package:aladdin_franchise/src/core/storages/local.dart';
import 'package:aladdin_franchise/src/core/storages/provider.dart';
import 'package:aladdin_franchise/src/features/pages/home/components/action/btn_o2o.dart';
import 'package:aladdin_franchise/src/features/pages/home/components/action/btn_refresh_data.dart';
import 'package:aladdin_franchise/src/features/pages/home/components/action/history_order.dart';
import 'package:aladdin_franchise/src/features/pages/home/components/action/type_order.dart';
import 'package:aladdin_franchise/src/features/pages/home/components/menu/components/list_category.dart';
import 'package:aladdin_franchise/src/features/pages/home/components/menu/components/list_tag.dart';
import 'package:aladdin_franchise/src/features/pages/home/components/menu/provider.dart';
import 'package:aladdin_franchise/src/features/pages/home/state.dart';
import 'package:aladdin_franchise/src/features/pages/table_layout/view.dart';
import 'package:aladdin_franchise/src/features/widgets/app_error_simple.dart';
import 'package:aladdin_franchise/src/features/widgets/app_icon_widget.dart';
import 'package:aladdin_franchise/src/features/widgets/button_main.dart';
import 'package:aladdin_franchise/src/features/widgets/gap.dart';
import 'package:aladdin_franchise/src/models/category.dart';
import 'package:aladdin_franchise/src/models/product.dart';
import 'package:aladdin_franchise/src/utils/app_check.dart';
import 'package:aladdin_franchise/src/utils/navigator.dart';
import 'package:aladdin_franchise/src/utils/size_util.dart';
import 'package:collection/collection.dart';
import 'package:diacritic/diacritic.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'components/barrel_component.dart';
import 'components/list_product.dart';

class MenuPage extends ConsumerStatefulWidget {
  const MenuPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MenuPageState();
}

class _MenuPageState extends ConsumerState<MenuPage> with WidgetsBindingObserver {
  late ScrollController _productScrollController;
  late ScrollController _categoryScrollController;
  Map<dynamic, GlobalKey> categoryKeys = {};
  late final Timer _timerReloadMenu;
  @override
  void initState() {
    super.initState();
    _productScrollController = ScrollController();
    _categoryScrollController = ScrollController();
    _productScrollController.addListener(_onScrollProduct);
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _timerReloadMenu = Timer.periodic(
        const Duration(minutes: 5),
        (timer) {
          ref.read(menuProvider.notifier).checkReloadMenu();
        },
      );
    });
  }

  void _onScrollProduct() {
    var state = ref.read(menuProvider);
    var categories = state.categories;
    var categorySelect = state.categorySelect;
    var subCategorySelect = state.subCategorySelect;

    List<dynamic> allCategory = [];
    for (var item in categories) {
      allCategory.add(item);
      if ((item.children ?? []).isNotEmpty) {
        allCategory.addAll(item.children ?? []);
      }
    }

    for (var item in allCategory.reversed) {
      bool isSubCategory = item is SubCategoryModel;
      final ctx = categoryKeys[item]?.currentContext;

      if (ctx != null) {
        final box = ctx.findRenderObject();
        if (box is RenderBox) {
          final pos = box.localToGlobal(Offset.zero);
          if (pos.dy <= 250) {
            if (isSubCategory && item != subCategorySelect) {
              var category = categories.firstWhereOrNull(
                  (e) => (e.children ?? []).firstWhereOrNull((i) => i.id == item.id) != null);
              if (category != categorySelect) {
                ref.read(menuProvider.notifier).changeCategorySelect(category);
              }
              ref.read(menuProvider.notifier).changeSubCategorySelect(item);
              _scrollCategoryBarTo(item, allCategory);
            } else if (!isSubCategory && item != categorySelect) {
              ref.read(menuProvider.notifier).changeCategorySelect(item);
              _scrollCategoryBarTo(item, allCategory);
            }

            break;
          }
        }
      }
    }

    return;
  }

  void _scrollCategoryBarTo(dynamic item, List<dynamic> allCategory) {
    var state = ref.read(menuProvider);
    // var categories = state.categories;
    var menuCategoryItem = state.menuCategoryItem;
    // var categorySelect = state.categorySelect;

    final visibleItems = ref
        .read(menuProvider.notifier)
        .categoryPositionsListener
        .itemPositions
        .value
        .where((position) => position.itemLeadingEdge < 1 && position.itemTrailingEdge > 0)
        .map((e) => e.index)
        .toList();
    List<dynamic> dataView = List.from(menuCategoryItem);
    // for (var item in categories) {
    //   bool selected = item == categorySelect;
    //   dataView.add(item);
    //   if (selected && (item.children ?? []).isNotEmpty) {
    //     dataView.add(null);
    //     dataView.addAll(item.children ?? []);
    //   }
    // }
    var items = [];
    for (var i in visibleItems) {
      items.add(dataView[i]);
    }
    if (!items.contains(item)) {
      var index = dataView.indexOf(item);
      if (index != -1) {
        ref.read(menuProvider.notifier).categoryScrollController.jumpTo(index: index);
      }
    }
  }

  void _scrollToCategory(dynamic item) {
    BuildContext? ctx = categoryKeys[item]?.currentContext;
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
    isCheckTypeOrderInit = false;
    _productScrollController.dispose();
    _categoryScrollController.dispose();
    kToken = "";
    kTypeOrder = 0;
    _timerReloadMenu.cancel();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        if (ref.read(menuProvider.notifier).getCheckReloadWhenHiddenApp()) {
          ref.read(menuProvider.notifier).updateReloadWhenHiddenApp(false);
          ref.read(menuProvider.notifier).getProducts();
        }
        break;
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    var categories = ref.watch(menuProvider.select((value) => value.categories));
    categoryKeys = ref.read(menuProvider.notifier).categoryKeys;
    var products = ref.watch(menuProvider.select((value) => value.products));
    var tags = ref.watch(menuProvider.select((value) => value.tags));

    var productsView = List<ProductModel>.from(products);
    var keyword = ref.watch(menuProvider.select((value) => value.search)).trim();
    var tagSelect = ref.watch(menuProvider.select((value) => value.tagSelect));
    if (tagSelect != null) {
      productsView =
          productsView.where((product) => (product.tags ?? []).contains(tagSelect.id)).toList();
    }
    if (keyword.isNotEmpty) {
      var search = removeDiacritics(keyword).toLowerCase();
      productsView = productsView
          .where((product) =>
              (product.getSearchName().toLowerCase()).contains(search) ||
              (product.getSearchShortName().toLowerCase().contains(search)))
          .toList();
    }
    List<Widget> dataView = [];
    for (var cate in categories) {
      List<ProductModel> categoryProducts =
          productsView.where((e) => e.categoryId == cate.id).toList();
      var subCategory = List<SubCategoryModel>.from((cate.children ?? []));
      Map<SubCategoryModel, List<ProductModel>> subCategoryProducts = {};
      for (var subCate in subCategory) {
        var data = productsView.where((e) => e.categoryId == subCate.id).toList();

        if (data.isNotEmpty) {
          subCategoryProducts[subCate] = data;
        }
      }
      if (categoryProducts.isNotEmpty || subCategoryProducts.isNotEmpty) {
        dataView.add(SliverToBoxAdapter(
          child: Container(
            key: categoryKeys[cate],
            decoration: const BoxDecoration(color: Colors.white),
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
            alignment: Alignment.centerLeft,
            child: Text(
              cate.title,
              style: AppTextStyle.bold(),
            ),
          ),
        ));
        if (categoryProducts.isNotEmpty) {
          dataView.add(SliverPadding(
            padding: const EdgeInsets.only(left: 10),
            sliver: SliverGrid.builder(
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 180,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: 0.8,
              ),
              itemBuilder: (context, index) => ProductBoxWidget(product: categoryProducts[index]),
              itemCount: categoryProducts.length,
            ),
          ));
        }
      }

      subCategoryProducts.forEach(
        (key, value) {
          if (value.isNotEmpty) {
            dataView.add(SliverToBoxAdapter(
              child: Container(
                key: categoryKeys[key],
                decoration: const BoxDecoration(color: Colors.white),
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
                alignment: Alignment.centerLeft,
                child: Text(
                  key.title,
                  style: AppTextStyle.bold(),
                ),
              ),
            ));
            dataView.add(SliverPadding(
              padding: const EdgeInsets.only(left: 10),
              sliver: SliverGrid.builder(
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 180,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  childAspectRatio: 0.8,
                ),
                itemBuilder: (context, index) => ProductBoxWidget(product: value[index]),
                itemCount: value.length,
              ),
            ));
          }
        },
      );
    }
    bool isMobile = AppDeviceSizeUtil.checkMobileDevice();
    bool portraitOrientation = AppDeviceSizeUtil.checkPortraitOrientation(context);

    bool emptyTags = tags.isEmpty;
    return Column(
      children: [
        Container(
          height: 48,
          width: double.maxFinite,
          alignment: Alignment.center,
          child: Row(
            children: [
              const Gap(8),
              Builder(
                builder: (context) {
                  return InkWell(
                    onTap: Scaffold.of(context).openDrawer,
                    child: const ResponsiveIconWidget(
                      iconData: CupertinoIcons.home,
                    ),
                  );
                },
              ),
              const Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                  child: SearchDish(),
                ),
              ),
              if (!isMobile) ...[
                const ButtonHistoryOrderWidget(),
                const Gap(8),
              ] else ...[
                const ButtonO2oData(),
                Consumer(
                  builder: (context, ref, child) {
                    ref.watch(typeOrderWaiterProvider);
                    var useO2O = LocalStorage.getDataLogin()?.restaurant?.o2oStatus ?? false;
                    if (useO2O || portraitOrientation) {
                      return const SizedBox.shrink();
                    }
                    if (emptyTags) {
                      return const TypeOrderWidget();
                    }
                    return const ButtonHistoryOrderWidget();
                  },
                ),
                const ButtonRefreshData(),
              ],
            ],
          ),
        ),
        Consumer(
          builder: (context, ref, child) {
            // var tags = ref.watch(homeProvider.select((value) => value.tags));
            // if (tags.isEmpty && isMobile) {
            //   return const SizedBox.shrink();
            // }

            return SizedBox(
              height: 48,
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              const Gap(8),
                              AppButtonWidget(
                                textAction: 'Layout nhà hàng',
                                onTap: () {
                                  push(context, const TableLayoutPage());
                                },
                                color: AppColors.secondColor,
                              ),
                              const Expanded(
                                child: ListTagsWidget(),
                              ),
                              if (!isMobile) ...const [
                                Gap(8),
                                ButtonRefreshData(),
                                ButtonO2oData(),
                              ],
                              const Gap(8),
                              const TypeOrderWidget(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
        Container(
          height: 42.px,
          padding: const EdgeInsets.fromLTRB(0, 4, 8, 4),
          alignment: Alignment.center,
          child: ListCategoryWidget(
              categoryScrollController: _categoryScrollController,
              onTap: (category) async {
                _scrollToCategory(category);
                await Future.delayed(const Duration(milliseconds: 350));
                // ref.read(homeProvider.notifier).ctrlSearch.text = '';
                if (category is CategoryModel) {
                  ref.read(menuProvider.notifier).changeCategorySelect(category);
                  return;
                }
                ref.read(menuProvider.notifier).changeSubCategorySelect(category);
              }),
        ),
        Expanded(
          child: Consumer(builder: (context, ref, child) {
            var productsState = ref.watch(menuProvider.select((value) => value.productsState));

            switch (productsState.status) {
              case PageCommonState.normal:
              case PageCommonState.loading:
                return GridView.builder(
                  padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    childAspectRatio: 0.7,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    return const ProductBoxLoadingWidget();
                  },
                  itemCount: 12,
                );
              case PageCommonState.error:
                return AppErrorSimpleWidget(
                  onTryAgain: () {
                    ref.read(menuProvider.notifier).getProducts();
                  },
                  message: productsState.messageError,
                );
              case PageCommonState.success:
            }
            return CustomScrollView(
              controller: _productScrollController,
              slivers: [
                ...dataView,
                const SliverToBoxAdapter(child: Gap(50)),
              ],
            );
          }),
        ),
      ],
    );
  }
}
