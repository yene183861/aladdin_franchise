import 'dart:async';
import 'dart:convert';

import 'package:aladdin_franchise/generated/l10n.dart';
import 'package:aladdin_franchise/src/configs/enums/bill_setting.dart';
import 'package:aladdin_franchise/src/core/network/api/app_exception.dart';
import 'package:aladdin_franchise/src/core/network/repository/o2o/o2o_repository.dart';
import 'package:aladdin_franchise/src/core/network/repository/order/order_repository.dart';
import 'package:aladdin_franchise/src/core/network/provider.dart';
import 'package:aladdin_franchise/src/core/services/print_queue.dart';
import 'package:aladdin_franchise/src/core/storages/local.dart';
import 'package:aladdin_franchise/src/core/storages/provider.dart';
import 'package:aladdin_franchise/src/data/enum/print_type.dart';
import 'package:aladdin_franchise/src/data/model/restaurant/printer.dart';
import 'package:aladdin_franchise/src/features/dialogs/message.dart';
import 'package:aladdin_franchise/src/features/pages/home/components/menu/provider.dart';
import 'package:aladdin_franchise/src/features/pages/home/provider.dart';
import 'package:aladdin_franchise/src/features/pages/home/state.dart';
import 'package:aladdin_franchise/src/models/combo_item.dart';
import 'package:aladdin_franchise/src/models/ip_order.dart';
import 'package:aladdin_franchise/src/data/model/o2o/local_notification_model.dart';
import 'package:aladdin_franchise/src/data/model/o2o/o2o_order_model.dart';
import 'package:aladdin_franchise/src/data/model/o2o/request_order.dart';
import 'package:aladdin_franchise/src/models/order.dart';
import 'package:aladdin_franchise/src/models/product.dart';
import 'package:aladdin_franchise/src/utils/app_log.dart';
import 'package:aladdin_franchise/src/utils/app_printer/app_printer.dart';
import 'package:aladdin_franchise/src/utils/app_printer/app_printer_html.dart';
import 'package:aladdin_franchise/src/utils/app_printer/app_printer_normal.dart';
import 'package:aladdin_franchise/src/utils/product_helper.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'state.dart';

final orderToOnlinePageProvider =
    StateNotifierProvider.autoDispose<OrderToOnlinePageNotifier, OrderToOnlineState>((ref) {
  return OrderToOnlinePageNotifier(
    ref,
    ref.read(orderRepositoryProvider),
    ref.read(o2oRepositoryProvider),
  );
});

class OrderToOnlinePageNotifier extends StateNotifier<OrderToOnlineState> {
  OrderToOnlinePageNotifier(this.ref, this._orderRepository, this._o2oRepository)
      : super(const OrderToOnlineState()) {
    var orderSelect = ref.read(homeProvider).orderSelect;
    state = state.copyWith(
        orderSelect: orderSelect?.id != null ? O2OOrderModel(orderId: orderSelect!.id) : null);
  }
  final OrderRepository _orderRepository;
  final OrderToOnlineRepository _o2oRepository;
  final Ref ref;

  void onChangeViewMode(O2oViewModeEnum value) {
    state = state.copyWith(viewMode: value);
  }

  void onChangeShowLoadingGetData(bool value) {
    state = state.copyWith(showLoadingGetData: value);
  }

  void changeOrderSelect(O2OOrderModel? order) async {
    state = state.copyWith(
      orderSelect: order,
      chatMessages: [],
      getChatMessageState: const PageState(status: PageCommonState.success, messageError: ''),
    );

    if (order != null) {
      try {
        await onChangeLockedOrderId(orderId: order.orderId);
      } catch (ex) {
        //
      }
      getChatMessages();
    }
  }

