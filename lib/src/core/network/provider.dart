import 'package:aladdin_franchise/src/configs/enums/type_order.dart';
import 'package:aladdin_franchise/src/core/network/category/category_repo_impl.dart';
import 'package:aladdin_franchise/src/core/network/category/category_repository.dart';
import 'package:aladdin_franchise/src/core/network/coupon/coupon_repo_impl.dart';
import 'package:aladdin_franchise/src/core/network/coupon/coupon_repository.dart';
import 'package:aladdin_franchise/src/core/network/customer/customer_repo_impl.dart';
import 'package:aladdin_franchise/src/core/network/customer/customer_repository.dart';
import 'package:aladdin_franchise/src/core/network/invoice/invoice_repo_impl.dart'
    show InvoiceRepositoryImpl;
import 'package:aladdin_franchise/src/core/network/invoice/invoice_repository.dart';
import 'package:aladdin_franchise/src/core/network/o2o/o2o_repo_impl.dart';
import 'package:aladdin_franchise/src/core/network/o2o/o2o_repository.dart';
import 'package:aladdin_franchise/src/core/network/order/order_repo_impl.dart';
import 'package:aladdin_franchise/src/core/network/order/order_repository.dart';
import 'package:aladdin_franchise/src/core/network/product/product_repo_impl.dart';
import 'package:aladdin_franchise/src/core/network/product/product_repository.dart';
import 'package:aladdin_franchise/src/core/network/responses/order.dart';
import 'package:aladdin_franchise/src/core/network/responses/product_checkout.dart';
import 'package:aladdin_franchise/src/core/network/restaurant/restaurant_repository.dart';
import 'package:aladdin_franchise/src/core/network/restaurant/restaurant_repository_impl.dart';
import 'package:aladdin_franchise/src/core/network/ticket/ticket_repo_impl.dart';
import 'package:aladdin_franchise/src/core/network/ticket/ticket_repository.dart';
import 'package:aladdin_franchise/src/core/network/user/user_repo_impl.dart';
import 'package:aladdin_franchise/src/core/network/user/user_repository.dart';
import 'package:aladdin_franchise/src/core/storages/local.dart';
import 'package:aladdin_franchise/src/core/storages/provider.dart';
import 'package:aladdin_franchise/src/features/pages/history_order/provider.dart';
import 'package:aladdin_franchise/src/features/pages/home/provider.dart';
import 'package:aladdin_franchise/src/models/history_order.dart';
import 'package:aladdin_franchise/src/models/o2o/o2o_order_model.dart';
import 'package:aladdin_franchise/src/models/o2o/request_order.dart';
import 'package:aladdin_franchise/src/models/order.dart';
import 'package:aladdin_franchise/src/models/reservation/reservation.dart';
import 'package:aladdin_franchise/src/models/table.dart';
import 'package:aladdin_franchise/src/models/ticket.dart';
import 'package:aladdin_franchise/src/models/waiter.dart';
import 'package:aladdin_franchise/src/utils/app_log.dart';
import 'package:collection/collection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'reservation/reservation_repo_impl.dart';
import 'reservation/reservation_repository.dart';

void _logEvent(dynamic event) {
  showLogs(event, flags: 'provider check');
}

final userRepositoryProvider = Provider<UserRepository>((ref) {
  return UserRepositoryImpl();
});

final categoryRepositoryProvider = Provider<CategoryRepository>((ref) {
  return CategoryRepositoryImpl();
});

final productRepositoryProvider = Provider<ProductRepository>((ref) {
  return ProductRepositoryImpl();
});

final couponRepositoryProvider = Provider<CouponRepository>((ref) {
  return CouponRepositoryImpl();
});

final customerRepositoryProvider = Provider<CustomerRepository>((ref) {
  return CustomerRepositoryImpl();
});

final orderRepositoryProvider = Provider<OrderRepository>((ref) {
  return OrderRepositoryImpl();
});

final restaurantRepositoryProvider = Provider<RestaurantRepository>((ref) {
  return RestaurantRepositoryImpl();
});
final ticketRepositoryProvider = Provider<TicketRepository>((ref) {
  return TicketRepositoryImpl();
});

final reservationRepositoryProvider = Provider<ReservationRepository>((ref) {
  return ReservationRepositoryImpl();
});

final o2oRepositoryProvider = Provider<OrderToOnlineRepository>((ref) {
  return OrderToOnlineRepositoryImpl();
});

final invoiceRepositoryProvider = Provider<InvoiceRepository>((ref) {
  return InvoiceRepositoryImpl();
});

