import 'dart:async';

import 'package:aladdin_franchise/generated/assets.dart';
import 'package:aladdin_franchise/generated/l10n.dart';
import 'package:aladdin_franchise/src/configs/app.dart';
import 'package:aladdin_franchise/src/configs/color.dart';
import 'package:aladdin_franchise/src/configs/text_style.dart';
import 'package:aladdin_franchise/src/core/network/provider.dart';
import 'package:aladdin_franchise/src/core/storages/local.dart';
import 'package:aladdin_franchise/src/core/storages/provider.dart';
import 'package:aladdin_franchise/src/features/dialogs/error.dart';
import 'package:aladdin_franchise/src/features/dialogs/info_restaurant.dart';
import 'package:aladdin_franchise/src/features/dialogs/message.dart';
import 'package:aladdin_franchise/src/features/dialogs/order/order_option_dialog.dart';
import 'package:aladdin_franchise/src/features/dialogs/processing.dart';
import 'package:aladdin_franchise/src/features/pages/cart/view.dart';
import 'package:aladdin_franchise/src/features/pages/checkout/view.dart';
import 'package:aladdin_franchise/src/features/pages/home/components/action/btn_o2o.dart';
import 'package:aladdin_franchise/src/features/pages/home/components/menu/components/list_tag.dart';
import 'package:aladdin_franchise/src/features/pages/home/components/order/order_detail.dart';

import 'package:aladdin_franchise/src/features/pages/home/provider.dart';
import 'package:aladdin_franchise/src/features/pages/home/state.dart';
import 'package:aladdin_franchise/src/features/pages/more/view.dart';
import 'package:aladdin_franchise/src/features/pages/order_to_online/components/barrel_components.dart';
import 'package:aladdin_franchise/src/features/pages/table_layout/view.dart';
import 'package:aladdin_franchise/src/features/pages/table_layout/view_test.dart';
import 'package:aladdin_franchise/src/features/widgets/app_error_simple.dart';
import 'package:aladdin_franchise/src/features/widgets/button_main.dart';
import 'package:aladdin_franchise/src/features/widgets/gap.dart';
import 'package:aladdin_franchise/src/features/widgets/image.dart';
import 'package:aladdin_franchise/src/models/category.dart';
import 'package:aladdin_franchise/src/models/order.dart';
import 'package:aladdin_franchise/src/models/product.dart';
import 'package:aladdin_franchise/src/utils/app_check.dart';
import 'package:aladdin_franchise/src/utils/app_log.dart';
import 'package:aladdin_franchise/src/utils/app_util.dart';
import 'package:aladdin_franchise/src/utils/navigator.dart';
import 'package:aladdin_franchise/src/utils/show_snackbar.dart';
import 'package:aladdin_franchise/src/utils/size_util.dart';
import 'package:collection/collection.dart';
import 'package:diacritic/diacritic.dart';
import 'package:float_bubble/float_bubble.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'components/action/btn_refresh_data.dart';
import 'components/action/history_order.dart';
import 'components/menu/components/list_category.dart';
import 'components/menu/components/list_product.dart';
import 'components/action/type_order.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:badges/badges.dart' as badge_lib;

import 'components/drawer/drawer.dart';
import 'package:aladdin_franchise/src/features/widgets/app_icon_widget.dart';

