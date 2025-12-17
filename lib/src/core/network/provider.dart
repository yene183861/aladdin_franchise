import 'package:aladdin_franchise/src/configs/enums/type_order.dart';
import 'package:aladdin_franchise/src/core/network/api/app_exception.dart';
import 'package:aladdin_franchise/src/core/network/api/rest_client.dart';
import 'package:aladdin_franchise/src/core/network/repository/coupon/coupon_repo_impl.dart';
import 'package:aladdin_franchise/src/core/network/repository/coupon/coupon_repository.dart';
import 'package:aladdin_franchise/src/core/network/repository/customer/customer_repo_impl.dart';
import 'package:aladdin_franchise/src/core/network/repository/customer/customer_repository.dart';
import 'package:aladdin_franchise/src/core/network/repository/invoice/invoice_repo_impl.dart'
    show InvoiceRepositoryImpl;
import 'package:aladdin_franchise/src/core/network/repository/invoice/invoice_repository.dart';
import 'package:aladdin_franchise/src/core/network/repository/menu/menu_repo_impl.dart';
import 'package:aladdin_franchise/src/core/network/repository/menu/menu_repository.dart';
import 'package:aladdin_franchise/src/core/network/repository/o2o/o2o_repo_impl.dart';
import 'package:aladdin_franchise/src/core/network/repository/o2o/o2o_repository.dart';
import 'package:aladdin_franchise/src/core/network/repository/order/order_repo_impl.dart';
import 'package:aladdin_franchise/src/core/network/repository/order/order_repository.dart';
import 'package:aladdin_franchise/src/core/network/repository/responses/order.dart';
import 'package:aladdin_franchise/src/core/network/repository/responses/product_checkout.dart';
import 'package:aladdin_franchise/src/core/network/repository/restaurant/restaurant_repository.dart';
import 'package:aladdin_franchise/src/core/network/repository/restaurant/restaurant_repository_impl.dart';
import 'package:aladdin_franchise/src/core/network/repository/ticket/ticket_repo_impl.dart';
import 'package:aladdin_franchise/src/core/network/repository/ticket/ticket_repository.dart';
import 'package:aladdin_franchise/src/core/network/repository/user/user_repo_impl.dart';
import 'package:aladdin_franchise/src/core/network/repository/user/user_repository.dart';
import 'package:aladdin_franchise/src/core/storages/local.dart';
import 'package:aladdin_franchise/src/core/storages/provider.dart';
import 'package:aladdin_franchise/src/features/pages/history_order/provider.dart';
import 'package:aladdin_franchise/src/features/pages/home/provider.dart';
import 'package:aladdin_franchise/src/models/employee_sale.dart';
import 'package:aladdin_franchise/src/models/history_order.dart';
import 'package:aladdin_franchise/src/models/o2o/o2o_order_model.dart';
import 'package:aladdin_franchise/src/models/o2o/request_order.dart';
import 'package:aladdin_franchise/src/models/order.dart';
import 'package:aladdin_franchise/src/models/reservation/reservation.dart';
import 'package:aladdin_franchise/src/models/table.dart';
import 'package:aladdin_franchise/src/models/ticket.dart';
import 'package:aladdin_franchise/src/models/waiter.dart';
import 'package:aladdin_franchise/src/utils/app_log.dart';
import 'package:aladdin_franchise/src/utils/date_time.dart';
import 'package:collection/collection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'repository/reservation/reservation_repo_impl.dart';
import 'repository/reservation/reservation_repository.dart';

import 'package:http/http.dart' as http;

void _logEvent(dynamic event) {
  showLogs(event, flags: 'provider check');
}

final restClientProvider = Provider<RestClient>((ref) {
  final httpClient = http.Client();
  // Dispose đúng lúc
  ref.onDispose(() {
    httpClient.close();
  });

  return RestClient(httpClient);
});
final userRepositoryProvider = Provider<UserRepository>((ref) {
  final client = ref.read(restClientProvider);
  return UserRepositoryImpl(client);
});

final menuRepositoryProvider = Provider<MenuRepository>((ref) {
  final client = ref.read(restClientProvider);
  return MenuRepositoryImpl(client);
});

final couponRepositoryProvider = Provider<CouponRepository>((ref) {
  final client = ref.read(restClientProvider);
  return CouponRepositoryImpl(client);
});

final customerRepositoryProvider = Provider<CustomerRepository>((ref) {
  final client = ref.read(restClientProvider);
  return CustomerRepositoryImpl(client);
});

final orderRepositoryProvider = Provider<OrderRepository>((ref) {
  final client = ref.read(restClientProvider);
  return OrderRepositoryImpl(client);
});

