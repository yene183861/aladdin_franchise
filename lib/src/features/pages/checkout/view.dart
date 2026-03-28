import 'package:aladdin_franchise/generated/l10n.dart';
import 'package:aladdin_franchise/src/configs/app.dart';
import 'package:aladdin_franchise/src/configs/color.dart';
import 'package:aladdin_franchise/src/configs/text_style.dart';
import 'package:aladdin_franchise/src/features/dialogs/customer/customer_option_dialog.dart';
import 'package:aladdin_franchise/src/features/dialogs/confirm_action.dart';
import 'package:aladdin_franchise/src/features/dialogs/coupon/coupon_option_dialog.dart';
import 'package:aladdin_franchise/src/features/dialogs/coupon/widgets/coupon_info.dart';
import 'package:aladdin_franchise/src/features/dialogs/customer/widgets/customer_info.dart';
import 'package:aladdin_franchise/src/features/dialogs/invoice/invoice_form_dialog.dart';
import 'package:aladdin_franchise/src/features/pages/checkout/provider.dart';
import 'package:aladdin_franchise/src/features/pages/home/components/menu/widgets/product_box.dart';
import 'package:aladdin_franchise/src/features/pages/home/components/order/feature_button_group.dart';
import 'package:aladdin_franchise/src/features/pages/home/provider.dart';
import 'package:aladdin_franchise/src/features/pages/home/state.dart';
import 'package:aladdin_franchise/src/features/widgets/app_error_simple.dart';
import 'package:aladdin_franchise/src/features/widgets/app_icon_widget.dart';
import 'package:aladdin_franchise/src/features/widgets/button/button_main.dart';
import 'package:aladdin_franchise/src/features/widgets/button/button_square_menu.dart';
import 'package:aladdin_franchise/src/features/widgets/empty_data_widget.dart';
import 'package:aladdin_franchise/src/features/widgets/gap.dart';
import 'package:aladdin_franchise/src/features/widgets/refresh_data.dart';
import 'package:aladdin_franchise/src/features/widgets/shimmer_box.dart';
import 'package:aladdin_franchise/src/models/order_invoice/order_invoice.dart';
import 'package:aladdin_franchise/src/models/product_checkout.dart';
import 'package:aladdin_franchise/src/utils/app_log.dart';
import 'package:aladdin_franchise/src/utils/app_util.dart';
import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import 'widgets/cancel_dish_action.dart';
import 'widgets/order_data_bill.dart';

enum CheckoutTabEnum { receipt, endow }

bool openCheckoutPage = false;

extension CheckoutTabEnumEx on CheckoutTabEnum {
  String get title {
    switch (this) {
      case CheckoutTabEnum.receipt:
        return 'Hóa đơn';
      case CheckoutTabEnum.endow:
        return 'Ưu đãi';
    }
  }
}

// class CheckoutPage extends ConsumerStatefulWidget {
//   const CheckoutPage({super.key});

//   @override
//   ConsumerState<ConsumerStatefulWidget> createState() => _CheckoutPageState();
// }

// class _CheckoutPageState extends ConsumerState<CheckoutPage> {
//   CheckoutTabEnum tabSelect = CheckoutTabEnum.receipt;
//   void _changeTabSelect(CheckoutTabEnum tab) {
//     if (tabSelect != tab) {
//       setState(() {
//         tabSelect = tab;
//       });
//     }
//   }

//   @override
//   void initState() {
//     super.initState();
//     openCheckoutPage = true;
//   }

//   @override
//   void dispose() {
//     openCheckoutPage = false;
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     var viewPadding = MediaQuery.of(context).viewPadding;
//     var tabWidget = Row(
//       children: CheckoutTabEnum.values.map(
//         (e) {
//           bool selected = e == tabSelect;
//           return Expanded(
//             child: InkWell(
//               onTap: () {
//                 _changeTabSelect(e);
//               },
//               child: Container(
//                 padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
//                 decoration: BoxDecoration(
//                   color: selected ? Colors.black87 : Colors.grey.shade200,
//                 ),
//                 child: Center(
//                   child: Text(
//                     e.title,
//                     maxLines: 1,
//                     overflow: TextOverflow.ellipsis,
//                     style: AppTextStyle.bold(color: selected ? Colors.white : Colors.grey),
//                   ),
//                 ),
//               ),
//             ),
//           );
//         },
//       ).toList(),
//     );
//     var continueBtn = ButtonMainWidget(
//       widthFactor: 0.5,
//       textAction: S.current.continue_text,
//       onPressed: () {
//         paymentBtnCallback(
//           ref: ref,
//           context: context,
//         );
//       },
//     );
//     var priceWidget = const Padding(
//       padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//       child: Center(
//         child: OrderDataBillWidget(),
//       ),
//     );
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           S.current.payment,
//           style: AppTextStyle.bold(color: Colors.white),
//         ),
//       ),
//       body: Padding(
//         padding: EdgeInsets.fromLTRB(viewPadding.left, 0, 0, 0),
//         child: OrientationBuilder(
//           builder: (context, orientation) {
//             if (orientation == Orientation.portrait) {
//               return Column(
//                 children: [
//                   tabWidget,
//                   Expanded(
//                     child: switch (tabSelect) {
//                       CheckoutTabEnum.receipt => Column(
//                           children: [
//                             const Expanded(
//                               child: OrderedItemsSelectedWidget(),
//                             ),
//                             priceWidget,
//                             continueBtn,
//                             const Gap(8),
//                           ],
//                         ),
//                       CheckoutTabEnum.endow => TabCustomerPayment(
//                           onApplyCallback: () {
//                             _changeTabSelect(CheckoutTabEnum.receipt);
//                           },
//                         ),
//                     },
//                   ),
//                 ],
//               );
//             }

