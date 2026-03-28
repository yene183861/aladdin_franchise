import 'dart:async';

import 'package:aladdin_franchise/generated/l10n.dart';
import 'package:aladdin_franchise/src/configs/app.dart';
import 'package:aladdin_franchise/src/configs/color.dart';
import 'package:aladdin_franchise/src/configs/dev_config.dart';
import 'package:aladdin_franchise/src/configs/text_style.dart';
import 'package:aladdin_franchise/src/core/storages/local.dart';
import 'package:aladdin_franchise/src/core/storages/provider.dart';
import 'package:aladdin_franchise/src/data/enum/status.dart';
import 'package:aladdin_franchise/src/features/pages/home/components/action/btn_notification.dart';
import 'package:aladdin_franchise/src/features/pages/home/components/action/btn_o2o.dart';
import 'package:aladdin_franchise/src/features/pages/home/components/action/btn_refresh_data.dart';
import 'package:aladdin_franchise/src/features/pages/home/components/action/history_order.dart';
import 'package:aladdin_franchise/src/features/pages/home/components/action/type_order.dart';
import 'package:aladdin_franchise/src/features/pages/home/components/menu/provider.dart';
import 'package:aladdin_franchise/src/features/pages/home/view.dart';
import 'package:aladdin_franchise/src/features/pages/table_layout/view.dart';
import 'package:aladdin_franchise/src/features/widgets/app_error_simple.dart';
import 'package:aladdin_franchise/src/features/widgets/app_icon_widget.dart';
import 'package:aladdin_franchise/src/features/widgets/button/button_main.dart';
import 'package:aladdin_franchise/src/features/widgets/button/button_with_icon.dart';
import 'package:aladdin_franchise/src/features/widgets/gap.dart';
import 'package:aladdin_franchise/src/models/category.dart';
import 'package:aladdin_franchise/src/models/product.dart';
import 'package:aladdin_franchise/src/utils/app_check.dart';
import 'package:aladdin_franchise/src/utils/navigator.dart';
import 'package:aladdin_franchise/src/utils/size_util.dart';
import 'package:collection/collection.dart';
import 'package:diacritic/diacritic.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import 'widgets/list_category.dart';
import 'widgets/list_product.dart';
import 'widgets/list_tag.dart';
import 'widgets/search_dish.dart';