final restaurantRepositoryProvider = Provider<RestaurantRepository>((ref) {
  final client = ref.read(restClientProvider);
  return RestaurantRepositoryImpl(client);
});
final ticketRepositoryProvider = Provider<TicketRepository>((ref) {
  final client = ref.read(restClientProvider);
  return TicketRepositoryImpl(client);
});

final reservationRepositoryProvider = Provider<ReservationRepository>((ref) {
  final client = ref.read(restClientProvider);
  return ReservationRepositoryImpl(client);
});

final o2oRepositoryProvider = Provider<OrderToOnlineRepository>((ref) {
  final client = ref.read(restClientProvider);
  return OrderToOnlineRepositoryImpl(client);
});

final invoiceRepositoryProvider = Provider<InvoiceRepository>((ref) {
  final client = ref.read(restClientProvider);
  return InvoiceRepositoryImpl(client);
});

/// lấy danh sách bàn của cả 2 kiểu
final FutureProvider<({OrdersResponseData? offline, OrdersResponseData? online})>
    tablesAndOrdersProvider =
    FutureProvider<({OrdersResponseData? offline, OrdersResponseData? online})>(
        (FutureProviderRef<({OrdersResponseData? offline, OrdersResponseData? online})> ref) async {
  OrdersResponseData? offData;
  var resultOff =
      await ref.read(orderRepositoryProvider).getOrders(typeOrder: TypeOrderEnum.offline.type);
  if (resultOff.isSuccess) {
    offData = resultOff.data;
  } else {
    throw AppException.fromMessage(resultOff.error);
  }
  OrdersResponseData? onData;
  if (ref.read(enableOrderOnlineProvider)) {
    var result =
        await ref.read(orderRepositoryProvider).getOrders(typeOrder: TypeOrderEnum.online.type);
    if (result.isSuccess) {
      onData = result.data;
    } else {
      throw AppException.fromMessage(result.error);
    }
  }

  final orderCurrent = ref.read(homeProvider.notifier).getOrderSelect();
  // Kiểm tra nếu đơn bàn đang chọn không tồn tại nữa thì xoá bỏ trong home state
  if (orderCurrent != null) {
    OrderModel? orderCheck = (orderCurrent.typeOrder == TypeOrderEnum.offline.type
            ? (offData?.userUsing ?? [])
            : (onData?.userUsing ?? []))
        .firstWhereOrNull((e) => e.id == orderCurrent.id);
    ref.read(homeProvider.notifier).changeOrderSelect(orderCheck);
  }
  return (offline: offData, online: onData);
});

/// lấy danh sách bàn chưa sử dụng kèm bàn theo đơn đang chọn
/// [0] - danh sách bàn hiện tại đang chọn
/// [1] - danh sách bàn chưa sử dụng + bàn hiện tại đang chọn
final FutureProvider<
        ({List<TableModel> notUse, List<TableModel> tableSelect, List<TableModel> using})>
    tableAvailableUpdateOrderProvider = FutureProvider<
            ({List<TableModel> notUse, List<TableModel> tableSelect, List<TableModel> using})>(
        (FutureProviderRef<
                ({List<TableModel> notUse, List<TableModel> tableSelect, List<TableModel> using})>
            ref) async {
  return (notUse: <TableModel>[], tableSelect: <TableModel>[], using: <TableModel>[]);
//   var orderSelect = ref.read(homeProvider.notifier).getOrderSelect();
//   if (orderSelect != null) {
//     final orderRepo = await ref.read(orderRepositoryProvider).getOrders();
//     var result = List<TableModel>.from(orderRepo.data.notUse);
//     // các bàn đang sử dụng
//     final tableUse = orderRepo.data.using;
//     // các bàn mà đơn hàng này đang giữ
//     var tableSelectRaw = orderSelect.name.split(',');
//     List<TableModel> tableSelect = [];
//     for (var tableName in tableSelectRaw) {
//       var tableTemp = tableUse.firstWhere((element) => element.name == tableName);
//       tableSelect.add(tableTemp);
//     }
//     result.insertAll(0, tableSelect);
//     return (notUse: result, tableSelect: tableSelect, using: tableUse);
//     // return [tableSelect, result, orderRepo.data.using];
//   }
//   return (notUse: <TableModel>[], tableSelect: <TableModel>[], using: <TableModel>[]);
// });

// /// lấy danh sách món đã gọi + lịch sử gọi món
// final FutureProvider<ProductCheckoutResponseData?> productCheckoutProvider =
//     FutureProvider<ProductCheckoutResponseData?>(
//         (FutureProviderRef<ProductCheckoutResponseData?> ref) async {
//   _logEvent('productCheckoutProvider');
//   final orderSelect = ref.watch(homeProvider.select((value) => value.orderSelect));
//   final data = await ref.read(orderRepositoryProvider).getProductCheckout(orderSelect);
//   return productRepo.data?.first;
});