//             return Row(
//               children: [
//                 const Expanded(
//                   flex: 1,
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Expanded(
//                         child: OrderedItemsSelectedWidget(),
//                       ),
//                       Padding(
//                         padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//                         child: CancelDishAction(),
//                       ),
//                     ],
//                   ),
//                 ),
//                 const VerticalDivider(width: 1),
//                 Expanded(
//                   flex: 1,
//                   child: Column(
//                     children: [
//                       tabWidget,
//                       Expanded(
//                         child: switch (tabSelect) {
//                           CheckoutTabEnum.receipt => Column(
//                               children: [
//                                 Expanded(
//                                   child: priceWidget,
//                                 ),
//                                 continueBtn,
//                                 const Gap(8),
//                               ],
//                             ),
//                           CheckoutTabEnum.endow => TabCustomerPayment(
//                               onApplyCallback: () {
//                                 _changeTabSelect(CheckoutTabEnum.receipt);
//                               },
//                             ),
//                         },
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             );
//           },
//         ),
//       ),
//     );
//   }
// }

class TabCustomerPayment extends ConsumerWidget {
  const TabCustomerPayment({
    Key? key,
    this.onApplyCallback,
    this.canAction = true,
  }) : super(key: key);
  final VoidCallback? onApplyCallback;
  final bool canAction;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final customer = ref.watch(checkoutProvider.select((value) => value.customer));
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          S.current.customerPolicy,
                          style: AppTextStyle.bold(),
                        ),
                        if (canAction)
                          ButtonSquareMenuWidget(
                            onPressed: () => showCustomerOptionDialog(context),
                            child: const ResponsiveIconWidget(iconData: Icons.person_search),
                          ),
                      ],
                    ),
                    Column(
                      children: [
                        customer == null
                            ? Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(S.current.noInfo),
                              )
                            : CustomerInfoCard(
                                canAction: canAction,
                                customer: customer,
                              )
                      ],
                    ),
                  ],
                ),
                const Divider(),
                Text(
                  'Số lượng người (Người lớn)',
                  style: AppTextStyle.bold(),
                ),
                const Gap(12),
                // const NumberOfAdultsWidget(labelText: ''),
                const Divider(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          S.current.discountCode,
                          style: AppTextStyle.bold(),
                        ),
                        if (canAction)
                          Row(
                            children: [
                              ButtonSquareMenuWidget(
                                onPressed: () {
                                  showCouponOptionDialog(context);
                                },
                                child: const ResponsiveIconWidget(iconData: CupertinoIcons.tickets),
                              ),
                              // if (Platform.isAndroid) ...[
                              //   // Gap(16),
                              //   // const ButtonScanCouponWidget(),
                              // ],
                            ],
                          )
                      ],
                    ),
                    CouponList(canAction: canAction)
                  ],
                ),
                const Divider(),
                Consumer(builder: (context, ref, child) {
                  var invoice = ref.watch(checkoutProvider.select((value) => value.invoice));
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            S.current.invoice,
                            style: AppTextStyle.bold(),
                          ),
                          if (canAction)
                            ButtonSquareMenuWidget(
                              onPressed: () async {
                                showInvoiceFormDialog(context);
                              },
                              child: ResponsiveIconWidget(
                                iconData:
                                    (invoice == null || invoice.isEmpty()) ? Icons.add : Icons.edit,
                              ),
                            ),
                        ],
                      ),
                      Column(
                        children: [
                          (invoice == null || invoice.isEmpty())
                              ? Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(S.current.noInfo),
                                )
                              : Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                                  child: Row(
                                    children: [
                                      const ResponsiveIconWidget(
                                        iconData: Icons.file_present,
                                      ),
                                      const Gap(8),
                                      Expanded(
                                        child: Text(invoice.companyName),
                                      ),
                                      const Gap(8),
                                      ResponsiveIconButtonWidget(
                                        iconData: CupertinoIcons.delete,
                                        color: AppColors.redColor,
                                        onPressed: () async {
                                          await showConfirmAction(
                                            context,
                                            message: 'Bạn có muốn xóa hóa đơn?',
                                            action: () async {
                                              await ref
                                                  .read(checkoutProvider.notifier)
                                                  .onUpdateOrderInvoice(
                                                    const OrderInvoice(),
                                                    isUpdate: true,
                                                  );
                                            },
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                        ],
                      ),
                    ],
                  );
                }),
              ],
            ),
          ),
        ),
        // if (canAction)
        //   Center(
        //     child: Padding(
        //       padding: const EdgeInsets.symmetric(vertical: 8),
        //       child: ButtonMainWidget(
        //         widthFactor: 0.5,
        //         onPressed: () {
        //           showConfirmAction(
        //             context,
        //             message: S.current.messageApplyDiscount,
        //             action: () async {
        //               final result = await ref.read(homeProvider.notifier).applyCustomerPolicy();
        //               if (result == null) {
        //                 await showMessageDialog(
        //                   context,
        //                   title: S.current.congratulations,
        //                   message: S.current.messageApplyDiscountResult,
        //                 );
        //                 onApplyCallback?.call();
        //               }
        //             },
        //           );
        //         },
        //         textAction: S.current.apply,
        //       ),
        //     ),
        //   ),
      ],
    );
  }
}