import 'components/menu/view.dart';

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

            showErrorDialog(
              context,
              message: ref.read(homeProvider.notifier).getMessageError(),
            );
            // showMessageDialog(
            //   context,
            //   message: ref.read(homeProvider.notifier).getMessageError(),
            // );
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
            showProcessingDialog(context, message: 'Đang khóa thao tác đơn bàn...');
            break;
          case HomeEvent.updateReservation:
            showProcessingDialog(context, message: 'Đang cập nhật lịch đặt bàn...');
            break;
          case HomeEvent.updateOrderReservation:
            showProcessingDialog(context, message: 'Đang thay đổi lịch đặt bàn của đơn...');
            break;
          case HomeEvent.addCoupon:
            showProcessingDialog(context, message: S.current.checking);
            break;
          default:
            break;
        }
      };

  final GlobalKey _floatingBtnKey = GlobalKey();
  OverlayEntry? _overlayEntry;
  double chatPopupHeight = 600;
  double chatPopupWidth = 600;

  @override
  void dispose() {
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

    var viewPadding = MediaQuery.of(context).viewPadding;
    bool isMobile = AppDeviceSizeUtil.checkMobileDevice();
    bool isTablet = AppDeviceSizeUtil.checkTabletDevice();
    bool portraitOrientation = AppDeviceSizeUtil.checkPortraitOrientation(context);

    bool showOrderInfo = !(isMobile || (isTablet && portraitOrientation));

    return Scaffold(
      resizeToAvoidBottomInset: false,
      drawer: const HomeDrawer(),
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(viewPadding.left, 0, 0, 0),
            child: Row(
              children: [
                const Expanded(flex: 1, child: MenuPage()),
                !showOrderInfo
                    ? const SizedBox.shrink()
                    : Container(
                        constraints: const BoxConstraints(maxWidth: 500),
                        child: const OrderPanelWidget(),
                      ),
              ],
            ),
          ),
          Consumer(
            builder: (context, ref, child) {
              bool useO2o = LocalStorage.getDataLogin()?.restaurant?.o2oStatus ?? false;
              // useO2o = true;
              final orderSelect = ref.watch(homeProvider.select((value) => value.orderSelect));

              bool isMobile = Device.screenType == ScreenType.mobile;
              bool isSmallDevice = isMobile;

              return orderSelect == null
                  ? const SizedBox.shrink()
                  : !(kTypeOrder == AppConfig.orderOfflineValue && useO2o)
                      ? const SizedBox.shrink()
                      : FloatBubble(
                          show: true,
                          initialAlignment:
                              isSmallDevice ? Alignment(1, (140 / 100.w) - 1) : Alignment.topRight,
                          child: GestureDetector(
                            onTap: () {
                              _showChatPopup(ref);
                            },
                            child: Container(
                              key: _floatingBtnKey,
                              height: isSmallDevice ? 48 : 60,
                              width: isSmallDevice ? 48 : 60,
                              padding: EdgeInsets.all(isSmallDevice ? 12 : 12),
                              decoration: const BoxDecoration(
                                color: AppColors.bgBoxProduct,
                                shape: BoxShape.circle,
                              ),
                              child: SvgPicture.asset(
                                Assets.iconsChat,
                                color: AppColors.secondColor,
                              ),
                            ),
                          ),
                        );
            },
          ),
        ],
      ),
      bottomNavigationBar: Builder(
        builder: (context) {
          return showOrderInfo
              ? const SizedBox.shrink()
              : Container(
                  height: 56,
                  decoration: BoxDecoration(color: Colors.grey.shade900),
                  alignment: Alignment.center,
                  child: Consumer(
                    builder: (context, ref, child) {
                      var orderSelect =
                          ref.watch(homeProvider.select((value) => value.orderSelect));
                      if (orderSelect == null) {
                        return GestureDetector(
                          onTap: () {
                            showOrderOptionDialog(context);
                            // showConfirmCodeDialog(context, ref, action: () async {
                            //   showOrderOptionDialog(context);
                            // });
                          },
                          child: Text(
                            'Chọn đơn bàn thao tác',
                            style: AppTextStyle.bold(color: Colors.white),
                          ),
                        );
                      }

                      return Row(children: [
                        const CartInfoWidget(),
                        const VerticalDivider(
                          indent: 20,
                          endIndent: 20,
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              showOrderOptionDialog(context);
                            },
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Flexible(
                                  child: Text(
                                    "${S.current.table} ${orderSelect.getNameView()}",
                                    style: AppTextStyle.bold(color: Colors.white),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                const Gap(4),
                                const ResponsiveIconWidget(
                                  iconData: Icons.change_circle_outlined,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                          ),
                        ),
                        const Gap(8),
                        AppButtonWidget(
                          textAction: 'Thanh toán',
                          color: AppColors.mainColor,
                          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                          borderRadius: BorderRadius.circular(8),
                          onTap: () async {
                            if (ref.read(homeProvider.notifier).getOrderSelect() == null) {
                              showMessageDialog(context, message: S.current.noOrderSelect);
                              return;
                            }

                            final OrderModel? order = await Navigator.of(context)
                                .push(MaterialPageRoute(builder: (context) => CheckoutPage()));
                          },
                        ),
                        const Gap(8),
                      ]);
                    },
                  ),
                );
        },
      ),
    );
  }

  void _showChatPopup(WidgetRef ref) {
    return;
    // ref.read(homeProvider.notifier).getO2OChatMessages();
    // if (_overlayEntry != null) {
    //   _overlayEntry?.remove();
    //   _overlayEntry = null;
    // }
    // RenderBox renderBox = _floatingBtnKey.currentContext!.findRenderObject() as RenderBox;
    // var buttonPosition = renderBox.localToGlobal(Offset.zero);
    // var buttonSize = renderBox.size;

    // var mediaQuery = MediaQuery.of(context);
    // var screenSize = mediaQuery.size;
    // double screenWidth = screenSize.width;
    // double screenHeight = screenSize.height;

    // double popupLeft = buttonPosition.dx;
    // double popupTop = buttonPosition.dy + buttonSize.height / 2;

    // if (popupTop + chatPopupHeight > screenHeight) {
    //   popupTop = buttonPosition.dy - chatPopupHeight;
    // }
    // if (popupTop < 0) {
    //   popupTop = 10;
    // }

    // if (buttonPosition.dx + buttonSize.width / 2 + 5 < screenWidth / 2) {
    //   popupLeft = buttonPosition.dx + buttonSize.width + 5;
    // } else {
    //   popupLeft = buttonPosition.dx - chatPopupWidth - 5;
    // }

    // _overlayEntry = _createOverlayEntry(popupLeft, popupTop);

    // Overlay.of(context).insert(_overlayEntry!);
  }

  OverlayEntry _createOverlayEntry(double left, double top) {
    bool canReply = true;
    return OverlayEntry(
      builder: (context) => Stack(
        children: [
          GestureDetector(
            onTap: () {
              _overlayEntry?.remove();
              _overlayEntry = null;
            },
            child: Container(
              color: Colors.transparent,
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
                  child: Column(
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
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              S.current.chat_with_customers,
                              style: AppTextStyle.bold(color: Colors.white),
                            ),
                            ResponsiveIconButtonWidget(
                              iconData: Icons.close,
                              color: Colors.white,
                              onPressed: () {
                                _overlayEntry?.remove();
                                _overlayEntry = null;
                              },
                            ),
                          ],
                        ),
                      ),
                      // Expanded(
                      //   child: Consumer(builder: (context, ref, child) {
                      //     final getChatMessageState =
                      //         ref.watch(homeProvider.select((value) => value.getChatMessageState));

                      //     final chatMessages =
                      //         ref.watch(homeProvider.select((value) => value.chatMessages));
                      //     return ListChatWidget(
                      //       state: getChatMessageState,
                      //       chatMessages: chatMessages,
                      //       onReload: ref.read(homeProvider.notifier).getO2OChatMessages,
                      //     );
                      //   }),
                      // ),
                    ],
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

class CartInfoWidget extends ConsumerWidget {
  const CartInfoWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var numberOfProduct = 0;
    var totalOrder = 0.0;
    var productsSelecting = ref.watch(homeProvider.select((value) => value.productsSelecting));
    var price = ref.watch(homeProvider.select((value) => value.dataBill.price));
    var priceState = ref.watch(homeProvider.select((value) => value.dataBillState));
    numberOfProduct = productsSelecting.length;
    for (var element in productsSelecting) {
      totalOrder += (double.tryParse(element.unitPrice) ?? 0) * element.numberSelecting;
    }
    Widget priceView = Container();

    switch (priceState.status) {
      case PageCommonState.loading:
        priceView = const CupertinoActivityIndicator(
            // color: AppColors.tcFooter,
            );
        break;
      case PageCommonState.error:
        priceView = InkWell(
          onTap: () {
            ref.read(homeProvider.notifier).getDataBill();
          },
          child: Text(
            S.current.errorAndPressAgain,
            textAlign: TextAlign.center,
            style: AppTextStyle.bold(
              color: AppColors.redColor,
            ),
          ),
        );
        break;
      case PageCommonState.success:
        totalOrder += price.totalPriceFinal;
        priceView = Text(
          AppUtils.formatCurrency(value: totalOrder, symbol: 'đ'),
          // NumberFormat.currency(symbol: 'đ', locale: 'vi').format(totalOrder),
          textAlign: TextAlign.left,
          overflow: TextOverflow.fade,
          style: AppTextStyle.bold(
            color: AppColors.tcFooter,
          ),
        );
        break;
      default:
        priceView = const CupertinoActivityIndicator(color: AppColors.tcFooter);
    }

    return InkWell(
      onTap: () {
        if (ref.read(homeProvider.notifier).getOrderSelect() == null) {
          showMessageDialog(context, message: S.current.noOrderSelect);
          return;
        }
        showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (context) {
              return const FractionallySizedBox(
                heightFactor: 0.92,
                child: CartPage(),
              );
            });
      },
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  badge_lib.Badge(
                    badgeContent: Text(
                      "$numberOfProduct",
                      style: AppTextStyle.regular(
                        color: Colors.white,
                        rawFontSize: numberOfProduct >= 10 ? 10 : 12,
                      ),
                    ),
                    child: const ResponsiveIconWidget(
                      iconData: CupertinoIcons.cart,
                      color: Colors.white,
                    ),
                  ),
                  const Gap(16),
                  Flexible(child: FittedBox(child: priceView)),
                ],
              ),
            ),
          ),
          numberOfProduct <= 0
              ? Container()
              : Align(
                  alignment: Alignment.topCenter,
                  child: AnimatedTextKit(
                    animatedTexts: [
                      ColorizeAnimatedText(
                        S.current.letsOrderFood,
                        textStyle: AppTextStyle.bold(),
                        colors: AppColors.tcAnimationText,
                      ),
                    ],
                    isRepeatingAnimation: true,
                    totalRepeatCount: 5,
                  ),
                ),
        ],
      ),
    );
  }
}