/// lấy danh sách bàn của cả 2 kiểu
final FutureProvider<({OrdersResponseData offline, OrdersResponseData? online})>
    tablesAndOrdersProvider =
    FutureProvider<({OrdersResponseData offline, OrdersResponseData? online})>(
        (FutureProviderRef<({OrdersResponseData offline, OrdersResponseData? online})> ref) async {
  final orderOffRepo = await ref.read(orderRepositoryProvider).getOrders(
        typeOrder: TypeOrderEnum.offline.type,
      );
  OrdersResponse? orderOnRepo;
  if (ref.read(enableOrderOnlineProvider)) {
    orderOnRepo =
        await ref.read(orderRepositoryProvider).getOrders(typeOrder: TypeOrderEnum.online.type);
  }

  final orderCurrent = ref.read(homeProvider.notifier).getOrderSelect();

  // Kiểm tra nếu đơn bàn đang chọn không tồn tại nữa thì xoá bỏ trong home state
  if (orderCurrent != null) {
    OrderModel? orderCheck = (orderCurrent.typeOrder == TypeOrderEnum.offline.type
            ? orderOffRepo.data.userUsing
            : (orderOnRepo?.data.userUsing ?? []))
        .firstWhereOrNull((e) => e.id == orderCurrent.id);
    ref.read(homeProvider.notifier).changeOrderSelect(orderCheck);
  }
  return (offline: orderOffRepo.data, online: orderOnRepo?.data);
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
  var orderSelect = ref.read(homeProvider.notifier).getOrderSelect();
  if (orderSelect != null) {
    final orderRepo = await ref.read(orderRepositoryProvider).getOrders();
    var result = List<TableModel>.from(orderRepo.data.notUse);
    // các bàn đang sử dụng
    final tableUse = orderRepo.data.using;
    // các bàn mà đơn hàng này đang giữ
    var tableSelectRaw = orderSelect.name.split(',');
    List<TableModel> tableSelect = [];
    for (var tableName in tableSelectRaw) {
      var tableTemp = tableUse.firstWhere((element) => element.name == tableName);
      tableSelect.add(tableTemp);
    }
    result.insertAll(0, tableSelect);
    return (notUse: result, tableSelect: tableSelect, using: tableUse);
    // return [tableSelect, result, orderRepo.data.using];
  }
  return (notUse: <TableModel>[], tableSelect: <TableModel>[], using: <TableModel>[]);
});

/// lấy danh sách món đã gọi + lịch sử gọi món
final FutureProvider<ProductCheckoutResponseData?> productCheckoutProvider =
    FutureProvider<ProductCheckoutResponseData?>(
        (FutureProviderRef<ProductCheckoutResponseData?> ref) async {
  _logEvent('productCheckoutProvider');
  final orderSelect = ref.watch(homeProvider.select((value) => value.orderSelect));
  final productRepo = await ref.read(orderRepositoryProvider).getProductCheckout(orderSelect);
  return productRepo.data?.first;
});

/// Lấy tổng tiền hoá đơn hiện tại
final FutureProvider<double> priceProductCheckoutProvider =
    FutureProvider<double>((FutureProviderRef<double> ref) async {
  _logEvent('priceProductCheckoutProvider');
  var productCheckout = ref.watch(productCheckoutProvider);
  return productCheckout.when(data: (data) {
    var totalOrder = 0.0;
    for (var product in data?.orderItem ?? []) {
      totalOrder += product.totalOrdered;
    }
    return totalOrder;
  }, error: (_, __) {
    throw Exception();
  }, loading: () {
    return 0;
  });
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
  _logEvent('tableAvailableAndWaiterTransferOrderProvider');
  var orderSelect = ref.read(homeProvider.notifier).getOrderSelect();
  if (orderSelect != null) {
    final orderRepo = await ref.read(orderRepositoryProvider).getOrders();
    var tableAvailable = List<TableModel>.from(orderRepo.data.notUse);
    // các bàn đang sử dụng
    final tableUse = orderRepo.data.using;
    // các bàn mà đơn hàng này đang giữ
    var tableSelectRaw = orderSelect.name.split(',');
    List<TableModel> tableCurrentSelect = [];
    for (var tableName in tableSelectRaw) {
      var tableTemp = tableUse.firstWhere((element) => element.name == tableName);
      tableCurrentSelect.add(tableTemp);
    }
    tableAvailable.insertAll(0, tableCurrentSelect);
    return [tableCurrentSelect, tableAvailable, orderRepo.data.waiters ?? [], tableUse];
  }
  return [];
});

/// Lấy danh sách phục vụ tại nhà hàng

final waitersProvider = FutureProvider.autoDispose<List<WaiterModel>>((ref) async {
  final orderRepo = await ref.read(orderRepositoryProvider).getOrders();
  return orderRepo.data.waiters ?? [];
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
  return result;
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

  return orders;
});