class _ProductCheckoutLine extends StatelessWidget {
  const _ProductCheckoutLine({
    required this.p,
    this.loading = false,
  });

  final ProductCheckoutModel p;
  final bool loading;

  @override
  Widget build(BuildContext context) {
    var child = Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200, width: 0.5),
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
                            '  (${AppUtils.formatCurrency(value: p.unitPrice, symbol: 'đ')}/${p.unit.trim()})',
                        style: AppTextStyle.medium(
                            rawFontSize: AppConfig.defaultRawTextSize - 1.5,
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
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: AppConfig.borderRadiusSecond,
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: Text(
                  'x${p.quantity}',
                  style: AppTextStyle.bold(),
                ),
              ),
            ],
          ),
          const Gap(4),
          Text(
            loading
                ? ''
                : AppUtils.formatCurrency(
                    value: (double.tryParse(p.unitPrice) ?? 0) * p.quantity, symbol: 'đ'),
            style: AppTextStyle.bold(),
          ),
        ],
      ),
    );
    if (loading) {
      return AppShimmerLoading(
        borderRadius: 12,
        child: child,
      );
    }
    return child;
  }
}

class CheckoutItemListView extends ConsumerWidget {
  const CheckoutItemListView({
    super.key,
    this.itemScrollController,
    this.itemPositionsListener,
  });
  final ItemScrollController? itemScrollController;
  final ItemPositionsListener? itemPositionsListener;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productCheckoutState =
        ref.watch(checkoutProvider.select((value) => value.productCheckoutState));
    var items = ref.watch(checkoutProvider.select((value) => value.productCheckout));
    var checkoutNotifier = ref.read(checkoutProvider.notifier);
    switch (productCheckoutState.status) {
      case PageCommonState.loading:
        return Container(
          color: Colors.grey.shade50,
          child: ScrollablePositionedList.separated(
            padding: const EdgeInsets.fromLTRB(8, 6, 8, 6),
            itemBuilder: (context, index) => const _ProductCheckoutLine(
              p: ProductCheckoutModel(
                  id: -1, name: 'Bánh bao', quantity: 1, unit: 'Suất', unitPrice: ''),
              loading: true,
            ),
            separatorBuilder: (context, index) => const Gap(8),
            itemCount: 3,
          ),
        );

      case PageCommonState.error:
        return Center(
          child: AppErrorSimpleWidget(
            message: productCheckoutState.messageError,
            onTryAgain: checkoutNotifier.getProductCheckout,
          ),
        );
      case PageCommonState.normal:
      case PageCommonState.success:
      default:
    }
    if (items.isEmpty) {
      return Center(
        child: EmptyDataWidget(
          icon: Icons.restaurant_rounded,
          message: S.of(context).ordered_item_empty,
        ),
      );
    }

    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        if (notification is UserScrollNotification) {
          ref.read(homeProvider.notifier).onChangeAutoScrollProducts(false);
        }
        return true;
      },
      child: RefreshDataWidget(
        indicatorTrigger: IndicatorTrigger.leadingEdge,
        onRefresh: checkoutNotifier.getProductCheckout,
        child: Container(
          color: Colors.grey.shade50,
          child: ScrollablePositionedList.separated(
            itemScrollController: itemScrollController,
            itemPositionsListener: itemPositionsListener,
            padding: const EdgeInsets.fromLTRB(8, 6, 8, 66),
            itemBuilder: (context, index) => _ProductCheckoutLine(p: items[index]),
            separatorBuilder: (context, index) => const Gap(8),
            itemCount: items.length,
          ),
        ),
      ),
    );
  }
}
