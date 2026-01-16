import 'dart:io';

import 'package:aladdin_franchise/generated/l10n.dart';
import 'package:aladdin_franchise/src/configs/color.dart';
import 'package:aladdin_franchise/src/configs/text_style.dart';
import 'package:aladdin_franchise/src/features/dialogs/customer/customer_option_dialog.dart';
import 'package:aladdin_franchise/src/features/dialogs/confirm_action.dart';
import 'package:aladdin_franchise/src/features/dialogs/confirm_input.dart';
import 'package:aladdin_franchise/src/features/dialogs/coupon/button_add_coupon.dart';
import 'package:aladdin_franchise/src/features/dialogs/coupon_info.dart';
import 'package:aladdin_franchise/src/features/dialogs/create_invoice_order_dialog.dart';
import 'package:aladdin_franchise/src/features/dialogs/error.dart';
import 'package:aladdin_franchise/src/features/dialogs/message.dart';
import 'package:aladdin_franchise/src/features/dialogs/payment/payment_method_dialog.dart';
import 'package:aladdin_franchise/src/features/pages/cart/widgets/product_checkout_action.dart';
import 'package:aladdin_franchise/src/features/pages/customer/view.dart';
import 'package:aladdin_franchise/src/features/pages/home/components/order/feature_button_group.dart';
import 'package:aladdin_franchise/src/features/pages/home/components/order/price_order_widget.dart';
import 'package:aladdin_franchise/src/features/pages/home/components/order/order_item_list_widget.dart';
import 'package:aladdin_franchise/src/features/pages/home/provider.dart';
import 'package:aladdin_franchise/src/features/pages/home/state.dart';
import 'package:aladdin_franchise/src/features/widgets/app_icon_widget.dart';
import 'package:aladdin_franchise/src/features/widgets/button/button_main.dart';
import 'package:aladdin_franchise/src/features/widgets/button/button_square_menu.dart';
import 'package:aladdin_franchise/src/features/widgets/gap.dart';
import 'package:aladdin_franchise/src/models/order_invoice/order_invoice.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'components/order_price_widget.dart';

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

class CheckoutPage extends ConsumerStatefulWidget {
  const CheckoutPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends ConsumerState<CheckoutPage> {
  CheckoutTabEnum tabSelect = CheckoutTabEnum.receipt;
  void _changeTabSelect(CheckoutTabEnum tab) {
    if (tabSelect != tab) {
      setState(() {
        tabSelect = tab;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    openCheckoutPage = true;
  }

  @override
  void dispose() {
    openCheckoutPage = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var viewPadding = MediaQuery.of(context).viewPadding;
    var tabWidget = Row(
      children: CheckoutTabEnum.values.map(
        (e) {
          bool selected = e == tabSelect;
          return Expanded(
            child: InkWell(
              onTap: () {
                _changeTabSelect(e);
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                decoration: BoxDecoration(
                  color: selected ? Colors.black87 : Colors.grey.shade200,
                ),
                child: Center(
                  child: Text(
                    e.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyle.bold(color: selected ? Colors.white : Colors.grey),
                  ),
                ),
              ),
            ),
          );
        },
      ).toList(),
    );
    var continueBtn = ButtonMainWidget(
      widthFactor: 0.5,
      textAction: S.current.continue_text,
      onPressed: () {
        paymentBtnCallback(
          ref: ref,
          context: context,
        );
      },
    );
    var priceWidget = const Padding(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Center(
        child: OrderPriceWidget(),
      ),
    );
    return Scaffold(
      appBar: AppBar(
        title: Text(
          S.current.payment,
          style: AppTextStyle.bold(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(viewPadding.left, 0, 0, 0),
        child: OrientationBuilder(
          builder: (context, orientation) {
            if (orientation == Orientation.portrait) {
              return Column(
                children: [
                  tabWidget,
                  Expanded(
                    child: switch (tabSelect) {
                      CheckoutTabEnum.receipt => Column(
                          children: [
                            const Expanded(
                              child: OrderedItemsSelectedWidget(),
                            ),
                            priceWidget,
                            continueBtn,
                            const Gap(8),
                          ],
                        ),
                      CheckoutTabEnum.endow => TabCustomerPayment(
                          onApplyCallback: () {
                            _changeTabSelect(CheckoutTabEnum.receipt);
                          },
                        ),
                    },
                  ),
                ],
              );
            }

            return Row(
              children: [
                const Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: OrderedItemsSelectedWidget(),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        child: ProductCheckoutActionWidget(),
                      ),
                    ],
                  ),
                ),
                const VerticalDivider(width: 1),
                Expanded(
                  flex: 1,
                  child: Column(
                    children: [
                      tabWidget,
                      Expanded(
                        child: switch (tabSelect) {
                          CheckoutTabEnum.receipt => Column(
                              children: [
                                Expanded(
                                  child: priceWidget,
                                ),
                                continueBtn,
                                const Gap(8),
                              ],
                            ),
                          CheckoutTabEnum.endow => TabCustomerPayment(
                              onApplyCallback: () {
                                _changeTabSelect(CheckoutTabEnum.receipt);
                              },
                            ),
                        },
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

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
    final customer = ref.watch(homeProvider.select((value) => value.customer));
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
                            onPressed: () => onChooseCustomerOption(context),
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
                            : CustomerInfoWidget(
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
                const NumberOfAdultsWidget(labelText: ''),
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
                                onPressed: () async {
                                  await showCouponDialog(context);
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
                    CouponInfoWidget(canAction: canAction)
                  ],
                ),
                const Divider(),
                Consumer(builder: (context, ref, child) {
                  var invoice = ref.watch(homeProvider.select((value) => value.invoice));
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
                                await showCreateInvoiceOrderDialog(
                                  context,
                                  orderInvoice: invoice,
                                );
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
                                                  .read(homeProvider.notifier)
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