// class _SearchDishWidget extends ConsumerWidget {
//   const _SearchDishWidget({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final inputBorder = OutlineInputBorder(
//       borderRadius: AppConfig.borderRadiusMain,
//       borderSide: BorderSide(
//         color: Colors.grey.shade300,
//       ),
//     );
//     var controller = ref.read(homeProvider.notifier).ctrlSearch;
//     final keyword = ref.watch(homeProvider.select((value) => value.search));

//     return TextFormField(
//       style: AppTextStyle.regular(),
//       decoration: InputDecoration(
//         contentPadding: EdgeInsets.zero,
//         prefixIcon: const ResponsiveIconWidget(iconData: CupertinoIcons.search),
//         hintText: S.of(context).searchDish,
//         hintStyle: AppTextStyle.light(rawFontSize: 12),
//         helperStyle: AppTextStyle.regular(rawFontSize: 13),
//         suffixIcon: keyword.trim().isEmpty
//             ? null
//             : IconButton(
//                 visualDensity: VisualDensity.compact,
//                 onPressed: () {
//                   controller.text = '';
//                   ref.read(homeProvider.notifier).changeSearch('');
//                 },
//                 color: AppColors.clearSearch,
//                 icon: const ResponsiveIconWidget(iconData: Icons.clear),
//               ),
//         enabledBorder: inputBorder,
//         border: inputBorder,
//       ),
//       controller: controller,
//       onTapOutside: (event) {
//         FocusManager.instance.primaryFocus?.unfocus();
//       },
//       onChanged: (value) {
//         ref.read(homeProvider.notifier).changeSearch(value);
//       },
//     );
//   }
// }

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

