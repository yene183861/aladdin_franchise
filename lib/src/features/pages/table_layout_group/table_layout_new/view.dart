import 'package:aladdin_franchise/generated/l10n.dart';
import 'package:aladdin_franchise/src/configs/app.dart';
import 'package:aladdin_franchise/src/configs/color.dart';
import 'package:aladdin_franchise/src/configs/enums/type_order.dart';
import 'package:aladdin_franchise/src/configs/text_style.dart';
import 'package:aladdin_franchise/src/core/network/provider.dart';
import 'package:aladdin_franchise/src/data/enum/reservation_status.dart';
import 'package:aladdin_franchise/src/data/model/reservation/reservation.dart';
import 'package:aladdin_franchise/src/features/dialogs/confirm_action.dart';
import 'package:aladdin_franchise/src/features/dialogs/message.dart';
import 'package:aladdin_franchise/src/features/pages/home/components/menu/provider.dart';
import 'package:aladdin_franchise/src/features/pages/home/components/menu/view.dart';

import 'package:aladdin_franchise/src/features/pages/home/provider.dart';
import 'package:aladdin_franchise/src/features/widgets/button/app_buton.dart';
import 'package:aladdin_franchise/src/features/widgets/gap.dart';
import 'package:aladdin_franchise/src/models/category.dart';
import 'package:aladdin_franchise/src/models/order.dart';
import 'package:aladdin_franchise/src/utils/app_log.dart';
import 'package:aladdin_franchise/src/utils/navigator.dart';
import 'package:aladdin_franchise/src/utils/show_snackbar.dart';
import 'package:animated_tree_view/animated_tree_view.dart';
import 'package:animated_tree_view/tree_view/tree_node.dart';
import 'package:animated_tree_view/tree_view/tree_view.dart';
import 'package:animated_tree_view/tree_view/widgets/expansion_indicator.dart';
import 'package:animated_tree_view/tree_view/widgets/indent.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import 'dialogs/transfer_order.dart';
import 'dialogs/update_order.dart';
import 'provider.dart';
import 'widgets/barrel_widget.dart';

class NewTableLayoutPage extends ConsumerStatefulWidget {
  const NewTableLayoutPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _NewTableLayoutPageState();
}

