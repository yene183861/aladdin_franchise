import 'dart:convert';
import 'dart:io';

import 'package:aladdin_franchise/src/models/ip_order.dart';
import 'package:flutter/services.dart';
import 'package:flutter_esc_pos_network/flutter_esc_pos_network.dart';

import '../app_log.dart';

enum ReceiptTypeEnum {
  temporaryReceipt,
  paymentReceipt,
}

extension ReceiptTypeEnumEx on ReceiptTypeEnum {
  String get title {
    switch (this) {
      case ReceiptTypeEnum.temporaryReceipt:
        return 'Phiếu tạm tính';
      case ReceiptTypeEnum.paymentReceipt:
        return 'Phiếu thanh toán';
    }
  }

  String get note {
    switch (this) {
      case ReceiptTypeEnum.temporaryReceipt:
        return 'Phiếu không có giá trị thanh toán';
      case ReceiptTypeEnum.paymentReceipt:
        return '';
    }
  }

  bool get showPaymentMethod {
    switch (this) {
      case ReceiptTypeEnum.temporaryReceipt:
        return false;
      case ReceiptTypeEnum.paymentReceipt:
        return true;
    }
  }
}

class AppPrinterCommon {
  AppPrinterCommon._();
  static const MethodChannel _channel = MethodChannel('native_ping');

  /// True => null
  ///
  /// False => messge - máy in lỗi
  static Future<String?> checkPrinter(IpOrderModel printer) async {
    final commonError = "Không kết nối được máy in\n${printer.name}\n"
        "${"Vui lòng kiểm tra & đảm bảo".toUpperCase()}\n"
        "- Máy in đã bật và không bị kẹt giấy\n"
        "- Dây mạng kết nối với máy in đã sáng";
    if (Platform.isAndroid) {
      try {
        final bool result = await _channel.invokeMethod('ping', {'ip': printer.ip});
        if (result) {
          return null;
        }

        throw Exception();
      } catch (ex) {
        return commonError;
      }
    } else if (Platform.isWindows) {
      try {
        final resultPingWin = await _pingWindows(printer.ip);
        return resultPingWin ? null : commonError;
      } catch (_) {
        return commonError;
      }
    } else {
      return "Lỗi ping cmd máy in!";
    }
  }

  static Future<bool> _pingWindows(String ip) async {
    try {
      final process = await Process.start('ping', ['-n', '4', '-w', '1000', ip]);
      bool hasReply = false;

      final stdoutLines = process.stdout.transform(utf8.decoder).transform(const LineSplitter());

      await for (final line in stdoutLines) {
        if (line.toLowerCase().contains('reply from')) {
          hasReply = true;
          break;
        }
      }

      await process.exitCode;

      return hasReply;
    } catch (e) {
      showLog(e, flags: 'checkPrinter _pingWindows');
      return false;
    }
  }

  /// True => null
  ///
  /// False => message - máy in lỗi
  static Future<String?> checkPrinters(List<IpOrderModel> printers) async {
    List<IpOrderModel> printerChecks = [];
    for (var printer in printers) {
      final check = await checkPrinter(printer);
      if (check != null) {
        printerChecks.add(printer);
      }
    }
    var infoPrinterError = "";
    for (var element in printerChecks) {
      infoPrinterError += "${element.name}\n";
    }
    return printerChecks.isEmpty
        ? null
        : "Không kết nối được máy in\n$infoPrinterError\n"
            "${"Vui lòng kiểm tra & đảm bảo".toUpperCase()}\n"
            "- KDS đã cắm dây mạng hoặc đã kết nối mạng Order\n"
            "- Máy in đã bật và không bị kẹt giấy\n"
            "- Dây mạng kết nối với máy in đã sáng";
  }

  /// Tách tên món (xuống dòng) với kí tự tối đa
  ///
  /// Mặc định là 32 kí tự
  static String splitTextPrint(String text, {int maxSegmentLength = 32}) {
    List<String> result = [];
    final textLen = text.length;
    if (textLen <= maxSegmentLength) {
      return text;
    }
    final words = text.split(' ');
    String subResult = '';
    for (var word in words) {
      if (subResult.length + word.length + 1 > maxSegmentLength) {
        result.add(subResult.trim());
        subResult = '';
      }
      subResult += "$word ";
    }
    if (subResult.isNotEmpty) {
      result.add(subResult.trim());
    }
    return result.join('\n');
  }

  static String? posPrintResultMessage(PosPrintResult result) {
    switch (result) {
      // 'Error. Printer connection timeout'
      case PosPrintResult.timeout:
        return 'Không kết nối được với máy in!';
      // 'Error. Printer not connected'
      case PosPrintResult.printerConnected:
        return 'Không kết nối được với máy in!';
      // 'Error. Ticket is empty'
      case PosPrintResult.ticketEmpty:
        return 'Error. Ticket is empty';
      default:
        return null;
    }
  }
}
