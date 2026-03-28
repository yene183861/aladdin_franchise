import 'package:aladdin_franchise/generated/assets.dart';
import 'package:aladdin_franchise/generated/l10n.dart';
import 'package:aladdin_franchise/src/configs/app.dart';
import 'package:aladdin_franchise/src/configs/color.dart';
import 'package:aladdin_franchise/src/configs/dev_config.dart';
import 'package:aladdin_franchise/src/configs/text_style.dart';
import 'package:aladdin_franchise/src/core/storages/provider.dart';
import 'package:aladdin_franchise/src/data/model/o2o/chat_message_model.dart';
import 'package:aladdin_franchise/src/features/dialogs/info_restaurant.dart';
import 'package:aladdin_franchise/src/features/dialogs/message.dart';
import 'package:aladdin_franchise/src/features/dialogs/processing.dart';
import 'package:aladdin_franchise/src/features/pages/cart/provider.dart';
import 'package:aladdin_franchise/src/features/pages/cart/state.dart';
import 'package:aladdin_franchise/src/features/pages/cart/view_new.dart';
import 'package:aladdin_franchise/src/features/pages/checkout/provider.dart';
import 'package:aladdin_franchise/src/features/pages/checkout/state.dart';

import 'package:aladdin_franchise/src/features/pages/home/provider.dart';
import 'package:aladdin_franchise/src/features/pages/home/state.dart';
import 'package:aladdin_franchise/src/features/pages/more/view.dart';
import 'package:aladdin_franchise/src/features/pages/order_to_online/components/chat_message_item.dart';
import 'package:aladdin_franchise/src/features/widgets/app_error_simple.dart';
import 'package:aladdin_franchise/src/features/widgets/app_simple_loading.dart';
import 'package:aladdin_franchise/src/features/widgets/button/icon_button.dart';
import 'package:aladdin_franchise/src/features/widgets/empty.dart';
import 'package:aladdin_franchise/src/features/widgets/gap.dart';
import 'package:aladdin_franchise/src/features/widgets/image.dart';
import 'package:aladdin_franchise/src/features/widgets/refresh_data.dart';
import 'package:aladdin_franchise/src/utils/app_check.dart';
import 'package:aladdin_franchise/src/utils/date_time.dart';
import 'package:aladdin_franchise/src/utils/navigator.dart';
import 'package:aladdin_franchise/src/utils/show_snackbar.dart';
import 'package:aladdin_franchise/src/utils/subwindows_moniter%20copy.dart';
import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:responsive_framework/responsive_framework.dart';

import 'components/action/barrel_btn.dart';
import 'components/action/group_home_action.dart';

import 'components/drawer/drawer.dart';
import 'package:aladdin_franchise/src/features/widgets/app_icon_widget.dart';

import 'components/menu/view.dart';
import 'components/menu/widgets/search_dish.dart';
import 'components/order/view.dart';

final GlobalKey<_HomePageState> homeKey = GlobalKey<_HomePageState>();

class HomePage extends ConsumerStatefulWidget {
  HomePage({Key? key}) : super(key: homeKey);