/// Lấy tổng tiền hoá đơn hiện tại
final FutureProvider<double> priceProductCheckoutProvider =
    FutureProvider<double>((FutureProviderRef<double> ref) async {
  return 0.0;
  // _logEvent('priceProductCheckoutProvider');
  // var productCheckout = ref.watch(productCheckoutProvider);
  // return productCheckout.when(data: (data) {
  //   var totalOrder = 0.0;
  //   for (var product in data?.orderItem ?? []) {
  //     totalOrder += product.totalOrdered;
  //   }
  //   return totalOrder;
  // }, error: (_, __) {
  //   throw Exception();
  // }, loading: () {
  //   return 0;
  // });
});

/// Dành cho chuyển giao đơn bàn
///
/// [[0]] - Danh sách bàn hiện tại đang chọn
///
/// [[1]] - Danh sách bàn chưa sử dụng + bàn hiện tại đang chọn
///
/// [[2]] - Danh sách waiter
final FutureProvider<List<List<dynamic>>> tableAvailableAndWaiterTransferOrderProvider =
    FutureProvider<List<List<dynamic>>>((FutureProviderRef<List<List<dynamic>>> ref) async {
  // _logEvent('tableAvailableAndWaiterTransferOrderProvider');
  // var orderSelect = ref.read(homeProvider.notifier).getOrderSelect();
  // if (orderSelect != null) {
  //   final orderRepo = await ref.read(orderRepositoryProvider).getOrders();
  //   var tableAvailable = List<TableModel>.from(orderRepo.data.notUse);
  //   // các bàn đang sử dụng
  //   final tableUse = orderRepo.data.using;
  //   // các bàn mà đơn hàng này đang giữ
  //   var tableSelectRaw = orderSelect.name.split(',');
  //   List<TableModel> tableCurrentSelect = [];
  //   for (var tableName in tableSelectRaw) {
  //     var tableTemp = tableUse.firstWhere((element) => element.name == tableName);
  //     tableCurrentSelect.add(tableTemp);
  //   }
  //   tableAvailable.insertAll(0, tableCurrentSelect);
  //   return [tableCurrentSelect, tableAvailable, orderRepo.data.waiters ?? [], tableUse];
  // }
  return [];
});

/// Lấy danh sách phục vụ tại nhà hàng

final waitersProvider = FutureProvider.autoDispose<List<WaiterModel>>((ref) async {
  return [];
  // final orderRepo = await ref.read(orderRepositoryProvider).getOrders();
  // return orderRepo.data.waiters ?? [];
});

final historyOrderProvider = FutureProvider.autoDispose<List<HistoryOrderModel>>((ref) async {
  var startDate = ref.watch(historyOrderPageProvider.select((value) => value.startDate));
  var endDate = ref.watch(historyOrderPageProvider.select((value) => value.endDate));
  var result = await ref
      .read(restaurantRepositoryProvider)
      .getOrderHistoryList(startDate: startDate, endDate: endDate);
  return result;
});

final ticketsProvider = FutureProvider.autoDispose<List<TicketModel>>((ref) async {
  var result = await ref.read(ticketRepositoryProvider).getTickets();
  return result;
});

final reservationsProvider = FutureProvider.autoDispose<List<ReservationModel>>((ref) async {
  var useReservation = LocalStorage.getDataLogin()?.restaurant?.reservationStatus ?? false;
  if (!useReservation) return [];
  var result = await ref.read(reservationRepositoryProvider).getReservations();
  if (!result.isSuccess) throw result.error;
  return result.data ?? [];
});