class _NewTableLayoutPageState extends ConsumerState<NewTableLayoutPage> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        ref.read(tableLayoutPageProvider.notifier).init();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var tables = ref.watch(tablesAndOrdersProvider);
    var tableSelect = ref.watch(tableLayoutPageProvider.select((value) => value.tableSelect));
    var data = tables.when(
      data: (data) => kTypeOrder == TypeOrderEnum.offline.type ? data.offline : data.online,
      error: (error, stackTrace) => null,
      loading: () => null,
    );

    var dataView = [
      ...(data?.using ?? []),
      ...(data?.notUse ?? []),
    ];

    dataView.sort(
      (a, b) => (a.name?.toLowerCase() ?? '').compareTo(b.name?.toLowerCase() ?? ''),
    );

    var smallDevice = ResponsiveBreakpoints.of(context).smallerOrEqualTo(TABLET);
    var orientation = ResponsiveBreakpoints.of(context).orientation;
    var padding = MediaQuery.of(context).viewPadding;
    // double scale = 1.0;
    // if (smallDevice) {
    //   scale = 0.7;
    // }
    bool onlyTablesInUse = ((data?.using ?? []).toSet()).containsAll(tableSelect);
    var ids = tableSelect.map((e) => e.id).toSet();
    OrderModel? orderSelect = onlyTablesInUse
        ? (data?.userUsing ?? [])
            .firstWhereOrNull((e) => e.getTableIds.toSet().containsAll(ids) && e.isRestore == 0)
        : null;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (smallDevice) Gap(padding.top),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                IconButton(
                    onPressed: () => pop(context), icon: const Icon(Icons.arrow_back_rounded)),
                Expanded(
                  child: Text(
                    'Danh sách bàn',
                    style: AppTextStyle.bold(
                      rawFontSize: AppConfig.defaultRawTextSize + 1.0,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey.shade300),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.04),
                        blurRadius: 8,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Row(
                      children: TypeOrderEnum.values.map((e) {
                    final selected = e.type == kTypeOrder;
                    return GestureDetector(
                      onTap: () {},
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: selected ? AppColors.mainColor : Colors.transparent,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          e.title,
                          textAlign: TextAlign.center,
                          style: AppTextStyle.bold(
                            color: selected ? Colors.white : null,
                          ),
                        ),
                      ),
                    );
                  }).toList()),
                ),
              ],
            ),
          ),
          const Divider(height: 8),
          const Row(
            children: [
              Expanded(child: FloorTabView()),
              StatusIndicator(),
            ],
          ),
          const Divider(height: 8),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 50),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: (smallDevice && orientation == Orientation.portrait)
                    ? 2
                    : (smallDevice ? 4 : 6),
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 1.0,
              ),
              itemCount: dataView.length,
              itemBuilder: (_, i) {
                var item = dataView[i];
                bool serving = (data?.using ?? []).contains(item);
                bool selected = tableSelect.contains(item);
                return TableCard(
                  item: item,
                  serving: serving,
                  selected: selected,
                  onLongPress: () {
                    ref.read(tableLayoutPageProvider.notifier).onChangeTableSelect(
                          item,
                          select: !selected,
                          serving: serving,
                          using: data?.using ?? [],
                          orders: data?.userUsing ?? [],
                        );
                  },
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      useSafeArea: true,
                      backgroundColor: Colors.white,
                      builder: (context) {
                        return FractionallySizedBox(
                          heightFactor: 0.9,
                          child: TestMenu(),
                        );
                      },
                    );
                    showLogs(item, flags: 'item');
                  },
                );
              },
            ),
          ),
          // if (tableSelect.isNotEmpty) ...[
          //   if (((data?.notUse ?? []).toSet()).containsAll(tableSelect)) ...[
          //     const Divider(height: 8),
          //     const Gap(4),
          //     Align(
          //       alignment: Alignment.center,
          //       child: AppButton(
          //         icon: Icons.add_circle_outline_rounded,
          //         textAction: 'Mở bàn ${tableSelect.map((e) => e.name).join(', ')}',
          //         widthFactor: 0.5,
          //         onPressed: () async {
          //           await showConfirmAction(
          //             context,
          //             message: 'Xác nhận mở bàn ${tableSelect.map((e) => e.name).join(', ')}',
          //             action: () async {
          //               var result = await ref.read(homeProvider.notifier).createNewOrder(
          //                     ids.toList(),
          //                     tableName: tableSelect.map((e) => e.name).join(', '),
          //                     reservation: null,
          //                     typeOrder: kTypeOrder,
          //                   );
          //               if (result.last == null) {
          //                 ref.refresh(tablesAndOrdersProvider);
          //                 if (kTypeOrder == AppConfig.orderOfflineValue) {
          //                   ref.refresh(orderToOnlineProvider);
          //                 }
          //               }
          //             },
          //           );
          //         },
          //       ),
          //     ),
          //     const Gap(8),
          //   ],
          //   if (orderSelect != null) ...[
          //     const Divider(height: 8),
          //     const Gap(8),
          //     Align(
          //       alignment: Alignment.center,
          //       child: Row(
          //         mainAxisAlignment: MainAxisAlignment.center,
          //         children: [
          //           const Text('Các bàn đang chọn hiện đang trong'),
          //           const Gap(8),
          //           Container(
          //             padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          //             decoration: BoxDecoration(
          //               color: Colors.blue.withOpacity(0.2),
          //               borderRadius: AppConfig.borderRadiusMain,
          //             ),
          //             child: Text(
          //               'ĐƠN BÀN ${orderSelect.getNameView()}',
          //               style: AppTextStyle.bold(
          //                 rawFontSize: AppConfig.defaultRawTextSize + 0.5,
          //                 color: Colors.blue,
          //               ),
          //             ),
          //           ),
          //         ],
          //       ),
          //     ),
          //     const Gap(8),
          //     Row(
          //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //       children: [
          //         AppButton(
          //           icon: Icons.edit,
          //           textAction: S.current.updateOrderCurrent,
          //           color: AppColors.secondColor,
          //           disabledColor: Colors.grey.shade300,
          //           onPressed: () async {
          //             await showDialog(
          //               context: context,
          //               useRootNavigator: false,
          //               barrierDismissible: false,
          //               builder: (context) => PopScope(
          //                 canPop: false,
          //                 child: UpdateOrderDialog(order: orderSelect),
          //               ),
          //             );
          //           },
          //         ),
          //         AppButton(
          //           icon: Icons.transfer_within_a_station,
          //           textAction: S.current.transferOrderCurrent,
          //           color: AppColors.secondColor,
          //           disabledColor: Colors.grey.shade300,
          //           onPressed: () async {
          //             await showDialog(
          //               context: context,
          //               useRootNavigator: false,
          //               barrierDismissible: false,
          //               builder: (context) => PopScope(
          //                 canPop: false,
          //                 child: TransferOrderDialog(order: orderSelect),
          //               ),
          //             );
          //           },
          //         ),
          //         AppButton(
          //           icon: Icons.delete,
          //           textAction: S.current.cancelOrderCurrent,
          //           disabledColor: Colors.grey.shade300,
          //           onPressed: () {
          //             _cancelOrder(ref: ref, context: context, order: orderSelect);
          //           },
          //         ),
          //       ],
          //     ),
          //     const Gap(8),
          //   ],
          // ],
        ],
      ),
    );
  }
}