  @override
  ConsumerState createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> with WidgetsBindingObserver {
  _listenEvent(BuildContext context, WidgetRef ref) => (HomeEvent? previous, HomeEvent? next) {
        switch (next) {
          case HomeEvent.checkCode:
            showProcessingDialog(context, message: S.current.verifying);
            break;
          case HomeEvent.createNewOrder:
            showProcessingDialog(context, message: S.current.creating_a_new_order);
            break;
          case HomeEvent.updateOrder:
            showProcessingDialog(context, message: S.current.updating_order);
            break;
          case HomeEvent.cancelOrder:
            showProcessingDialog(context, message: S.current.cancel_order);
            break;
          case HomeEvent.loadingChangeOrderCurrent:
            showProcessingDialog(context, message: S.current.updating_order_panel);
            break;
          case HomeEvent.transferOrder:
            showProcessingDialog(context, message: S.current.orders_are_being_delivered);
            break;
          case HomeEvent.processOrder:
            showProcessingDialog(context, message: S.current.processing);
            break;
          case HomeEvent.cancelDishInOrder:
            showProcessingDialog(context, message: S.current.sending_request_to_cancel_order);
            break;
          case HomeEvent.paymentProcess:
            showProcessingDialog(context, message: S.current.processing_payment);
            break;
          case HomeEvent.checkLocalNetwork:
            showProcessingDialog(context, message: S.current.checking_connection);
            break;
          case HomeEvent.updateTypeOrderWaiter:
            showProcessingDialog(context, message: S.current.changing_form_of_sell_mode);
            break;
          case HomeEvent.switchAccount:
            showProcessingDialog(
              context,
              message: S.current.switching_accounts,
            );
            break;
          case HomeEvent.switchAccountSuccess:
            Navigator.pop(context);
            showDoneSnackBar(
              context: context,
              message: "${S.current.switched_accounts} ${ref.read(userInfoProvider).user?.name} "
                  "(${ref.read(userInfoProvider).user?.username?.toUpperCase()})",
            );
            break;
          case HomeEvent.normal:
            Navigator.pop(context);
            break;
          case HomeEvent.errorInfo:
            Navigator.pop(context);
            showMessageDialog(context, message: ref.read(homeProvider.notifier).getMessageError());
            break;
          case HomeEvent.findingCustomer:
            showProcessingDialog(context, message: S.current.getInfoProcessing);
            break;
          case HomeEvent.createCustomer:
            showProcessingDialog(context, message: S.current.creating_customer);
            break;
          case HomeEvent.checkTicket:
            showProcessingDialog(
              context,
              message: S.current.checking,
            );
            break;
          case HomeEvent.removeTicket:
            showProcessingDialog(
              context,
              message: "${S.current.canceling} ${S.current.discount.toLowerCase()}",
            );
            break;
          case HomeEvent.findingTaxCode:
            showProcessingDialog(
              context,
              message: S.current.finding_by_tax_code,
            );
            break;
          case HomeEvent.updateInvoice:
            showProcessingDialog(context,
                message: "${S.current.updating} ${S.current.invoice.toLowerCase()}");
            break;
          case HomeEvent.insertInvoice:
            showProcessingDialog(context,
                message: "${S.current.creating} ${S.current.invoice.toLowerCase()}");
            break;
          case HomeEvent.unlockOrder:
            showProcessingDialog(
              context,
              // message: S.current.closing_order_payment,
              message: S.current.unlocking_order,
            );
            break;
          case HomeEvent.processed:
            Navigator.pop(context);
            break;
          case HomeEvent.processError:
            Navigator.pop(context);

            // showErrorDialog(
            //   context,
            //   message: ref.read(homeProvider.notifier).getMessageError(),
            // );
            showMessageDialog(
              context,
              message: ref.read(homeProvider.notifier).getMessageError(),
            );
            break;
          case HomeEvent.checkPaymentMethod:
            showProcessingDialog(
              context,
              message: S.current.checking_payment_method,
            );
            break;
          case HomeEvent.removeCustomer:
            showProcessingDialog(
              context,
              message: S.current.removing_customer,
            );
            break;
          case HomeEvent.applyPolicy:
            showProcessingDialog(
              context,
              message: S.current.applied_policy,
            );
            break;
          case HomeEvent.printProduct:
            showProcessingDialog(
              context,
              message: S.current.sending_bill_kitchen,
            );
            break;
          case HomeEvent.completeBillAgain:
            showProcessingDialog(
              context,
              message: S.current.completing_order,
            );
            break;
          case HomeEvent.cancelProductsCheckout:
            showProcessingDialog(
              context,
              message: S.current.cancelling_item,
            );
            break;
          case HomeEvent.sendTicket:
            showProcessingDialog(
              context,
              message: S.current.sending_ticket,
            );
            break;
          case HomeEvent.getPaymentGateway:
            showProcessingDialog(
              context,
              message: S.current.loading_payment_gateway_url,
            );
            break;
          case HomeEvent.dynamicPosCallback:
            showProcessingDialog(
              context,
              message: S.current.sending_command_pos,
            );
            break;
          case HomeEvent.closingShift:
            showProcessingDialog(
              context,
              message: S.current.system_closing_shift,
            );
            break;
          case HomeEvent.updateTax:
            showProcessingDialog(
              context,
              message: S.current.updating_tax,
            );
            break;
          case HomeEvent.getDataBill:
            showProcessingDialog(context, message: S.current.updating_payment_info);
            break;
          case HomeEvent.getProductCheckout:
            showProcessingDialog(context, message: S.current.updating_payment_info);
            break;
          case HomeEvent.checkPrinter:
            showProcessingDialog(context, message: S.current.checking_printer_status);
            break;
          // coupon
          case HomeEvent.removeCoupon:
            showProcessingDialog(
              context,
              message: "${S.current.canceling} ${S.current.discount.toLowerCase()}",
            );
            break;

          case HomeEvent.lockOrder:
            showProcessingDialog(context, message: S.current.locking_order_action);
            break;
          case HomeEvent.updateReservation:
            showProcessingDialog(context, message: S.current.updating_reservation_info);
            break;
          case HomeEvent.updateOrderReservation:
            showProcessingDialog(context, message: S.current.updating_order_reser);
            break;
          case HomeEvent.addCoupon:
            showProcessingDialog(context, message: S.current.checking);
            break;
          case HomeEvent.saveO2oConfig:
            showProcessingDialog(context, message: S.current.saving_config);
            break;
          // case HomeEvent.sendPrintData:
          //   showProcessingDialog(context, message: 'Đang gửi lệnh in ');
          //   break;
          case HomeEvent.addCustomerToOrder:
            showProcessingDialog(
              context,
              message: S.current.saving_customer_info,
            );
            break;
          default:
            break;
        }
      };
  _listenCheckoutEvent(BuildContext context, WidgetRef ref) =>
      (CheckoutEvent? previous, CheckoutEvent? next) {
        switch (next) {
          case CheckoutEvent.normal:
            pop(context);
            break;
          case CheckoutEvent.findingCustomer:
            showProcessingDialog(context, message: S.current.getInfoProcessing);
            break;
          case CheckoutEvent.removeCustomer:
            showProcessingDialog(context, message: S.current.removing_customer);
            break;
          case CheckoutEvent.createCustomer:
            showProcessingDialog(context, message: S.current.creating_customer);
            break;
          case CheckoutEvent.addCoupon:
            showProcessingDialog(context, message: S.current.checking);
            break;
          case CheckoutEvent.removeCoupon:
            showProcessingDialog(
              context,
              message: "Đang xoá ${S.current.discount.toLowerCase()}",
            );
            break;
          case CheckoutEvent.applyPolicy:
            showProcessingDialog(
              context,
              message: S.current.applied_policy,
            );
            break;
          case CheckoutEvent.updateTax:
            showProcessingDialog(
              context,
              message: S.current.updating_tax,
            );
            break;

          case CheckoutEvent.updateInvoice:
            showProcessingDialog(context,
                message: "${S.current.updating} ${S.current.invoice.toLowerCase()}");
            break;
          case CheckoutEvent.insertInvoice:
            showProcessingDialog(context,
                message: "${S.current.creating} ${S.current.invoice.toLowerCase()}");
            break;

          case CheckoutEvent.processed:
            pop(context);
            break;
          case CheckoutEvent.processError:
            pop(context);
            showMessageDialog(
              context,
              message: ref.read(checkoutProvider).message,
            );
            break;
          case CheckoutEvent.getDataBill:
            showProcessingDialog(context, message: S.current.updating_payment_info);
            break;
          case CheckoutEvent.paymentProcess:
            showProcessingDialog(context, message: S.current.processing_payment);
            break;
          case CheckoutEvent.completeBillAgain:
            showProcessingDialog(context, message: S.current.completing_order);
            break;
          case CheckoutEvent.dynamicPosCallback:
            showProcessingDialog(context, message: S.current.sending_command_pos);
            break;
          case CheckoutEvent.getProductCheckout:
            showProcessingDialog(context, message: S.current.updating_payment_info);
            break;
          case CheckoutEvent.getPaymentGateway:
            showProcessingDialog(context, message: S.current.loading_payment_gateway_url);
            break;
          case CheckoutEvent.getInvoice:
            showProcessingDialog(context, message: 'Đang tải thông tin hoá đơn');
            break;
          case CheckoutEvent.checkPaymentMethod:
            showProcessingDialog(context, message: S.current.checking_payment_method);
            break;
          default:
            break;
        }
      };
  _listenCartEvent(BuildContext context, WidgetRef ref) => (CartEvent? previous, CartEvent? next) {
        switch (next) {
          case CartEvent.normal:
            pop(context);
            break;
          case CartEvent.addItems:
            showProcessingDialog(context, message: S.current.getInfoProcessing);
            break;
          case CartEvent.sendPrintData:
            showProcessingDialog(context, message: 'Đang gửi lệnh in');
            break;

          default:
            break;
        }
      };

  final GlobalKey _chatBubbleKey = GlobalKey();
  OverlayEntry? _overlayEntry;
  double chatPopupHeight = 600;
  double chatPopupWidth = 600;

  @override
  void initState() {
    super.initState();
    PrinterMonitor.instance.init();
  }

  @override
  void dispose() {
    PrinterMonitor.instance.stop();
    isCheckTypeOrderInit = false;
    kToken = "";
    kTypeOrder = 0;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    checkUpdateApp(ref, context);
    checkTypeOrder(ref, context);
    ref.listen<HomeEvent>(
      homeProvider.select((value) => value.event),
      _listenEvent(context, ref),
    );
    ref.listen<CheckoutEvent>(
      checkoutProvider.select((value) => value.event),
      _listenCheckoutEvent(context, ref),
    );
    ref.listen<CartEvent>(
      cartPageProvider.select((value) => value.event),
      _listenCartEvent(context, ref),
    );

    var viewPadding = MediaQuery.of(context).viewPadding;
    bool orderDetailSidePanel = ResponsiveBreakpoints.of(context).largerThan(TABLET);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      drawer: const HomeDrawer(),
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(viewPadding.left, viewPadding.top, 0, 0),
            child: Row(
              children: [
                Expanded(
                    flex: 1,
                    child: Column(
                      children: [
                        if (orderDetailSidePanel)
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
                                            Builder(builder: (context) {
                                              return AppIconButton(
                                                icon: CupertinoIcons.home,
                                                onTap: Scaffold.of(context).openDrawer,
                                              );
                                            }),
                                            const Gap(6),
                                            const Expanded(
                                              child: SearchDish(),
                                            ),
                                            const HomeAction(showWhenTagsEmpty: false),
                                          ],
                                        ),
                                      ),
                                      const Gap(6),
                                      const Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              child: Row(
                                                children: [
                                                  RestaurantLayoutBtn(),
                                                  Expanded(
                                                    child: HomeAction(showWhenTagsEmpty: true),
                                                  ),
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
                                    Expanded(child: RestaurantHistoryOrderBtn()),
                                    Gap(6),
                                    Expanded(child: TypeOrderBtn()),
                                  ],
                                )),
                              ],
                            ),
                          )
                        else
                          Container(
                            padding: const EdgeInsets.only(top: 12, bottom: 12),
                            // padding: const EdgeInsets.only(top: 40, bottom: 12),
                            // decoration: const BoxDecoration(
                            //   color: Color(0xFF1E1E1E),
                            //   borderRadius: BorderRadius.vertical(
                            //     bottom: Radius.circular(20),
                            //   ),
                            // ),
                            child:

                                /// HEADER
                                Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      const Icon(Icons.menu),

                                      const Gap(20),

                                      /// Title + subtitle
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: const [
                                          Text(
                                            "Bàn 19",
                                            style: TextStyle(
                                              color: Color(0xFFFF7043),
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            "Tầng 1 • Khu A",
                                            style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 12,
                                            ),
                                          ),
                                        ],
                                      ),

