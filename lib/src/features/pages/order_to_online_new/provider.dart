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
import 'package:aladdin_franchise/src/features/pages/checkout/provider.dart';
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
    StateNotifierProvider.autoDispose<NewOrderToOnlinePageNotifier, NewOrderToOnlineState>((ref) {
  return NewOrderToOnlinePageNotifier(
    ref,
    ref.read(orderRepositoryProvider),
    ref.read(o2oRepositoryProvider),
  );
});

class NewOrderToOnlinePageNotifier extends StateNotifier<NewOrderToOnlineState> {
  NewOrderToOnlinePageNotifier(this.ref, this._orderRepository, this._o2oRepository)
      : super(const NewOrderToOnlineState()) {
    var orderSelect = ref.read(homeProvider).orderSelect;
    state = state.copyWith(orderIdSelect: orderSelect?.id);
  }
  final OrderRepository _orderRepository;
  final OrderToOnlineRepository _o2oRepository;
  final Ref ref;

  void onChangeViewMode(O2oViewModeEnum value) {
    state = state.copyWith(viewMode: value);
  }

  // void onChangeShowLoadingGetData(bool value) {
  //   state = state.copyWith(showLoadingGetData: value);
  // }

  void changeOrderSelect(int? orderId) async {
    if (orderId == state.orderIdSelect) return;
    state = state.copyWith(
      orderIdSelect: orderId,
      chatMessages: [],
      getChatMessageState: const PageState(status: PageCommonState.success, messageError: ''),
      requestSelect: null,
    );
    getChatMessages();
  }

  void cancelRequest({required String reason}) async {
    try {
      var orderIdSelect = state.orderIdSelect;
      var requestSelect = state.requestSelect;
      var listItem = state.requestSelect?.listItem ?? [];
      if (orderIdSelect == null || requestSelect == null || listItem.isEmpty) {
        return;
      }
      state = state.copyWith(
          event: NewOrderToOnlineEvent.loading, message: S.current.canceling_request);

      await _o2oRepository.processO2oRequest(
        orderId: orderIdSelect,
        orderItemId: requestSelect.id,
        orderItems: listItem,
        status: 2,
        notes: reason,
      );
      ref.refresh(orderToOnlineProvider);
      state = state.copyWith(
        event: NewOrderToOnlineEvent.success,
        message: '',
        requestSelect: null,
      );
    } catch (ex) {
      state = state.copyWith(
        event: NewOrderToOnlineEvent.error,
        message: ex.toString(),
      );
    }
  }