  void cancelRequest({required String reason}) async {
    try {
      var orderSelect = state.orderSelect;
      var requestSelect = state.requestSelect;
      var listItem = state.requestSelect?.listItem ?? [];
      if (orderSelect == null || requestSelect == null || listItem.isEmpty) {
        return;
      }
      state =
          state.copyWith(event: OrderToOnlineEvent.loading, message: S.current.canceling_request);

      await _o2oRepository.processO2oRequest(
        orderId: orderSelect.orderId,
        orderItemId: requestSelect.id,
        orderItems: listItem,
        status: 2,
        notes: reason,
      );
      if (!ref.read(homeProvider).realtimeStatus) {
        ref.refresh(orderToOnlineProvider);
      }
      state = state.copyWith(
        event: OrderToOnlineEvent.success,
        message: '',
        requestSelect: null,
      );
    } catch (ex) {
      state = state.copyWith(
        event: OrderToOnlineEvent.error,
        message: ex.toString(),
      );
    }
  }

  Future<String?> acceptRequest1({
    String note = '',
    Set<PrinterModel> printerSelect = const <PrinterModel>{},
    bool useDefaultPrinter = true,
  }) async {
    try {
      var orderSelect = state.orderSelect;
      var requestSelect = state.requestSelect;
      var listItem = state.requestSelect?.listItem ?? [];

      if (orderSelect == null || requestSelect == null || listItem.isEmpty) {
        return null;
      }

      Map<int, List<ProductModel>> productPrint =
          ref.read(menuProvider.notifier).mapO2oItemWithPrintType(listItem);

      var order = OrderModel(
        id: orderSelect.orderId,
        name: orderSelect.tableName,
        misc: '{"order_code":"${orderSelect.orderCode}","remarks":""}',
      );

      state = state.copyWith(event: OrderToOnlineEvent.loading, message: S.current.processing);
      List<int> printerCheck = productPrint.keys.toList();
      List<IpOrderModel> printers = [];
      if (printerCheck.isNotEmpty) {
        printers = await _orderRepository.getIpPrinterOrder(
          order,
          productPrint.keys.toList(),
        );
      }

      await _o2oRepository.processO2oRequest(
        orderId: orderSelect.orderId,
        orderItemId: requestSelect.id,
        orderItems: listItem,
        status: 1,
        notes: note,
      );
      ref.refresh(orderToOnlineProvider);
      state = state.copyWith(
        event: OrderToOnlineEvent.success,
        message: '',
        requestSelect: null,
      );
      if (useDefaultPrinter) {
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
                note: note,
              );
        }
      } else {
        var allData = productPrint.values.expand((list) => list).toList();

        var resultSend = await ref.read(homeProvider.notifier).sendPrintData(
              type: PrintTypeEnum.order,
              products: allData,
              printers: printerSelect.toList(),
              useDefaultPrinters: false,
              totalBill: true,
              note: note,
            );
      }

      // if (!ref.read(homeProvider).realtimeStatus || !ref.read(printSettingProvider).autoAcceptO2o) {
      //   ref.read(menuProvider.notifier).printO2oRequest(
      //         order: order,
      //         context: context,
      //         data: productPrint,
      //         note: note,
      //         printers: printers,
      //       );
      // }