                                      const Spacer(),

                                      /// Search + badge
                                      Stack(
                                        children: [
                                          const Icon(Icons.search),
                                          // Positioned(
                                          //   right: -4,
                                          //   top: -4,
                                          //   child: Container(
                                          //     padding: const EdgeInsets.all(4),
                                          //     decoration: const BoxDecoration(
                                          //       color: Colors.orange,
                                          //       shape: BoxShape.circle,
                                          //     ),
                                          //     child: const Text(
                                          //       "5",
                                          //       style: TextStyle(
                                          //         color: Colors.white,
                                          //         fontSize: 10,
                                          //       ),
                                          //     ),
                                          //   ),
                                          // ),
                                        ],
                                      ),
                                      AppIconButton(
                                        icon: CupertinoIcons.bell,
                                        onTap: () {},
                                      ),
                                    ],
                                  ),
                                  const Gap(12),
                                  Row(
                                    children: [
                                      Container(
                                        padding:
                                            const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color: AppColors.mainColor.withOpacity(0.5),
                                              width: 0.3),
                                          borderRadius: BorderRadius.circular(24),
                                          color: Colors.grey.shade100,
                                        ),
                                        child: Row(
                                          children: [
                                            Container(
                                              padding:
                                                  EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                                              decoration: BoxDecoration(
                                                color: AppColors.mainColor,
                                                border: Border.all(
                                                    color: AppColors.mainColor, width: 0.8),
                                                borderRadius: BorderRadius.circular(20),
                                              ),
                                              child: Text(
                                                'Tại chỗ',
                                                style: AppTextStyle.bold(color: Colors.white),
                                              ),
                                            ),
                                            Container(
                                              padding:
                                                  EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.transparent, width: 0.8),
                                                borderRadius: BorderRadius.circular(20),
                                              ),
                                              child: Text('Mang về'),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const Gap(8),
                                      AppIconButton(
                                        icon: CupertinoIcons.bell,
                                        onTap: () {},
                                        textAction: 'Tự order',
                                      ),
                                      Spacer(),
                                      AppIconButton(
                                        icon: CupertinoIcons.cloud_download,
                                        onTap: () {},
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        const Expanded(child: MenuSection()),
                      ],
                    )),
                // do checkoutProvider,cartPageProvider để autodispose
                Consumer(
                  builder: (context, ref, child) {
                    ref.watch(checkoutProvider);
                    ref.watch(cartPageProvider);
                    return const SizedBox.shrink();
                  },
                ),
                orderDetailSidePanel
                    ? Container(
                        constraints: const BoxConstraints(maxWidth: 500),
                        child: const DetailOrderPanel(),
                      )
                    : const SizedBox.shrink(),
              ],
            ),
          ),
          if (DevConfig.newUI)
            Positioned(
              bottom: 12,
              right: 0,
              left: 0,
              child: Consumer(
                builder: (context, ref, child) {
                  return Container(
                    margin: EdgeInsets.fromLTRB(12, 0, 12, 0),
                    child: CheckoutBar(
                      itemCount: 7,
                      totalPrice: 354000,
                    ),
                  );
                },
              ),
            ),
          ChatBubbleBtn(
            bubbleKey: _chatBubbleKey,
            onTap: () {
              _showChatContent(ref);
            },
          ),
        ],
      ),
      // bottomNavigationBar: Builder(
      //   builder: (context) {
      //     return showOrderInfo
      //         ? const SizedBox.shrink()
      //         : Container(
      //             height: 56,
      //             decoration: BoxDecoration(color: Colors.grey.shade900),
      //             alignment: Alignment.center,
      //             child: Consumer(
      //               builder: (context, ref, child) {
      //                 var orderSelect =
      //                     ref.watch(homeProvider.select((value) => value.orderSelect));
      //                 if (orderSelect == null) {
      //                   return GestureDetector(
      //                     onTap: () {
      //                       showOrderOptionDialog(context);
      //                       // showConfirmCodeDialog(context, ref, action: () async {
      //                       //   showOrderOptionDialog(context);
      //                       // });
      //                     },
      //                     child: Text(
      //                       S.current.selectOrder,
      //                       style: AppTextStyle.bold(color: Colors.white),
      //                     ),
      //                   );
      //                 }

      //                 return Row(children: [
      //                   const CartInfoWidget(),
      //                   const VerticalDivider(
      //                     indent: 20,
      //                     endIndent: 20,
      //                   ),
      //                   Expanded(
      //                     child: GestureDetector(
      //                       onTap: () {
      //                         showOrderOptionDialog(context);
      //                       },
      //                       child: Row(
      //                         mainAxisSize: MainAxisSize.min,
      //                         mainAxisAlignment: MainAxisAlignment.center,
      //                         children: [
      //                           Flexible(
      //                             child: Text(
      //                               "${S.current.table} ${orderSelect.getNameView()}",
      //                               style: AppTextStyle.bold(color: Colors.white),
      //                               textAlign: TextAlign.center,
      //                             ),
      //                           ),
      //                           const Gap(4),
      //                           const ResponsiveIconWidget(
      //                             iconData: Icons.change_circle_outlined,
      //                             color: Colors.white,
      //                           ),
      //                         ],
      //                       ),
      //                     ),
      //                   ),
      //                   const Gap(8),
      //                   AppButton(
      //                     textAction: S.of(context).payment,
      //                     onPressed: () async {
      //                       if (ref.read(homeProvider.notifier).getOrderSelect() == null) {
      //                         showMessageDialog(context, message: S.current.noOrderSelect);
      //                         return;
      //                       }

      //                       final OrderModel? order = await Navigator.of(context)
      //                           .push(MaterialPageRoute(builder: (context) => CheckoutPage()));
      //                     },
      //                   ),
      //                   // AppButtonWidget(
      //                   //   textAction: 'Thanh toán',
      //                   //   color: AppColors.mainColor,
      //                   //   padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      //                   //   borderRadius: BorderRadius.circular(8),
      //                   //   onTap: () async {
      //                   //     if (ref.read(homeProvider.notifier).getOrderSelect() == null) {
      //                   //       showMessageDialog(context, message: S.current.noOrderSelect);
      //                   //       return;
      //                   //     }

      //                   //     final OrderModel? order = await Navigator.of(context)
      //                   //         .push(MaterialPageRoute(builder: (context) => CheckoutPage()));
      //                   //   },
      //                   // ),
      //                   const Gap(8),
      //                 ]);
      //               },
      //             ),
      //           );
      //   },
      // ),
    );
  }

  void _showChatContent(WidgetRef ref) {
    if (_overlayEntry != null) {
      _overlayEntry?.remove();
      _overlayEntry = null;
    }
    RenderBox renderBox = _chatBubbleKey.currentContext!.findRenderObject() as RenderBox;
    var buttonPosition = renderBox.localToGlobal(Offset.zero);
    var buttonSize = renderBox.size;

    var mediaQuery = MediaQuery.of(context);
    var screenSize = mediaQuery.size;
    double screenWidth = screenSize.width;
    double screenHeight = screenSize.height;

    double popupLeft = buttonPosition.dx;
    double popupTop = buttonPosition.dy + buttonSize.height / 2;

    if (popupTop + chatPopupHeight > screenHeight) {
      popupTop = buttonPosition.dy - chatPopupHeight;
    }
    if (popupTop < 0) {
      popupTop = 10;
    }

    if (buttonPosition.dx + buttonSize.width / 2 + 5 < screenWidth / 2) {
      popupLeft = buttonPosition.dx + buttonSize.width + 5;
    } else {
      popupLeft = buttonPosition.dx - chatPopupWidth - 5;
    }

    _overlayEntry = _createOverlayEntry(popupLeft, popupTop);

    Overlay.of(context).insert(_overlayEntry!);
  }

  OverlayEntry _createOverlayEntry(double left, double top) {
    bool canReply = false;
    return OverlayEntry(
      builder: (context) => Stack(
        children: [
          GestureDetector(
            onTap: () {
              _overlayEntry?.remove();
              _overlayEntry = null;
            },
            child: Container(
              color: Colors.black45,
            ),
          ),
          Positioned(
            left: left,
            top: top,
            child: Material(
              color: Colors.transparent,
              child: GestureDetector(
                onTap: () {
                  // Prevent the popup from closing when tapped inside
                },
                child: Container(
                  width: chatPopupWidth,
                  height: chatPopupHeight,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 12,
                        offset: Offset(2, 2),
                      )
                    ],
                  ),
                  child: ChatContentBubble(
                    onClose: () {
                      _overlayEntry?.remove();
                      _overlayEntry = null;
                    },
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class ChatContentBubble extends ConsumerWidget {
  const ChatContentBubble({super.key, this.onClose});
  final VoidCallback? onClose;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: const BoxDecoration(
            color: AppColors.bgTitleChatPopup,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
            ),
          ),
          child:
              //  TitleWithCloseIconDialog(
              //   title: S.current.chat_with_customers,
              //   onPressedCloseBtn: onClose,
              // )
              Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                S.current.chat_with_customers,
                style: AppTextStyle.bold(color: Colors.white),
              ),
              ResponsiveIconButtonWidget(
                iconData: Icons.close,
                color: Colors.white,
                onPressed: onClose,
              ),
            ],
          ),
        ),
        Expanded(
          child: Consumer(builder: (context, ref, child) {
            final state = ref.watch(homeProvider.select((value) => value.getChatMessageState));

            final messages = ref.watch(homeProvider.select((value) => value.chatMessages));
            return ChatMessageView(
              state: state,
              messages: messages,
              onReload: ref.read(homeProvider.notifier).getO2OChatMessages,
            );
          }),
        ),
      ],
    );
  }
}

