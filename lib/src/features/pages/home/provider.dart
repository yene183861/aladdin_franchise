import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:aladdin_franchise/src/configs/app.dart';
import 'package:aladdin_franchise/src/configs/const.dart';
import 'package:aladdin_franchise/src/configs/enums/bill_setting.dart';
import 'package:aladdin_franchise/src/configs/enums/type_order.dart';
import 'package:aladdin_franchise/src/core/network/api/app_exception.dart';
import 'package:aladdin_franchise/src/core/network/api/safe_call_api.dart';
import 'package:aladdin_franchise/src/core/network/repository/coupon/coupon_repository.dart';
import 'package:aladdin_franchise/src/core/network/repository/customer/customer_repository.dart';
import 'package:aladdin_franchise/src/core/network/repository/invoice/invoice_repository.dart';
import 'package:aladdin_franchise/src/core/network/repository/menu/menu_repository.dart';
import 'package:aladdin_franchise/src/core/network/repository/o2o/o2o_repository.dart';
import 'package:aladdin_franchise/src/core/network/repository/order/order_repository.dart';
import 'package:aladdin_franchise/src/core/network/provider.dart';
import 'package:aladdin_franchise/src/core/network/repository/reservation/reservation_repository.dart';
import 'package:aladdin_franchise/src/core/network/repository/responses/customer.dart';
import 'package:aladdin_franchise/src/core/network/repository/responses/data_bill.dart';
import 'package:aladdin_franchise/src/core/network/repository/restaurant/restaurant_repository.dart';
import 'package:aladdin_franchise/src/core/network/repository/user/user_repository.dart';
import 'package:aladdin_franchise/src/core/services/local_notification.dart';
import 'package:aladdin_franchise/src/core/services/print_queue.dart';
import 'package:aladdin_franchise/src/core/storages/local.dart';
import 'package:aladdin_franchise/src/data/enum/discount_type.dart';
import 'package:aladdin_franchise/src/data/enum/payment_status.dart';
import 'package:aladdin_franchise/src/data/enum/print_type.dart';
import 'package:aladdin_franchise/src/data/enum/printer_type.dart';
import 'package:aladdin_franchise/src/data/enum/receipt_type.dart';
import 'package:aladdin_franchise/src/data/enum/reservation_status.dart';
import 'package:aladdin_franchise/src/data/enum/status.dart';
import 'package:aladdin_franchise/src/data/enum/windows_method.dart';
import 'package:aladdin_franchise/src/data/model/notification.dart';
import 'package:aladdin_franchise/src/data/model/o2o/o2o_config.dart';
import 'package:aladdin_franchise/src/data/model/o2o/o2o_order_model.dart';
import 'package:aladdin_franchise/src/data/model/o2o/request_order.dart';
import 'package:aladdin_franchise/src/data/model/reservation/reservation.dart';
import 'package:aladdin_franchise/src/data/model/restaurant/printer.dart';
import 'package:aladdin_franchise/src/data/request/payment_receipt_print.dart';
import 'package:aladdin_franchise/src/data/response/close_shift.dart';
import 'package:aladdin_franchise/src/features/common/process_state.dart';
import 'package:aladdin_franchise/src/features/dialogs/message.dart';
import 'package:aladdin_franchise/src/features/pages/cart/provider.dart';
import 'package:aladdin_franchise/src/features/pages/checkout/provider.dart';
import 'package:aladdin_franchise/src/features/pages/home/components/menu/provider.dart';
import 'package:aladdin_franchise/src/features/pages/home/state.dart';
import 'package:aladdin_franchise/src/features/pages/home/view.dart';
import 'package:aladdin_franchise/src/models/atm_pos.dart';
import 'package:aladdin_franchise/src/models/combo_item.dart';
import 'package:aladdin_franchise/src/models/customer/cusomter_portrait.dart';
import 'package:aladdin_franchise/src/models/customer/customer.dart';
import 'package:aladdin_franchise/src/models/customer/customer_policy.dart';
import 'package:aladdin_franchise/src/models/data_bill.dart';
import 'package:aladdin_franchise/src/models/ip_order.dart';
import 'package:aladdin_franchise/src/models/minvoice/minvoice.dart';
import 'package:aladdin_franchise/src/models/order.dart';
import 'package:aladdin_franchise/src/models/order_invoice/order_invoice.dart';
import 'package:aladdin_franchise/src/models/param_family/bank_param.dart';
import 'package:aladdin_franchise/src/models/payment_method/payment_method.dart';
import 'package:aladdin_franchise/src/models/product.dart';
import 'package:aladdin_franchise/src/models/product_checkout.dart';
import 'package:aladdin_franchise/src/models/table.dart';
import 'package:aladdin_franchise/src/models/user_bank.dart';
import 'package:aladdin_franchise/src/models/waiter.dart';
import 'package:aladdin_franchise/src/utils/app_log.dart';
import 'package:aladdin_franchise/src/utils/app_printer/app_printer_common.dart';
import 'package:aladdin_franchise/src/utils/app_printer/app_printer_html.dart';
import 'package:aladdin_franchise/src/utils/app_printer/app_printer_normal.dart';
import 'package:aladdin_franchise/src/utils/app_util.dart';
import 'package:aladdin_franchise/src/utils/date_time.dart';
import 'package:aladdin_franchise/src/utils/ip_config_helper.dart';
import 'package:aladdin_franchise/src/utils/product_helper.dart';
import 'package:aladdin_franchise/src/utils/subwindows_moniter%20copy.dart';
import 'package:collection/collection.dart';
import 'package:desktop_multi_window/desktop_multi_window.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:local_notifier/local_notifier.dart';
import 'package:redis/redis.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../../../../generated/l10n.dart';
import '../../../core/storages/provider.dart';

enum HomePaymentError {
  printBill,
  temp,
  complete,
  printCompleteError,
}

final homeProvider = StateNotifierProvider.autoDispose<HomeNotifier, HomeState>((ref) {
  return HomeNotifier(
    ref,
    ref.read(orderRepositoryProvider),
    ref.read(userRepositoryProvider),
    ref.read(customerRepositoryProvider),
    ref.read(couponRepositoryProvider),
    ref.read(restaurantRepositoryProvider),
    ref.read(menuRepositoryProvider),
    ref.read(o2oRepositoryProvider),
    ref.read(invoiceRepositoryProvider),
    ref.read(reservationRepositoryProvider),
  );
});

class HomeNotifier extends StateNotifier<HomeState> {
  HomeNotifier(
    this.ref,
    this._orderRepository,
    this._userRepository,
    this._customerRepository,
    this._couponRepository,
    this._restaurantRepository,
    this._menuRepository,
    this._o2oRepository,
    this._invoiceRepository,
    this._reservationRepository,
  ) : super(const HomeState()) {
    AppConfig.initHomeProvider = true;
    listenRedisChannel();
    loadNotifications();
    listenNotificationsChange();
    chatIdStreamController = StreamController<int?>.broadcast();
  }

  void listenNotificationsChange() async {
    if (Hive.isBoxOpen(AppConfig.notificationBoxName)) {
      Hive.box<NotificationModel>(AppConfig.notificationBoxName).listenable().addListener(() {
        if (mounted) {
          ref.read(homeProvider.notifier).loadNotifications();
        }
      });
    }
  }

  final Ref ref;
  final OrderRepository _orderRepository;
  final UserRepository _userRepository;
  final CustomerRepository _customerRepository;
  final CouponRepository _couponRepository;
  final RestaurantRepository _restaurantRepository;
  final MenuRepository _menuRepository;

  final OrderToOnlineRepository _o2oRepository;
  final InvoiceRepository _invoiceRepository;
  final ReservationRepository _reservationRepository;

  /// bắt buộc update lại thuế với giá trị mặc định
  bool requireUpdateDefaultTax = false;

  final selectedItemsScrollCtrl = ItemScrollController();
  final selectedItemsPositionsListener = ItemPositionsListener.create();

  final selectingItemsScrollCtrl = ItemScrollController();
  final selectingItemsPositionsListener = ItemPositionsListener.create();

  Command? pubCommand;

  late StreamController<int?> chatIdStreamController;

  @override
  void dispose() {
    chatIdStreamController.close();
    AppConfig.initHomeProvider = false;
    pubCommand = null;
    super.dispose();
  }

  void _lockOrder(dynamic ex) {
    if (ex is AppException && ex.errorCode == 423) {
      state = state.copyWith(lockedOrder: true);
    }
  }

  Future<void> _checkOrderSelect() async {
    if (state.orderSelect == null) {
      // _resetOrder();
      throw S.current.noOrderSelect;
    }
  }

  void initialize({
    bool fetchProducts = true,
    OrderModel? order,
  }) async {
    if (!mounted) return;
    state = state.copyWith(
      orderSelect: order,
      // banks: [],
      // paymentMethods: [],
      // listAtmPos: [],
    );
    // ref.refresh(o2oConfigProvider);

    // ref.refresh(printersProvider);
    // _resetOrder();
    ref.read(menuProvider.notifier).init(fetchProducts: fetchProducts);
    ref.read(checkoutPageProvider.notifier).initialize();
    ref.read(cartPageProvider.notifier).initialize();

    // if (order != null) {
    //   var checkoutNotifier = ref.read(checkoutPageProvider.notifier);
    //   getO2OChatMessages();
    //   // onLoadProductSelecting();
    //   // getOrderProductCheckout();
    //   // getOrderInvoice();
    //   if (checkoutNotifier.mounted) {
    //     checkoutNotifier.getOrderProductCheckout();
    //     checkoutNotifier.getOrderInvoice();
    //   }
    // }
  }

  // void onLoadProductSelecting() {
  //   var order = state.orderSelect;
  //   if (order == null) return;
  //   var productSelectingMap = LocalStorage.getOrderItemSelectingForOrder(order.id);

  //   List<ProductModel> selecting = [];
  //   var _products = ref.read(menuProvider).products;
  //   productSelectingMap.forEach((key, value) {
  //     var p = _products.firstWhereOrNull((e) => e.id.toString() == key);
  //     if (p != null) {
  //       selecting.add(p.copyWith(numberSelecting: value));
  //     }
  //   });

