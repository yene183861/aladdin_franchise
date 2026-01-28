import 'package:aladdin_franchise/src/configs/app.dart';
import 'package:aladdin_franchise/src/configs/text_style.dart';
import 'package:aladdin_franchise/src/features/pages/checkout/provider.dart';
import 'package:aladdin_franchise/src/features/pages/home/components/menu/provider.dart';
import 'package:aladdin_franchise/src/features/pages/home/components/menu/widgets/list_product.dart';
import 'package:aladdin_franchise/src/features/pages/home/provider.dart';
import 'package:aladdin_franchise/src/features/pages/home/state.dart';
import 'package:aladdin_franchise/src/features/widgets/app_error_simple.dart';
import 'package:aladdin_franchise/src/features/widgets/app_icon_widget.dart';
import 'package:aladdin_franchise/src/features/widgets/gap.dart';
import 'package:aladdin_franchise/src/utils/app_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinbox/material.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class OrderProductCheckoutList extends ConsumerWidget {
  const OrderProductCheckoutList({
    super.key,
    this.itemScrollController,
    this.itemPositionsListener,
  });
  final ItemScrollController? itemScrollController;
  final ItemPositionsListener? itemPositionsListener;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final productCheckoutState = ref.watch(
    //     checkoutPageProvider.select((value) => value.productCheckoutState));
    final orderLineItems = ref.watch(
        checkoutPageProvider.select((value) => value.dataBill.orderLineItems));
    final dataBillState =
        ref.watch(checkoutPageProvider.select((value) => value.dataBillState));
    // var orderHistory =
    //     ref.watch(checkoutPageProvider.select((value) => value.orderHistory));
    // var productsCheckout = ref
    //     .watch(checkoutPageProvider.select((value) => value.productsCheckout));
    var products = ref.watch(menuProvider.select((value) => value.products));

    switch (dataBillState.status) {
      case PageCommonState.loading:
        return ListView.separated(
          padding: const EdgeInsets.symmetric(vertical: 12),
          itemBuilder: (context, index) {
            return const _OrderProductLoadingWidget();
          },
          separatorBuilder: (context, index) => const Divider(),
          itemCount: 4,
        );

      case PageCommonState.error:
        return Center(
          child: AppErrorSimpleWidget(
            message: dataBillState.messageError,
            onTryAgain: ref.read(checkoutPageProvider.notifier).getDataBill,
          ),
        );
      case PageCommonState.normal:
      case PageCommonState.success:
      default:
    }
    var notifier = ref.read(homeProvider.notifier);
    return orderLineItems.isEmpty
        ? Center(
            child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const ResponsiveIconWidget(
                iconData: Icons.restaurant_rounded,
                color: Colors.grey,
              ),
              Text(
                'Danh sách món đã gọi đang trống',
                style: AppTextStyle.regular(
                  color: Colors.grey,
                  rawFontSize: AppConfig.defaultRawTextSize - 1.0,
                ),
              ),
            ],
          ))
        : NotificationListener<ScrollNotification>(
            onNotification: (notification) {
              if (notification is UserScrollNotification) {
                ref
                    .read(homeProvider.notifier)
                    .onChangeAutoScrollProducts(false);
              }
              return true;
            },
            child: Container(
              color: Colors.grey.shade50,
              child: ScrollablePositionedList.separated(
                itemScrollController:
                    itemScrollController ?? notifier.selectedItemsScrollCtrl,
                itemPositionsListener: itemPositionsListener ??
                    notifier.selectedItemsPositionsListener,
                padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
                itemBuilder: (context, index) {
                  var p = orderLineItems[index];
// var p = products.firstWhereOrNull((e) => )
                  // var cancelCount = productCheckout
                  //         .firstWhereOrNull((e) => e.id == p.id)
                  //         ?.quantityCancel ??
                  //     0;

                  return Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border:
                          Border.all(color: Colors.grey.shade200, width: 0.5),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text.rich(
                                TextSpan(
                                  text: p.name,
                                  children: [
                                    TextSpan(
                                      text:
                                          '  (${AppUtils.formatCurrency(value: p.price, symbol: 'đ')
                                          // NumberFormat.currency(locale: 'vi', symbol: 'đ').format(double.tryParse(p.unitPrice) ?? 0)
                                          }/${p.unit.trim()})',
                                      style: AppTextStyle.medium(
                                          rawFontSize:
                                              AppConfig.defaultRawTextSize -
                                                  1.5,
                                          color: Colors.grey.shade400),
                                    ),
                                  ],
                                ),
                                style: AppTextStyle.medium(),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            const Gap(4),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 2),
                              decoration: BoxDecoration(
                                color: Colors.grey.shade100,
                                borderRadius: AppConfig.borderRadiusSecond,
                                border: Border.all(color: Colors.grey.shade200),
                              ),
                              child: Text(
                                'x${p.count}',
                                style: AppTextStyle.bold(),
                              ),
                            ),
                            // Text.rich(
                            //   TextSpan(
                            //     text: 'SL: ',
                            //     children: [
                            //       TextSpan(
                            //         text: p.numberSelecting.toString(),
                            //         style: AppTextStyle.bold(),
                            //       ),
                            //     ],
                            //     style: AppTextStyle.bold(
                            //       color: Colors.grey.shade500,
                            //       rawFontSize:
                            //           AppConfig.defaultRawTextSize - 1.0,
                            //     ),
                            //   ),
                            // ),
                          ],
                        ),
                        const Gap(4),
                        Row(
                          children: [
                            Text('Thuế ${p.tax}'), const Gap(4),
                            // DropdownTaxWidget(
                            //   taxs: [0.0, 0.08, 0.1],
                            //   taxSelect: 0.08,
                            //   yIndex: 1,
                            //   onChangeTax: (value) {},
                            //   widthBtn: TextUtil.getTextSize(
                            //               text: S.current.default_1,
                            //               textStyle: AppTextStyle.regular())
                            //           .width +
                            //       12 * 2,
                            //   oddRowColor: Colors.grey.shade200,
                            // ),

                            // Expanded(
                            //   child: Container(),
                            // ),
                            // Text('Hủy', style: AppTextStyle.regular()),
                            // const Gap(6),
                            // Expanded(
                            //   child: Row(
                            //     mainAxisSize: MainAxisSize.min,
                            //     children: [
                            //       InkWell(
                            //         onTap: () {
                            //           if (-cancelCount < 1) return;
                            //           ref
                            //               .read(homeProvider.notifier)
                            //               .cancelProductCheckout(p, 1);
                            //         },
                            //         child: Container(
                            //           padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                            //           decoration: BoxDecoration(
                            //             color: Colors.grey.shade50,
                            //             // border: Border(
                            //             //   top: BorderSide(
                            //             //       color: Colors.grey.shade300),
                            //             //   bottom: BorderSide(
                            //             //       color: Colors.grey.shade300),
                            //             //   left: BorderSide(
                            //             //       color: Colors.grey.shade300),
                            //             // ),
                            //             borderRadius: BorderRadius.horizontal(
                            //               left: Radius.circular(6),
                            //             ),
                            //           ),
                            //           child: Row(
                            //             children: [
                            //               Text('', style: AppTextStyle.bold()),
                            //               Icon(
                            //                 Icons.remove,
                            //                 size: 16,
                            //                 color:
                            //                     -cancelCount < 1 ? Colors.grey.shade300 : null,
                            //               ),
                            //             ],
                            //           ),
                            //         ),
                            //       ),
                            //       Container(
                            //         padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                            //         decoration: BoxDecoration(
                            //           color: Colors.grey.shade50,
                            //           // border: Border.symmetric(
                            //           //   horizontal: BorderSide(
                            //           //       color: Colors.grey.shade300),
                            //           // ),
                            //         ),
                            //         child: Text((-cancelCount).toString(),
                            //             style: AppTextStyle.bold(color: Colors.red)),
                            //       ),
                            //       InkWell(
                            //         onTap: () {
                            //           if (-cancelCount >= p.numberSelecting) {
                            //             return;
                            //           }
                            //           ref
                            //               .read(homeProvider.notifier)
                            //               .cancelProductCheckout(p, -1);
                            //         },
                            //         child: Container(
                            //           padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                            //           decoration: BoxDecoration(
                            //             color: Colors.grey.shade50,
                            //             // border: Border(
                            //             //   top: BorderSide(
                            //             //       color: Colors.grey.shade300),
                            //             //   bottom: BorderSide(
                            //             //       color: Colors.grey.shade300),
                            //             //   right: BorderSide(
                            //             //       color: Colors.grey.shade300),
                            //             // ),
                            //             borderRadius: BorderRadius.horizontal(
                            //               right: Radius.circular(6),
                            //             ),
                            //           ),
                            //           child: Row(
                            //             children: [
                            //               Text('', style: AppTextStyle.bold()),
                            //               Icon(
                            //                 Icons.add,
                            //                 size: 16,
                            //                 color: -cancelCount >= p.numberSelecting
                            //                     ? Colors.grey.shade300
                            //                     : null,
                            //               ),
                            //             ],
                            //           ),
                            //         ),
                            //       ),
                            //     ],
                            //   ),
                            // ),
                            // const Gap(4),
                            Text(
                              AppUtils.formatCurrency(
                                  value:
                                      (double.tryParse(p.price) ?? 0) * p.count,
                                  symbol: 'đ'),
                              // NumberFormat.currency(locale: 'vi', symbol: 'đ').format(
                              //     (double.tryParse(p.unitPrice) ?? 0) * p.numberSelecting),
                              style: AppTextStyle.bold(),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                  // return _OrderProductItem(
                  //   item: items[index],
                  //   allowEnterNote: true,
                  //   allowExtraItem: true,
                  //   onTap: null,
                  // );
                },
                separatorBuilder: (context, index) => const Gap(6),
                itemCount: orderLineItems.length,
              ),
            ),
          );
  }

  // void showProductInfoAndHistory(BuildContext context, ProductModel item) {
  //   showDialog(
  //     context: context,
  //     builder: (context) {
  //       return _ProductInfoAndHistoryDialog(
  //         product: item,
  //       );
  //     },
  //   );
  // }
}

class _OrderProductLoadingWidget extends StatelessWidget {
  const _OrderProductLoadingWidget();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Row(
            children: [
              Expanded(child: AppShimmerLoading()),
              GapW(50),
              AppShimmerLoading(width: 100),
            ],
          ),
          const Gap(8),
          SizedBox(
            height: 36,
            child: Row(
              children: [
                const Expanded(
                  child: AppShimmerLoading(),
                ),
                const Gap(12),
                SizedBox(
                  width: 100,
                  child: AppShimmerLoading(
                    child: SpinBox(),
                  ),
                ),
              ],
            ),
          ),
          const Gap(8),
        ],
      ),
    );
  }
}
