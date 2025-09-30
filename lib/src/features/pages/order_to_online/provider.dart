import 'dart:async';

import 'package:aladdin_franchise/generated/l10n.dart';
import 'package:aladdin_franchise/src/configs/enums/bill_setting.dart';
import 'package:aladdin_franchise/src/core/network/order/order_repository.dart';
import 'package:aladdin_franchise/src/core/network/provider.dart';
import 'package:aladdin_franchise/src/core/services/task_queue.dart';
import 'package:aladdin_franchise/src/core/storages/local.dart';
import 'package:aladdin_franchise/src/features/dialogs/message.dart';
import 'package:aladdin_franchise/src/features/pages/home/provider.dart';
import 'package:aladdin_franchise/src/features/pages/home/state.dart';
import 'package:aladdin_franchise/src/models/ip_order.dart';
import 'package:aladdin_franchise/src/models/o2o/local_notification_model.dart';
import 'package:aladdin_franchise/src/models/o2o/notification_model.dart';
import 'package:aladdin_franchise/src/models/o2o/o2o_order_model.dart';
import 'package:aladdin_franchise/src/models/o2o/request_order.dart';
import 'package:aladdin_franchise/src/models/order.dart';
import 'package:aladdin_franchise/src/models/product.dart';
import 'package:aladdin_franchise/src/utils/app_log.dart';
import 'package:aladdin_franchise/src/utils/app_printer/app_printer.dart';
import 'package:aladdin_franchise/src/utils/app_printer/app_printer_html.dart';
import 'package:aladdin_franchise/src/utils/app_printer/app_printer_normal.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'state.dart';

final orderToOnlinePageNotifier = StateNotifierProvider.autoDispose<
    OrderToOnlinePageNotifier, OrderToOnlineState>((ref) {
  return OrderToOnlinePageNotifier(
    ref,
    ref.read(orderRepositoryProvider),
  );
});

class OrderToOnlinePageNotifier extends StateNotifier<OrderToOnlineState> {
  OrderToOnlinePageNotifier(this.ref, this._orderRepository)
      : super(const OrderToOnlineState()) {
    _listenChangeO2OData();
  }
  final OrderRepository _orderRepository;
  final Ref ref;

  void _listenChangeO2OData() {
    ref.listen(homeProvider.select((value) => value.o2oData), (previous, next) {
      _getO2OData(next);
    });
  }