      if (orderSelect.orderId == ref.read(homeProvider).orderSelect?.id) {
        ref.read(homeProvider.notifier).getOrderProductCheckout();
      }
      return null;
    } catch (ex) {
      state = state.copyWith(
        event: OrderToOnlineEvent.error,
        message: ex.toString(),
      );
      return ex.toString();
    }
  }

  // void acceptRequest(
  //     {required String note, required BuildContext context}) async {
  //   try {
  //     var orderSelect = state.orderSelect;
  //     var requestSelect = state.requestSelect;
  //     var listItem = state.requestSelect?.listItem ?? [];

  //     if (orderSelect == null || requestSelect == null || listItem.isEmpty) {
  //       return;
  //     }

  //     Map<int, List<ProductModel>> productPrint =
  //         ref.read(menuProvider.notifier).mapO2oItemWithPrintType(listItem);

  //     var order = OrderModel(
  //       id: orderSelect.orderId,
  //       name: orderSelect.tableName,
  //       misc: '{"order_code":"${orderSelect.orderCode}","remarks":""}',
  //     );

  //     state = state.copyWith(
  //         event: OrderToOnlineEvent.loading, message: S.current.processing);
  //     List<int> printerCheck = productPrint.keys.toList();
  //     List<IpOrderModel> printers = [];
  //     if (printerCheck.isNotEmpty) {
  //       printers = await _orderRepository.getIpPrinterOrder(
  //         order,
  //         productPrint.keys.toList(),
  //       );
  //     }

  //     var result = await _o2oRepository.processO2oRequest(
  //       orderId: orderSelect.orderId,
  //       orderItemId: requestSelect.id,
  //       orderItems: listItem,
  //       status: 1,
  //       notes: note,
  //     );
  //     state = state.copyWith(
  //       event: OrderToOnlineEvent.success,
  //       message: '',
  //       requestSelect: null,
  //     );
  //     if (!ref.read(homeProvider).realtimeStatus) {
  //       ref.refresh(orderToOnlineProvider);
  //     }
  //     // var resultSend =
  //     /// check here
  //     // await ref.read(homeProvider.notifier).sendPrintData(
  //     //       type: PrintTypeEnum.order,
  //     //       products: productPrint,
  //     //       printers: printers
  //     //           .map((e) => PrinterModel(ip: e.ip, port: e.port, name: e.name))
  //     //           .toList(),
  //     //       useDefaultPrinters: true,
  //     //       totalBill: true,
  //     //       note: note ?? '',
  //     //     );
  //     // ref.read(menuProvider.notifier).printO2oRequest(
  //     //       order: order,
  //     //       context: context,
  //     //       data: productPrint,
  //     //       note: note,
  //     //       printers: printers,
  //     //     );
  //     // }

  //     if (orderSelect.orderId == ref.read(homeProvider).orderSelect?.id) {
  //       ref.read(homeProvider.notifier).getOrderProductCheckout();
  //     }
  //   } catch (ex) {
  //     state = state.copyWith(
  //       event: OrderToOnlineEvent.error,
  //       message: ex.toString(),
  //     );
  //   }
  // }

  Future<void> onChangeLockedOrderId({required int orderId, bool showLoading = false}) async {
    try {
      if (showLoading) {
        state = state.copyWith(
            event: OrderToOnlineEvent.loading, message: 'Đang kiểm tra trạng thái đơn bàn');
      }
      final locked = await _checkStatusLockOrder(orderId);
      if (showLoading) {
        state = state.copyWith(event: OrderToOnlineEvent.success, message: '');
      }
      var lockedIds = Set<int>.from(state.lockedOrderIds);
      if (locked) {
        lockedIds.add(orderId);
      } else {
        lockedIds.remove(orderId);
      }

      state = state.copyWith(lockedOrderIds: lockedIds);
      if (locked) {
        throw '${S.current.temporarily_locked_order}\n${S.current.msg_check_other_devices_using_the_same_order}';
      }
    } catch (ex) {
      if (showLoading) {
        state = state.copyWith(event: OrderToOnlineEvent.success, message: '');
      } else {
        rethrow;
      }
    }
  }

  Future<bool> _checkStatusLockOrder(int orderId) async {
    try {
      final result = await _orderRepository.checkStatusLockOrder(orderId);
      return result;
    } catch (ex) {
      return false;
    }
  }

  void onChangeRequestSelect({
    required RequestOrderModel request,
    required RequestOrderItemModel item,
  }) {
    var requestSelect = state.requestSelect;

    if (requestSelect == null || requestSelect.id != request.id) {
      state = state.copyWith(requestSelect: request.copyWith(listItem: [item]));
      return;
    }

    List<RequestOrderItemModel> itemsSelect =
        List<RequestOrderItemModel>.from(requestSelect.listItem);
    var itemCheck = itemsSelect.firstWhereOrNull((e) => e.id == item.id);
    if (itemCheck == null) {
      itemsSelect.add(item);
    } else {
      var index = itemsSelect.indexOf(itemCheck);
      if (index != -1) {
        itemsSelect.removeAt(index);
      }
    }
    state = state.copyWith(requestSelect: request.copyWith(listItem: itemsSelect));
  }

  void changeNoteRestaurantItem({
    required String itemId,
    required String codeProduct,
    required int requestId,
    String note = '',
  }) {
    // if (requestId == state.requestOrderId) {
    //   List<RequestOrderItemModel> orderItems = List<RequestOrderItemModel>.from(state.orderItems);
    //   final item =
    //       orderItems.firstWhereOrNull((e) => e.id == itemId && e.codeProduct == codeProduct);
    //   if (item != null) {
    //     orderItems.removeWhere((e) => e.id == itemId && e.codeProduct == codeProduct);
    //     orderItems.add(item.copyWith(noteRestaurant: note));
    //     state = state.copyWith(orderItems: orderItems);
    //   }
    // }
  }

  void changeStatusFilter(RequestProcessingStatus status) {
    state = state.copyWith(statusFilter: status);
  }

  void changeSortByNewestTime() {
    state = state.copyWith(sortByNewestTime: !state.sortByNewestTime);
  }

  // void addWaitingPaymentOrders(int orderId) {
  //   List<OrderModel> orders = List<OrderModel>.from(state.orders.keys);
  //   var order = orders.firstWhereOrNull((e) => e.id == orderId);
  //   if (order != null) {
  //     List<OrderModel> waitingPaymentOrders = List<OrderModel>.from(state.beingPaidOrders);
  //     state = state.copyWith(beingPaidOrders: [...waitingPaymentOrders, order]);
  //   }
  //   bool beingPaid = _checkBeingPaidOrder();
  //   state = state.copyWith(beingPaid: beingPaid);
  // }

  void changeStatusOrder(BuildContext context, ChangeOrderModel model) async {
    Map<O2OOrderModel, Map<String, dynamic>> orders =
        Map<O2OOrderModel, Map<String, dynamic>>.from(state.orders);
    List<O2OOrderModel> tables = List<O2OOrderModel>.from(state.orders.keys);
    if (orders.isEmpty) return;
    var orderChange = tables.firstWhereOrNull((e) => e.orderId == model.orderId);
    if (orderChange == null) return;
    var orderSelect = state.orderSelect;
    final status = model.orderStatus;
    Set<int> lockedOrderIds = Set<int>.from(state.lockedOrderIds);

    bool selected = orderSelect != null && orderSelect.orderId == model.orderId;

    switch (status) {
      /// đơn đang được thanh toán
      case OrderStatus.paymenting:
        if (!lockedOrderIds.contains(model.orderId)) {
          lockedOrderIds.add(model.orderId);
          state = state.copyWith(lockedOrderIds: lockedOrderIds);
        }
        return;

      /// đang thanh toán thì mở lại đơn cho khách order thêm
      case OrderStatus.proccessing:
        if (lockedOrderIds.contains(model.orderId)) {
          lockedOrderIds.removeWhere((e) => e == model.orderId);
          state = state.copyWith(lockedOrderIds: lockedOrderIds);
        }
        return;

      /// đơn thanh toán xong
      case OrderStatus.complete:
        if (lockedOrderIds.contains(model.orderId)) {
          lockedOrderIds.removeWhere((e) => e == model.orderId);
          state = state.copyWith(lockedOrderIds: lockedOrderIds);
        }
        orders.remove(orderSelect);
        state = state.copyWith(orders: orders);
        if (selected) {
          changeOrderSelect(orders.isEmpty ? null : orders.keys.first);
        }

        return;
      default:
    }
  }

  void changePrinterSelect(IpOrderModel? printer) {
    if (printer == null) {
      state = state.copyWith(printerSelect: null);
      return;
    }
    List<IpOrderModel> printers = List<IpOrderModel>.from(state.printers);
    if (!printers.contains(printer)) {
      state = state.copyWith(printerSelect: null);
      return;
    }
    state = state.copyWith(printerSelect: printer);
  }

  void printQRCode() async {
    var orderSelect = state.orderSelect;
    if (orderSelect == null || state.printerSelect == null) return;
    try {
      state = state.copyWith(
          event: OrderToOnlineEvent.loading, message: '${S.current.printing_QR_code}...');

      var message = await AppPrinterUtils.instance.printQrO2O(
          order: OrderModel(
            id: orderSelect.orderId,
            // orderCode: orderSelect.orderCode,
            name: orderSelect.tableName,
            misc: '{"order_code": "${orderSelect.orderCode}"}',
          ),
          printer: state.printerSelect!,
          linkO2o: orderSelect.qrOrderO2o.firstOrNull ?? '');
      message ??=
          '${S.current.print_QR_code_o2o_success}\n${S.current.at_the_printer}: ${state.printerSelect!.name}';
      state = state.copyWith(
        event: OrderToOnlineEvent.error,
        message: message,
      );
    } catch (ex) {
      state = state.copyWith(
        event: OrderToOnlineEvent.error,
        message: ex.toString(),
      );
    }
  }

  Future<String?> getPrinters() async {
    var orderSelect = state.orderSelect;
    if (orderSelect == null) {
      state = state.copyWith(printers: [], printerSelect: null);
      return null;
    }
    try {
      state = state.copyWith(
          event: OrderToOnlineEvent.loading, message: S.current.retrieving_printer_list);
      final result = await _orderRepository.getIpPrinterOrder(
          OrderModel(
              id: orderSelect.orderId,
              name: orderSelect.tableName,
              qrO2O: orderSelect.qrOrderO2o,
              misc: '{"order_code": "${orderSelect.orderCode}"}'),
          [0, 1, 3]);
      var printers = result;
      Set<String> listIps = {};
      final listPrinters = <IpOrderModel>[];

      for (final item in printers) {
        final key = '${item.ip}:${item.port}';
        if (!listIps.contains(key)) {
          listIps.add(key);
          listPrinters.add(item);
        }
      }
      state = state.copyWith(
        event: OrderToOnlineEvent.success,
        message: '',
        printers: listPrinters,
        printerSelect: printers.isNotEmpty ? printers.first : null,
      );
      return null;
    } catch (ex) {
      state = state.copyWith(
        event: OrderToOnlineEvent.error,
        message: ex.toString(),
      );
      return ex.toString();
    }
  }

  void selectAllRequestItem({required RequestOrderModel request, required bool selectAll}) {
    if (!selectAll) {
      state = state.copyWith(requestSelect: null);
      return;
    }
    state = state.copyWith(requestSelect: request);
  }

  void getChatMessages() async {
    if (!state.showChatTab) return;
    final loginData = LocalStorage.getDataLogin();
    int? restaurantId = loginData?.restaurant?.id;
    final orderSelect = state.orderSelect;
    state = state.copyWith(
      getChatMessageState: const PageState(status: PageCommonState.loading),
    );
    if (restaurantId == null || orderSelect == null) {
      state = state.copyWith(
        chatMessages: [],
        getChatMessageState:
            PageState(status: PageCommonState.success, messageError: S.current.no_data),
      );
      return;
    }

    try {
      final result = await _o2oRepository.getChatMessages(
        restaurantId: restaurantId,
        orderId: orderSelect.orderId,
      );

      state = state.copyWith(
        getChatMessageState: const PageState(status: PageCommonState.success, messageError: ''),
        chatMessages: result,
      );
    } catch (ex) {
      state = state.copyWith(
        getChatMessageState: PageState(status: PageCommonState.error, messageError: ex.toString()),
      );
    }
  }

  void onChangeShowChatTab({bool? value}) {
    state = state.copyWith(showChatTab: value ?? !state.showChatTab);
    if (state.showChatTab) {
      getChatMessages();
    }
  }
}
