/// Author: sondv
/// Created 18/9/24 at 15:47

import 'dart:convert';

import 'package:aladdin_franchise/src/models/customer/customer.dart';
import 'package:aladdin_franchise/src/models/customer/customer_policy.dart';
import 'package:aladdin_franchise/src/models/order.dart';
import 'package:aladdin_franchise/src/models/order_history.dart';
import 'package:aladdin_franchise/src/models/product_cancel.dart';
import 'package:aladdin_franchise/src/models/product_checkout.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:intl/intl.dart';

part 'order_offline.freezed.dart';
part 'order_offline.g.dart';

@freezed
class OrderOffline with _$OrderOffline {
  const factory OrderOffline({
    required OrderModel order,
    required DateTime lastUpdate,
    List<CustomerPolicyModel>? coupons,
    CustomerModel? customer,
    @Default([]) List<ProductCheckoutModel> orderItem,
    @Default([]) List<ProductCancelModel> itemCancels,
    @Default([]) List<OrderHistory> orderHistory,
  }) = _OrderOffline;

  factory OrderOffline.fromJson(Map<String, dynamic> json) =>
      _$OrderOfflineFromJson(json);

  const OrderOffline._();

  // String getNameView() {
  //   String name = "Đơn bàn ${order.getNameView()}";
  //   final orderCode = getOrderMisc();
  //   if (orderCode != null) {
  //     name += " ($orderCode)";
  //   }
  //   //name += " - ${getLastUpdate()}";
  //   return name;
  // }

  String? getOrderMisc() {
    try {
      final miscMap = jsonDecode(order.misc);
      final orderCode = miscMap['order_code'];
      if (orderCode != null) {
        return orderCode;
      }
    } catch (ex) {
      return null;
    }
  }

  String getLastUpdate() {
    return DateFormat("dd/MM/yyyy HH:mm:ss").format(lastUpdate);
  }

  // String getDataSearch() => "${order.getNameView()} | ${getOrderMisc()}".toLowerCase();
}