class ChatMessageView extends ConsumerWidget {
  const ChatMessageView({
    super.key,
    required this.state,
    this.messages = const [],
    this.onReload,
  });

  final PageState state;
  final List<ChatMessageModel> messages;
  final VoidCallback? onReload;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    switch (state.status) {
      case PageCommonState.loading:
        return const AppSimpleLoadingWidget();
      case PageCommonState.error:
        return AppErrorSimpleWidget(
          message: state.messageError,
          onTryAgain: () {
            onReload?.call();
          },
        );
      default:
        if (messages.isEmpty) {
          // // đang k có nút tải lại
          // return EmptyDataWidget(
          //   message: S.current.no_messages,
          // );
          return EmptyWidget(
            message: S.current.no_messages,
            onRefresh: () {
              onReload?.call();
            },
            emptyImage: SvgPicture.asset(
              Assets.iconsChat,
              height: 36,
              width: 36,
            ),
          );
        }
        Map<DateTime, List<ChatMessageModel>> map =
            messages.groupListsBy((e) => e.createdAt.onlyDate());
        List<DateTime> dates = map.keys.toList();
        dates.sort(
          (a, b) => b.compareTo(a),
        );
        return RefreshDataWidget(
          onRefresh: () {
            onReload?.call();
          },
          child: ListView.builder(
            padding: const EdgeInsets.only(top: 8, bottom: 8),
            itemBuilder: (context, index) {
              var date = dates[index];
              return ChatMessageGroupByDateItem(
                datetime: dates[index],
                messages: map[date] ?? [],
                showDate: dates.length > 1,
              );
            },
            itemCount: dates.length,
          ),
        );
    }
  }
}