  //   ref.read(cartPageProvider.notifier).init(selecting);
  // }

  void updateEvent(HomeEvent? event) {
    state = state.copyWith(event: event ?? HomeEvent.normal);
  }

  void changeOrderSelect(OrderModel? order) async {
    var changeOrder = order?.id != state.orderSelect?.id;
    state = state.copyWith(orderSelect: order);
    if (order != null && order.typeOrder != kTypeOrder) {
      showLogs('change type order: ${order.typeOrder}', flags: 'changeOrderSelect');
      await LocalStorage.setTypeOrderWaiter(order.typeOrder);
      ref.refresh(typeOrderProvider);
      kTypeOrder = order.typeOrder;
      initialize(order: order);
    } else if (changeOrder) {
      showLogs('only change order', flags: 'changeOrderSelect');
      ref.read(checkoutPageProvider.notifier).initialize();
      ref.read(cartPageProvider.notifier).initialize();
    } else {
      showLogs('no change', flags: 'changeOrderSelect');
    }

    // if (state.orderSelect != null) {
    //   try {
    //     Map<String, int> data = {};
    //     // for (var e in state.productsSelecting) {
    //     //   data[e.id.toString()] = e.numberSelecting;
    //     // }

    //     await LocalStorage.setOrderItemSelectingForOrder(
    //       orderId: state.orderSelect!.id,
    //       data: data,
    //     );
    //   } catch (ex) {
    //     //
    //   }
    // }
    // _resetOrder();
    // if (orderModel != null) {
    //   if (orderModel.typeOrder != kTypeOrder) {
    //     await LocalStorage.setTypeOrderWaiter(orderModel.typeOrder);
    //     ref.refresh(typeOrderWaiterProvider);
    //     ref.read(homeProvider.notifier).initialize(order: orderModel);
    //   } else {
    //     getO2OChatMessages();
    //     onLoadProductSelecting();
    //     getOrderProductCheckout();
    //     getOrderInvoice();
    //   }
    // }
  }

  // Future<void> getOrderProductCheckout({
  //   bool loadingHome = false,
  //   bool applyPolicy = true,
  //   bool ignoreGetDataBill = false,
  // }) async {
  //   try {
  //     state = state.copyWith(
  //       productCheckoutState: const PageState(status: PageCommonState.loading),
  //     );
  //     if (loadingHome) updateEvent(HomeEvent.getProductCheckout);

  //     int tryAgain = 0;
  //     while (tryAgain < 3) {
  //       var orderSelect = state.orderSelect;
  //       try {
  //         if (orderSelect == null) {
  //           if (loadingHome) updateEvent(null);
  //           state = state.copyWith(
  //             productCheckoutState: const PageState(status: PageCommonState.success),
  //           );
  //           _resetOrder();
  //           return;
  //         }
  //         final data = await _orderRepository.getProductCheckout(orderSelect);

  //         final pc = List<ProductCheckoutModel>.from(data.data?.first.orderItem ?? []);

  //         final coupons = List<CustomerPolicyModel>.from(data.coupons ?? []);
  //         final customer = data.customer;
  //         var orderHistory = data.data?.first.orderHistory ?? [];
  //         state = state.copyWith(orderHistory: orderHistory);
  //         var notes = LocalStorage.getNotePerOrderItem(order: orderSelect);
  //         List<ProductModel> productsSelected = [];
  //         var products = ref.read(menuProvider).products;
  //         // map: ProductCheckoutModel -> ProductModel
  //         for (var item in pc) {
  //           var p = products.firstWhereOrNull((e) => e.id == item.id);
  //           if (p != null) {
  //             var changeProduct = p.copyWith(
  //               numberSelecting: item.quantity,
  //               note: notes?[p.id.toString()] ?? '',
  //             );
  //             productsSelected.add(changeProduct);
  //           } else {
  //             // case món k có trong menu (k hiện nhưng tiền # 0)
  //             productsSelected.add(
  //               ProductModel(
  //                 id: item.id,
  //                 numberSelecting: item.quantity,
  //                 unitPrice: item.unitPrice,
  //                 name: item.name,
  //                 language: item.language,
  //                 unit: item.unit,
  //                 tax: item.tax,
  //                 printerType: item.printerType,
  //                 note: notes?[item.id.toString()] ?? '',
  //               ),
  //             );
  //           }
  //         }

  //         for (final c in coupons) {
  //           /// cập nhật số lượng món 0 đồng
  //           if (c.isPromotion()) {
  //             final discountUpdate = List<DiscountPolicy>.from(c.discount);

  //             for (int dc = 0; dc < discountUpdate.length; dc++) {
  //               final dcIndex = discountUpdate[dc];

  //               for (final pt in c.promotionItems) {
  //                 if (pt.menuItemId.toString() == dcIndex.id) {
  //                   discountUpdate[dc] = dcIndex.copyWith(numberSelect: pt.quantity);
  //                   // cập nhật số lượng món tặng 0 đồng
  //                   var ps = productsSelected.firstWhereOrNull((e) => e.id == pt.menuItemId);

  //                   if (ps != null) {
  //                     try {
  //                       productsSelected[productsSelected.indexOf(ps)] =
  //                           ps.copyWith(quantityPromotion: ps.quantityPromotion + pt.quantity);
  //                     } catch (ex) {
  //                       //
  //                     }
  //                   }
  //                   var pcout = pc.firstWhereOrNull((e) => e.id == pt.menuItemId);
  //                   if (pcout != null) {
  //                     try {
  //                       pc[pc.indexOf(pcout)] = pcout.copyWith(
  //                           quantityPromotion: (ps?.quantityPromotion ?? 0) + pt.quantity);
  //                     } catch (ex) {
  //                       //
  //                     }
  //                   }
  //                 }
  //               }
  //             }
  //             coupons[coupons.indexOf(c)] = c.copyWith(discount: discountUpdate);
  //           }
  //         }

  //         var productSelectingMap = LocalStorage.getOrderItemSelectingForOrder(orderSelect.id);

  //         List<ProductModel> selecting = [];
  //         var _products = ref.read(menuProvider).products;
  //         productSelectingMap.forEach((key, value) {
  //           var p = _products.firstWhereOrNull((e) => e.id.toString() == key);
  //           if (p != null) {
  //             selecting.add(p.copyWith(numberSelecting: value));
  //           }
  //         });

  //         state = state.copyWith(
  //           coupons: coupons,
  //           customer: customer,
  //           numberOfAdults: max(data.numberOfAdults, 1),
  //           orderHistory: orderHistory,
  //         );
  //         ref.read(checkoutPageProvider.notifier).init(pc);
  //         for (var e in [
  //           WindowsMethodEnum.customer,
  //           WindowsMethodEnum.productCheckout,
  //         ]) {
  //           syncInfoCustomerPage(method: e);
  //         }

  //         state = state.copyWith(
  //             productCheckoutState: const PageState(status: PageCommonState.success));
  //         if (loadingHome) updateEvent(HomeEvent.normal);
  //         if (applyPolicy) {
  //           applyCustomerPolicy(loadingHome: false);
  //         } else {
  //           if (!ignoreGetDataBill) getDataBill();
  //         }
  //         break;
  //       } catch (ex) {
  //         if (ex is AppException && ex.errorCode == 423) {
  //           tryAgain == 3;
  //           state = state.copyWith(lockedOrder: true);
  //         }
  //         tryAgain++;
  //         if (tryAgain >= 3) {
  //           rethrow;
  //         }
  //       }
  //     }
  //   } catch (ex) {
  //     getDataBill();
  //     state = state.copyWith(
  //       productCheckoutState: PageState(
  //         status: PageCommonState.error,
  //         messageError: ex.toString(),
  //       ),
  //     );
  //     if (loadingHome) updateEvent(HomeEvent.normal);
  //   }
  // }

  /// Tạo đơn hàng mới
  /// [0]: orderId, -1 là lỗi tạo đơn mới
  /// [1]: Message
  Future<List<dynamic>> createNewOrder(
    List<int> tableIds, {
    required int typeOrder,
    ReservationModel? reservation,
    required String tableName,
  }) async {
    try {
      updateEvent(HomeEvent.createNewOrder);
      final result = await _orderRepository.createAndUpdateOrder(
        tableIds,
        const OrderModel(id: 0, name: "name", misc: "misc"),
        typeOrder: typeOrder,
        reservation: reservation,
        updateSaleInfo: true,
      );
      updateEvent(null);
      return [result.orderId, null];
    } catch (ex) {
      updateEvent(null);
      return [-1, ex.toString()];
    }
  }

  /// Cập nhật đơn hàng
  ///
  /// Khi yêu cầu huỷ đơn: tableIds = []
  Future<({String? error, int? orderId})> updateOrder(
    List<int> tableIds,
    OrderModel order, {
    bool cancel = false,
    ReservationModel? reservation,
  }) async {
    try {
      updateEvent(cancel ? HomeEvent.cancelOrder : HomeEvent.updateOrder);
      await _checkOrderSelect();
      final result = await _orderRepository.createAndUpdateOrder(
        tableIds,
        state.orderSelect!,
        reservation: reservation,
        typeOrder: kTypeOrder,
        updateSaleInfo: false,
      );

      if (tableIds.isEmpty) {
        try {
          LocalStorage.deleteNotePerOrderItem(order: state.orderSelect!);
        } catch (ex) {
          //
        }
      }
      updateEvent(null);
      return (error: null, orderId: result.orderId);
    } catch (ex) {
      _lockOrder(ex);
      updateEvent(null);
      return (error: ex.toString(), orderId: -1);
    }
  }

  OrderModel? getOrderSelect() => state.orderSelect;

  Future<void> logout() async {
    try {
      await LocalStorage.logout();
    } catch (ex) {
      //
    }
    ref.invalidate(checkLoginProvider);
  }