  Future<void> _getO2OData(List<O2OOrderModel> value) async {
    try {
      var loginUserId = LocalStorage.getDataLogin()?.user?.id;

      Map<O2OOrderModel, Map<String, dynamic>> orders = {};
      for (var e in value) {
        if (e.userId != loginUserId) continue;

        var order = e.copyWith(items: []);
        var data = orders[order] ?? {};

        var items = List<RequestOrderModel>.from(e.items);
        // var items = List<RequestOrderModel>.from([
        //   RequestOrderModel(
        //     id: 1,
        //     status: 1,
        //     notes: 'Chi chú test',
        //     timeOrder: DateTime.now(),
        //     orderTimes: 1,
        //     sender: 'KH',
        //     listItem: [
        //       RequestOrderItemModel(
        //         id: 1,
        //         codeProduct: 'CODE-2',
        //         image: '',
        //         name: 'Sp test',
        //         quantity: 1,
        //       ),
        //       RequestOrderItemModel(
        //         id: 2,
        //         codeProduct: 'CODE-1',
        //         image:
        //             'https://images.unsplash.com/photo-1757664171295-4fd313cd6bd1?q=80&w=735&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
        //         name: 'Sp test',
        //         quantity: 1,
        //       ),
        //     ],
        //   ),
        //   RequestOrderModel(
        //     id: 2,
        //     status: 2,
        //     notes: 'Chi chú test',
        //     timeOrder: DateTime.now(),
        //     orderTimes: 2,
        //     sender: 'KH',
        //     listItem: [
        //       RequestOrderItemModel(
        //         id: 1,
        //         codeProduct: 'CODE-2',
        //         image: '',
        //         name: 'Sp test',
        //         quantity: 1,
        //         note: 'KH muốn ra nhanh',
        //         noteRestaurant: 'NH note',
        //       ),
        //     ],
        //   ),
        //   RequestOrderModel(
        //     id: 3,
        //     status: 3,
        //     notes: 'Chi chú test',
        //     timeOrder: DateTime.now(),
        //     orderTimes: 3,
        //     sender: 'KH',
        //     listItem: [
        //       RequestOrderItemModel(
        //         id: 1,
        //         codeProduct: 'CODE-2',
        //         image: '',
        //         name: 'Sp test 1',
        //         quantity: 1,
        //       ),
        //       RequestOrderItemModel(
        //         id: 2,
        //         codeProduct: 'CODE-1',
        //         image:
        //             'https://images.unsplash.com/photo-1757664171295-4fd313cd6bd1?q=80&w=735&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
        //         name: 'Sp test 2',
        //         quantity: 2,
        //       ),
        //     ],
        //   ),
        //   RequestOrderModel(
        //     id: 4,
        //     status: 3,
        //     notes: 'Chi chú test',
        //     timeOrder: DateTime.now(),
        //     orderTimes: 4,
        //     sender: 'KH',
        //     listItem: [
        //       RequestOrderItemModel(
        //         id: 1,
        //         codeProduct: 'CODE-2',
        //         image: '',
        //         name: 'Sp test 1',
        //         quantity: 1,
        //       ),
        //       RequestOrderItemModel(
        //         id: 2,
        //         codeProduct: 'CODE-1',
        //         image:
        //             'https://images.unsplash.com/photo-1757664171295-4fd313cd6bd1?q=80&w=735&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
        //         name: 'Sp test 2',
        //         quantity: 2,
        //       ),
        //     ],
        //   ),
        //   RequestOrderModel(
        //     id: 5,
        //     status: 3,
        //     notes: 'Chi chú test',
        //     timeOrder: DateTime.now(),
        //     orderTimes: 5,
        //     sender: 'KH',
        //     listItem: [],
        //   ),
        // ]);

        var itemData = List<RequestOrderModel>.from(data['items'] ?? []);

        int count = data['count'] ?? 0;
        itemData.addAll(items);

        for (var i in items) {
          if (i.requestProcessingStatus == RequestProcessingStatus.waiting &&
              i.listItem.isNotEmpty) {
            count++;
          }
        }

        orders[order] = {
          'items': itemData,
          'count': count,
        };
      }

      // sort theo value
      var sortedEntries = orders.entries.toList()
        ..sort((a, b) => b.value['count'].compareTo(a.value['count']));

      var sortedMap = {for (var e in sortedEntries) e.key: e.value};

      if (mounted) {
        state = state.copyWith(orders: sortedMap);
      }
    } catch (ex) {
      //
    }
  }

  void init({int? orderId}) async {
    var data = ref.read(homeProvider).o2oData;
    await _getO2OData(data);
    var orders = state.orders.keys.toList();

    var orderSelect = orders.isEmpty ? null : orders.first;
    if (orderId != null) {
      var check =
          orders.firstWhereOrNull((element) => element.orderId == orderId);
      orderSelect = check ?? orderSelect;
    }
    state = state.copyWith(orderSelect: orderSelect);

    if (orderSelect != null) {
      getNotifications();
      getChatMessages();
    }
  }

  void getNotifications() async {
    final orderSelect = state.orderSelect;
    if (orderSelect == null) {
      state = state.copyWith(notifications: []);
      return;
    }
    if (!Hive.isBoxOpen('notifications')) {
      await Hive.openBox('notifications');
    }
    var box = Hive.box<NotificationModel>('notifications');
    List<NotificationModel> data = box.values
        .toList()
        .where((e) => e.orderId == orderSelect.orderId)
        .toList();
    data.sort((a, b) => (b.datetime ?? DateTime.now())
        .compareTo((a.datetime ?? DateTime.now())));
    if (mounted) {
      data = data.where((e) => e.title.trim().isNotEmpty).toList();
      state = state.copyWith(notifications: data);
    }
  }