class CartInfoWidget extends ConsumerWidget {
  const CartInfoWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container();
    // var numberOfProduct = 0;
    // var totalOrder = 0.0;
    // var productsSelecting = ref.watch(cartPageProvider.select((value) => value.productsSelecting));
    // var price = ref.watch(homeProvider.select((value) => value.dataBill.price));
    // var priceState = ref.watch(homeProvider.select((value) => value.dataBillState));
    // numberOfProduct = productsSelecting.length;
    // for (var element in productsSelecting) {
    //   totalOrder += (double.tryParse(element.unitPrice) ?? 0) * element.numberSelecting;
    // }
    // Widget priceView = Container();

    // switch (priceState.status) {
    //   case PageCommonState.loading:
    //     priceView = const CupertinoActivityIndicator(
    //         // color: AppColors.tcFooter,
    //         );
    //     break;
    //   case PageCommonState.error:
    //     priceView = InkWell(
    //       onTap: () {
    //         // ref.read(homeProvider.notifier).getDataBill();
    //       },
    //       child: Text(
    //         S.current.errorAndPressAgain,
    //         textAlign: TextAlign.center,
    //         style: AppTextStyle.bold(
    //           color: AppColors.redColor,
    //         ),
    //       ),
    //     );
    //     break;
    //   case PageCommonState.success:
    //     totalOrder += price.totalPriceFinal;
    //     priceView = Text(
    //       AppUtils.formatCurrency(value: totalOrder, symbol: 'đ'),
    //       textAlign: TextAlign.left,
    //       overflow: TextOverflow.fade,
    //       style: AppTextStyle.bold(
    //         color: AppColors.tcFooter,
    //       ),
    //     );
    //     break;
    //   default:
    //     priceView = const CupertinoActivityIndicator(color: AppColors.tcFooter);
    // }