class TestMenu extends ConsumerStatefulWidget {
  const TestMenu({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TestMenuState();
}

class _TestMenuState extends ConsumerState<TestMenu> {
  late AutoScrollController categoryScrollController;
  TreeViewController? categoryController;

  @override
  void initState() {
    super.initState();
    categoryScrollController = AutoScrollController();
  }

  @override
  void dispose() {
    categoryScrollController.dispose();
    categoryController = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var categoryData = ref.watch(categoryByOrderProvider(kTypeOrder));
    var categorySelect = ref.watch(menuProvider.select(
      (value) => value.categorySelect,
    ));
    var subCategorySelect = ref.watch(menuProvider.select(
      (value) => value.subCategorySelect,
    ));
    return Row(
      children: [
        const Gap(12),
        SizedBox(
          width: 250,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Gap(16),
              Text(
                'Danh mục',
                style: AppTextStyle.bold(
                  color: Colors.grey,
                  rawFontSize: AppConfig.defaultRawTextSize + 1.0,
                ),
              ),
              Expanded(
                child: categoryData.when(
                  data: (data) {
                    TreeNode<dynamic>? expandNodeTree;
                    final tree = TreeNode.root()
                      ..addAll(data.data.map(
                        (e) {
                          var node = TreeNode(key: e.id?.toString(), data: e);
                          if (e.children?.isNotEmpty ?? false) {
                            node.addAll((e.children ?? [])
                                .map((i) => TreeNode(key: i.id.toString(), data: i)));
                          }
                          if (categorySelect?.id == node.data?.id ||
                              (e.children ?? [])
                                      .firstWhereOrNull((i) => i.id == subCategorySelect?.id) !=
                                  null) {
                            expandNodeTree = node;
                          }
                          return node;
                        },
                      ).toList());

                    return TreeView.simple(
                      tree: tree,
                      showRootNode: false,
                      expansionIndicatorBuilder: (context, node) => ChevronIndicator.rightDown(
                        tree: node,
                        color: Colors.blue[700],
                        padding: const EdgeInsets.all(8),
                      ),
                      scrollController: categoryScrollController,
                      indentation: const Indentation(style: IndentStyle.roundJoint),
                      onItemTap: (item) {},
                      onTreeReady: (controller) {
                        categoryController = controller;
                        if (expandNodeTree != null) controller.expandNode(expandNodeTree!);
                        if (expandNodeTree != null) {
                          var data = expandNodeTree?.data;
                          controller.scrollToItem(expandNodeTree!);
                          // if (expandNodeTree!.isLeaf) {
                          //   controller.scrollToItem(expandNodeTree!);
                          // } else {
                          //   // var node = expandNodeTree?.data
                          // }
                        }
                      },
                      builder: (context, node) {
                        bool selected =
                            [categorySelect?.id, subCategorySelect?.id].contains(node.data?.id);
                        var text = '';
                        try {
                          text = node.data?.title ?? '';
                        } catch (ex) {
                          //
                        }
                        return Container(
                          margin: EdgeInsets.only(bottom: 12),
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                          decoration: BoxDecoration(
                            color: selected ? AppColors.mainColor : null,
                            borderRadius: AppConfig.borderRadiusMain,
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.restaurant_rounded,
                                size: 20,
                                color: selected ? AppColors.white : null,
                              ),
                              const Gap(12),
                              Expanded(
                                child: Text(
                                  text,
                                  style: AppTextStyle.bold(
                                    rawFontSize: AppConfig.defaultRawTextSize,
                                    color: selected ? AppColors.white : null,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );

                    return ScrollablePositionedList.separated(
                      itemCount: data.data.length,
                      itemBuilder: (context, index) {
                        bool selected = index % 3 == 0;
                        return Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                          decoration: BoxDecoration(
                            color: selected ? AppColors.mainColor : null,
                            borderRadius: AppConfig.borderRadiusMain,
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.restaurant_rounded,
                                size: 20,
                                color: selected ? AppColors.white : null,
                              ),
                              const Gap(12),
                              Text(
                                data.data[index].title,
                                style: AppTextStyle.bold(
                                  rawFontSize: AppConfig.defaultRawTextSize,
                                  color: selected ? AppColors.white : null,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                      separatorBuilder: (context, index) => const Gap(12),
                    );
                  },
                  error: (error, stackTrace) {
                    return Container();
                  },
                  loading: () {
                    return Container();
                  },
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Column(
            children: [
              // Expanded(
              //   child: categoryData.when(
              //     data: (data) {
              //       return Column(
              //         children: [
              //           const _Header(),
              //           Expanded(
              //             child: Row(
              //               children: [
              //                 /// LEFT
              //                 Expanded(
              //                   flex: 2,
              //                   child: Container(
              //                     padding: const EdgeInsets.all(16),
              //                     child: const _MenuList(),
              //                   ),
              //                 ),

              //                 /// RIGHT
              //                 Container(
              //                   width: 360,
              //                   padding: const EdgeInsets.all(16),
              //                   decoration: const BoxDecoration(
              //                     border: Border(left: BorderSide(color: Color(0xffe5e7eb))),
              //                     color: Colors.white,
              //                   ),
              //                   child: const _OrderPanel(),
              //                 )
              //               ],
              //             ),
              //           )
              //         ],
              //       );
              //     },
              //     error: (error, stackTrace) {
              //       return Container();
              //     },
              //     loading: () {
              //       return Container();
              //     },
              //   ),
              // ),
            ],
          ),
        ),
      ],
    );
  }
}

class Test extends ConsumerWidget {
  const Test({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var categoryData = ref.watch(categoryByOrderProvider(kTypeOrder));
    var categorySelect = ref.watch(menuProvider.select(
      (value) => value.categorySelect,
    ));
    return Row(
      children: [
        const Gap(12),
        SizedBox(
          width: 250,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Gap(16),
              Text(
                'Danh mục',
                style: AppTextStyle.bold(
                  color: Colors.grey,
                  rawFontSize: AppConfig.defaultRawTextSize + 1.0,
                ),
              ),
              Expanded(
                child: categoryData.when(
                  data: (data) {
                    final tree = TreeNode.root()
                      ..addAll(data.data.map(
                        (e) {
                          var node = TreeNode(key: e.id?.toString(), data: e);
                          if (e.children?.isNotEmpty ?? false) {
                            node.addAll((e.children ?? [])
                                .map((i) => TreeNode(key: i.id.toString(), data: i)));
                          }
                          return node;
                        },
                      ).toList());
                    return TreeView.simple(
                      tree: tree,
                      showRootNode: false,
                      expansionIndicatorBuilder: (context, node) => ChevronIndicator.rightDown(
                        tree: node,
                        color: Colors.blue[700],
                        padding: const EdgeInsets.all(8),
                      ),
                      indentation: const Indentation(style: IndentStyle.roundJoint),
                      onItemTap: (item) {},
                      onTreeReady: (controller) {
                        // _controller = controller;
                        // if (expandChildrenOnReady) controller.expandAllChildren(sampleTree);
                      },
                      builder: (context, node) {
                        bool selected = categorySelect?.id == node.data?.id;
                        var text = '';
                        try {
                          text = node.data?.title ?? '';
                        } catch (ex) {
                          //
                        }
                        return Container(
                          margin: EdgeInsets.only(bottom: 12),
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                          decoration: BoxDecoration(
                            color: selected ? AppColors.mainColor : null,
                            borderRadius: AppConfig.borderRadiusMain,
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.restaurant_rounded,
                                size: 20,
                                color: selected ? AppColors.white : null,
                              ),
                              const Gap(12),
                              Expanded(
                                child: Text(
                                  text,
                                  style: AppTextStyle.bold(
                                    rawFontSize: AppConfig.defaultRawTextSize,
                                    color: selected ? AppColors.white : null,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );

                    return ScrollablePositionedList.separated(
                      itemCount: data.data.length,
                      itemBuilder: (context, index) {
                        bool selected = index % 3 == 0;
                        return Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                          decoration: BoxDecoration(
                            color: selected ? AppColors.mainColor : null,
                            borderRadius: AppConfig.borderRadiusMain,
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.restaurant_rounded,
                                size: 20,
                                color: selected ? AppColors.white : null,
                              ),
                              const Gap(12),
                              Text(
                                data.data[index].title,
                                style: AppTextStyle.bold(
                                  rawFontSize: AppConfig.defaultRawTextSize,
                                  color: selected ? AppColors.white : null,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                      separatorBuilder: (context, index) => const Gap(12),
                    );
                  },
                  error: (error, stackTrace) {
                    return Container();
                  },
                  loading: () {
                    return Container();
                  },
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Column(
            children: [
              Expanded(
                child: categoryData.when(
                  data: (data) {
                    return Column(
                      children: [
                        const _Header(),
                        Expanded(
                          child: Row(
                            children: [
                              /// LEFT
                              Expanded(
                                flex: 2,
                                child: Container(
                                  padding: const EdgeInsets.all(16),
                                  child: const _MenuList(),
                                ),
                              ),

                              /// RIGHT
                              Container(
                                width: 360,
                                padding: const EdgeInsets.all(16),
                                decoration: const BoxDecoration(
                                  border: Border(left: BorderSide(color: Color(0xffe5e7eb))),
                                  color: Colors.white,
                                ),
                                child: const _OrderPanel(),
                              )
                            ],
                          ),
                        )
                      ],
                    );
                  },
                  error: (error, stackTrace) {
                    return Container();
                  },
                  loading: () {
                    return Container();
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff5f6f8),
      body: SafeArea(
        child: Column(
          children: [
            const _Header(),
            Expanded(
              child: Row(
                children: [
                  /// LEFT
                  Expanded(
                    flex: 2,
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      child: const _MenuList(),
                    ),
                  ),

                  /// RIGHT
                  Container(
                    width: 360,
                    padding: const EdgeInsets.all(16),
                    decoration: const BoxDecoration(
                      border: Border(left: BorderSide(color: Color(0xffe5e7eb))),
                      color: Colors.white,
                    ),
                    child: const _OrderPanel(),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: Color(0xffe5e7eb))),
      ),
      child: Row(
        children: [
          const Icon(Icons.arrow_back),
          const SizedBox(width: 12),
          const Text(
            "Select Menu ",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const Spacer(),
          IconButton(onPressed: () {}, icon: const Icon(Icons.close))
        ],
      ),
    );
  }
}

class _MenuList extends StatelessWidget {
  const _MenuList();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        /// Search
        TextField(
          decoration: InputDecoration(
            hintText: "Search Item Name",
            prefixIcon: const Icon(Icons.search),
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
          ),
        ),

        const SizedBox(height: 12),

        /// Category chips
        SizedBox(
          height: 40,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: const [
              _Chip("All", selected: true),
              _Chip("Chef Recommendation"),
              _Chip("Soup"),
              _Chip("Noodle"),
              _Chip("Rice"),
              _Chip("Dessert"),
            ],
          ),
        ),

        const SizedBox(height: 16),

        /// Grid
        Expanded(
          child: GridView.builder(
            itemCount: 8,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisExtent: 210,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
            ),
            itemBuilder: (_, i) => const _MenuCard(),
          ),
        )
      ],
    );
  }
}

class _Chip extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback? onTap;
  final int? count;

  const _Chip(
    this.label, {
    this.selected = false,
    this.onTap,
    this.count,
  });

  @override
  Widget build(BuildContext context) {
    final bg = selected ? const Color(0xffe7efff) : Colors.white;
    final border = selected ? const Color(0xff3b82f6) : const Color(0xffe5e7eb);
    final text = selected ? const Color(0xff2563eb) : Colors.black87;

    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: InkWell(
        borderRadius: BorderRadius.circular(999),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(
            color: bg,
            borderRadius: BorderRadius.circular(999),
            border: Border.all(color: border),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: text,
                ),
              ),
              if (count != null) ...[
                const SizedBox(width: 6),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: selected ? const Color(0xff3b82f6) : const Color(0xfff1f5f9),
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: Text(
                    "$count",
                    style: TextStyle(
                      fontSize: 11,
                      color: selected ? Colors.white : Colors.black54,
                    ),
                  ),
                )
              ]
            ],
          ),
        ),
      ),
    );
  }
}

class _MenuCard extends StatelessWidget {
  const _MenuCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xffe5e7eb)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// IMAGE
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(14)),
            child: Stack(
              children: [
                Image.network(
                  "https://picsum.photos/300",
                  height: 100,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  left: 8,
                  top: 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      "Available",
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ),
                )
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Butter Chicken",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                const Text(
                  "Creamy butter chicken with spices",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Text(
                      "\$12.64",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                    const Spacer(),
                    OutlinedButton(
                      onPressed: () {},
                      child: const Text("Add to Cart"),
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _OrderPanel extends StatelessWidget {
  const _OrderPanel();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            const Text(
              "Order Details",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const Spacer(),
            TextButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.delete_outline),
              label: const Text("Reset Order"),
            )
          ],
        ),
        const Spacer(),
        const Icon(Icons.shopping_cart_outlined, size: 48, color: Colors.grey),
        const SizedBox(height: 8),
        const Text("No order found"),
        const Spacer(),
        const _SummaryRow("Sub Total", "US\$0"),
        const _SummaryRow("Tax 12%", "US\$0"),
        const Divider(),
        const _SummaryRow("Total Payment", "US\$0", bold: true),
        const SizedBox(height: 12),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {},
            child: const Text("Continue"),
          ),
        )
      ],
    );
  }
}

class _SummaryRow extends StatelessWidget {
  final String label;
  final String value;
  final bool bold;

  const _SummaryRow(this.label, this.value, {this.bold = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Text(label),
          const Spacer(),
          Text(
            value,
            style: TextStyle(fontWeight: bold ? FontWeight.bold : null),
          )
        ],
      ),
    );
  }
}

void _cancelOrder({
  required WidgetRef ref,
  required BuildContext context,
  OrderModel? order,
}) async {
  if (order == null) {
    return;
  }
  await showConfirmAction(context,
      title: "${S.current.confirm} ${S.current.cancelOrder.toUpperCase()}",
      message: '${S.current.messageCancelOrder}'
          '${order.reservationCrmId != null ? '\n\nĐơn bàn hiện đang được gán với lịch đặt bàn. '
              'Việc huỷ đơn bàn sẽ đồng thời chuyển lịch đặt sang trạng thái "Huỷ lịch".'
              '\nNếu không muốn huỷ lịch, vui lòng cập nhật lịch đặt bàn trước khi huỷ bàn.' : ''}',
      action: () async {
    var reservation =
        order.reservationCrmId == null ? null : ReservationModel(id: order.reservationCrmId);
    var result = await ref.read(homeProvider.notifier).updateOrder(
      [],
      order,
      cancel: true,
      reservation: reservation,
    );
    if (result.error == null) {
      if (context.mounted) {
        showDoneSnackBar(context: context, message: S.current.cancelOrderSuccess);
      }
      ref.refresh(tablesAndOrdersProvider);
      if (reservation != null) {
        ref.read(homeProvider.notifier).updateReservationStatus(
          reservation.id,
          ReservationStatusEnum.cancel,
          [],
        );
      }
    } else {
      showMessageDialog(context, message: result.error ?? '');
    }
  });
}