  // Future<void> getOrderToOnline({int? orderId, bool refreshChatMessage = true}) async {
  //   try {
  //     final result = await _orderRepository.getOrderToOnline();
  //     var loginUserId = LocalStorage.getDataLogin()?.user?.id;
  //     List<OrderModel> orders = [];
  //     for (var o2o in result) {
  //       if (o2o.userId == loginUserId) {
  //         orders.add(OrderModel(
  //           id: o2o.orderId,
  //           name: o2o.tableName,
  //           qrO2O: List<String>.from(o2o.qrOrderO2o),
  //           orderCode: o2o.orderCode,
  //         ));
  //       }
  //     }

  //     orders = orders.toSet().toList();
  //     OrderModel? initSelectedOrder;
  //     if (orderId != null) {
  //       initSelectedOrder = orders.firstWhereOrNull((element) => element.id == orderId);
  //     }
  //     Map<OrderModel, int> map = {};
  //     for (var order in orders) {
  //       final requests = result.where((e) => e.orderId == order.id).toList();
  //       int count = 0;
  //       for (var request in requests) {
  //         for (var item in request.items) {
  //           if (item.requestProcessingStatus == RequestProcessingStatus.waiting &&
  //               item.listItem.isNotEmpty) {
  //             count++;
  //           }
  //         }
  //         map[order] = count;
  //       }
  //     }
  //     var sortedEntries = map.entries.toList()..sort((a, b) => b.value.compareTo(a.value));
  //     map = Map<OrderModel, int>.fromEntries(sortedEntries);
  //     OrderModel? selectedOrd = initSelectedOrder ?? state.selectedOrder;
  //     if (map.keys.isEmpty) {
  //       selectedOrd = null;
  //     } else {
  //       var o = orders.firstWhereOrNull((e) => e.id == selectedOrd?.id);
  //       if (o != null) {
  //         selectedOrd = o;
  //       } else {
  //         selectedOrd = map.keys.first;
  //       }
  //     }

  //     state = state.copyWith(
  //       datas: result,
  //       selectedOrder: selectedOrd,
  //       orders: map,
  //     );
  //     state = state.copyWith(showErrorRefreshO2O: false);
  //     try {
  //       bool locked = await _checkStatusLockOrder(state.selectedOrder!.id);
  //       state = state.copyWith(beingLocked: locked);
  //     } catch (ex) {
  //       //
  //     }
  //     getNotifications();
  //     if (refreshChatMessage) {
  //       getChatMessages();
  //     }
  //   } catch (ex) {
  //     state = state.copyWith(showErrorRefreshO2O: true);
  //     rethrow;
  //   }
  // }

  void changeOrderSelect(O2OOrderModel? order) async {
    state = state.copyWith(
      orderSelect: order,
      chatMessages: [],
      getChatMessageState:
          const PageState(status: PageCommonState.success, messageError: ''),
      notifications: [],
    );

    if (order != null) {
      try {
        await onChangeLockedOrderId(orderId: order.orderId);
      } catch (ex) {
        //
      }
      getNotifications();
      getChatMessages();
    }
  }

  // /// kiểm tra bàn đang chọn có đang ở trạng thái thanh toán?
  // bool _checkBeingPaidOrder() {
  //   final orderSelect = state.orderSelect;
  //   if (orderSelect == null) return false;
  //   List<O2OOrderModel> orders = List<O2OOrderModel>.from(state.orders.keys);
  //   if (orders.firstWhereOrNull((e) => e.orderId == orderSelect.orderId) == null) {
  //     return false;
  //   }
  //   // List<OrderModel> waitingPaymentOrders = List<OrderModel>.from(state.beingPaidOrders);
  //   // if (waitingPaymentOrders.firstWhereOrNull((e) => e.id == orderSelect.id) != null) {
  //   //   return true;
  //   // }
  //   return false;
  // }