  // void _resetOrder() {
  //   state = state.copyWith(
  //     lockedOrder: false,
  //     // productsSelected: [],
  //     // productsSelecting: [],
  //     // productCheckout: [],
  //     productCheckoutState: const PageState(status: PageCommonState.success),
  //     customer: null,
  //     coupons: [],
  //     vouchers: [],
  //     createVouchers: null,
  //     applyPolicyState: const PageState(status: PageCommonState.success),
  //     paymentMethodSelected: null,
  //     statusPaymentGateway: false,
  //     totalPaymentGateway: 0.0,
  //     bankSelect: null,
  //     cashReceivedAmount: 0.0,
  //     atmPosSelect: null,
  //     invoice: null,
  //     orderInvoiceState: const PageState(),
  //     dataBill: const DataBillResponseData(),
  //     dataBillState: const PageState(status: PageCommonState.success),
  //     imageBills: [],
  //     numberOfAdults: 1,
  //     numberOfChildren: 0,
  //     kitchenNote: '',
  //     customerPortraitSelect: null,
  //     completeNote: '',
  //     printNumberOfPeople: false,
  //     autoScrollProducts: true,
  //     changedProductId: null,
  //     chatMessages: [],
  //     getChatMessageState: const PageState(status: PageCommonState.success),
  //   );

  //   try {
  //     ref.read(checkoutPageProvider.notifier).init([]);
  //   } catch (ex) {
  //     //
  //   }
  //   for (var e in [
  //     WindowsMethodEnum.order,
  //     WindowsMethodEnum.paymentMethod,
  //     WindowsMethodEnum.customer,
  //     WindowsMethodEnum.price,
  //     WindowsMethodEnum.productCheckout,
  //     WindowsMethodEnum.changeOrderProduct,
  //   ]) {
  //     syncInfoCustomerPage(method: e);
  //   }
  // }

  Future<void> loadingChangeOrderSelect(
    int orderId, {
    int? typeOrder,
    dynamic reservationCrmId,
  }) async {
    try {
      updateEvent(HomeEvent.loadingChangeOrderCurrent);
      state = state.copyWith(
          orderSelect: OrderModel(
        id: orderId,
        typeOrder: typeOrder ?? kTypeOrder,
        reservationCrmId: reservationCrmId,
      ));
      // _resetOrder();
      ref.invalidate(tablesAndOrdersProvider);
      updateEvent(null);
    } catch (ex) {
      state = state.copyWith(
        event: HomeEvent.errorInfo,
        messageError: "${S.current.error_change_order}\n"
            "---\n"
            "${S.current.ex_problem}: ${ex.toString()}",
        orderSelect: null,
      );
      // _resetOrder();
    }
  }

  String getMessageError() => state.messageError;

  void listenRedisChannel() async {
    StreamSubscription<dynamic>? streamSubscription;
    try {
      var info = LocalStorage.getDataLogin()?.restaurant?.redisGatewayPayment;
      if (info == null) return;
      var ip = info.host;
      var port = info.port;
      var password = info.password ?? '';
      final redisConnection = RedisConnection();
      showLog("$ip:$port", flags: "Connecting to");
      var command = await redisConnection.connect(ip, port);
      if (password.isNotEmpty) {
        await command.send_object(['AUTH', password]);
      }
      final pubSub = PubSub(command);
      pubSub.subscribe([
        kRedisUpdateItemChannel,
        kUserCreateOrderChannel,
        kUserUpdateOrderChannel,
        kPaymentRequestChannel,
        kCallStaffChannel,
        kStatusOrderChannel,
        // kUserUpdateItemOrderChannel,
        kLockOrderChannel,
        '$kPrintChannel.${LocalStorage.getDataLogin()?.restaurant?.id ?? 0}',
      ]);
      final stream = pubSub.getStream();
      streamSubscription = stream.listen(
        _handleRedisEvent,
        onError: (_, __) async {
          showLog("onError listing $_ $__");
          await streamSubscription?.cancel();
          _reconnectRedis(redisConnection: redisConnection);
        },
        onDone: () async {
          showLog("end listing");
          await streamSubscription?.cancel();
          _reconnectRedis(redisConnection: redisConnection);
        },
      );
      showLog("$ip:$port", flags: "On start listen");
      state = state.copyWith(
        reconnectRedis: false,
        realtimeStatus: true,
      );
      showLog(state.realtimeStatus, flags: "realtimeStatus");
    } catch (ex) {
      showLog(ex, flags: 'RedisConnection error');
      await streamSubscription?.cancel();
      _reconnectRedis();
    }
  }

  Future<String?> sendPrintData({
    required PrintTypeEnum type,
    List<ProductModel> products = const [],
    String note = '',
    List<PrinterModel> printers = const [],
    int? timeOrder,
    CloseShiftResponseModel? closeShiftData,
    PaymentReceiptPrintRequest? paymentData,
    bool printDirectly = false,
    bool useDefaultPrinters = true,
    bool totalBill = true,
    OrderModel? order,
    bool? useOddBill,
    AppPrinterSettingTypeEnum? appPrinterType,
  }) async {
    try {
      var orderPrint = order ?? state.orderSelect ?? const OrderModel();
      var id = DateTimeUtils.formatToString(
          time: DateTime.now(), newPattern: DateTimePatterns.dateTime3);
      var data = NotificationDataModel(
        id: id,
        type: type,
        mode: appPrinterType ?? LocalStorage.getPrintSetting().appPrinterType,
        closeShiftData: closeShiftData,
        paymentData: paymentData,
        useOddBill: useOddBill ?? ref.read(printSettingProvider).billReturnSetting.useOddBill,
        useDefaultPrinters: useDefaultPrinters,
        totalBill: totalBill,
        refId: null,
        senderDeviceId: kDeviceId,
        handleDeviceId: null,
        note: note,
        order: orderPrint,
        printers: printers,
        products: products,
        printStatus: PrintStatusEnum.waiting,
      );
      var printerDeviceId = ref.read(o2oConfigProvider).when(
          skipError: false,
          data: (data) => data.printerDeviceId,
          error: (error, stackTrace) => null,
          loading: () => null);
      var error = await _checkBeforeSendData(
        data: data.toJson(),
        order: orderPrint,
        ignoreSendEvent: printDirectly || printerDeviceId == kDeviceId,
        saveNotification: !(printDirectly || printerDeviceId == kDeviceId),
      );
      if (error != null) {
        throw error;
      }

      return null;
    } catch (ex) {
      return ex.toString();
    }
  }

  /// sau 15s k nhận được phản hồi kq in thì show thông báo
  void _checkResponsePrintStatus(String? notiId) async {
    if (notiId == null) return;
    await Future.delayed(const Duration(seconds: 15));
    try {
      if (!Hive.isBoxOpen(AppConfig.notificationBoxName)) return;
      var box = Hive.box<NotificationModel>(AppConfig.notificationBoxName);
      var values = box.values.toList();
      var noti = values.firstWhereOrNull((e) => e.id == notiId);
      if (noti != null) {
        var data = NotificationDataModel.fromJson(jsonDecode(noti.data));
        showLogs(data, flags: '_checkResponsePrintStatus notiId');
        if (data.printStatus == PrintStatusEnum.waiting) {
          if (!Hive.isBoxOpen(AppConfig.notificationBoxName)) return;
          box = Hive.box<NotificationModel>(AppConfig.notificationBoxName);
          values = box.values.toList();
          var valueIndex = values.indexWhere((e) => e.id == notiId);
          var title = 'Chưa nhận được kết quả phản hồi yêu cầu xử lý in.';
          var body = 'Kiểm tra lại thiết bị được cài là thiết bị in chính';
          data = data.copyWith(printStatus: PrintStatusEnum.noResponse);
          if (valueIndex != -1) {
            try {
              await box.putAt(
                valueIndex,
                noti.copyWith(
                  data: jsonEncode(data.toJson()),
                  title: title,
                  body: body,
                  viewed: false,
                  read: false,
                ),
              );
            } catch (ex) {
              //
            }
          }
          if (Platform.isAndroid || Platform.isIOS) {
            appLocalNotificationService?.showLocalNotification(title, '');
          } else if (Platform.isWindows || Platform.isMacOS || Platform.isLinux) {
            try {
              LocalNotification notification = LocalNotification(
                title: title,
                body: '',
              );
              notification.show();
            } catch (ex) {
              //
            }
          }
        }
      }
    } catch (ex) {
      showLogs(ex, flags: '_checkResponsePrintStatus ex');
    }
  }

  void _handleRedisEvent(dynamic event) async {
    showLog(event, flags: "New event");
    //[message, item-channel, {"event":"App\\Events\\ItemCreated","data":{"data":"created item","socket":null},"socket":null}]
    try {
      if (event[0] == "message") {
        showLog('run', flags: "Test reload");
        switch (event[1]) {
          case kRedisUpdateItemChannel:
            ref.read(menuProvider.notifier).updateReloadWhenHiddenApp(true);
            ref.read(menuProvider.notifier).getProducts();
            break;
          case kUserCreateOrderChannel:
          case kUserUpdateOrderChannel:
          case kCallStaffChannel:
          case kPaymentRequestChannel:
            _handleO2oEvent(event);
            break;
          default:
        }
        if (event[1] == '$kPrintChannel.${LocalStorage.getDataLogin()?.restaurant?.id ?? 0}') {
          _handlePrintRedisEvent(event);
        }
      }
    } catch (ex) {
      showLog(ex, flags: "Error listen redis");
    }
  }