final orderToOnlineProvider =
    FutureProvider.autoDispose<Map<O2OOrderModel, Map<String, dynamic>>>((ref) async {
  var useO2O = LocalStorage.getDataLogin()?.restaurant?.o2oStatus ?? false;
  if (!useO2O) return {};
  // var loginUserId = LocalStorage.getDataLogin()?.user?.id;
  Map<O2OOrderModel, Map<String, dynamic>> orders = {};
  orders = {};
  final result = await ref.read(o2oRepositoryProvider).getOrderToOnline();
  for (var e in result) {
    // if (loginUserId != null && e.userId != loginUserId) continue;

    var order = e.copyWith(items: []);
    var data = orders[order] ?? {};

    var items = List<RequestOrderModel>.from(e.items);

    var itemData = List<RequestOrderModel>.from(data['items'] ?? []);

    int count = data['count'] ?? 0;
    itemData.addAll(items);

    for (var i in items) {
      if (i.requestProcessingStatus == RequestProcessingStatus.waiting && i.listItem.isNotEmpty) {
        count++;
      }
    }

    orders[order] = {
      'items': itemData,
      'count': count,
    };
  }

  // return {
  //   O2OOrderModel(
  //     orderId: 1,
  //     tableName: 'Test 01',
  //     userId: 6,
  //     orderCode: 'Test01',
  //     qrOrderO2o: [],
  //     items: [],
  //   ): {
  //     'items': [
  //       RequestOrderModel(
  //         id: 1,
  //         status: 1,
  //         timeOrder: DateTime.now(),
  //         orderTimes: 1,
  //         listItem: [
  //           RequestOrderItemModel(
  //             id: 1,
  //             codeProduct: 'CHCMP028',
  //             menuItemId: 82,
  //             quantity: 1,
  //             noteRestaurant: 'note 111',
  //             name: 'Cơm niêu ba chỉ heo kho ngũ hương',
  //             image: 'http://192.168.10.136:85/storage/3055/CHCMP033.jpg?3055',
  //             // printerType: 2,
  //             // unit: 'Suất',
  //           ),
  //           RequestOrderItemModel(
  //             id: 2,
  //             codeProduct: 'CHDSU001',
  //             menuItemId: 82,
  //             quantity: 1,
  //             noteRestaurant: 'note 111',
  //             name: 'Há cảo tôm thịt 3 chiếc',
  //             image: 'https://o2o.aladdin-jsc.com/storage/4564/CHDSU001_1754401345.jpg',
  //             // printerType: 2,
  //             // unit: 'Suất',
  //           ),
  //         ],
  //       ),
  //       RequestOrderModel(
  //         id: 2,
  //         status: 2,
  //         timeOrder: DateTime.now(),
  //         orderTimes: 2,
  //         listItem: [
  //           RequestOrderItemModel(
  //             id: 3,
  //             codeProduct: 'CHCMP028',
  //             menuItemId: 82,
  //             quantity: 1,
  //             noteRestaurant: 'note 111',
  //             name: 'Cơm niêu ba chỉ heo kho ngũ hương',
  //             image: 'http://192.168.10.136:85/storage/3055/CHCMP033.jpg?3055',
  //             // printerType: 2,
  //             // unit: 'Suất',
  //           ),
  //           RequestOrderItemModel(
  //             id: 4,
  //             codeProduct: 'CHDSU001',
  //             menuItemId: 82,
  //             quantity: 1,
  //             noteRestaurant: 'note 111',
  //             name: 'Há cảo tôm thịt 3 chiếc',
  //             image: 'https://o2o.aladdin-jsc.com/storage/4564/CHDSU001_1754401345.jpg',
  //             // printerType: 2,
  //             // unit: 'Suất',
  //           ),
  //         ],
  //       ),
  //       RequestOrderModel(
  //         id: 3,
  //         status: 0,
  //         timeOrder: DateTime.now(),
  //         orderTimes: 3,
  //         listItem: [
  //           RequestOrderItemModel(
  //             id: 5,
  //             codeProduct: 'CHCMP028',
  //             menuItemId: 82,
  //             quantity: 1,
  //             noteRestaurant: 'note 111',
  //             name: 'Cơm niêu ba chỉ heo kho ngũ hương',
  //             image: 'http://192.168.10.136:85/storage/3055/CHCMP033.jpg?3055',
  //             // printerType: 2,
  //             // unit: 'Suất',
  //           ),
  //           RequestOrderItemModel(
  //             id: 6,
  //             codeProduct: 'CHDSU001',
  //             menuItemId: 82,
  //             quantity: 1,
  //             noteRestaurant: 'note 111',
  //             name: 'Há cảo tôm thịt 3 chiếc',
  //             image: 'https://o2o.aladdin-jsc.com/storage/4564/CHDSU001_1754401345.jpg',
  //             // printerType: 2,
  //             // unit: 'Suất',
  //           ),
  //         ],
  //       ),
  //     ],
  //     'count': 1,
  //   },
  // };

  return orders;
});
// final employeeSalesProvider = FutureProvider.autoDispose<List<EmployeeSaleModel>>((ref) async {
//   final result = await ref.read(restaurantRepositoryProvider).getEmployeeSales();
//   if (ref.read(homeProvider.notifier).mounted) {
//     var sale = ref.read(homeProvider).employeeSaleSelect;
//     if (sale != null && !result.contains(sale)) {
//       ref.read(homeProvider.notifier).onChangeEmployeeSaleSelect(null);
//     }
//   }
//   return result;
// });

final todayHistoryOrderProvider = FutureProvider.autoDispose<List<HistoryOrderModel>>((ref) async {
  var today = DateTime.now().date;
  var result = await ref
      .read(restaurantRepositoryProvider)
      .getOrderHistoryList(startDate: today.subtract(const Duration(days: 1)), endDate: today);
  return result;
});