class MenuSection extends ConsumerStatefulWidget {
  const MenuSection({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MenuSectionState();
}

class _MenuSectionState extends ConsumerState<MenuSection> {
  ItemScrollController categoryItemScrollController = ItemScrollController();
  ItemPositionsListener categoryItemPositionsListener = ItemPositionsListener.create();
  ItemScrollController productItemScrollController = ItemScrollController();
  ItemPositionsListener productItemPositionsListener = ItemPositionsListener.create();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      if (DevConfig.newUI) ...[
        Container(
          height: AppConfig.heightBtn * 2 + 6 * 2,
          padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 6),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          AppIconButton(
                            icon: CupertinoIcons.home,
                            onTap: Scaffold.of(context).openDrawer,
                          ),
                          const Gap(6),
                          const Expanded(
                            child: SearchDish(),
                          ),
                          const HomeAction(showWhenTagsEmpty: false),
                        ],
                      ),
                    ),
                    const Gap(6),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                ButtonWithIconWidget(
                                  padding: const EdgeInsets.all(6),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                      AppConfig.sizeBorderRadiusSecond,
                                    ),
                                  ),
                                  onPressed: () {
                                    push(context, const TableLayoutPage());
                                  },
                                  textAction: S.of(context).restaurant_layout,
                                  // iconWidget: SvgPicture.asset(Assets.iconsDocumentText),
                                ),
                                // AppButtonWidget(
                                //   textAction: S.of(context).restaurant_layout,
                                //   onTap: () {
                                //     push(context, const TableLayoutPage());
                                //   },
                                //   color: AppColors.secondColor,
                                // ),

                                Expanded(
                                  child: HomeAction(
                                    showWhenTagsEmpty: true,
                                  ),
                                ),
                                // const Expanded(
                                //   child: ListTagsWidget(),
                                // ),
                                // if (!isMobile) ...const [
                                //   Gap(8),
                                //   ButtonRefreshData(),
                                //   ButtonO2oData(),
                                //   Gap(12),
                                //   ButtonNotification(),
                                // ],
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const Gap(8),
              const IntrinsicWidth(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(child: ButtonHistoryOrderWidget()),
                  Gap(6),
                  Expanded(child: TypeOrderWidget()),
                ],
              )),
            ],
          ),
        ),
      ],
      Container(
        height: 56,
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 12),
        // alignment: Alignment.center,
        child: ListCategoryWidget(
          itemScrollController: categoryItemScrollController,
          itemPositionsListener: categoryItemPositionsListener,
          onTap: (item) {
            //   _scrollToCategory(category);
            //   await Future.delayed(const Duration(milliseconds: 350));
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
            var menuDataView = ref.watch(menuProvider.select((value) => value.menuDataView));
            List<dynamic> dataView = [];

            menuDataView.forEach(
              (key, value) {
                if (value.item != null) {
                  dataView.add(value.item);
                }
                if (value.products.isNotEmpty) {
                  dataView.add(value.products);
                }
              },
            );
            return ScrollablePositionedList.builder(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
              scrollDirection: Axis.vertical,
              itemCount: dataView.length,
              itemScrollController: _categoryItemScrollController,
              itemPositionsListener: _categoryItemPositionsListener,
              itemBuilder: (context, index) {
                var item = dataView[index];
                bool isCategorySelected =
                    categorySelect?.id == item.id || categorySelect?.id == item.parentId;
                bool isSubCategorySelected = subCategorySelect?.id == item.id;
                bool selected = isCategorySelected || isSubCategorySelected;

                var check =
                    categoryDataView.firstWhereOrNull((element) => element.id == item.parentId);
                // if (item.parentId != null &&
                //     check != null &&
                //     !(open[check.id] ?? false)) {
                //   return const SizedBox.shrink();
                // }

                return Container();
                // return CategoryCard(
                //   item: item,
                //   selected: selected,
                //   borderRadius: 8,
                //   onTap: () async {
                //     _scrollToCategory(item);
                //     await Future.delayed(const Duration(milliseconds: 350));
                //     var notifier = ref.read(foodChartProvider.notifier);
                //     if (item.parentId != null) {
                //       var parent =
                //           categories.firstWhereOrNull((element) => element.id == item.parentId);
                //       if (parent?.id != categorySelect?.id) {
                //         notifier.onChangeCategorySelect(parent);
                //       }
                //       notifier.onChangeSubCategorySelect(item);
                //     } else {
                //       notifier.onChangeCategorySelect(item);
                //     }
                //   },
                // );
              },
            );
          },
        ),
      ),
    ]);
  }
}

class HomeAction extends ConsumerWidget {
  const HomeAction({
    super.key,
    this.showWhenTagsEmpty = false,
  });
  final bool showWhenTagsEmpty;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var tags = ref.watch(menuProvider.select((value) => value.tags));
    if (tags.isNotEmpty == showWhenTagsEmpty) return const SizedBox.shrink();
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        const Gap(8),
        AppIconButton(
          icon: CupertinoIcons.cloud_download,
          onTap: () {},
        ),
        // Consumer(
        //   builder: (context, ref, child) {
        //     ref.watch(typeOrderWaiterProvider);
        //     return const ButtonHistoryOrderWidget();
        //   },
        // ),
        const Gap(8),
        AppIconButton(
          icon: CupertinoIcons.bell,
          onTap: () {},
        ),
        const Gap(8),
        AppIconButton(
          icon: CupertinoIcons.bell,
          onTap: () {},
        ),
      ],
    );
  }
}

class AppIconButton extends StatelessWidget {
  const AppIconButton({
    super.key,
    this.onTap,
    required this.icon,
    this.backgroundColor,
    this.textAction,
    this.borderRadius,
  });
  final VoidCallback? onTap;
  final IconData icon;
  final Color? backgroundColor;
  final String? textAction;
  final BorderRadius? borderRadius;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onTap,
      icon: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon),
          if (textAction != null) ...[
            const Gap(4),
            Flexible(
              child: Text(textAction!),
            ),
          ],
        ],
      ),
      style: ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(backgroundColor ?? Colors.grey.shade100),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: borderRadius ?? BorderRadius.circular(50),
          ),
        ),
      ),
    );
  }
}

// class MenuPage extends ConsumerStatefulWidget {
//   const MenuPage({super.key});

//   @override
//   ConsumerState<ConsumerStatefulWidget> createState() => _MenuPageState();
// }

