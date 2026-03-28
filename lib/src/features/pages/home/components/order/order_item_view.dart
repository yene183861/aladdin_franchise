import 'package:aladdin_franchise/src/configs/color.dart';
import 'package:aladdin_franchise/src/configs/dev_config.dart';
import 'package:aladdin_franchise/src/configs/text_style.dart';
import 'package:aladdin_franchise/src/features/pages/cart/provider.dart';
import 'package:aladdin_franchise/src/features/pages/cart/view.dart';
import 'package:aladdin_franchise/src/features/pages/cart/widgets/price_summary.dart';
import 'package:aladdin_franchise/src/features/pages/checkout/provider.dart';
import 'package:aladdin_franchise/src/features/pages/checkout/view.dart';
import 'package:aladdin_franchise/src/features/pages/checkout/widgets/checkout_summary.dart';
import 'package:aladdin_franchise/src/features/pages/home/components/order/button/send_to_kitchen_btn.dart';
import 'package:aladdin_franchise/src/features/pages/home/provider.dart';
import 'package:aladdin_franchise/src/features/pages/home/state.dart';
import 'package:aladdin_franchise/src/features/widgets/gap.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'button/cancel_product_checkout_btn.dart';
import 'button/order_history_btn.dart';

class OrderItemsView extends ConsumerWidget {
  const OrderItemsView({super.key, this.widthSection});
  final double? widthSection;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var orderTabSelect = ref.watch(homeProvider.select((value) => value.orderTabSelect));
    var cartNotifier = ref.read(cartPageProvider.notifier);
    var checkoutNotifier = ref.read(checkoutProvider.notifier);
    return Column(
      children: [
        const _TabSection(),
        Expanded(
          child: Stack(
            children: [
              IndexedStack(
                index: orderTabSelect.index,
                children: [
                  CartItemListView(
                    itemScrollController: cartNotifier.itemScrollController,
                    itemPositionsListener: cartNotifier.itemPositionsListener,
                  ),
                  CheckoutItemListView(
                    itemScrollController: checkoutNotifier.itemScrollController,
                    itemPositionsListener: checkoutNotifier.itemPositionsListener,
                  ),
                ],
              ),
              if (!DevConfig.newUI)
                Positioned(
                  bottom: 10,
                  right: 10,
                  child: Consumer(builder: (context, ref, child) {
                    if (orderTabSelect == OrderTabEnum.ordering) {
                      var productsSelecting =
                          ref.watch(cartPageProvider.select((value) => value.productsSelecting));
                      if (productsSelecting.isEmpty) {
                        return const SizedBox.shrink();
                      }
                      return const AddItemToOrderBtn();
                    } else {
                      var productCheckout =
                          ref.watch(checkoutProvider.select((value) => value.productCheckout));
                      var orderHistoryData =
                          ref.watch(checkoutProvider.select((value) => value.orderHistory));
                      if (orderHistoryData.isEmpty && productCheckout.isEmpty) {
                        return const SizedBox.shrink();
                      }
                      return Container(
                        width: widthSection,
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Row(children: [
                          if (orderHistoryData.isNotEmpty) const OrderHistoryBtn(),
                          const Spacer(),
                          if (productCheckout.isNotEmpty) ...[
                            const Gap(8),
                            const CancelProductCheckoutBtn(),
                          ],
                        ]),
                      );
                    }
                  }),
                ),
            ],
          ),
        ),
        if (orderTabSelect == OrderTabEnum.ordered) ...[
          const CheckoutSummary(),
        ] else ...[
          const CartPriceSummary(),
        ],
        const Gap(10),
      ],
    );
  }
}

class _TabSection extends ConsumerWidget {
  const _TabSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var orderTabs = ref.watch(homeProvider.select((value) => value.orderTabs));
    var orderTabSelect = ref.watch(homeProvider.select((value) => value.orderTabSelect));
    if (orderTabs.length < 2) return const SizedBox.shrink();
    var productsSelecting = ref.watch(cartPageProvider.select((value) => value.productsSelecting));
    var productCheckout = ref.watch(checkoutProvider.select((value) => value.productCheckout));
    return Row(
      children: orderTabs.map((e) {
        int count = 0;
        switch (e) {
          case OrderTabEnum.ordering:
            count = productsSelecting.length;
            break;
          case OrderTabEnum.ordered:
            count = productCheckout.length;
            break;
          default:
        }
        return Expanded(
          child: InkWell(
            onTap: () {
              ref.read(homeProvider.notifier).onChangeOrderTabSelect(e);
            },
            child: _TabItem(
              value: e,
              selected: e == orderTabSelect,
              count: count,
            ),
          ),
        );
      }).toList(),
    );
  }
}

class _TabItem extends ConsumerWidget {
  const _TabItem({required this.value, this.selected = false, this.count = 0});
  final OrderTabEnum value;
  final bool selected;
  final int count;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool newUI = DevConfig.newUI;

    Color? bgColor = selected ? AppColors.secondColor : Colors.grey.shade200;
    Color? textColor = selected ? Colors.white : null;
    Color loadingIconColor = Colors.blue;

    var title = '${value.title} ($count)';
    if (newUI) {
      title = title.toUpperCase();
      bgColor = null;
      textColor = selected ? AppColors.mainColor : Colors.grey;
    }
    return Column(
      children: [
        Container(
          width: double.maxFinite,
          color: bgColor,
          padding: const EdgeInsets.all(12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                child: Text(
                  title,
                  style: AppTextStyle.bold(color: textColor),
                  textAlign: TextAlign.center,
                ),
              ),
              if (value == OrderTabEnum.ordered)
                Consumer(
                  builder: (context, ref, child) {
                    var pcState =
                        ref.watch(checkoutProvider.select((value) => value.productCheckoutState));

                    switch (pcState.status) {
                      case PageCommonState.loading:
                        return Padding(
                          padding: const EdgeInsets.only(left: 4),
                          child: CupertinoActivityIndicator(
                            color: loadingIconColor,
                            radius: 8,
                          ),
                        );
                      case PageCommonState.error:
                        return const Padding(
                          padding: EdgeInsets.only(left: 4),
                          child: Icon(
                            Icons.info_outlined,
                            color: AppColors.redColor,
                          ),
                        );
                      default:
                    }
                    return const SizedBox.shrink();
                  },
                )
            ],
          ),
        ),
        if (newUI)
          Stack(
            children: [
              Container(
                height: 1,
                color: Colors.grey.shade300,
              ),
              if (selected)
                Container(
                  height: 2,
                  color: AppColors.mainColor,
                )
            ],
          ),
      ],
    );
  }
}