// class OrderPageTest extends ConsumerStatefulWidget {
//   OrderPageTest({Key? key}) : super(key: homeKey);

//   @override
//   ConsumerState createState() => _OrderPageTestState();
// }

// class _OrderPageTestState extends ConsumerState<OrderPageTest> with WidgetsBindingObserver {
//   late final Timer _timerReloadMenu;

//   late ScrollController _productScrollController;
//   late ScrollController _categoryScrollController;
//   Map<dynamic, GlobalKey> categoryKeys = {};

//   final GlobalKey _floatingBtnKey = GlobalKey();
//   OverlayEntry? _overlayEntry;
//   double chatPopupHeight = 600;
//   double chatPopupWidth = 600;

//   @override
//   void initState() {
//     super.initState();
//     _productScrollController = ScrollController();
//     _categoryScrollController = ScrollController();
//     _productScrollController.addListener(_onScrollProduct);
//     WidgetsBinding.instance.addObserver(this);
//     WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
//       _timerReloadMenu = Timer.periodic(
//         const Duration(minutes: 5),
//         (timer) {
//           ref.read(homeProvider.notifier).checkReloadMenu();
//         },
//       );
//     });
//   }

//   void _onScrollProduct() {
//     var state = ref.read(homeProvider);
//     var categories = state.categories;
//     var categorySelect = state.categorySelect;
//     var subCategorySelect = state.subCategorySelect;

//     List<dynamic> allCategory = [];
//     for (var item in categories) {
//       allCategory.add(item);
//       if ((item.children ?? []).isNotEmpty) {
//         allCategory.addAll(item.children ?? []);
//       }
//     }

//     for (var item in allCategory.reversed) {
//       bool isSubCategory = item is SubCategoryModel;
//       final ctx = categoryKeys[item]?.currentContext;

//       if (ctx != null) {
//         final box = ctx.findRenderObject();
//         if (box is RenderBox) {
//           final pos = box.localToGlobal(Offset.zero);
//           if (pos.dy <= 250) {
//             if (isSubCategory && item != subCategorySelect) {
//               var category = categories.firstWhereOrNull(
//                   (e) => (e.children ?? []).firstWhereOrNull((i) => i.id == item.id) != null);
//               if (category != categorySelect) {
//                 ref.read(homeProvider.notifier).changeCategorySelect(category);
//               }
//               ref.read(homeProvider.notifier).changeSubCategorySelect(item);
//               _scrollCategoryBarTo(item, allCategory);
//             } else if (!isSubCategory && item != categorySelect) {
//               ref.read(homeProvider.notifier).changeCategorySelect(item);
//               _scrollCategoryBarTo(item, allCategory);
//             }

//             break;
//           }
//         }
//       }
//     }

//     return;
//   }

//   void _scrollCategoryBarTo(dynamic item, List<dynamic> allCategory) {
//     var state = ref.read(homeProvider);
//     // var categories = state.categories;
//     var menuCategoryItem = state.menuCategoryItem;
//     // var categorySelect = state.categorySelect;