// class _MenuPageState extends ConsumerState<MenuPage> with WidgetsBindingObserver {
//   late ScrollController _productScrollController;
//   late ScrollController _categoryScrollController;
//   Map<dynamic, GlobalKey> categoryKeys = {};
//   late final Timer _timerReloadMenu;
//   @override
//   void initState() {
//     super.initState();
//     _productScrollController = ScrollController();
//     _categoryScrollController = ScrollController();
//     _productScrollController.addListener(_onScrollProduct);
//     WidgetsBinding.instance.addObserver(this);
//     WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
//       _timerReloadMenu = Timer.periodic(
//         const Duration(minutes: 5),
//         (timer) {
//           ref.read(menuProvider.notifier).checkReloadMenu();
//         },
//       );
//     });
//   }

//   void _onScrollProduct() {
//     var state = ref.read(menuProvider);
//     var categories = state.categories;
//     var categorySelect = state.categorySelect;
//     var subCategorySelect = state.subCategorySelect;

//     List<dynamic> allCategory = [];
//     for (var item in categories) {
//       allCategory.add(item);
//       if ((item.children ?? []).isNotEmpty) {
//         allCategory.addAll(item.children ?? []);
//       }
//     }

//     for (var item in allCategory.reversed) {
//       bool isSubCategory = item is SubCategoryModel;
//       final ctx = categoryKeys[item]?.currentContext;

//       if (ctx != null) {
//         final box = ctx.findRenderObject();
//         if (box is RenderBox) {
//           final pos = box.localToGlobal(Offset.zero);
//           if (pos.dy <= 250) {
//             if (isSubCategory && item != subCategorySelect) {
//               var category = categories.firstWhereOrNull(
//                   (e) => (e.children ?? []).firstWhereOrNull((i) => i.id == item.id) != null);
//               if (category != categorySelect) {
//                 ref.read(menuProvider.notifier).changeCategorySelect(category);
//               }
//               ref.read(menuProvider.notifier).changeSubCategorySelect(item);
//               _scrollCategoryBarTo(item, allCategory);
//             } else if (!isSubCategory && item != categorySelect) {
//               ref.read(menuProvider.notifier).changeCategorySelect(item);
//               _scrollCategoryBarTo(item, allCategory);
//             }

//             break;
//           }
//         }
//       }
//     }

//     return;
//   }

//   void _scrollCategoryBarTo(dynamic item, List<dynamic> allCategory) {
//     var state = ref.read(menuProvider);
//     // var categories = state.categories;
//     var menuCategoryItem = state.menuCategoryItem;
//     // var categorySelect = state.categorySelect;

//     final visibleItems = ref
//         .read(menuProvider.notifier)
//         .categoryPositionsListener
//         .itemPositions
//         .value
//         .where((position) => position.itemLeadingEdge < 1 && position.itemTrailingEdge > 0)
//         .map((e) => e.index)
//         .toList();
//     List<dynamic> dataView = List.from(menuCategoryItem);
//     // for (var item in categories) {
//     //   bool selected = item == categorySelect;
//     //   dataView.add(item);
//     //   if (selected && (item.children ?? []).isNotEmpty) {
//     //     dataView.add(null);
//     //     dataView.addAll(item.children ?? []);
//     //   }
//     // }
//     var items = [];
//     for (var i in visibleItems) {
//       items.add(dataView[i]);
//     }
//     if (!items.contains(item)) {
//       var index = dataView.indexOf(item);
//       if (index != -1) {
//         ref.read(menuProvider.notifier).categoryScrollController.jumpTo(index: index);
//       }
//     }
//   }

//   void _scrollToCategory(dynamic item) {
//     BuildContext? ctx = categoryKeys[item]?.currentContext;
//     if (ctx != null) {
//       Scrollable.ensureVisible(
//         ctx,
//         duration: const Duration(milliseconds: 300),
//         alignment: 0,
//       );
//     }
//   }

//   @override
//   void dispose() {
//     isCheckTypeOrderInit = false;
//     _productScrollController.dispose();
//     _categoryScrollController.dispose();
//     kToken = "";
//     kTypeOrder = 0;
//     _timerReloadMenu.cancel();
//     WidgetsBinding.instance.removeObserver(this);
//     super.dispose();
//   }

