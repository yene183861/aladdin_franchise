import 'package:aladdin_franchise/generated/l10n.dart';
import 'package:aladdin_franchise/src/core/network/api/app_exception.dart';
import 'package:aladdin_franchise/src/core/storages/local.dart';
import 'package:aladdin_franchise/src/models/ip_order.dart';
import 'package:aladdin_franchise/src/models/order.dart';
import 'package:aladdin_franchise/src/models/restaurant.dart';
import 'package:flutter_esc_pos_network/flutter_esc_pos_network.dart';
import 'package:flutter_esc_pos_utils/flutter_esc_pos_utils.dart';
import 'package:image/image.dart' as image_lib;
import 'package:intl/intl.dart';
import 'package:webcontent_converter/webcontent_converter.dart';

class AppPrinterUtils {
  AppPrinterUtils._();

  static final AppPrinterUtils _instance = AppPrinterUtils._();

  static AppPrinterUtils get instance => _instance;

  Future<String?> printQrO2O({
    required OrderModel order,
    required IpOrderModel printer,
    required String linkO2o,
  }) async {
    final xPrinter = PrinterNetworkManager(
      printer.ip,
      port: printer.port,
    );
    try {
      final PosPrintResult res = await xPrinter.connect();
      if (res != PosPrintResult.success) {
        throw printer.messageConnectFail();
      }
      final ticket = await _generatorLinkO2OBill(order, linkO2o);
      final resultBill = await xPrinter.printTicket(ticket, isDisconnect: false);
      await xPrinter.disconnect();

      if (resultBill != PosPrintResult.success) {
        return S.current.print_failed;
      }
      return null;
    } catch (ex) {
      try {
        await xPrinter.disconnect();
      } catch (_) {}

      return ex.toString();
    }
  }

  Future<List<int>> _generatorLinkO2OBill(OrderModel order, String linkO2o) async {
    try {
      List<int> bytes = [];
      final profile = await CapabilityProfile.load();
      final generator = Generator(PaperSize.mm80, profile);

      final loginData = LocalStorage.getDataLogin();
      RestaurantModel? restaurant = loginData?.restaurant;
      // bytes += generator.text(
      //   "LINK O2O",
      //   styles: const PosStyles(
      //     bold: true,
      //     height: PosTextSize.size2,
      //     width: PosTextSize.size2,
      //     align: PosAlign.center,
      //   ),
      // );
      // bytes += generator.text(
      //   "BAN: ${order.name}",
      //   styles: const PosStyles(
      //     bold: true,
      //     height: PosTextSize.size2,
      //     width: PosTextSize.size2,
      //     align: PosAlign.center,
      //   ),
      // );
      String htmlData = '''
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>RECEIPT</title>
</head>
<style>

   body,
    p {
        margin: 0px;
        padding: 0px;
        font-weight: normal;
    }
    h4, h3 {
      text-align: center;
      padding: 0;
      margin: 0;
    }
    
    body {
        background: #eee;
        width: 302.36px;
    }
    h3 {
      font-size: 21px;
    }
    h4 {
      font-size: 20px;
    }



</style>
<body>
      <h3 >${restaurant?.name ?? ''}</h3>
      <p style="font-size: 13px;text-align: center;">${restaurant?.address ?? ''}</p>
      <br>
      <h4>ĐƠN BÀN: ${order.getOrderMisc()}</h4>
      <h4>BÀN: ${order.name}</h4>
</body>
</html> 
    ''';
      var byteImage = await WebcontentConverter.contentToImage(content: htmlData);
      final image_lib.Image? receipt = image_lib.decodeImage(byteImage);
      if (receipt == null) {
        throw AppException.fromMessage(S.current.error_loading_bill_image);
      }
      final image_lib.Image receiptResize = image_lib.copyResize(
        receipt,
        width: PaperSize.mm80.width,
        interpolation: image_lib.Interpolation.linear,
      );

      bytes += generator.image(receiptResize);
      bytes += generator.emptyLines(1);
      bytes += generator.qrcode(linkO2o, size: QRSize.size8);
      bytes += generator.emptyLines(1);
      bytes += generator.text(
        "Powered by Aladdin.,JSC",
        styles: const PosStyles(
          align: PosAlign.center,
        ),
      );
      bytes += generator.text(
        DateFormat("EEEE, dd/MM/yyyy HH:mm:ss", 'en').format(DateTime.now()),
        styles: const PosStyles(
          align: PosAlign.center,
        ),
      );
      bytes += generator.cut();
      return bytes;
    } catch (ex) {
      throw S.current.create_print_bill_failed;
    }
  }
}
