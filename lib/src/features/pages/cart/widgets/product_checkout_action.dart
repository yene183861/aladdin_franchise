import 'package:aladdin_franchise/generated/l10n.dart';
import 'package:aladdin_franchise/src/configs/app.dart';
import 'package:aladdin_franchise/src/configs/color.dart';
import 'package:aladdin_franchise/src/configs/text_style.dart';
import 'package:aladdin_franchise/src/features/pages/checkout/dialog/cancel_product_checkout.dart';
import 'package:aladdin_franchise/src/features/pages/checkout/provider.dart';

import 'package:aladdin_franchise/src/features/pages/home/provider.dart';
import 'package:aladdin_franchise/src/features/widgets/app_icon_widget.dart';
import 'package:aladdin_franchise/src/features/widgets/button/app_buton.dart';

import 'package:aladdin_franchise/src/features/widgets/gap.dart';
import 'package:aladdin_franchise/src/models/order_history.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

void showHistoryOrderItemDialog(BuildContext context) async {
  await showDialog(
    context: context,
    builder: (context) {
      return FractionallySizedBox(
        widthFactor: 0.8,
        child: Dialog(
            child: Column(
          children: [
            const Gap(20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  const Icon(
                    Icons.history,
                    color: AppColors.mainColor,
                    size: 20,
                  ),
                  const Gap(8),
                  Text(
                    'Lịch sử gọi - hủy đồ',
                    style: AppTextStyle.bold(
                      rawFontSize: AppConfig.defaultRawTextSize + 1.0,
                      color: AppColors.mainColor,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),
            Flexible(
              child: Consumer(builder: (context, ref, child) {
                var orderHistoryData = ref
                    .watch(homeProvider.select((value) => value.orderHistory));
                var dataView = List<OrderHistory>.from(orderHistoryData);
                dataView.sort((a, b) => b.createdAt.compareTo(a.createdAt));
                if (dataView.isEmpty) {
                  return Center(
                    child: Text(
                      'Không có dữ liệu',
                      style: AppTextStyle.regular(
                        color: Colors.grey.shade500,
                        rawFontSize: AppConfig.defaultRawTextSize - 0.5,
                      ),
                    ),
                  );
                }
                return ScrollablePositionedList.separated(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  itemBuilder: (context, index) {
                    var orderTime = dataView[index];
                    bool isCancel = orderTime.products.any((e) => e.cancel);
                    return Card(
                      elevation: 0,
                      shadowColor: Colors.white,
                      color: Colors.grey.shade50,
                      shape: RoundedRectangleBorder(
                        borderRadius: AppConfig.borderRadiusMain,
                      ),
                      child: Column(
                        children: [
                          ListTile(
                            leading:
                                const ResponsiveIconWidget(iconData: Icons.tag),
                            tileColor: isCancel
                                ? Colors.red.shade50
                                : Colors.blueGrey.shade50,
                            title: Text(
                              "${S.current.turn} ${orderTime.timesOrder} ${isCancel ? " - ${S.current.cancelDish}" : ""}",
                              style: AppTextStyle.medium(),
                            ),
                            subtitle: orderTime.notes.isEmpty
                                ? null
                                : Text(
                                    orderTime.notes,
                                    style: AppTextStyle.medium(),
                                  ),
                            trailing: Text(
                              appConfig.dateFormatHhMmSsDDMMYYYY
                                  .format(orderTime.createdAt),
                              style: AppTextStyle.regular(
                                  rawFontSize:
                                      AppConfig.defaultRawTextSize - 1.0),
                            ),
                          ),
                          ...orderTime.products.map(
                            (e) => Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: ListTile(
                                      title: Text(
                                        e.getNameView(),
                                        style: AppTextStyle.medium(),
                                      ),
                                      subtitle: e.notes.isEmpty
                                          ? null
                                          : Text(
                                              e.notes,
                                              style: AppTextStyle.regular(),
                                            ),
                                      trailing: Text(
                                        "${S.current.quantityCut}: ${e.quantity}",
                                        style: AppTextStyle.regular(),
                                      ),
                                    ),
                                  ),
                                  AppConfig.useKds
                                      ? Expanded(
                                          flex: 1,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Text(
                                                e.cancel
                                                    ? S.current.cancel
                                                    : appConfig.getNameByStatus(
                                                        e.status),
                                                style: AppTextStyle.medium(),
                                              ),
                                              const Gap(12),
                                            ],
                                          ),
                                        )
                                      : Container(),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => const Gap(4),
                  itemCount: dataView.length,
                );
              }),
            ),
          ],
        )),
      );
    },
  );
}

class ProductCheckoutActionWidget extends ConsumerWidget {
  const ProductCheckoutActionWidget({
    super.key,
    this.padding,
  });
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var productCheckout = ref
        .watch(checkoutPageProvider.select((value) => value.productsCheckout));

    var orderHistoryData =
        ref.watch(homeProvider.select((value) => value.orderHistory));
    if (orderHistoryData.isEmpty) return const SizedBox.shrink();
    return Container(
      color: Colors.white,
      padding: padding ?? const EdgeInsets.all(8.0),
      child: Row(children: [
        AppButton(
          icon: Icons.history,
          padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
          textAction: 'Lịch sử gọi - hủy',
          color: Colors.orange,
          onPressed: () async {
            showHistoryOrderItemDialog(context);
          },
        ),
        const Spacer(),
        if (productCheckout.isNotEmpty) ...[
          const Gap(12),
          AppButton(
            textAction: 'Hủy món',
            padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
            onPressed: () async {
              await showDialog(
                context: context,
                builder: (context) {
                  return const CancelProductCheckoutDialog();
                },
              );
            },
          ),
          // InkWell(
          //   onTap: () async {
          //     await showDialog(
          //       context: context,
          //       builder: (context) {
          //         return CancelProductCheckoutDialog();
          //       },
          //     );
          //     // var state = ref.read(homeProvider);
          //     // if (state.displayOrderHistory) return;
          //     // await onPressedCancelItem(
          //     //   context,
          //     //   ref,
          //     //   productCancel: state.productCheckout,
          //     // );
          //   },
          //   borderRadius: AppConfig.borderRadiusMain,
          //   child: Container(
          //     padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          //     decoration: BoxDecoration(
          //       color: AppColors.mainColor,
          //       borderRadius: AppConfig.borderRadiusMain,
          //     ),
          //     child: Text(
          //       'Hủy món',
          //       style: AppTextStyle.regular(
          //         rawFontSize: AppConfig.defaultRawTextSize - 1.5,
          //         color: Colors.white,
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ]),
    );
  }
}