//     final visibleItems = ref
//         .read(homeProvider.notifier)
//         .categoryPositionsListener
//         .itemPositions
//         .value
//         .where((position) => position.itemLeadingEdge < 1 && position.itemTrailingEdge > 0)
//         .map((e) => e.index)
//         .toList();
//     List<dynamic> dataView = List.from(menuCategoryItem);
//     // for (var item in categories) {
//     //   bool selected = item == categorySelect;
//     //   dataView.add(item);
//     //   if (selected && (item.children ?? []).isNotEmpty) {
//     //     dataView.add(null);
//     //     dataView.addAll(item.children ?? []);
//     //   }
//     // }
//     var items = [];
//     for (var i in visibleItems) {
//       items.add(dataView[i]);
//     }
//     if (!items.contains(item)) {
//       var index = dataView.indexOf(item);
//       if (index != -1) {
//         ref.read(homeProvider.notifier).categoryScrollController.jumpTo(index: index);
//       }
//     }
//   }

//   void _scrollToCategory(dynamic item) {
//     BuildContext? ctx = categoryKeys[item]?.currentContext;
//     if (ctx != null) {
//       Scrollable.ensureVisible(
//         ctx,
//         duration: const Duration(milliseconds: 300),
//         alignment: 0,
//       );
//     }
//   }

//   @override
//   void dispose() {
//     isCheckTypeOrderInit = false;
//     _productScrollController.dispose();
//     _categoryScrollController.dispose();
//     kToken = "";
//     kTypeOrder = 0;
//     _timerReloadMenu.cancel();
//     WidgetsBinding.instance.removeObserver(this);
//     super.dispose();
//   }

//   @override
//   void didChangeAppLifecycleState(AppLifecycleState state) {
//     switch (state) {
//       case AppLifecycleState.resumed:
//         if (ref.read(homeProvider.notifier).getCheckReloadWhenHiddenApp()) {
//           ref.read(homeProvider.notifier).updateReloadWhenHiddenApp(false);
//           ref.read(homeProvider.notifier).getProducts();
//         }
//         break;
//       case AppLifecycleState.inactive:
//         showLog('inactive');
//         break;
//       case AppLifecycleState.paused:
//         showLog('paused');
//         break;
//       case AppLifecycleState.detached:
//         showLog('detached');
//         break;
//       case AppLifecycleState.hidden:
//         showLog('hidden');
//         break;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     checkUpdateApp(ref, context);
//     checkTypeOrder(ref, context);

//     var categories = ref.watch(homeProvider.select((value) => value.categories));
//     categoryKeys = ref.read(homeProvider.notifier).categoryKeys;
//     var products = ref.watch(homeProvider.select((value) => value.products));
//     var tags = ref.watch(homeProvider.select((value) => value.tags));

//     var productsView = List<ProductModel>.from(products);
//     var keyword = ref.watch(homeProvider.select((value) => value.search)).trim();
//     var tagSelect = ref.watch(homeProvider.select((value) => value.tagSelect));
//     if (tagSelect != null) {
//       productsView =
//           productsView.where((product) => (product.tags ?? []).contains(tagSelect.id)).toList();
//     }
//     if (keyword.isNotEmpty) {
//       var search = removeDiacritics(keyword).toLowerCase();
//       productsView = productsView
//           .where((product) =>
//               (product.getSearchName().toLowerCase()).contains(search) ||
//               (product.getSearchShortName().toLowerCase().contains(search)))
//           .toList();
//     }
//     List<Widget> dataView = [];
//     for (var cate in categories) {
//       List<ProductModel> categoryProducts =
//           productsView.where((e) => e.categoryId == cate.id).toList();
//       var subCategory = List<SubCategoryModel>.from((cate.children ?? []));
//       Map<SubCategoryModel, List<ProductModel>> subCategoryProducts = {};
//       for (var subCate in subCategory) {
//         var data = productsView.where((e) => e.categoryId == subCate.id).toList();

//         if (data.isNotEmpty) {
//           subCategoryProducts[subCate] = data;
//         }
//       }
//       if (categoryProducts.isNotEmpty || subCategoryProducts.isNotEmpty) {
//         dataView.add(SliverToBoxAdapter(
//           child: Container(
//             key: categoryKeys[cate],
//             decoration: const BoxDecoration(color: Colors.white),
//             padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
//             alignment: Alignment.centerLeft,
//             child: Text(
//               cate.title,
//               style: AppTextStyle.bold(),
//             ),
//           ),
//         ));
//         if (categoryProducts.isNotEmpty) {
//           dataView.add(SliverPadding(
//             padding: const EdgeInsets.only(left: 10),
//             sliver: SliverGrid.builder(
//               gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
//                 maxCrossAxisExtent: 180,
//                 mainAxisSpacing: 10,
//                 crossAxisSpacing: 10,
//                 childAspectRatio: 0.8,
//               ),
//               itemBuilder: (context, index) => ProductBoxWidget(product: categoryProducts[index]),
//               itemCount: categoryProducts.length,
//             ),
//           ));
//         }
//       }

