import 'package:aladdin_franchise/generated/l10n.dart';
import 'package:aladdin_franchise/src/configs/text_style.dart';
import 'package:aladdin_franchise/src/features/pages/cart/provider.dart';
import 'package:aladdin_franchise/src/features/pages/cart/dialog/confirm_add_items.dart';
import 'package:aladdin_franchise/src/features/pages/home/components/order/locked_order_widget.dart';
import 'package:aladdin_franchise/src/features/pages/home/components/order/order_tab_widget.dart';
import 'package:aladdin_franchise/src/features/pages/home/components/order/order_item_list_widget.dart';

import 'package:aladdin_franchise/src/features/pages/home/provider.dart';
import 'package:aladdin_franchise/src/features/pages/home/state.dart';
import 'package:aladdin_franchise/src/features/widgets/button/app_buton.dart';
import 'package:aladdin_franchise/src/features/widgets/gap.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import 'preview_price_widget.dart';
import 'product_checkout_action.dart';

class OrderItemsWidget extends ConsumerWidget {
  const OrderItemsWidget({
    super.key,
    this.priceSidebar = false,
    this.textProcessOrderItem,
    this.itemScrollController,
    this.itemPositionsListener,
    this.itemSelectingScrollController,
    this.itemSelectingPositionsListener,
  });
  final bool priceSidebar;

  final String? textProcessOrderItem;
  final ItemScrollController? itemScrollController;
  final ItemPositionsListener? itemPositionsListener;
  final ItemScrollController? itemSelectingScrollController;
  final ItemPositionsListener? itemSelectingPositionsListener;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var orderTabSelect = ref.watch(homeProvider.select((value) => value.orderTabSelect));

    return Container(
      color: Colors.white,
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Column(
              children: [
                const OrderTabWidget(),
                const LockedOrderWidget(),
                Expanded(
                  child: IndexedStack(
                    index: orderTabSelect.index,
                    children: [
                      OrderItemsSelectingWidget(
                        itemScrollController: itemSelectingScrollController,
                        itemPositionsListener: itemSelectingPositionsListener,
                      ),
                      OrderedItemsSelectedWidget(
                        itemScrollController: itemScrollController,
                        itemPositionsListener: itemPositionsListener,
                      ),
                    ],
                  ),
                ),
                if (orderTabSelect == OrderTabEnum.ordered) ...[
                  const Gap(8),
                  const ProductCheckoutActionWidget(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                  ),
                ] else ...[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Row(
                      children: [
                        const Spacer(),
                        Consumer(
                          builder: (mContext, ref, child) {
                            var productsSelecting = ref
                                .watch(cartPageProvider.select((value) => value.productsSelecting));
                            if (productsSelecting.isEmpty) {
                              return const SizedBox.shrink();
                            }

                            return AppButton(
                              textAction: S.of(context).send_to_the_kitchen,
                              onPressed: () async {
                                await showDialog(
                                  context: context,
                                  builder: (context) {
                                    return const AddItemOrderDialog();
                                  },
                                );
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
                if (!priceSidebar) const PreviewPriceWidget(),
                const Gap(4),
              ],
            ),
          ),
          if (priceSidebar) ...[
            const VerticalDivider(width: 1),
            Expanded(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    child: Text(
                      S.of(context).invoice,
                      style: AppTextStyle.bold(),
                    ),
                  ),
                  const Expanded(
                    child: Center(
                      child: PreviewPriceWidget(
                        backgroundColor: Colors.transparent,
                        padding: EdgeInsets.zero,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}