//   @override
//   void didChangeAppLifecycleState(AppLifecycleState state) {
//     switch (state) {
//       case AppLifecycleState.resumed:
//         if (ref.read(menuProvider.notifier).getCheckReloadWhenHiddenApp()) {
//           ref.read(menuProvider.notifier).updateReloadWhenHiddenApp(false);
//           ref.read(menuProvider.notifier).getProducts();
//         }
//         break;
//       default:
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SegmentedMenu(
//       items: ['TẤT CẢ', 'MANG VỀ', 'KHAI VỊ', 'ĐỒ VIÊN'],
//       onChanged: (index) {
//         print('Selected: $index');
//       },
//     );
//     var categories = ref.watch(menuProvider.select((value) => value.categories));
//     categoryKeys = ref.read(menuProvider.notifier).categoryKeys;
//     var products = ref.watch(menuProvider.select((value) => value.products));
//     var tags = ref.watch(menuProvider.select((value) => value.tags));

//     var productsView = List<ProductModel>.from(products);
//     var keyword = ref.watch(menuProvider.select((value) => value.search)).trim();
//     var tagSelect = ref.watch(menuProvider.select((value) => value.tagSelect));
//     if (tagSelect != null) {
//       productsView =
//           productsView.where((product) => (product.tags ?? []).contains(tagSelect.id)).toList();
//     }
//     if (keyword.isNotEmpty) {
//       var search = removeDiacritics(keyword).toLowerCase();
//       productsView = productsView
//           .where((product) =>
//               (product.getSearchName().toLowerCase()).contains(search) ||
//               (product.getSearchShortName().toLowerCase().contains(search)))
//           .toList();
//     }
//     List<Widget> dataView = [];
//     for (var cate in categories) {
//       List<ProductModel> categoryProducts =
//           productsView.where((e) => e.categoryId == cate.id).toList();
//       var subCategory = List<SubCategoryModel>.from((cate.children ?? []));
//       Map<SubCategoryModel, List<ProductModel>> subCategoryProducts = {};
//       for (var subCate in subCategory) {
//         var data = productsView.where((e) => e.categoryId == subCate.id).toList();

//         if (data.isNotEmpty) {
//           subCategoryProducts[subCate] = data;
//         }
//       }
//       if (categoryProducts.isNotEmpty || subCategoryProducts.isNotEmpty) {
//         dataView.add(SliverToBoxAdapter(
//           child: Container(
//             key: categoryKeys[cate],
//             decoration: const BoxDecoration(color: Colors.white),
//             padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
//             alignment: Alignment.centerLeft,
//             child: Text(
//               cate.getNameView(),
//               style: AppTextStyle.bold(),
//             ),
//           ),
//         ));
//         if (categoryProducts.isNotEmpty) {
//           dataView.add(SliverPadding(
//             padding: const EdgeInsets.only(left: 10),
//             sliver: SliverGrid.builder(
//               gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
//                 maxCrossAxisExtent: 180,
//                 mainAxisSpacing: 10,
//                 crossAxisSpacing: 10,
//                 childAspectRatio: 0.8,
//               ),
//               itemBuilder: (context, index) => ProductBox(product: categoryProducts[index]),
//               itemCount: categoryProducts.length,
//             ),
//           ));
//         }
//       }

//       subCategoryProducts.forEach(
//         (key, value) {
//           if (value.isNotEmpty) {
//             dataView.add(SliverToBoxAdapter(
//               child: Container(
//                 key: categoryKeys[key],
//                 decoration: const BoxDecoration(color: Colors.white),
//                 padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
//                 alignment: Alignment.centerLeft,
//                 child: Text(
//                   key.getNameView(),
//                   style: AppTextStyle.bold(),
//                 ),
//               ),
//             ));
//             dataView.add(SliverPadding(
//               padding: const EdgeInsets.only(left: 10),
//               sliver: SliverGrid.builder(
//                 gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
//                   maxCrossAxisExtent: 180,
//                   mainAxisSpacing: 10,
//                   crossAxisSpacing: 10,
//                   childAspectRatio: 0.8,
//                 ),
//                 itemBuilder: (context, index) => ProductBox(product: value[index]),
//                 itemCount: value.length,
//               ),
//             ));
//           }
//         },
//       );
//     }
//     bool isMobile = ResponsiveBreakpoints.of(context).isMobile;
//     bool showLogoRestaurant =
//         !(isMobile && ResponsiveBreakpoints.of(context).orientation == Orientation.portrait);

//     // bool portraitOrientation = AppDeviceSizeUtil.checkPortraitOrientation(context);

//     // bool emptyTags = tags.isEmpty;

//     // bool orderDetailSidePanel = ResponsiveBreakpoints.of(context).largerThan(TABLET);
//     return Column(
//       children: [
//         Container(
//           height: 48 * 2,
//           child: Row(
//             children: [
//               // if (showLogoRestaurant)
//               //   SizedBox(
//               //     width: showLogoRestaurant ? 60 * (isMobile ? 1 : 2) : 0,
//               //     child: const LogoWidget(),
//               //   ),
//               Expanded(
//                 child: Column(
//                   children: [
//                     Expanded(
//                       child: Row(
//                         children: [
//                           const Gap(8),
//                           Builder(
//                             builder: (context) {
//                               return InkWell(
//                                 onTap: Scaffold.of(context).openDrawer,
//                                 child: const ResponsiveIconWidget(
//                                   iconData: CupertinoIcons.home,
//                                 ),
//                               );
//                             },
//                           ),
//                           const Gap(8),
//                           const Expanded(
//                             child: Padding(
//                               padding: EdgeInsets.symmetric(horizontal: 0, vertical: 4),
//                               child: SearchDish(),
//                             ),
//                           ),
//                           // if (!isMobile)
//                           //   ...[]
//                           // else ...[
//                           //   const ButtonO2oData(),
//                           //   const ButtonNotification(),
//                           //   Consumer(
//                           //     builder: (context, ref, child) {
//                           //       ref.watch(typeOrderWaiterProvider);
//                           //       var useO2O =
//                           //           LocalStorage.getDataLogin()?.restaurant?.o2oStatus ?? false;
//                           //       if (useO2O || portraitOrientation) {
//                           //         return const SizedBox.shrink();
//                           //       }
//                           //       if (emptyTags) {
//                           //         return const TypeOrderWidget();
//                           //       }
//                           //       return const ButtonHistoryOrderWidget();
//                           //     },
//                           //   ),
//                           //   const Gap(8),
//                           //   const ButtonRefreshData(),
//                           // ],
//                         ],
//                       ),
//                     ),
//                     Expanded(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Expanded(
//                             child: Row(
//                               children: [
//                                 const Gap(8),
//                                 AppButtonWidget(
//                                   textAction: S.of(context).restaurant_layout,
//                                   onTap: () {
//                                     push(context, const TableLayoutPage());
//                                   },
//                                   color: AppColors.secondColor,
//                                 ),
//                                 const Expanded(
//                                   child: ListTagsWidget(),
//                                 ),
//                                 if (!isMobile) ...const [
//                                   Gap(8),
//                                   ButtonRefreshData(),
//                                   ButtonO2oData(),
//                                   Gap(12),
//                                   ButtonNotification(),
//                                 ],
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               const Gap(8),
//               const IntrinsicWidth(
//                   child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                 children: [
//                   Gap(6),
//                   Expanded(child: ButtonHistoryOrderWidget()),
//                   Gap(8),
//                   Expanded(child: TypeOrderWidget()),
//                   Gap(6),
//                 ],
//               )),
//               const Gap(8),
//             ],
//           ),
//         ),
//         Container(
//           height: 42.px,
//           padding: const EdgeInsets.fromLTRB(0, 4, 8, 4),
//           alignment: Alignment.center,
//           child: ListCategoryWidget(
//               categoryScrollController: _categoryScrollController,
//               onTap: (category) async {
//                 _scrollToCategory(category);
//                 await Future.delayed(const Duration(milliseconds: 350));
//                 // ref.read(homeProvider.notifier).ctrlSearch.text = '';
//                 if (category is CategoryModel) {
//                   ref.read(menuProvider.notifier).changeCategorySelect(category);
//                   return;
//                 }
//                 ref.read(menuProvider.notifier).changeSubCategorySelect(category);
//               }),
//         ),
//         Expanded(
//           child: Consumer(builder: (context, ref, child) {
//             var productState = ref.watch(menuProvider.select((value) => value.productState));

//             switch (productState.status) {
//               case StatusEnum.normal:
//               case StatusEnum.loading:
//                 return GridView.builder(
//                   padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
//                   gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
//                     maxCrossAxisExtent: 200,
//                     mainAxisSpacing: 10,
//                     crossAxisSpacing: 10,
//                     childAspectRatio: 0.7,
//                   ),
//                   itemBuilder: (BuildContext context, int index) {
//                     return const ProductBoxLoadingWidget();
//                   },
//                   itemCount: 12,
//                 );
//               case StatusEnum.error:
//                 return AppErrorSimpleWidget(
//                   onTryAgain: () {
//                     ref.read(menuProvider.notifier).getProducts();
//                   },
//                   message: productState.message,
//                 );
//               case StatusEnum.success:
//             }
//             return CustomScrollView(
//               controller: _productScrollController,
//               slivers: [
//                 ...dataView,
//                 const SliverToBoxAdapter(child: Gap(50)),
//               ],
//             );
//           }),
//         ),
//       ],
//     );
//   }

//   Widget buildMenu() {
//     return Row(
//       children: [
//         _breadcrumbItem('TẤT CẢ'),
//         _divider(),
//         _breadcrumbItem('MANG VỀ'),
//         _divider(),
//         _activeChip('KHAI VỊ'),
//         const SizedBox(width: 8),
//         _outlineChip('ĐỒ VIÊN'),
//       ],
//     );
//   }

//   Widget _breadcrumbItem(String text) {
//     return Text(
//       text,
//       style: const TextStyle(
//         fontSize: 14,
//         color: Colors.grey,
//         fontWeight: FontWeight.w500,
//       ),
//     );
//   }

//   Widget _divider() {
//     return const Padding(
//       padding: EdgeInsets.symmetric(horizontal: 6),
//       child: Icon(Icons.chevron_right, size: 16, color: Colors.grey),
//     );
//   }

//   Widget _activeChip(String text) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//       decoration: BoxDecoration(
//         color: Colors.red,
//         borderRadius: BorderRadius.circular(20),
//       ),
//       child: Text(
//         text,
//         style: const TextStyle(
//           color: Colors.white,
//           fontWeight: FontWeight.w600,
//         ),
//       ),
//     );
//   }

//   Widget _outlineChip(String text) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//       decoration: BoxDecoration(
//         border: Border.all(color: Colors.red),
//         borderRadius: BorderRadius.circular(20),
//       ),
//       child: Text(
//         text,
//         style: const TextStyle(
//           color: Colors.red,
//           fontWeight: FontWeight.w500,
//         ),
//       ),
//     );
//   }
// }

// class SegmentedMenu extends StatefulWidget {
//   final List<String> items;
//   final ValueChanged<int>? onChanged;

//   const SegmentedMenu({
//     super.key,
//     required this.items,
//     this.onChanged,
//   });

//   @override
//   State<SegmentedMenu> createState() => _SegmentedMenuState();
// }

// class _SegmentedMenuState extends State<SegmentedMenu> {
//   int selectedIndex = 0;

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: 40,
//       child: ListView.separated(
//         scrollDirection: Axis.horizontal,
//         padding: const EdgeInsets.symmetric(horizontal: 12),
//         itemBuilder: (_, index) {
//           final isSelected = index == selectedIndex;

//           return GestureDetector(
//             onTap: () {
//               setState(() {
//                 selectedIndex = index;
//               });
//               widget.onChanged?.call(index);
//             },
//             child: AnimatedContainer(
//               duration: const Duration(milliseconds: 250),
//               curve: Curves.easeInOut,
//               padding: const EdgeInsets.symmetric(horizontal: 16),
//               alignment: Alignment.center,
//               decoration: BoxDecoration(
//                 color: isSelected ? Colors.red : Colors.grey.shade100,
//                 borderRadius: BorderRadius.circular(50),
//                 border: Border.all(
//                   color: isSelected ? Colors.red : Colors.grey.shade300,
//                 ),
//                 gradient: isSelected
//                     ? const LinearGradient(
//                         colors: [Color.fromARGB(255, 245, 59, 56), Color(0xFFD32F2F)],
//                       )
//                     : null,
//                 boxShadow: isSelected
//                     ? [
//                         BoxShadow(
//                           color: Colors.red.withOpacity(0.3),
//                           blurRadius: 8,
//                           offset: Offset(0, 3),
//                         )
//                       ]
//                     : [],
//               ),
//               child: AnimatedDefaultTextStyle(
//                 duration: const Duration(milliseconds: 200),
//                 style: TextStyle(
//                   color: isSelected ? Colors.white : Colors.black87,
//                   fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
//                   fontSize: 14,
//                 ),
//                 child: Text(
//                   widget.items[index],
//                   // style: TextStyle(
//                   //   color: isSelected ? Colors.white : Colors.black87,
//                   //   fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
//                   //   fontSize: 14,
//                   // ),
//                 ),
//               ),
//             ),
//           );
//         },
//         separatorBuilder: (_, __) => const SizedBox(width: 8),
//         itemCount: widget.items.length,
//       ),
//     );
//   }
// }