  void _handleO2oEvent(dynamic event) async {
    final loginData = LocalStorage.getDataLogin();
    bool useO2O = loginData?.restaurant?.o2oStatus ?? false;
    if (!useO2O) return;
    dynamic dataDecode = jsonDecode(event[2])['data'];
    dynamic data = dataDecode['data'];
    showLogs(dataDecode, flags: 'dataDecode event');
    showLogs(data, flags: 'data event');
    int? restaurantId = loginData?.restaurant?.id;
    int? userId = loginData?.user?.id;
    dynamic eventRestaurantId = data['restaurant_id'];
    dynamic waiterId = data['waiter_id'];
    if (userId == null) return;
    if (restaurantId != eventRestaurantId) return;
    switch (event[1]) {
      case kUserCreateOrderChannel:
        ref.refresh(orderToOnlineProvider);
        var orderId = data['order_id'] as int?;
        chatIdStreamController.add(orderId);
        break;
      case kUserUpdateOrderChannel:
        ref.refresh(orderToOnlineProvider);
        var orderId = data['order_id'] as int?;
        chatIdStreamController.add(orderId);
        var o2oConfig = ref.read(o2oConfigProvider).when(
              data: (data) => data,
              error: (error, stackTrace) => O2oConfigModel(),
              loading: () => const O2oConfigModel(),
            );

        if (o2oConfig.isEnabled && kDeviceId == o2oConfig.printerDeviceId) {
          var orderId = data['order_id'] as int?;
          var status = data['status'] as int?;
          if (status != 1) return;
          var notes = data['notes'] as String?;
          var itemsData = (jsonDecode(data['items']) as Map<String, dynamic>?) ?? {};
          List<RequestOrderItemModel> items = itemsData.values
              .toList()
              .map((e) => RequestOrderItemModel.fromJson(e as Map<String, dynamic>))
              .toList();

          Map<int, List<ProductModel>> productPrint =
              ref.read(menuProvider.notifier).mapO2oItemWithPrintType(items);
          ref.read(tablesAndOrdersProvider).whenData(
            (value) async {
              var order = value.offline?.userUsing.firstWhereOrNull((e) => e.id == orderId);
              if (order == null) return;

              List<int> printerCheck = productPrint.keys.toList();
              List<IpOrderModel> printers = [];
              if (printerCheck.isNotEmpty) {
                int retry = 0;

                while (retry < 3) {
                  try {
                    printers = await _orderRepository.getIpPrinterOrder(
                      order,
                      productPrint.keys.toList(),
                    );
                    break;
                  } catch (ex) {
                    retry++;
                  }
                }
              }
              for (var printer in printers) {
                var products = productPrint[printer.type] ?? [];
                if (products.isEmpty) continue;
                var resultSend = await ref.read(homeProvider.notifier).sendPrintData(
                      type: PrintTypeEnum.order,
                      products: products,
                      printers: printers
                          .map((e) => PrinterModel(ip: e.ip, port: e.port, name: e.name))
                          .toList(),
                      useDefaultPrinters: true,
                      totalBill: true,
                      note: notes ?? '',
                    );
              }
              showLogs(productPrint, flags: 'productPrint');
              // ref.read(menuProvider.notifier).printO2oRequest(
              //       order: order,
              //       data: productPrint,
              //       note: notes,
              //       printers: printers,
              //     );
            },
          );
        }
        break;

      case kCallStaffChannel:
        final note = data['note'];
        final table = data['table'];
        var title = '${S.current.table} ${table ?? ''} ${S.current.request_service.toLowerCase()}';
        var body = note ?? '';
        var id = await _saveNotification(
          title: title,
          error: body,
          type: NotificationTypeEnum.o2oWaiter,
          order: OrderModel(
            name: table ?? '',
            id: data['order_id'] as int,
          ),
        );
        showLogs(id, flags: 'id');
        if (Platform.isAndroid) {
          appLocalNotificationService?.showLocalNotification(title, body);
        } else if (Platform.isWindows) {
          try {
            LocalNotification notification = LocalNotification(
              title: title,
              body: body,
            );
            notification.show();
          } catch (ex) {
            //
          }
        }
        break;

      case kPaymentRequestChannel:
        if (userId != waiterId) return;
        final table = data['table'];
        var title = '${S.current.table} ${table ?? ''} gọi thanh toán';
        _saveNotification(
          title: title,
          error: '',
          type: NotificationTypeEnum.o2oPayment,
          order: OrderModel(
            name: table ?? '',
            id: data['order_id'] as int,
          ),
        );
        if (Platform.isAndroid) {
          appLocalNotificationService?.showLocalNotification(title, '');
        } else if (Platform.isWindows) {
          try {
            LocalNotification notification = LocalNotification(
              title: title,
              body: '',
            );
            notification.show();
          } catch (ex) {
            //
          }
        }
        break;
    }
  }

  Future<void> _reconnectRedis({RedisConnection? redisConnection}) async {
    state = state.copyWith(
      reconnectRedis: true,
      realtimeStatus: false,
    );
    if (redisConnection != null) {
      await redisConnection.close();
    }
    await Future.delayed(
      const Duration(seconds: 5),
      () => listenRedisChannel(),
    );
  }

  void _handlePrintRedisEvent(dynamic event) async {
    try {
      var data = jsonDecode(event[2]);
      var restaurantId = data['restaurant_id'];
      if (restaurantId != LocalStorage.getDataLogin()?.restaurant?.id) return;
      dynamic dataDecode = data['data'];
      List<LineItemDataBill> lineItems = [];
      if (dataDecode['payment_data'] != null) {
        lineItems = (dataDecode['payment_data']['order_line_items'] as List<dynamic>).map((e) {
          var json = Map<String, dynamic>.from(e);
          var listItem = (e['list_item'] as List<dynamic>)
              .map((e) => SubLineItemDataBill.fromJson(e as Map<String, dynamic>))
              .toList();
          var result = LineItemDataBill.fromJson(json).copyWith(listItem: listItem, language: {});
          return result;
        }).toList();
        dataDecode['payment_data']['order_line_items'] = null;
        dataDecode['payment_data']['language'] = null;
      }

      var notificationData = NotificationDataModel.fromJson(dataDecode);
      notificationData = notificationData.copyWith(
          paymentData: notificationData.paymentData?.copyWith(orderLineItems: lineItems));
      var printDeviceId = data['printer_device_id'] as String?;

      var printType = notificationData.type;
      var printStatus = notificationData.printStatus;
      if ([PrintStatusEnum.done, PrintStatusEnum.error].contains(printStatus)) {
        if (notificationData.handleDeviceId != kDeviceId) _handlePrintStatus(notificationData);
        return;
      }
      switch (printType) {
        case PrintTypeEnum.order:
        case PrintTypeEnum.cancel:
          if (kDeviceId != printDeviceId) return;
          _handlePrintProcessItem(notificationData);

          break;
        case PrintTypeEnum.closeShift:
          if (kDeviceId != printDeviceId) return;
          _handlePrintCloseShift(notificationData);
          break;
        case PrintTypeEnum.payment:
          if (kDeviceId != printDeviceId) return;
          _handlePrintPaymentReceipt(notificationData);
          break;

        default:
      }
    } catch (ex) {
      showLogs(ex, flags: '_handlePrintRedisEvent ex');
    }
  }

  void _handlePrintStatus(NotificationDataModel data) async {
    var refId = data.refId;

    try {
      var noti = state.notifications;
      var checks = noti.where((e) {
        var notiData = NotificationDataModel.fromJson(jsonDecode(e.data) as Map<String, dynamic>);
        if (notiData.senderDeviceId == kDeviceId && refId == notiData.id) {
          return true;
        }
        return false;
      }).toList();
      var check = checks.firstOrNull;
      if (check != null) {
        var notiData =
            NotificationDataModel.fromJson(jsonDecode(check.data) as Map<String, dynamic>);
        String title = data.title ?? '';
        String body = data.message ?? '';
        try {
          if (!Hive.isBoxOpen(AppConfig.notificationBoxName)) return;
          var box = Hive.box<NotificationModel>(AppConfig.notificationBoxName);
          var values = box.values.toList();
          var valueIndex = values.indexWhere((e) => e.id == check.id);
          if (valueIndex != -1) {
            notiData = notiData.copyWith(
              printStatus: data.printStatus,
              handleDeviceId: data.handleDeviceId,
            );
            await box.putAt(
              valueIndex,
              check.copyWith(
                data: jsonEncode(notiData),
                title: title,
                body: body,
                viewed: false,
                read: false,
              ),
            );
          }
        } catch (ex) {
          showLogs(ex, flags: '_handlePrintStatus ex box hive');
          return;
        }
        if (data.printStatus == PrintStatusEnum.error) {
          if (Platform.isAndroid || Platform.isIOS) {
            appLocalNotificationService?.showLocalNotification(title, body);
          } else if (Platform.isWindows || Platform.isMacOS || Platform.isLinux) {
            try {
              LocalNotification notification = LocalNotification(
                title: title,
                body: body,
              );
              notification.show();
            } catch (ex) {
              //
            }
          }
        }
      }
    } catch (ex) {
      showLogs(ex, flags: '_handlePrintStatus ex');
      //
    }
  }

  void _handlePrintPaymentReceipt(NotificationDataModel data) async {
    try {
      var printers = data.printers;
      var order = data.order;

      showLogs(printers, flags: 'printers');
      showLogs(data.paymentData, flags: 'data.paymentData');
      if (data.paymentData == null || printers.isEmpty) return;
      final receiptData = data;
      for (var printer in printers) {
        PrintQueue.instance.addTask(
          ip: printer.ip!,
          port: printer.port!,
          buildReceipt: (generator) async {
            showLogs(receiptData, flags: 'data');
            var bytes = await AppPrinterHtmlUtils.instance.getReceptBillContent(data.paymentData!);
            return bytes;
          },
          onComplete: (success, error) async {
            if (success) {
              showLogs(null, flags: "✅ In thành công");
            } else {
              showLogs(error, flags: '❌ In thất bại');
            }
            var callback = data.copyWith(
              refId: data.id,
              id: DateTimeUtils.formatToString(
                  time: DateTime.now(), newPattern: DateTimePatterns.dateTime3),
              handleDeviceId: kDeviceId,
              printStatus: success ? PrintStatusEnum.done : PrintStatusEnum.error,
              message: error,
            );
            bool ignoreSendEvent = callback.senderDeviceId == callback.handleDeviceId;
            await _checkBeforeSendData(
              data: callback.toJson(),
              ignoreSendEvent: ignoreSendEvent,
              saveNotification: !ignoreSendEvent || !success,
              title: ignoreSendEvent
                  ? 'Sự cố in hoá đơn thanh toán (Đơn bàn ${order?.getNameView() ?? ''} - ${order?.getOrderMisc() ?? ''})'
                  : null,
              message: error,
            );
            if (ignoreSendEvent) {
              _handlePrintStatus(callback);
            }
          },
        );
      }
    } catch (ex) {
      showLogs(ex, flags: '_handlePrintPaymentReceipt ex');
    }
  }