//       subCategoryProducts.forEach(
//         (key, value) {
//           if (value.isNotEmpty) {
//             dataView.add(SliverToBoxAdapter(
//               child: Container(
//                 key: categoryKeys[key],
//                 decoration: const BoxDecoration(color: Colors.white),
//                 padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
//                 alignment: Alignment.centerLeft,
//                 child: Text(
//                   key.title,
//                   style: AppTextStyle.bold(),
//                 ),
//               ),
//             ));
//             dataView.add(SliverPadding(
//               padding: const EdgeInsets.only(left: 10),
//               sliver: SliverGrid.builder(
//                 gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
//                   maxCrossAxisExtent: 180,
//                   mainAxisSpacing: 10,
//                   crossAxisSpacing: 10,
//                   childAspectRatio: 0.8,
//                 ),
//                 itemBuilder: (context, index) => ProductBoxWidget(product: value[index]),
//                 itemCount: value.length,
//               ),
//             ));
//           }
//         },
//       );
//     }
//     var viewPadding = MediaQuery.of(context).viewPadding;
//     bool isMobile = AppDeviceSizeUtil.checkMobileDevice();
//     bool isTablet = AppDeviceSizeUtil.checkTabletDevice();
//     bool portraitOrientation = AppDeviceSizeUtil.checkPortraitOrientation(context);

//     bool showOrderInfo = !(isMobile || (isTablet && portraitOrientation));
//     bool emptyTags = tags.isEmpty;

//     return Padding(
//       padding: EdgeInsets.fromLTRB(viewPadding.left, 0, 0, 0),
//       child: Row(
//         children: [
//           Expanded(
//             flex: 1,
//             child: Column(
//               children: [
//                 Container(
//                   height: 48,
//                   width: double.maxFinite,
//                   alignment: Alignment.center,
//                   child: Row(
//                     children: [
//                       const Gap(16),
//                       Expanded(
//                         flex: 1,
//                         child: Text(
//                           'Menu Nhà hàng',
//                           style: AppTextStyle.bold(),
//                         ),
//                       ),
//                       const Gap(20),
//                       const Expanded(
//                         flex: 2,
//                         child: _SearchDishWidget(),
//                       ),
//                       const Gap(16),
//                     ],
//                   ),
//                 ),

//                 // Consumer(
//                 //   builder: (context, ref, child) {
//                 //     var tags = ref.watch(homeProvider.select((value) => value.tags));
//                 //     if (tags.isEmpty && isMobile) {
//                 //       return const SizedBox.shrink();
//                 //     }

//                 //     return SizedBox(
//                 //       height: 48,
//                 //       child: Row(
//                 //         children: [
//                 //           Expanded(
//                 //             child: Column(
//                 //               crossAxisAlignment: CrossAxisAlignment.start,
//                 //               children: [
//                 //                 Expanded(
//                 //                   child: Row(
//                 //                     children: [
//                 //                       const Expanded(
//                 //                         child: ListTagsWidget(),
//                 //                       ),
//                 //                       if (!isMobile) ...const [
//                 //                         Gap(8),
//                 //                         ButtonRefreshData(),
//                 //                         ButtonO2oData(),
//                 //                       ],
//                 //                       const Gap(8),
//                 //                       const TypeOrderWidget(),
//                 //                     ],
//                 //                   ),
//                 //                 ),
//                 //               ],
//                 //             ),
//                 //           ),
//                 //         ],
//                 //       ),
//                 //     );
//                 //   },
//                 // ),

//                 Container(
//                   height: 42.px,
//                   padding: const EdgeInsets.fromLTRB(0, 4, 8, 4),
//                   alignment: Alignment.center,
//                   child: ListCategoryWidget(
//                       categoryScrollController: _categoryScrollController,
//                       onTap: (category) async {
//                         _scrollToCategory(category);
//                         await Future.delayed(const Duration(milliseconds: 350));
//                         // ref.read(homeProvider.notifier).ctrlSearch.text = '';
//                         if (category is CategoryModel) {
//                           ref.read(homeProvider.notifier).changeCategorySelect(category);
//                           return;
//                         }
//                         ref.read(homeProvider.notifier).changeSubCategorySelect(category);
//                       }),
//                 ),
//                 Expanded(
//                   child: Consumer(builder: (context, ref, child) {
//                     var productsState =
//                         ref.watch(homeProvider.select((value) => value.productsState));