  Future<({String? pingPrinters, String? error, String? resultSendPrintData})> acceptRequest({
    String note = '',
    Set<PrinterModel> printerSelect = const <PrinterModel>{},
    bool useDefaultPrinter = true,
    bool ignorePrint = false,
    bool processOrder = true,
  }) async {
    String? pingPrinters;
    String? resultSendPrintData;
    String? error;
    bool showLoading = processOrder || !ignorePrint;
    try {
      var orderIdSelect = state.orderIdSelect;
      var requestSelect = state.requestSelect;
      var listItem = state.requestSelect?.listItem ?? [];

      if (orderIdSelect == null || requestSelect == null || listItem.isEmpty) {
        return (pingPrinters: pingPrinters, error: error, resultSendPrintData: resultSendPrintData);
      }

      Map<int?, List<ProductModel>> productPrint =
          ref.read(menuProvider.notifier).mapO2oItemWithPrintType(listItem);
      if (showLoading) {
        state = state.copyWith(
          event: NewOrderToOnlineEvent.loading,
          message: S.current.processing,
        );
      }

      if (!ignorePrint) {
        // if (useDefaultPrinter) {
        //   for (var item in products) {
        //     switch (item.printerType) {
        //       case ProductPrinterType.drink:
        //         drinks.add(item);
        //         break;
        //       case ProductPrinterType.food:
        //         foods.add(item);
        //         break;
        //     }
        //   }

        //   for (var item in printerSelect) {
        //     switch (item.type) {
        //       case ProductPrinterType.drink:
        //         barPrinterDefault.add(item);
        //         break;
        //       case ProductPrinterType.food:
        //         foodPrinterDefault.add(item);
        //         break;
        //     }
        //   }

        //   if (drinks.isNotEmpty) {
        //     printers.addAll(barPrinterDefault);
        //   }
        //   if (foods.isNotEmpty) {
        //     printers.addAll(foodPrinterDefault);
        //   }
        // } else {
        //   printers = Set<PrinterModel>.from(printerSelect);
        // }
        // checkPrinters = await AppPrinterCommon.checkListPrintersStatus(printers.toList());
        // if (checkPrinters != null) throw checkPrinters;
      }

      if (processOrder) {
        await _o2oRepository.processO2oRequest(
          orderId: orderIdSelect,
          orderItemId: requestSelect.id,
          orderItems: listItem,
          status: 1,
          notes: note,
        );
        ref.refresh(orderToOnlineProvider);
        state = state.copyWith(requestSelect: null);
      }
      if (showLoading) {
        state = state.copyWith(
          event: NewOrderToOnlineEvent.success,
          message: '',
        );
      }

      if (useDefaultPrinter) {
        // for (var printer in printerSelect) {
        //   var products = productPrint[printer.type] ?? [];
        //   if (products.isEmpty) continue;
        //   resultSendPrintData = await ref.read(homeProvider.notifier).sendPrintData(
        //         type: PrintTypeEnum.order,
        //         products: products,
        //         printers: printers
        //             .map((e) => PrinterModel(ip: e.ip, port: e.port, name: e.name))
        //             .toList(),
        //         useDefaultPrinters: true,
        //         totalBill: true,
        //         note: note,
        //       );
        // }
      } else {
        var allData = productPrint.values.expand((list) => list).toList();

        resultSendPrintData = await ref.read(homeProvider.notifier).sendPrintData(
              type: PrintTypeEnum.order,
              products: allData,
              printers: printerSelect.toList(),
              useDefaultPrinters: false,
              totalBill: true,
              note: note,
            );
      }

      if (processOrder && orderIdSelect == ref.read(homeProvider).orderSelect?.id) {
        // ref.read(checkoutPageProvider.notifier).getProductCheckouts();
        // ref.read(checkoutPageProvider.notifier).getDataBill();
      }
      return (pingPrinters: pingPrinters, error: error, resultSendPrintData: resultSendPrintData);
    } catch (ex) {
      if (showLoading) {
        state = state.copyWith(
          event: NewOrderToOnlineEvent.error,
          message: ex.toString(),
        );
      }
      return (pingPrinters: pingPrinters, error: error, resultSendPrintData: resultSendPrintData);
    }
  }

  // Future<void> onChangeLockedOrderId({required int orderId, bool showLoading = false}) async {
  //   try {
  //     if (showLoading) {
  //       state = state.copyWith(
  //           event: OrderToOnlineEvent.loading, message: 'Đang kiểm tra trạng thái đơn bàn');
  //     }
  //     final locked = await _checkStatusLockOrder(orderId);
  //     if (showLoading) {
  //       state = state.copyWith(event: OrderToOnlineEvent.success, message: '');
  //     }
  //     var lockedIds = Set<int>.from(state.lockedOrderIds);
  //     if (locked) {
  //       lockedIds.add(orderId);
  //     } else {
  //       lockedIds.remove(orderId);
  //     }

  //     state = state.copyWith(lockedOrderIds: lockedIds);
  //     if (locked) {
  //       throw '${S.current.temporarily_locked_order}\n${S.current.msg_check_other_devices_using_the_same_order}';
  //     }
  //   } catch (ex) {
  //     if (showLoading) {
  //       state = state.copyWith(event: OrderToOnlineEvent.success, message: '');
  //     } else {
  //       rethrow;
  //     }
  //   }
  // }

  // Future<bool> _checkStatusLockOrder(int orderId) async {
  //   try {
  //     final result = await _orderRepository.checkStatusLockOrder(orderId);
  //     return result;
  //   } catch (ex) {
  //     return false;
  //   }
  // }

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

  // void changeNoteRestaurantItem({
  //   required String itemId,
  //   required String codeProduct,
  //   required int requestId,
  //   String note = '',
  // }) {
  //   // if (requestId == state.requestOrderId) {
  //   //   List<RequestOrderItemModel> orderItems = List<RequestOrderItemModel>.from(state.orderItems);
  //   //   final item =
  //   //       orderItems.firstWhereOrNull((e) => e.id == itemId && e.codeProduct == codeProduct);
  //   //   if (item != null) {
  //   //     orderItems.removeWhere((e) => e.id == itemId && e.codeProduct == codeProduct);
  //   //     orderItems.add(item.copyWith(noteRestaurant: note));
  //   //     state = state.copyWith(orderItems: orderItems);
  //   //   }
  //   // }
  // }