  void _handlePrintCloseShift(NotificationDataModel data) async {
    try {
      var printMode = data.mode;

      var printers = data.printers;
      if (data.closeShiftData == null || printers.isEmpty) return;

      var bytes = printMode == AppPrinterSettingTypeEnum.normal
          ? await AppPrinterNormalUtils.instance.getCloseShift(data.closeShiftData!)
          : await AppPrinterHtmlUtils.instance.getCloseShiftContent(data.closeShiftData!);
      for (var printer in printers) {
        PrintQueue.instance.addTask(
          ip: printer.ip!,
          port: printer.port!,
          buildReceipt: (generator) async {
            return bytes;
          },
          onComplete: (success, error) async {
            if (success) {
              showLogs(null, flags: "✅ In thành công");
            } else {
              showLogs(error, flags: '❌ In thất bại');
            }
            var callback = data.copyWith(
              refId: data.id,
              id: DateTimeUtils.formatToString(
                  time: DateTime.now(), newPattern: DateTimePatterns.dateTime3),
              handleDeviceId: kDeviceId,
              printStatus: success ? PrintStatusEnum.done : PrintStatusEnum.error,
              message: error,
            );

            bool ignoreSendEvent = callback.senderDeviceId == callback.handleDeviceId;
            await _checkBeforeSendData(
              data: callback.toJson(),
              ignoreSendEvent: ignoreSendEvent,
              saveNotification: !ignoreSendEvent || !success,
              title: ignoreSendEvent ? 'Sự cố in phiếu chốt ca' : null,
              message: error,
            );
            if (ignoreSendEvent) {
              _handlePrintStatus(callback);
            }
          },
        );
      }
    } catch (ex) {
      showLogs(ex, flags: '_handlePrintProcessItem ex');
    }
  }

  void _handlePrintProcessItem(NotificationDataModel data) async {
    try {
      var note = data.note ?? '';

      var printMode = data.mode;

      var order = data.order;
      var products = data.products;

      var printers = data.printers;

      bool useOddBill = data.useOddBill;
      bool useDefaultPrinters = data.useDefaultPrinters;
      bool totalBill = data.totalBill;

      if (order == null || printers.isEmpty || products.isEmpty) return;
      bool cancel = data.type == PrintTypeEnum.cancel;
      bool printNormal = printMode == AppPrinterSettingTypeEnum.normal;

      var bytes = printNormal
          ? await AppPrinterNormalUtils.instance.generateBill(
              order: order,
              billSingle: false,
              cancel: cancel,
              timeOrder: 1,
              totalNote: note,
              products: products,
              title: cancel ? 'HUY DO' : 'BIll tổng',
            )
          : await AppPrinterHtmlUtils.instance
              .generateImageBill(AppPrinterHtmlUtils.instance.kitchenBillContent(
              order: order,
              product: products,
              note: note,
              timeOrders: 1,
              cancel: cancel,
              totalBill: true,
            ));
      Map<ProductModel, List<int>> oddBillDatas = {};
      bool initOddBillData = false;

      for (var printer in printers) {
        PrintQueue.instance.addTask(
          ip: printer.ip!,
          port: printer.port!,
          buildReceipt: (generator) async {
            return bytes;
          },
          onComplete: (success, error) async {
            var titleNoti = cancel ? 'Huỷ đồ' : 'Gọi món';

            String title = '$titleNoti ';
            var callback = data.copyWith(
              refId: data.id,
              id: DateTimeUtils.formatToString(
                  time: DateTime.now(), newPattern: DateTimePatterns.dateTime3),
              handleDeviceId: kDeviceId,
              printStatus: success ? PrintStatusEnum.done : PrintStatusEnum.error,
              message: error,
            );
            bool ignoreSendEvent = callback.senderDeviceId == callback.handleDeviceId;
            showLogs(ignoreSendEvent, flags: "ignoreSendEvent");
            if (success) {
              title =
                  '$titleNoti - In bill ${totalBill ? 'tổng' : 'lẻ'} xuống bếp, bar thành công: Đơn bàn ${order.getNameView()} (${order.getOrderMisc() ?? ''})';
              callback = callback.copyWith(
                title: title,
                message: error,
              );
              showLogs(null, flags: "✅ In bill tổng thành công");
              if (!cancel && useOddBill && totalBill) {
                /// nếu có bill tổng có:
                /// + đồ ăn + đồ uống => in bill lẻ tất cả
                /// + chỉ có đồ uống => bỏ qua
                Set<ProductModel> foods = <ProductModel>{}, drinks = <ProductModel>{};
                bool onlyDrinks = true;
                for (var p in products) {
                  // 4 - đồ uống
                  // 2 - đồ ăn
                  switch (p.printerType) {
                    case 2:
                      onlyDrinks = false;
                      foods.add(p);
                      break;
                    case 4:
                      drinks.add(p);
                      break;
                    default:
                  }
                }
                if (onlyDrinks) {
                  await _checkBeforeSendData(
                    data: callback.toJson(),
                    ignoreSendEvent: ignoreSendEvent,
                    order: order,
                    saveNotification: !ignoreSendEvent,
                    title: title,
                    message: error ?? '',
                  );
                  if (ignoreSendEvent) {
                    _handlePrintStatus(callback);
                  }
                  return;
                }
                if (!initOddBillData) {
                  for (var item in foods) {
                    var listComboItemPrint = ProductHelper().getComboDescription(item);
                    // món thường
                    if (listComboItemPrint == null || listComboItemPrint.isEmpty) {
                      var byteDatas = printNormal
                          ? await AppPrinterNormalUtils.instance.generateBill(
                              order: state.orderSelect!,
                              billSingle: false,
                              cancel: false,
                              timeOrder: 1,
                              totalNote: note,
                              products: [item],
                              title: 'BILL lẻ',
                            )
                          : await AppPrinterHtmlUtils.instance.generateImageBill(
                              AppPrinterHtmlUtils.instance.kitchenBillContent(
                                product: [item],
                                totalBill: false,
                                order: state.orderSelect!,
                                note: note,
                                timeOrders: 1,
                              ),
                            );
                      oddBillDatas[item] = byteDatas;
                    } else {
                      // in từng món trong combo
                      for (var ci in listComboItemPrint) {
                        var byteDatas = printNormal
                            ? await AppPrinterNormalUtils.instance.generateBill(
                                order: state.orderSelect!,
                                billSingle: false,
                                cancel: false,
                                timeOrder: 1,
                                totalNote: note,
                                products: [
                                  item.copyWith(description: jsonEncode([ci]))
                                ],
                                title: 'BILL lẻ',
                              )
                            : await AppPrinterHtmlUtils.instance.generateImageBill(
                                AppPrinterHtmlUtils.instance.kitchenBillContent(
                                  product: [
                                    item.copyWith(description: jsonEncode([ci]))
                                  ],
                                  totalBill: false,
                                  order: state.orderSelect!,
                                  note: note,
                                  timeOrders: 1,
                                ),
                              );
                        oddBillDatas[item.copyWith(description: jsonEncode([ci]))] = byteDatas;
                      }
                    }
                  }

                  for (var item in drinks) {
                    var byteDatas = printNormal
                        ? await AppPrinterNormalUtils.instance.generateBill(
                            order: state.orderSelect!,
                            billSingle: true,
                            cancel: false,
                            timeOrder: 1,
                            totalNote: note,
                            products: [item],
                            title: 'BILL LẺ',
                          )
                        : await AppPrinterHtmlUtils.instance.generateImageBill(
                            AppPrinterHtmlUtils.instance.kitchenBillContent(
                              product: [item],
                              totalBill: false,
                              order: state.orderSelect!,
                              note: note,
                              timeOrders: 1,
                            ),
                          );
                    oddBillDatas[item] = byteDatas;
                  }

                  initOddBillData = true;
                }
                if (oddBillDatas.isEmpty) {
                  await _checkBeforeSendData(
                    data: callback.toJson(),
                    ignoreSendEvent: ignoreSendEvent,
                    order: order,
                    saveNotification: !ignoreSendEvent,
                    title: title,
                    message: error ?? '',
                  );
                  if (ignoreSendEvent) {
                    _handlePrintStatus(callback);
                  }
                  return;
                }

                oddBillDatas.forEach(
                  (key, value) {
                    PrintQueue.instance.addTask(
                      ip: printer.ip ?? '',
                      port: printer.port ?? 9100,
                      buildReceipt: (generator) async {
                        return value;
                      },
                      onComplete: (success, error) async {
                        var subTitle =
                            '$titleNoti - Không thể in bill lẻ xuống bếp, bar: Đơn bàn ${order.getNameView()} (${order.getOrderMisc() ?? ''})';
                        if (success) {
                          showLogs(null, flags: "✅ In bill lẻ thành công");
                        } else {
                          showLogs("❌ In bill lẻ thất bại\n$key", flags: 'BILL LẺ');
                          _saveNotification(
                            title: subTitle,
                            error: error,
                            order: order,
                            dataDecode: callback
                                .copyWith(
                                  printStatus: PrintStatusEnum.error,
                                  totalBill: false,
                                  title: subTitle,
                                  message: error,
                                )
                                .toJson(),
                          );
                        }
                      },
                    );
                  },
                );
              }
              await _checkBeforeSendData(
                data: callback.toJson(),
                ignoreSendEvent: ignoreSendEvent,
                order: order,
                saveNotification: !ignoreSendEvent,
                title: title,
                message: error ?? '',
              );
              if (ignoreSendEvent) {
                _handlePrintStatus(callback);
              }
            } else {
              showLogs(error, flags: '❌ In bill tổng thất bại');
              title =
                  '$titleNoti - Không thể in bill ${totalBill ? 'tổng' : 'lẻ'} xuống bếp, bar: Đơn bàn ${order.getNameView()} (${order.getOrderMisc() ?? ''})';
              callback = callback.copyWith(
                title: title,
                message: error,
              );
              await _checkBeforeSendData(
                data: callback.toJson(),
                ignoreSendEvent: ignoreSendEvent,
                order: order,
                saveNotification: true,
                title: title,
                message: error ?? '',
              );
              if (ignoreSendEvent) {
                _handlePrintStatus(callback);
              }
            }
          },
        );
      }
    } catch (ex) {
      showLogs(ex, flags: '_handlePrintProcessItem ex');
    }
  }

