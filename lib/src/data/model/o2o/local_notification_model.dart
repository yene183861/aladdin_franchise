class LocalNotificationModel {
  String? title;
  String? body;

  /// thay đổi thông tin bàn
  ChangeOrderModel? order;
  int? status;

  bool reloadDataO2O;
  LocalNotificationModel({
    this.title,
    this.body,
    this.order,
    this.reloadDataO2O = false,
  });
}

class ChangeOrderModel {
  int orderId;
  int status;
  String? table;

  ChangeOrderModel({
    required this.orderId,
    required this.status,
    this.table,
  });

  OrderStatus get orderStatus => convertOrderStatus(status);
}

enum OrderStatus {
  proccessing,
  paymenting,
  complete,
}

OrderStatus convertOrderStatus(int status) {
  switch (status) {
    case 15:
      return OrderStatus.proccessing;
    case 16:
      return OrderStatus.paymenting;
    case 20:
      return OrderStatus.complete;

    default:
      return OrderStatus.proccessing;
  }
}