  // void changeStatusFilter(RequestProcessingStatus status) {
  //   state = state.copyWith(statusFilter: status);
  // }

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

  // void changeStatusOrder(BuildContext context, ChangeOrderModel model) async {
  //   Map<O2OOrderModel, Map<String, dynamic>> orders =
  //       Map<O2OOrderModel, Map<String, dynamic>>.from(state.orders);
  //   List<O2OOrderModel> tables = List<O2OOrderModel>.from(state.orders.keys);
  //   if (orders.isEmpty) return;
  //   var orderChange = tables.firstWhereOrNull((e) => e.orderId == model.orderId);
  //   if (orderChange == null) return;
  //   var orderSelect = state.orderSelect;
  //   final status = model.orderStatus;
  //   Set<int> lockedOrderIds = Set<int>.from(state.lockedOrderIds);

  //   bool selected = orderSelect != null && orderSelect.orderId == model.orderId;

  //   switch (status) {
  //     /// đơn đang được thanh toán
  //     case OrderStatus.paymenting:
  //       if (!lockedOrderIds.contains(model.orderId)) {
  //         lockedOrderIds.add(model.orderId);
  //         state = state.copyWith(lockedOrderIds: lockedOrderIds);
  //       }
  //       return;

  //     /// đang thanh toán thì mở lại đơn cho khách order thêm
  //     case OrderStatus.proccessing:
  //       if (lockedOrderIds.contains(model.orderId)) {
  //         lockedOrderIds.removeWhere((e) => e == model.orderId);
  //         state = state.copyWith(lockedOrderIds: lockedOrderIds);
  //       }
  //       return;

  //     /// đơn thanh toán xong
  //     case OrderStatus.complete:
  //       if (lockedOrderIds.contains(model.orderId)) {
  //         lockedOrderIds.removeWhere((e) => e == model.orderId);
  //         state = state.copyWith(lockedOrderIds: lockedOrderIds);
  //       }
  //       orders.remove(orderSelect);
  //       state = state.copyWith(orders: orders);
  //       if (selected) {
  //         changeOrderSelect(orders.isEmpty ? null : orders.keys.first);
  //       }

  //       return;
  //     default:
  //   }
  // }

  void changePrinterSelect(IpOrderModel? printer) {
    state = state.copyWith(printerSelect: null);
  }

  // void printQRCode() async {
  //   var orderSelect = state.orderSelect;
  //   if (orderSelect == null || state.printerSelect == null) return;
  //   try {
  //     state = state.copyWith(
  //         event: OrderToOnlineEvent.loading, message: '${S.current.printing_QR_code}...');

  //     var message = await AppPrinterUtils.instance.printQrO2O(
  //         order: OrderModel(
  //           id: orderSelect.orderId,
  //           // orderCode: orderSelect.orderCode,
  //           name: orderSelect.tableName,
  //           misc: '{"order_code": "${orderSelect.orderCode}"}',
  //         ),
  //         printer: state.printerSelect!,
  //         linkO2o: orderSelect.qrOrderO2o.firstOrNull ?? '');
  //     message ??=
  //         '${S.current.print_QR_code_o2o_success}\n${S.current.at_the_printer}: ${state.printerSelect!.name}';
  //     state = state.copyWith(
  //       event: OrderToOnlineEvent.error,
  //       message: message,
  //     );
  //   } catch (ex) {
  //     state = state.copyWith(
  //       event: OrderToOnlineEvent.error,
  //       message: ex.toString(),
  //     );
  //   }
  // }

  Future<void> selectAllRequestItem(
      {required RequestOrderModel request, required bool selectAll}) async {
    if (!selectAll) {
      state = state.copyWith(requestSelect: null);
      return;
    }
    state = state.copyWith(requestSelect: request);
  }

  void getChatMessages() async {
    final loginData = LocalStorage.getDataLogin();
    int? restaurantId = loginData?.restaurant?.id;
    final orderIdSelect = state.orderIdSelect;
    state = state.copyWith(
      getChatMessageState: const PageState(status: PageCommonState.loading),
    );
    if (restaurantId == null || orderIdSelect == null) {
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
        orderId: orderIdSelect,
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

  void onChangeShowChat(bool? value) {
    state = state.copyWith(showChat: value ?? !state.showChat);
  }
}