  Future<String?> _checkBeforeSendData({
    Map<String, dynamic> data = const {},
    OrderModel? order,
    bool ignoreSendEvent = false,
    bool saveNotification = true,
    // String? titleError,
    // String? bodyError,

    String? title,
    String? message,
  }) async {
    if (data.isEmpty) return null;
    int retry = 0;
    // var printerDeviceId = ref.read(o2oConfigProvider).when(
    //     data: (data) => data.printerDeviceId,
    //     error: (error, stackTrace) => null,
    //     loading: () => null);
    String? error;
    bool sendEvent = !ignoreSendEvent
        // &&
        //     !(kDeviceId == printerDeviceId && kDeviceId == data['sender_device_id']
        // )
        ;

    showLogs(sendEvent, flags: 'sendEvent _checkBeforeSendData');
    if (sendEvent) {
      while (retry < 1) {
        try {
          await _restaurantRepository.sendPrintData(data);
          error = null;
          break;
        } catch (ex) {
          error = ex.toString();
          retry++;
          showLogs(ex, flags: 'send data print');
        }
      }
      if (error != null) {
        // if (titleError != null) {
        //   await _saveNotification(
        //     title: titleError,
        //     error: bodyError,
        //     dataDecode: data,
        //     order: order,
        //     viewed: true,
        //   );
        // }
        // if (saveNotification) {
        //   var notiId = await _saveNotification(
        //     title: 'Yêu cầu in đã được gửi tới hệ thống và đang chờ xử lý.',
        //     dataDecode: data,
        //     order: order,
        //     viewed: true,
        //   );
        //   if (sendEvent) _checkResponsePrintStatus(notiId);
        // }
        return error;
      }
    }
    if (saveNotification) {
      var notiId = await _saveNotification(
        title: title ?? 'Yêu cầu in đã được gửi tới hệ thống và đang chờ xử lý.',
        error: message ?? '',
        dataDecode: data,
        order: order,
        viewed: title == null,
      );

      showLogs(notiId, flags: 'notiId _checkBeforeSendData');
      if (sendEvent) _checkResponsePrintStatus(notiId);
    }
    if (!sendEvent) {
      _handlePrintRedisEvent([
        null,
        null,
        jsonEncode({
          'data': data,
          'printer_device_id': kDeviceId,
          'restaurant_id': LocalStorage.getDataLogin()?.restaurant?.id,
        })
      ]);
    }

    return null;
  }

  Future<String?> _saveNotification({
    required String title,
    String? error,
    OrderModel? order,
    dynamic dataDecode,
    NotificationTypeEnum type = NotificationTypeEnum.print,
    bool viewed = false,
  }) async {
    if (!Hive.isBoxOpen(AppConfig.notificationBoxName)) {
      return null;
    }
    var box = Hive.box<NotificationModel>(AppConfig.notificationBoxName);
    try {
      var id = DateTimeUtils.formatToString(
          time: DateTime.now(), newPattern: DateTimePatterns.dateTime3);
      await box.add(NotificationModel(
        id: id,
        title: title,
        body: error ?? '',
        orderId: order?.id,
        datetime: DateTime.now(),
        data: jsonEncode(dataDecode),
        type: type.name,
        viewed: viewed,
      ));
      return id;
    } catch (ex) {
      showLogs(ex, flags: '_saveNotification ex');
      return null;
    }
  }

  Future<bool> lockOrder({
    bool showLoading = true,
    bool lock = true,
    String? messageError,
  }) async {
    try {
      if (showLoading) updateEvent(lock ? HomeEvent.lockOrder : HomeEvent.unlockOrder);
      int retry = 0;

      do {
        try {
          var order = state.orderSelect;
          if (order == null) {
            throw S.current.noOrderSelect;
          }
          await _orderRepository.lockOrder(orderId: order.id, statusLock: lock ? 1 : 0);
          break;
        } catch (ex) {
          retry++;
          if (retry >= 3) {
            rethrow;
          }
        }
      } while (retry < 3);

      if (showLoading) updateEvent(null);
      ref.read(checkoutPageProvider.notifier).resetPaymentAndBank();
      return true;
    } catch (ex) {
      if (showLoading) updateEvent(null);
      state = state.copyWith(
        messageError: messageError ??
            "${S.current.failed_payment_closing}\n${S.current.ex_problem}: ${ex.toString()}",
      );
      return false;
    }
  }

  // Future<void> loadBanksInfo() async {
  //   try {
  //     state = state.copyWith(
  //       banksState: const PageState(status: PageCommonState.loading),
  //       banks: [],
  //       bankSelect: null,
  //     );
  //     syncInfoCustomerPage(method: WindowsMethodEnum.bank);
  //     await _checkOrderSelect();
  //     final apiBankParam = ApiBankParam(state.dataBill.order, getFinalPaymentPrice.totalPriceFinal);
  //     final paymentMethodSelect = state.paymentMethodSelected;
  //     final result = await _restaurantRepository.getBanks(apiBankParam);

  //     var bankView = List<UserBankModel>.from(result ?? []);
  //     // Loại bỏ những bank không hỗ trợ PTTT
  //     bankView.removeWhere(
  //         (element) => element.listPaymentId.contains(paymentMethodSelect?.key) == false);

  //     if (bankView.length == 1) {
  //       state = state.copyWith(bankSelect: bankView.first);
  //       syncInfoCustomerPage(method: WindowsMethodEnum.bank);
  //       // syncInfoForCustomer();
  //     }
  //     state = state.copyWith(
  //       banksState: const PageState(status: PageCommonState.success),
  //       banks: bankView,
  //     );
  //   } catch (ex) {
  //     state = state.copyWith(
  //       banksState: PageState(
  //         status: PageCommonState.error,
  //         messageError: ex.toString(),
  //       ),
  //     );
  //   }
  // }

  // /// áp dụng ưu đãi
  // ///
  // /// [loadingHome] = true - show loading giữa trang
  // ///
  // /// [requireApply] = false - bắt buộc áp dụng lại
  // Future<String?> applyCustomerPolicy({
  //   bool retry = true,
  //   bool loadingHome = true,
  //   bool ignoreGetDataBill = false,
  //   bool requireApply = false,
  // }) async {
  //   if (!ignoreGetDataBill) getDataBill(loadingHome: loadingHome);
  //   return null;
  // }

  // void onChangeKitchenNote(String note) {
  //   state = state.copyWith(kitchenNote: note);
  // }

  // void onChangeCompleteNote(String note) {
  //   state = state.copyWith(completeNote: note);
  // }

  // Future<String?> sendTicket({
  //   required String title,
  //   required String desc,
  //   List<File> files = const [],
  // }) async {
  //   return 'Chưa triển khai';
  // }

  // Future<({String? url, String? qr, int? expiryMin, String? error, int? statusCode})>
  //     getPaymentGateway() async {
  //   String? url, qr, error;
  //   int? statusCode;
  //   int? expiryMin;
  //   try {
  //     updateEvent(HomeEvent.getPaymentGateway);
  //     final apiBankParam = ApiBankParam(state.dataBill.order, getFinalPaymentPrice.totalPriceFinal);

  //     final paymentMethodSelect = state.paymentMethodSelected;
  //     if (paymentMethodSelect == null) {
  //       throw S.current.payment_method_not_select;
  //     }
  //     final result = await _restaurantRepository.getPaymentGateway(
  //       apiBankParam: apiBankParam,
  //       keyPaymentMethod: paymentMethodSelect.key,
  //     );

  //     var data = result;
  //     url = data?.url;
  //     qr = data?.qr;
  //     expiryMin = data?.expiryMin;
  //     error = data?.message;
  //     statusCode = data?.status;
  //   } catch (ex) {
  //     error = ex.toString();
  //   }
  //   updateEvent(HomeEvent.processed);
  //   return (
  //     url: url,
  //     qr: qr,
  //     expiryMin: expiryMin,
  //     error: error,
  //     statusCode: statusCode,
  //   );
  // }

  /// Close shift - Chốt ca

  Future<
      ({
        String? error,
        String? resultSendPrintData,
        String? checkPrinters,
        CloseShiftResponseModel? data,
      })> closeShift(BuildContext context) async {
    String? checkPrinters;
    CloseShiftResponseModel? data;
    try {
      updateEvent(HomeEvent.closingShift);
      var data = await _userRepository.closeShift();

      var printer = data.infoPrint;
      if (printer == null) {
        throw 'Chốt ca thành công nhưng không có thông tin máy in để in bill chốt ca.';
      }
      var result = await printCloseShiftBill(
        data: data,
        printDirectly: false,
        showLoading: false,
      );

      updateEvent(HomeEvent.normal);
      return (
        error: null,
        resultSendPrintData: result.resultSendPrintData,
        checkPrinters: result.checkPrinters,
        data: data
      );
    } catch (ex) {
      updateEvent(HomeEvent.normal);
      return (
        error: ex.toString(),
        resultSendPrintData: null,
        checkPrinters: checkPrinters,
        data: data
      );
    }
  }