//                     switch (productsState.status) {
//                       case PageCommonState.normal:
//                       case PageCommonState.loading:
//                         return GridView.builder(
//                           padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
//                           gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
//                             maxCrossAxisExtent: 200,
//                             mainAxisSpacing: 10,
//                             crossAxisSpacing: 10,
//                             childAspectRatio: 0.7,
//                           ),
//                           itemBuilder: (BuildContext context, int index) {
//                             return const ProductBoxLoadingWidget();
//                           },
//                           itemCount: 12,
//                         );
//                       case PageCommonState.error:
//                         return AppErrorSimpleWidget(
//                           onTryAgain: () {
//                             ref.read(homeProvider.notifier).getProducts();
//                           },
//                           message: productsState.messageError,
//                         );
//                       case PageCommonState.success:
//                     }
//                     return CustomScrollView(
//                       controller: _productScrollController,
//                       slivers: [
//                         ...dataView,
//                         const SliverToBoxAdapter(child: Gap(50)),
//                       ],
//                     );
//                   }),
//                 ),
//               ],
//             ),
//           ),
//           !showOrderInfo
//               ? const SizedBox.shrink()
//               : Container(
//                   constraints: const BoxConstraints(maxWidth: 500),
//                   child: const OrderPanelWidget(),
//                 ),
//         ],
//       ),
//       // ),
//       // Consumer(
//       //   builder: (context, ref, child) {
//       //     bool useO2o = LocalStorage.getDataLogin()?.restaurant?.o2oStatus ?? false;
//       //     // useO2o = true;
//       //     final orderSelect = ref.watch(homeProvider.select((value) => value.orderSelect));

//       //     bool isMobile = Device.screenType == ScreenType.mobile;
//       //     bool isSmallDevice = isMobile;

//       //     return orderSelect == null
//       //         ? const SizedBox.shrink()
//       //         : !(kTypeOrder == AppConfig.orderOfflineValue && useO2o)
//       //             ? const SizedBox.shrink()
//       //             : FloatBubble(
//       //                 show: true,
//       //                 initialAlignment: isSmallDevice
//       //                     ? Alignment(1, (140 / 100.w) - 1)
//       //                     : Alignment.topRight,
//       //                 child: GestureDetector(
//       //                   onTap: () {
//       //                     _showChatPopup(ref);
//       //                   },
//       //                   child: Container(
//       //                     key: _floatingBtnKey,
//       //                     height: isSmallDevice ? 48 : 60,
//       //                     width: isSmallDevice ? 48 : 60,
//       //                     padding: EdgeInsets.all(isSmallDevice ? 12 : 12),
//       //                     decoration: const BoxDecoration(
//       //                       color: AppColors.bgBoxProduct,
//       //                       shape: BoxShape.circle,
//       //                     ),
//       //                     child: SvgPicture.asset(
//       //                       AppIcons.icChat,
//       //                       color: AppColors.secondColor,
//       //                     ),
//       //                   ),
//       //                 ),
//       //               );
//       //   },
//       // ),

//       // ],
//       // ),
//       //   bottomNavigationBar: Builder(
//       //     builder: (context) {
//       //       return showOrderInfo
//       //           ? const SizedBox.shrink()
//       //           : Container(
//       //               height: 56,
//       //               decoration: BoxDecoration(color: Colors.grey.shade900),
//       //               alignment: Alignment.center,
//       //               child: Consumer(
//       //                 builder: (context, ref, child) {
//       //                   var orderSelect =
//       //                       ref.watch(homeProvider.select((value) => value.orderSelect));
//       //                   if (orderSelect == null) {
//       //                     return GestureDetector(
//       //                       onTap: () {
//       //                         showOrderOptionDialog(context);
//       //                         // showConfirmCodeDialog(context, ref, action: () async {
//       //                         //   showOrderOptionDialog(context);
//       //                         // });
//       //                       },
//       //                       child: Text(
//       //                         'Chọn đơn bàn thao tác',
//       //                         style: AppTextStyle.bold(color: Colors.white),
//       //                       ),
//       //                     );
//       //                   }

//       //                   return Row(children: [
//       //                     const CartInfoWidget(),
//       //                     const VerticalDivider(
//       //                       indent: 20,
//       //                       endIndent: 20,
//       //                     ),
//       //                     Expanded(
//       //                       child: GestureDetector(
//       //                         onTap: () {
//       //                           showOrderOptionDialog(context);
//       //                         },
//       //                         child: Row(
//       //                           mainAxisSize: MainAxisSize.min,
//       //                           mainAxisAlignment: MainAxisAlignment.center,
//       //                           children: [
//       //                             Flexible(
//       //                               child: Text(
//       //                                 "${S.current.table} ${orderSelect.getNameView()}",
//       //                                 style: AppTextStyle.bold(color: Colors.white),
//       //                                 textAlign: TextAlign.center,
//       //                               ),
//       //                             ),
//       //                             const Gap(4),
//       //                             const ResponsiveIconWidget(
//       //                               iconData: Icons.change_circle_outlined,
//       //                               color: Colors.white,
//       //                             ),
//       //                           ],
//       //                         ),
//       //                       ),
//       //                     ),
//       //                     const Gap(8),
//       //                     AppButtonWidget(
//       //                       textAction: 'Thanh toán',
//       //                       padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
//       //                       borderRadius: BorderRadius.circular(8),
//       //                       onTap: () async {
//       //                         if (ref.read(homeProvider.notifier).getOrderSelect() == null) {
//       //                           showMessageDialog(context, message: S.current.noOrderSelect);
//       //                           return;
//       //                         }

