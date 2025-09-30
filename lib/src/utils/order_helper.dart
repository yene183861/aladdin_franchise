/// Author: sondv
/// Created 23/02/2023 at 10:05

class OrderHelper {
  /// [0]: danh sách thông tin máy in
  ///
  /// [1]: String? error - nếu có lỗi
  // static Future<List<dynamic>> getPrinterBill(
  //   OrderModel order,
  //
  //   /// Loại máy in cần check tuỳ theo danh sách món ăn
  //   List<int> printerCheck,
  // ) async {
  //   List<IpOrderModel> ipResult = [];
  //   String? error;
  //   try {
  //     // Lấy thông tin máy in
  //     ipResult = await OrderRepositoryImpl().getIpPrinterOrder(order, [2, 4]);
  //     showLogs(ipResult, flags: "Printer");
  //     if (ipResult.isEmpty) {
  //       error = "Máy in chưa được thiếp lập";
  //     } else {
  //       // Kiểm tra tình trạng máy in
  //       for (var ipPrinter in ipResult) {
  //         if (printerCheck.contains(ipPrinter.type)) {
  //           var checkPrinterAvailable =
  //               await LocalNetworkService.checkPrinter(ipPrinter.ip, ipPrinter.port);
  //           showLog(checkPrinterAvailable, flags: "checkPrinterAvailable[${ipPrinter.type}]");
  //           if (checkPrinterAvailable == false) {
  //             error = "Không kết nối được máy in\nVui lòng kiểm tra lại!";
  //           }
  //         }
  //       }
  //     }
  //   } catch (ex) {
  //     error = "Có lỗi khi lấy thông tin máy in\nVui lòng thử lại!";
  //   }
  //   return [ipResult, error];
  // }
}