    // return InkWell(
    //   onTap: () {
    //     if (ref.read(homeProvider.notifier).getOrderSelect() == null) {
    //       showMessageDialog(context, message: S.current.noOrderSelect);
    //       return;
    //     }
    //     showModalBottomSheet(
    //         context: context,
    //         isScrollControlled: true,
    //         builder: (context) {
    //           return const FractionallySizedBox(
    //             heightFactor: 0.92,
    //             child: CartPage(),
    //           );
    //         });
    //   },
    //   child: Stack(
    //     children: [
    //       Padding(
    //         padding: const EdgeInsets.symmetric(horizontal: 12),
    //         child: Center(
    //           child: Row(
    //             mainAxisAlignment: MainAxisAlignment.center,
    //             mainAxisSize: MainAxisSize.min,
    //             children: [
    //               badge_lib.Badge(
    //                 badgeContent: Text(
    //                   "$numberOfProduct",
    //                   style: AppTextStyle.regular(
    //                     color: Colors.white,
    //                     rawFontSize: numberOfProduct >= 10 ? 10 : 12,
    //                   ),
    //                 ),
    //                 child: const ResponsiveIconWidget(
    //                   iconData: CupertinoIcons.cart,
    //                   color: Colors.white,
    //                 ),
    //               ),
    //               const Gap(16),
    //               Flexible(child: FittedBox(child: priceView)),
    //             ],
    //           ),
    //         ),
    //       ),
    //       numberOfProduct <= 0
    //           ? Container()
    //           : Align(
    //               alignment: Alignment.topCenter,
    //               child: AnimatedTextKit(
    //                 animatedTexts: [
    //                   ColorizeAnimatedText(
    //                     S.current.letsOrderFood,
    //                     textStyle: AppTextStyle.bold(),
    //                     colors: AppColors.tcAnimationText,
    //                   ),
    //                 ],
    //                 isRepeatingAnimation: true,
    //                 totalRepeatCount: 5,
    //               ),
    //             ),
    //     ],
    //   ),
    // );
  }
}