  Future<
      ({
        String? resultSendPrintData,
        String? checkPrinters,
      })> printCloseShiftBill({
    CloseShiftResponseModel? data,
    bool showLoading = false,
    bool printDirectly = false,
  }) async {
    String? checkPrinter;
    if (showLoading) updateEvent(HomeEvent.closingShift);

    try {
      var infoPrint = data?.infoPrint;
      var printer = PrinterModel(
        ip: infoPrint?.ip,
        port: infoPrint?.port,
        name: infoPrint?.name ?? '',
        type: infoPrint?.type ?? 0,
        typeAreaLocation: infoPrint?.typeAreaLocation ?? 1,
      );
      checkPrinter = await AppPrinterCommon.checkPrinterStatus(printer);
      if (checkPrinter != null) {
        throw checkPrinter;
      }
      var resultSendPrintData = await ref.read(homeProvider.notifier).sendPrintData(
            type: PrintTypeEnum.closeShift,
            closeShiftData: data,
            printers: [printer],
            printDirectly: printDirectly,
          );
      if (showLoading) updateEvent(HomeEvent.normal);
      return (
        resultSendPrintData: resultSendPrintData,
        checkPrinters: null,
      );
    } catch (ex) {
      if (showLoading) updateEvent(HomeEvent.normal);
      return (
        resultSendPrintData: null,
        checkPrinters: checkPrinter,
      );
    }
  }

  // void onChangeAutoScrollProducts(bool value) {
  //   state = state.copyWith(autoScrollProducts: value);
  //   syncInfoCustomerPage(method: WindowsMethodEnum.changeOrderProduct);
  // }

  // void onChangeChangedProductId(int? id) {
  //   state = state.copyWith(changedProductId: id);
  //   syncInfoCustomerPage(method: WindowsMethodEnum.changeOrderProduct);
  // }

  void onChangePinnedOrder(bool value) {
    state = state.copyWith(pinnedOrder: value);
  }

  // void onChangeNotePerItem(ProductModel item, String? note) {
  //   try {
  //     var order = state.orderSelect;
  //     if (order == null) return;

  //     var items = LocalStorage.getNotePerOrderItem(order: order);
  //     Map<String, String> notes = items ?? <String, String>{};
  //     notes[item.id.toString()] = note ?? '';
  //     notes.removeWhere((key, value) => value.trim().isEmpty);
  //     LocalStorage.saveNotePerOrderItem(order: order, notes: notes);
  //   } catch (ex) {
  //     //
  //   }
  // }

  // void setUnlockOrder() {
  //   state = state.copyWith(lockedOrder: false);
  // }

  // // promotion
  // void changeSelectDiscountPromotion(
  //   CustomerPolicyModel coupon,
  //   DiscountPolicy discount,
  //   int amount,
  // ) {
  //   DiscountPolicy discountUpdate = discount.copyWith(numberSelect: amount);
  //   CustomerPolicyModel couponUpdate = coupon.copyWith();

  //   List<DiscountPolicy> listDiscountUpdate = List<DiscountPolicy>.from(couponUpdate.discount);
  //   listDiscountUpdate[listDiscountUpdate
  //       .indexWhere((element) => element.id == discountUpdate.id)] = discountUpdate;

  //   couponUpdate = couponUpdate.copyWith(discount: listDiscountUpdate);
  //   List<CustomerPolicyModel> couponState = List.from(state.coupons);
  //   couponState[couponState.indexWhere((element) => element.id == couponUpdate.id)] = couponUpdate;

  //   state = state.copyWith(coupons: couponState);
  //   applyCustomerPolicy();
  // }

  void onChangeCustomerLanguage() {
    syncInfoCustomerPage(method: WindowsMethodEnum.language);
  }

  // Future<String?> checkPrinter(List<IpOrderModel> printers) async {
  //   try {
  //     updateEvent(HomeEvent.checkPrinter);
  //     var resultCheck = await AppPrinterCommon.checkPrinters(printers);
  //     updateEvent(null);
  //     return resultCheck;
  //   } catch (ex) {
  //     updateEvent(null);
  //     return ex.toString();
  //   }
  // }

  // void onChangePrintNumberOfPeople() {
  //   state = state.copyWith(printNumberOfPeople: !state.printNumberOfPeople);
  // }

  // PriceDataBill get getFinalPaymentPrice => state.dataBill.price;

  // void onChangeOrderTabSelect(OrderTabEnum value) {
  //   state = state.copyWith(orderTabSelect: value);
  // }

  // // void onChangeDisplayOrderHistory(bool? value) {
  // //   state = state.copyWith(
  // //       displayOrderHistory: value ?? !state.displayOrderHistory);
  // // }

  // Future<String?> addItemToOrder({
  //   List<ProductModel> products = const [],
  //   double total = 0.0,
  //   String kitchenNote = '',
  // }) async {
  //   if (products.isEmpty) return null;
  //   updateEvent(HomeEvent.processOrder);
  //   try {
  //     await _orderRepository.processOrderItem(
  //       order: state.orderSelect!,
  //       total: total,
  //       products: products,
  //       note: kitchenNote,
  //       cancel: false,
  //     );
  //     getOrderProductCheckout();
  //     getDataBill();
  //     updateEvent(HomeEvent.normal);
  //     return null;
  //   } catch (ex) {
  //     updateEvent(HomeEvent.normal);
  //     _lockOrder(ex);
  //     return ex.toString();
  //   }
  // }

  // void getO2OChatMessages() async {
  //   try {
  //     var useO2o = LocalStorage.getDataLogin()?.restaurant?.o2oStatus ?? false;
  //     if (!useO2o) {
  //       state = state.copyWith(
  //         getChatMessageState: const PageState(status: PageCommonState.success),
  //         chatMessages: [],
  //       );
  //       return;
  //     }
  //     state = state.copyWith(
  //       getChatMessageState: const PageState(status: PageCommonState.loading),
  //     );
  //     final loginData = LocalStorage.getDataLogin();
  //     int? restaurantId = loginData?.restaurant?.id;
  //     final orderSelect = state.orderSelect;
  //     if (restaurantId == null || orderSelect == null) {
  //       state = state.copyWith(
  //         getChatMessageState:
  //             PageState(status: PageCommonState.error, messageError: S.current.no_data),
  //       );
  //       return;
  //     }

  //     final messages = await _o2oRepository.getChatMessages(
  //       restaurantId: restaurantId,
  //       orderId: orderSelect.id,
  //     );
  //     state = state.copyWith(
  //       getChatMessageState: const PageState(status: PageCommonState.success),
  //       chatMessages: messages,
  //     );
  //   } catch (ex) {
  //     state = state.copyWith(
  //       getChatMessageState: PageState(
  //         status: PageCommonState.error,
  //         messageError: ex.toString(),
  //       ),
  //     );
  //   }
  // }

  // void updateReservation(
  //   ReservationModel? reservation, {
  //   bool showLoading = false,
  // }) async {
  //   if (reservation == null) return;
  //   if (showLoading) updateEvent(HomeEvent.updateReservation);
  //   int retry = 0;
  //   while (retry < 3) {
  //     try {
  //       var result = await ref
  //           .read(reservationRepositoryProvider)
  //           .updateReservation(reservation.id, reservation);

  //       break;
  //     } catch (ex) {
  //       retry++;
  //     }
  //   }
  //   if (showLoading) updateEvent(null);
  // }

  // /// Chuyển giao đơn bàn
  // Future<String?> transferOrder(
  //   List<int> tableIds,
  //   OrderModel order,
  //   WaiterModel waiterTransfer, {
  //   ReservationModel? reservation,
  // }) async {
  //   try {
  //     updateEvent(HomeEvent.transferOrder);

  //     await _orderRepository.createAndUpdateOrder(
  //       tableIds,
  //       order,
  //       reservation: reservation,
  //       waiterTransfer: waiterTransfer,
  //       updateSaleInfo: false,
  //     );

  //     updateEvent(null);
  //     return null;
  //   } catch (ex) {
  //     updateEvent(null);
  //     return ex.toString();
  //   }
  // }

  // /// Cập nhật lịch đặt bàn cho đơn bàn
  // Future<String?> updateOrderReservation({
  //   required List<int> tableIds,
  //   ReservationModel? newReservation,
  // }) async {
  //   try {
  //     var orderSelect = state.orderSelect;
  //     if (orderSelect == null) return null;
  //     updateEvent(HomeEvent.updateOrderReservation);

  //     await _orderRepository.createAndUpdateOrder(
  //       tableIds,
  //       orderSelect,
  //       reservation: newReservation,
  //       updateSaleInfo: true,
  //     );

  //     state = state.copyWith(
  //       orderSelect: orderSelect.copyWith(reservationCrmId: newReservation?.id),
  //     );
  //     updateEvent(null);
  //     return null;
  //   } catch (ex) {
  //     updateEvent(null);
  //     return ex.toString();
  //   }
  // }

  Future<void> syncInfoCustomerPage({
    WindowsMethodEnum method = WindowsMethodEnum.data,
    dynamic arguments,
  }) async {
    if (!Platform.isWindows || state.pinnedOrder) return;

    var args = arguments ?? _tranferDataToCustomerPage(method: method);
    final subWindows = await DesktopMultiWindow.getAllSubWindowIds();
    for (final id in subWindows) {
      DesktopMultiWindow.invokeMethod(id, method.name, jsonEncode(args));
    }
  }

  Map<String, dynamic> getAllDataToCustomerPage() {
    var products = ref.read(menuProvider).products;
    var checkoutPage = ref.read(checkoutPageProvider);
    var productsCheckout = checkoutPage.productsCheckout;
    List<ProductModel> items = [];
    for (var i in productsCheckout) {
      var p = products.firstWhereOrNull((e) => e.id == i.id);
      if (p != null) {
        showLogs(i);
        items.add(p.copyWith(numberSelecting: i.quantity, unitPrice: i.unitPrice));
      } else {
        items.add(ProductModel(id: i.id, name: i.name, unitPrice: i.unitPrice, unit: i.unit));
      }
    }
    return {
      'order': state.orderSelect,
      'customer': checkoutPage.customer,
      'payment_method': checkoutPage.paymentMethodSelected,
      'price': checkoutPage.dataBill.price.copyWith(
        receivedAmount: (checkoutPage.paymentMethodSelected?.isCash ?? false)
            ? checkoutPage.cashReceivedAmount
            : 0,
      ),
      'bank': checkoutPage.bankSelect,
      'product': items,
      'auto_scroll': state.autoScrollProducts,
      'change_product_id': state.changedProductId,
    };
  }