//       //                         final OrderModel? order = await Navigator.of(context)
//       //                             .push(MaterialPageRoute(builder: (context) => CheckoutPage()));
//       //                       },
//       //                     ),
//       //                     const Gap(8),
//       //                   ]);
//       //                 },
//       //               ),
//       //             );
//       //     },
//       //   ),
//       // ),
//     );
//   }

//   // void _showChatPopup(WidgetRef ref) {
//   //   ref.read(homeProvider.notifier).getO2OChatMessages();
//   //   if (_overlayEntry != null) {
//   //     _overlayEntry?.remove();
//   //     _overlayEntry = null;
//   //   }
//   //   RenderBox renderBox = _floatingBtnKey.currentContext!.findRenderObject() as RenderBox;
//   //   var buttonPosition = renderBox.localToGlobal(Offset.zero);
//   //   var buttonSize = renderBox.size;

//   //   var mediaQuery = MediaQuery.of(context);
//   //   var screenSize = mediaQuery.size;
//   //   double screenWidth = screenSize.width;
//   //   double screenHeight = screenSize.height;

//   //   double popupLeft = buttonPosition.dx;
//   //   double popupTop = buttonPosition.dy + buttonSize.height / 2;

//   //   if (popupTop + chatPopupHeight > screenHeight) {
//   //     popupTop = buttonPosition.dy - chatPopupHeight;
//   //   }
//   //   if (popupTop < 0) {
//   //     popupTop = 10;
//   //   }

//   //   if (buttonPosition.dx + buttonSize.width / 2 + 5 < screenWidth / 2) {
//   //     popupLeft = buttonPosition.dx + buttonSize.width + 5;
//   //   } else {
//   //     popupLeft = buttonPosition.dx - chatPopupWidth - 5;
//   //   }

//   //   _overlayEntry = _createOverlayEntry(popupLeft, popupTop);

//   //   Overlay.of(context).insert(_overlayEntry!);
//   // }

//   OverlayEntry _createOverlayEntry(double left, double top) {
//     bool canReply = true;
//     return OverlayEntry(
//       builder: (context) => Stack(
//         children: [
//           GestureDetector(
//             onTap: () {
//               _overlayEntry?.remove();
//               _overlayEntry = null;
//             },
//             child: Container(
//               color: Colors.transparent,
//             ),
//           ),
//           Positioned(
//             left: left,
//             top: top,
//             child: Material(
//               color: Colors.transparent,
//               child: GestureDetector(
//                 onTap: () {
//                   // Prevent the popup from closing when tapped inside
//                 },
//                 child: Container(
//                   width: chatPopupWidth,
//                   height: chatPopupHeight,
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(12),
//                     boxShadow: const [
//                       BoxShadow(
//                         color: Colors.black12,
//                         blurRadius: 12,
//                         offset: Offset(2, 2),
//                       )
//                     ],
//                   ),
//                   child: Column(
//                     children: [
//                       Container(
//                         padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//                         decoration: const BoxDecoration(
//                           color: AppColors.bgTitleChatPopup,
//                           borderRadius: BorderRadius.only(
//                             topLeft: Radius.circular(12),
//                             topRight: Radius.circular(12),
//                           ),
//                         ),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Text(
//                               S.current.chat_with_customers,
//                               style: AppTextStyle.bold(color: Colors.white),
//                             ),
//                             ResponsiveIconButtonWidget(
//                               iconData: Icons.close,
//                               color: Colors.white,
//                               onPressed: () {
//                                 _overlayEntry?.remove();
//                                 _overlayEntry = null;
//                               },
//                             ),
//                           ],
//                         ),
//                       ),
//                       // Expanded(
//                       //   child: Consumer(builder: (context, ref, child) {
//                       //     final getChatMessageState =
//                       //         ref.watch(homeProvider.select((value) => value.getChatMessageState));

//                       //     final chatMessages =
//                       //         ref.watch(homeProvider.select((value) => value.chatMessages));
//                       //     return ListChatWidget(
//                       //       state: getChatMessageState,
//                       //       chatMessages: chatMessages,
//                       //       onReload: ref.read(homeProvider.notifier).getO2OChatMessages,
//                       //     );
//                       //   }),
//                       // ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
