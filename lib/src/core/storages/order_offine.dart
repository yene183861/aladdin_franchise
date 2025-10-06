import 'dart:io';

import 'package:aladdin_franchise/src/core/network/app_exception.dart';
import 'package:aladdin_franchise/src/core/storages/local.dart';
import 'package:aladdin_franchise/src/models/order_offline/order_offline.dart';
import 'package:aladdin_franchise/src/utils/app_log.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';

class OrderOfflineService {
  static final OrderOfflineService _instance = OrderOfflineService._();

  static OrderOfflineService get instance => _instance;

  OrderOfflineService._();

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    final pathFile = '$path/order_offline.txt';
    final file = File(pathFile);
    if (await file.exists() == false) {
      await file.create();
    }
    return file;
  }

  Future<List<OrderOffline>> readOrderOffline() async {
    try {
      // final file = await _localFile;
      // final dataFile = await file.readAsString();
      // if (dataFile.trim().isEmpty) {
      //   return [];
      // }
      // final dataJson = jsonDecode(dataFile);
      // return dataJson.map<OrderOffline>((e) => OrderOffline.fromJson(e)).toList();
      final results = LocalStorage.getOrderOffline();
      return results;
    } catch (ex) {
      showLog(ex, flags: "readOrderOffline");
      throw AppException.fromMessage(
          "Lỗi đọc dữ liệu order trên thiết bị\n${ex.toString()}");
    }
  }

  Future<void> updateOrderOffline(OrderOffline orderOffline) async {
    try {
      // final file = await _localFile;
      // var orders = await readOrderOffline();
      // final now = DateTime.now();
      // // Loại bỏ đơn hàng >= 24h
      // orders.removeWhere((element) => now.difference(element.lastUpdate).inHours >= 24);
      // // Kiểm tra sự tồn tại của đơn bàn
      // // Tồn tại => ghi đè dữ liệu
      // // Đơn mới => thêm vào
      // final orderExistIndex = orders.indexWhere((e) => e.order.id == orderOffline.order.id);
      // if (orderExistIndex == -1) {
      //   orders.add(orderOffline);
      // } else {
      //   orders[orderExistIndex] = orderOffline;
      // }
      // await file.writeAsString(jsonEncode(orders));
      // showLog(orders.length, flags: "Order Offline");
      await LocalStorage.updateOrderOffline(orderOffline);
    } catch (ex) {
      showLog(ex, flags: "updateOrderOffline");
    }
  }
}

final orderOfflineLocalProvider =
    FutureProvider.autoDispose<List<OrderOffline>>((ref) async {
  //final result = await OrderOfflineService.instance.readOrderOffline();
  final result = LocalStorage.getOrderOffline();
  result.sort((a, b) => b.lastUpdate.compareTo(a.lastUpdate));
  return result;
});