class LogoWidget extends ConsumerWidget {
  const LogoWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () {
        showInfoRestaurantDialog(context);
      },
      onLongPress: () {
        showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (context) {
              return const FractionallySizedBox(
                heightFactor: 0.9,
                child: MorePage(),
              );
            });
      },
      child: Container(
        color: AppColors.bgMenu,
        width: double.maxFinite,
        height: 160, //appConfig.appHeaderHeight,
        child: Consumer(
          builder: (context, ref, _) {
            final info = ref.watch(userInfoProvider);
            return AppImageCacheNetworkWidget(
              key: UniqueKey(),
              imageUrl: info.restaurant?.logo ?? "",
              fit: BoxFit.cover,
              memCacheHeight: 720,
              memCacheWidth: 1080,
              errorWidget: Image.asset(
                Assets.imagesLogoH,
                height: 120,
                fit: BoxFit.cover,
              ),
            );
          },
        ),
      ),
    );
  }
}

class CheckoutBar extends StatelessWidget {
  final int itemCount;
  final int totalPrice;
  final VoidCallback? onCheckout;

  const CheckoutBar({
    super.key,
    required this.itemCount,
    required this.totalPrice,
    this.onCheckout,
  });

  String _formatPrice(int price) {
    // Format number with dots as thousands separator
    final str = price.toString();
    final buffer = StringBuffer();
    int count = 0;
    for (int i = str.length - 1; i >= 0; i--) {
      if (count > 0 && count % 3 == 0) buffer.write('.');
      buffer.write(str[i]);
      count++;
    }
    return buffer.toString().split('').reversed.join();
  }