  void cancelRequest({required String reason}) async {
    try {
      var orderSelect = state.orderSelect;
      var requestSelect = state.requestSelect;
      var listItem = state.requestSelect?.listItem ?? [];
      if (orderSelect == null || requestSelect == null || listItem.isEmpty) {
        return;
      }
      state = state.copyWith(
          event: OrderToOnlineEvent.loading,
          message: S.current.canceling_request);
      await onChangeLockedOrderId(orderId: orderSelect.orderId);

      await _orderRepository.updateStatusRequestOrderO2O(
        orderId: orderSelect.orderId,
        orderItemId: requestSelect.id,
        orderItems: listItem,
        status: 2,
        notes: reason,
      );
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

  void acceptRequest(
      {required String note, required BuildContext context}) async {
    try {
      var orderSelect = state.orderSelect;
      var requestSelect = state.requestSelect;
      var listItem = state.requestSelect?.listItem ?? [];
      showLogs(
        requestSelect,
        flags: 'acceptRequest requestSelect',
      );
      if (orderSelect == null || requestSelect == null || listItem.isEmpty) {
        return;
      }
      Set<int> printerCheck = {};
      // List<ProductModel> productPrintBill = listItem.map((e) {
      //   if (e.printerType != null) {
      //     printerCheck.add(e.printerType!);
      //   }
      //   return ProductModel();
      // }).toList();
      var order = OrderModel(
          id: orderSelect.orderId,
          name: orderSelect.tableName,
          misc: '{"order_code":"${orderSelect.orderCode}"}');

      state = state.copyWith(
          event: OrderToOnlineEvent.loading, message: S.current.processing);
      var listPrinters = await _orderRepository.getIpPrinterOrder(
        order,
        printerCheck.toList(),
      );
      // await onChangeLockedOrderId(orderId: orderSelect.orderId);

      await _orderRepository.updateStatusRequestOrderO2O(
        orderId: orderSelect.orderId,
        orderItemId: requestSelect.id,
        orderItems: listItem,
        status: 1,
        notes: note,
      );

      state = state.copyWith(
        event: OrderToOnlineEvent.success,
        message: '',
        requestSelect: null,
      );
      // var bytes = LocalStorage.getAppSettings().appPrinterType ==
      //         AppPrinterSettingTypeEnum.normal
      //     ? await AppPrinterNormalUtils.instance.generateBill(
      //         order: order,
      //         billSingle: false,
      //         cancel: false,
      //         timeOrder: 1,
      //         totalNote: kitchenNote,
      //         products: productPrinter,
      //         title: '',
      //       )
      //     : await AppPrinterHtmlUtils.instance.generateImageBill(htmlData);
      // PrinterTaskQueue.instance.addTask(
      //   ip: printer.ip,
      //   port: printer.port,
      //   buildReceipt: (generator) async {
      //     return bytes;
      //   },
      //   onComplete: (success, error) async {
      //     if (success) {
      //       showLogs("✅ In thành công", flags: 'in món thành công');
      //       // chỉ in bill lẻ với bếp
      //       if (printer.type == 2 && appSeting.billReturnSetting.useOddBill) {
      //         for (var p in productPrinter) {
      //           List<int> byteDatas;
      //           var oddHtmlBill =
      //               AppPrinterHtmlUtils.instance.kitchenBillContent(
      //             product: [p],
      //             totalBill: false,
      //             order: state.orderSelect!,
      //             note: kitchenNote,
      //             timeOrders: 1,
      //           );
      //           byteDatas = appPrinterType == AppPrinterSettingTypeEnum.normal
      //               ? await AppPrinterNormalUtils.instance.generateBill(
      //                   order: state.orderSelect!,
      //                   billSingle: true,
      //                   cancel: false,
      //                   timeOrder: 1,
      //                   totalNote: kitchenNote,
      //                   products: [p],
      //                   title: '',
      //                 )
      //               : await AppPrinterHtmlUtils.instance
      //                   .generateImageBill(oddHtmlBill);
      //           PrinterTaskQueue.instance.addTask(
      //             ip: printer.ip,
      //             port: printer.port,
      //             buildReceipt: (generator) async {
      //               // var byteDatas = await AppPrinterHtmlUtils.instance
      //               //     .generateImageBill(oddHtmlBill);
      //               return byteDatas;
      //             },
      //             onComplete: (success, error) {
      //               if (success) {
      //                 showLogs("✅ In thành công",
      //                     flags: 'in món lẻ thành công');
      //               } else {
      //                 showLogs("❌ In thất bại: $error",
      //                     flags: 'in món lẻ thất bại');
      //               }
      //             },
      //           );
      //         }
      //       }
      //     } else {
      //       showLogs("❌ In thất bại: $error", flags: 'in món thất bại');
      //       if (error != null) {
      //         showMessageDialog(context, message: error);
      //       }
      //     }
      //   },
      // );

      if (orderSelect.orderId == ref.read(homeProvider).orderSelect?.id) {
        showLogs(
          null,
          flags: 'acceptRequest getProductOrder',
        );
        ref.read(homeProvider.notifier).getOrderProductCheckout();
      }
      // ref.invalidate(productCheckoutProvider);
    } catch (ex) {
      state = state.copyWith(
        event: OrderToOnlineEvent.error,
        message: ex.toString(),
      );
    }
  }

  Future<void> onChangeLockedOrderId(
      {required int orderId, bool showLoading = false}) async {
    try {
      if (showLoading) {
        state = state.copyWith(
            event: OrderToOnlineEvent.loading,
            message: 'Đang kiểm tra trạng thái đơn bàn');
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
      final locked =
          await _orderRepository.checkStatusLockOrder(orderId: orderId);
      return locked;
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
    state =
        state.copyWith(requestSelect: request.copyWith(listItem: itemsSelect));
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
    var orderChange =
        tables.firstWhereOrNull((e) => e.orderId == model.orderId);
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
          event: OrderToOnlineEvent.loading,
          message: '${S.current.printing_QR_code}...');

      var message = await AppPrinterUtils.instance.printQrO2O(
          order: OrderModel(
            id: orderSelect.orderId,
            // orderCode: orderSelect.orderCode,
            name: orderSelect.tableName,
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
          event: OrderToOnlineEvent.loading,
          message: S.current.retrieving_printer_list);
      final result = await _orderRepository.getIpPrinterOrder(
          OrderModel(
              id: orderSelect.orderId,
              name: orderSelect.tableName,
              qrO2O: orderSelect.qrOrderO2o,
              misc: '{"order_code": "${orderSelect.orderCode}"}'),
          [0, 1, 3]);
      var printers = result.printers;
      var error = result.error;
      if (error != null) {
        throw error;
      }

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

  void selectAllRequestItem(
      {required RequestOrderModel request, required bool selectAll}) {
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
    if (restaurantId == null || orderSelect == null) {
      state = state.copyWith(
        chatMessages: [],
        getChatMessageState: PageState(
            status: PageCommonState.success, messageError: S.current.no_data),
      );
      return;
    }

    try {
      final messages = await _orderRepository.getChatMessages(
        restaurantId: restaurantId,
        orderId: orderSelect.orderId,
      );
      state = state.copyWith(
        getChatMessageState:
            const PageState(status: PageCommonState.success, messageError: ''),
        chatMessages: messages,
      );
    } catch (ex) {
      state = state.copyWith(
        getChatMessageState: PageState(
            status: PageCommonState.error, messageError: ex.toString()),
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
