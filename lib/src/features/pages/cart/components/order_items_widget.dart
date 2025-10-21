import 'package:aladdin_franchise/src/configs/app.dart';
import 'package:aladdin_franchise/src/configs/color.dart';
import 'package:aladdin_franchise/src/configs/text_style.dart';
import 'package:aladdin_franchise/src/features/dialogs/message.dart';
import 'package:aladdin_franchise/src/features/pages/home/components/order/locked_order_widget.dart';
import 'package:aladdin_franchise/src/features/pages/home/components/order/order_detail.dart';
import 'package:aladdin_franchise/src/features/pages/home/components/order/order_tab_widget.dart';
import 'package:aladdin_franchise/src/features/pages/home/components/order/order_item_list_widget.dart';

import 'package:aladdin_franchise/src/features/pages/home/provider.dart';
import 'package:aladdin_franchise/src/features/pages/home/state.dart';
import 'package:aladdin_franchise/src/features/widgets/gap.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'preview_price_widget.dart';
import 'product_checkout_action.dart';

class OrderItemsWidget extends ConsumerWidget {
  const OrderItemsWidget({
    super.key,
    this.priceSidebar = false,
    this.textProcessOrderItem,
  });
  final bool priceSidebar;

  final String? textProcessOrderItem;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var orderTabSelect = ref.watch(homeProvider.select((value) => value.orderTabSelect));

    return Row(
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
                  children: const [
                    OrderItemsSelectingWidget(),
                    OrderedItemsSelectedWidget(),
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
                      const Expanded(child: KitchenNoteWidget()),
                      Consumer(
                        builder: (mContext, ref, child) {
                          var productsSelecting =
                              ref.watch(homeProvider.select((value) => value.productsSelecting));
                          if (productsSelecting.isEmpty) {
                            return const SizedBox.shrink();
                          }
                          return InkWell(
                            onTap: () async {
                              // var locked =
                              //     ref.read(homeProvider).lockedOrder;
                              var res =
                                  await ref.read(homeProvider.notifier).addItemsToOrder(context);
                              if (res != null && context.mounted) {
                                showMessageDialog(context, message: res);
                                return;
                              }
                            },
                            borderRadius: AppConfig.borderRadiusSecond,
                            child: Container(
                              margin: const EdgeInsets.only(left: 4),
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                              decoration: BoxDecoration(
                                  color: AppColors.mainColor,
                                  borderRadius: AppConfig.borderRadiusSecond),
                              child: Text(
                                textProcessOrderItem ?? 'Gọi món\nngay',
                                style:
                                    AppTextStyle.regular(rawFontSize: 13, color: AppColors.white),
                                textAlign: TextAlign.center,
                              ),
                            ),
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
                    'Hóa đơn',
                    style: AppTextStyle.regular(),
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
    );
  }
}