  @override
  Widget build(BuildContext context) {
    const darkRed = Color(0xFFB71C1C);
    const mediumRed = Color(0xFFC62828);

    return Container(
      height: 64,
      decoration: BoxDecoration(
        color: mediumRed,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: darkRed.withOpacity(0.4),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          // Left: Cart icon + info
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: Row(
                children: [
                  // Cart icon with badge
                  InkWell(
                    onTap: () {
                      push(context, CartScreen());
                    },
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(
                            Icons.shopping_cart_outlined,
                            color: Colors.white,
                            size: 22,
                          ),
                        ),
                        Positioned(
                          top: -6,
                          right: -6,
                          child: Container(
                            width: 20,
                            height: 20,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Text(
                                '$itemCount',
                                style: const TextStyle(
                                  color: mediumRed,
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  // Text info
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '$itemCount MÓN ĐÃ CHỌN',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.85),
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0.3,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        '${_formatPrice(totalPrice)}đ',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // Divider
          // Container(
          //   width: 1,
          //   height: 40,
          //   color: Colors.white.withOpacity(0.2),
          // ),

          // Right: Thanh Toán button
          GestureDetector(
            onTap: onCheckout ?? () {},
            child: Container(
              height: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
              decoration: BoxDecoration(
                // withOpacity(0.12)
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    'Thanh Toán',
                    // style: TextStyle(
                    //   color: Colors.white,
                    //   fontSize: 15,
                    //   fontWeight: FontWeight.w600,
                    // ),
                  ),
                  SizedBox(width: 4),
                  Icon(
                    Icons.chevron_right,
                    // color: Colors.white,
                    size: 20,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