  dynamic _tranferDataToCustomerPage({WindowsMethodEnum method = WindowsMethodEnum.data}) {
    var products = ref.read(menuProvider).products;
    var checkoutPage = ref.read(checkoutPageProvider);
    var productsCheckout = checkoutPage.productsCheckout;
    List<ProductModel> items = [];
    for (var i in productsCheckout) {
      var p = products.firstWhereOrNull((e) => e.id == i.id);
      if (p != null) {
        items.add(p.copyWith(
          numberSelecting: i.quantity,
          unitPrice: i.unitPrice,
        ));
      } else {
        items.add(ProductModel(id: i.id, name: i.name, unitPrice: i.unitPrice, unit: i.unit));
      }
    }
    switch (method) {
      case WindowsMethodEnum.data:
        return getAllDataToCustomerPage();
      case WindowsMethodEnum.order:
        return state.orderSelect;
      case WindowsMethodEnum.customer:
        return checkoutPage.customer;
      case WindowsMethodEnum.price:
        return checkoutPage.dataBill.price.copyWith(
          receivedAmount: (checkoutPage.paymentMethodSelected?.isCash ?? false)
              ? checkoutPage.cashReceivedAmount
              : 0,
        );
      case WindowsMethodEnum.paymentMethod:
        return checkoutPage.paymentMethodSelected;
      case WindowsMethodEnum.productCheckout:
        return items;
      case WindowsMethodEnum.completeNote:
        return checkoutPage.completeNote;
      case WindowsMethodEnum.kitchenNote:
        return checkoutPage.kitchenNote;
      case WindowsMethodEnum.bank:
        return checkoutPage.bankSelect;
      case WindowsMethodEnum.detailProduct:
        return null;
      case WindowsMethodEnum.language:
        return LocalStorage.getCustomerLanguageLocal().name;
      case WindowsMethodEnum.changeOrderProduct:
        return {
          'auto_scroll': state.autoScrollProducts,
          'change_product_id': state.changedProductId,
        };
      default:
        return null;
    }
  }

  // void updateReservationStatus(
  //   dynamic id,
  //   ReservationStatusEnum status,
  //   List<TableModel> table,
  // ) async {
  //   int retry = 0;
  //   while (retry < 3) {
  //     try {
  //       var result = await _reservationRepository.getReservationById(id);

  //       var reservation = result?.copyWith(
  //         status: status.type,
  //         statusName: status.title,
  //         table: table.map((e) => e.name).join(', '),
  //         tableId: table.map((e) => e.id).toList(),
  //       );
  //       updateReservation(reservation, showLoading: false);
  //       break;
  //     } catch (ex) {
  //       retry++;
  //     }
  //   }
  // }

  // Future<String?> saveO2oAutoProcessConfig(O2oConfigModel value) async {
  //   try {
  //     updateEvent(HomeEvent.saveO2oConfig);
  //     await _restaurantRepository.setO2oAutoAcceptConfig(
  //       isEnabled: value.isEnabled,
  //       confirmTimeout: value.confirmTimeout,
  //     );
  //     updateEvent(null);
  //     ref.refresh(o2oConfigProvider);
  //     return null;
  //   } catch (ex) {
  //     updateEvent(null);
  //     return ex.toString();
  //   }
  // }

  // Future<String?> savePrintDevice(bool enable) async {
  //   try {
  //     updateEvent(HomeEvent.saveO2oConfig);
  //     await _restaurantRepository.setO2oAutoAcceptConfig(
  //       changePrintDeviceId: enable,
  //     );
  //     updateEvent(null);
  //     ref.refresh(o2oConfigProvider);
  //     return null;
  //   } catch (ex) {
  //     updateEvent(null);
  //     return ex.toString();
  //   }
  // }

  // /// áp dụng lại mã giảm giá (mã giảm nhập số tiền, %)
  // Future<({String? errorRemove, String? errorAdd})> applyAgainVoucher() async {
  //   var coupon = state.coupons.firstOrNull;
  //   String? errorRemove, errorAdd;
  //   if (coupon == null) {
  //     return (errorRemove: null, errorAdd: null);
  //   } else {
  //     var discount = coupon.discount.firstOrNull;
  //     if (discount == null) return (errorRemove: null, errorAdd: null);
  //     int retry = 0;
  //     updateEvent(HomeEvent.applyPolicy);
  //     while (retry < 3) {
  //       try {
  //         await _couponRepository.deleteVoucher(coupon.id);
  //         var coupons = List<CustomerPolicyModel>.from(state.coupons);
  //         coupons.removeWhere((e) => e.id == coupon.id);
  //         state = state.copyWith(coupons: coupons);
  //         retry = 0;
  //         errorRemove = null;
  //         break;
  //       } catch (ex) {
  //         errorRemove = ex.toString();
  //         retry++;
  //       }
  //     }

  //     if (retry == 3) {
  //       updateEvent(null);
  //       return (errorRemove: errorRemove, errorAdd: errorAdd);
  //     }
  //     while (retry < 3) {
  //       try {
  //         final result = await _couponRepository.addVoucher(
  //           order: state.orderSelect!,
  //           totalBill: getFinalPaymentPrice.totalPrice * 1.0,
  //           amount: discount.amount,
  //           type: discount.type == DiscountTypeEnum.percent.key
  //               ? DiscountTypeEnum.percent
  //               : DiscountTypeEnum.vnd,
  //         );
  //         retry = 0;
  //         errorAdd = null;
  //         state = state.copyWith(
  //           coupons: [
  //             CustomerPolicyModel(
  //               id: result.id,
  //               name: result.name,
  //               type: null,
  //               isType: 3,
  //               discount: [
  //                 DiscountPolicy(
  //                   id: null,
  //                   name: null,
  //                   // do response trả về lại là số tiền giảm nên type sẽ là DiscountTypeEnum.vnd
  //                   // getOrderProductCheckout sẽ ghi đè lại thông in mã giảm
  //                   type: DiscountTypeEnum.vnd.key,
  //                   amount: result.amount,
  //                 ),
  //               ],
  //             ),
  //             ...state.coupons
  //           ],
  //         );
  //         getOrderProductCheckout();
  //         getDataBill();
  //         break;
  //       } catch (ex) {
  //         errorAdd = ex.toString();
  //         retry++;
  //       }
  //     }
  //     updateEvent(null);
  //     return (errorRemove: errorRemove, errorAdd: errorAdd);
  //   }
  // }

  // /// start - notification
  // ///
  // void markViewAllNotification() async {
  //   if (!Hive.isBoxOpen(AppConfig.notificationBoxName)) return;
  //   var box = Hive.box<NotificationModel>(AppConfig.notificationBoxName);
  //   final Map<dynamic, NotificationModel> updates = {};

  //   for (final key in box.keys) {
  //     final item = box.get(key);
  //     if (item != null) {
  //       updates[key] = item.copyWith(viewed: true);
  //     }
  //   }

  //   try {
  //     await box.putAll(updates);
  //   } catch (ex) {
  //     //
  //   }
  // }

  void loadNotifications() async {
    if (!Hive.isBoxOpen(AppConfig.notificationBoxName)) {
      return;
    }
    var box = Hive.box<NotificationModel>(AppConfig.notificationBoxName);
    final keysToDelete = box.keys.where((key) {
      final item = box.get(key);
      return item != null && item.datetime?.date != DateTime.now().date;
    }).toList();

    if (keysToDelete.isEmpty) {
      final values = box.values.toList();
      List<NotificationModel> data = [];

      data = values.where((e) => true).toList();

      data = List.from(data.reversed);
      data.sort((a, b) => (b.datetime ?? DateTime.now()).compareTo((a.datetime ?? DateTime.now())));

      state = state.copyWith(notifications: data);
    } else {
      try {
        await box.deleteAll(keysToDelete);
      } catch (ex) {
        //
      }
    }
  }

  // void markReadAllNotification(List<String> notiIds) async {
  //   if (!Hive.isBoxOpen(AppConfig.notificationBoxName)) return;
  //   var box = Hive.box<NotificationModel>(AppConfig.notificationBoxName);
  //   final Map<dynamic, NotificationModel> updates = {};

  //   for (final key in box.keys) {
  //     final item = box.get(key);
  //     if (item != null && notiIds.contains(item.id)) {
  //       updates[key] = item.markRead().copyWith(viewed: true);
  //     }
  //   }

  //   try {
  //     await box.putAll(updates);
  //   } catch (ex) {
  //     //
  //   }
  // }

  // void markReadNotification(String id) async {
  //   if (!Hive.isBoxOpen(AppConfig.notificationBoxName)) return;
  //   var box = Hive.box<NotificationModel>(AppConfig.notificationBoxName);
  //   final Map<dynamic, NotificationModel> updates = {};

  //   for (final key in box.keys) {
  //     final item = box.get(key);
  //     if (item != null && item.id == id) {
  //       updates[key] = item.markRead().copyWith(viewed: true);
  //     }
  //   }

  //   try {
  //     await box.putAll(updates);
  //   } catch (ex) {
  //     //
  //   }
  // }

  // void deleleNotification(List<String> notiIds) async {
  //   if (!Hive.isBoxOpen(AppConfig.notificationBoxName)) return;
  //   var box = Hive.box<NotificationModel>(AppConfig.notificationBoxName);
  //   final keysToDelete = box.keys.where((key) {
  //     final item = box.get(key);
  //     return item != null && notiIds.contains(item.id);
  //   }).toList();
  //   try {
  //     await box.deleteAll(keysToDelete);
  //   } catch (ex) {
  //     //
  //   }
  // }

  /// end - notifications
}
