import 'package:aladdin_franchise/generated/l10n.dart';
import 'package:aladdin_franchise/src/configs/app.dart';
import 'package:aladdin_franchise/src/configs/color.dart';
import 'package:aladdin_franchise/src/configs/text_style.dart';
import 'package:aladdin_franchise/src/features/dialogs/message.dart';
import 'package:aladdin_franchise/src/features/pages/home/components/order/locked_order_widget.dart';
import 'package:aladdin_franchise/src/features/pages/home/components/order/order_detail.dart';
import 'package:aladdin_franchise/src/features/pages/home/components/order/order_tab_widget.dart';
import 'package:aladdin_franchise/src/features/pages/home/components/order/price_order_widget.dart';
import 'package:aladdin_franchise/src/features/pages/home/components/order/product_selecting_widget.dart';

import 'package:aladdin_franchise/src/features/pages/home/provider.dart';
import 'package:aladdin_franchise/src/features/pages/home/state.dart';
import 'package:aladdin_franchise/src/features/widgets/gap.dart';
import 'package:aladdin_franchise/src/features/widgets/price_data_bill_preview.dart';
import 'package:aladdin_franchise/src/utils/size_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'components/product_checkout_action.dart';

class CartPage extends ConsumerWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var viewPadding = MediaQuery.of(context).viewPadding;
    var orderTabSelect =
        ref.watch(homeProvider.select((value) => value.orderTabSelect));
    bool priceSidebar = !AppDeviceSizeUtil.checkPortraitOrientation(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          S.current.cart,
          style: AppTextStyle.bold(
            color: Colors.white,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(viewPadding.left, 0, 0, 0),
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
                      children: const [
                        CurrentOrderItemsWidget(orderTab: OrderTabEnum.all),
                        OrderItemsSelectingWidget(),
                        OrderedItemsWidget(),
                      ],
                    ),
                  ),
                  if (orderTabSelect == OrderTabEnum.ordered) ...[
                    const Gap(8),
                    const ProductCheckoutActionWidget(
                      padding: EdgeInsets.symmetric(horizontal: 12),
                    ),
                  ] else ...[
                    Consumer(
                      builder: (context, ref, child) {
                        var autoSave = ref.watch(homeProvider
                            .select((value) => value.autoSaveOrder));
                        var tabSelect = ref.watch(homeProvider
                            .select((value) => value.orderTabSelect));
                        var productCheckout = ref.watch(homeProvider
                            .select((value) => value.productCheckout));
                        var productsSelecting = ref.watch(homeProvider
                            .select((value) => value.productsSelecting));
                        var displayOrderHistory = ref.watch(homeProvider
                            .select((value) => value.displayOrderHistory));
                        // if (autoSave || tabSelect != OrderTabEnum.ordered) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Row(
                            children: [
                              const Expanded(child: KitchenNoteWidget()),
                              Consumer(
                                builder: (context, ref, child) {
                                  var autoSave = ref.watch(homeProvider
                                      .select((value) => value.autoSaveOrder));
                                  var productsSelecting = ref.watch(
                                      homeProvider.select(
                                          (value) => value.productsSelecting));
                                  if (autoSave || productsSelecting.isEmpty) {
                                    return const SizedBox.shrink();
                                  }
                                  return InkWell(
                                    onTap: () async {
                                      var res = await ref
                                          .read(homeProvider.notifier)
                                          .addItemsToOrder(context);
                                      if (res != null) {
                                        showMessageDialog(context,
                                            message: res);
                                        return;
                                      }
                                    },
                                    borderRadius: AppConfig.borderRadiusSecond,
                                    child: Container(
                                      margin: const EdgeInsets.only(left: 4),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16, vertical: 4),
                                      decoration: BoxDecoration(
                                          color: AppColors.mainColor,
                                          borderRadius:
                                              AppConfig.borderRadiusSecond),
                                      child: Column(
                                        children: [
                                          // const Icon(
                                          //   Icons.restaurant,
                                          //   size: 16,
                                          //   color: AppColors.white,
                                          // ),
                                          Text(
                                            'Gọi món ngay',
                                            style: AppTextStyle.regular(
                                                fontSize: 12,
                                                color: AppColors.white),
                                            textAlign: TextAlign.center,
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        );
                        // }
                        // return Padding(
                        //   padding: const EdgeInsets.symmetric(horizontal: 12)
                        //       .copyWith(top: 4),
                        //   child: const ProductCheckoutAction(),
                        // );
                      },
                    ),
                  ],
                  if (!priceSidebar) const PricePreviewWidget(),
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
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 8),
                      child: Text(
                        'Thông tin hóa đơn',
                        style: AppTextStyle.regular(),
                      ),
                    ),
                    const Expanded(
                      child: Center(
                        child: PricePreviewWidget(
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
      ),
    );
  }
}

class PricePreviewWidget extends ConsumerWidget {
  const PricePreviewWidget(
      {super.key, this.backgroundColor, this.margin, this.padding});

  final Color? backgroundColor;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var tabSelect =
        ref.watch(homeProvider.select((value) => value.orderTabSelect));
    var productsSelecting =
        ref.watch(homeProvider.select((value) => value.productsSelecting));

    var totalSelecting = productsSelecting.fold(
      0.0,
      (previousValue, e) =>
          previousValue +
          (double.tryParse(e.unitPrice) ?? 0.0) * e.numberSelecting,
    );

    return Container(
      margin: margin ?? const EdgeInsets.fromLTRB(12, 4, 12, 4),
      padding:
          padding ?? const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: backgroundColor ?? Colors.grey.shade200,
        borderRadius: BorderRadius.circular(AppConfig.sizeBorderRadiusMain),
      ),
      child: tabSelect == OrderTabEnum.ordering
          ? Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: LineInfoPaymentQRWidget(
                title: 'Tổng tiền món đang chọn',
                value: totalSelecting,
                isLoading: false,
              ),
            )
          : const OrderPriceWidget(),
    );
  }
}
