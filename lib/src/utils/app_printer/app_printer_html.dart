import 'dart:convert';
import 'dart:math';

import 'package:aladdin_franchise/generated/l10n.dart';
import 'package:aladdin_franchise/src/configs/enums/bill_setting.dart';
import 'package:aladdin_franchise/src/core/storages/local.dart';
import 'package:aladdin_franchise/src/models/combo_item.dart';
import 'package:aladdin_franchise/src/models/data_bill.dart';
import 'package:aladdin_franchise/src/models/ip_order.dart';
import 'package:aladdin_franchise/src/models/order.dart';
import 'package:aladdin_franchise/src/models/payment_method/payment_method.dart';
import 'package:aladdin_franchise/src/models/policy_result.dart';
import 'package:aladdin_franchise/src/models/product.dart';
import 'package:aladdin_franchise/src/models/restaurant.dart';
import 'package:aladdin_franchise/src/utils/app_log.dart';
import 'package:aladdin_franchise/src/utils/app_printer/app_printer_common.dart';
import 'package:aladdin_franchise/src/utils/date_time.dart';
import 'package:aladdin_franchise/src/utils/product_helper.dart';
import 'package:flutter_esc_pos_network/flutter_esc_pos_network.dart';
import 'package:flutter_esc_pos_utils/flutter_esc_pos_utils.dart';
import 'package:image/image.dart' as image_lib;
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:webcontent_converter/webcontent_converter.dart';
import 'package:aladdin_franchise/src/utils/app_printer/app_printer_common.dart';
// import 'package:webcontent_converter/src/webcontent_converter/webcontent_converter_io.dart'
//     as convertIo;

class AppPrinterHtmlUtils {
  AppPrinterHtmlUtils._();

  static final AppPrinterHtmlUtils _instance = AppPrinterHtmlUtils._();

  static AppPrinterHtmlUtils get instance => _instance;
  factory AppPrinterHtmlUtils() => _instance;

  Future<List<int>> getReceptBillContent({
    required OrderModel order,
    List<LineItemDataBill> orderLineItems = const [],
    required PriceDataBill price,
    String? note,
    PaymentMethod? paymentMethod,
    List<HistoryPolicyResultModel> vouchers = const [],
    required ReceiptTypeEnum receiptType,
    required List<IpOrderModel> printers,
    bool printNumberOfPeople = false,
    String customerPhone = '',
    int numberOfPeople = 1,
    double paymentAmount = 0.0,
    int numberPrintCompleted = 1,
    int numberPrintTemporary = 1,
    String cashierCompleted = '',
    DateTime? timeCompleted,
    DateTime? timeCreatedAt,
    String cashierPrint = '',
  }) async {
    var htmlData = paymentBillContent(
      order: order,
      orderLineItems: orderLineItems,
      price: price,
      receiptType: receiptType,
      note: note ?? '',
      customerPhone: customerPhone,
      numberOfPeople: numberOfPeople,
      paymentAmount: paymentAmount,
      paymentMethod: paymentMethod,
      printNumberOfPeople: printNumberOfPeople,
      vouchers: vouchers,
      numberPrintCompleted: numberPrintCompleted,
      numberPrintTemporary: numberPrintTemporary,
      cashierCompleted: cashierCompleted,
      timeCompleted: timeCompleted,
      timeCreatedAt: timeCreatedAt,
      cashierPrint: cashierPrint,
    );
    var bytes = await generateImageBill(htmlData);
    return bytes;
  }

  /// in hóa đơn
  Future<String?> printReceipt({
    required OrderModel order,
    List<LineItemDataBill> orderLineItems = const [],
    required PriceDataBill price,
    String? note,
    PaymentMethod? paymentMethod,
    List<HistoryPolicyResultModel> vouchers = const [],
    required ReceiptTypeEnum receiptType,
    required List<IpOrderModel> printers,
    bool printNumberOfPeople = false,
    String customerPhone = '',
    int numberOfPeople = 1,
    double paymentAmount = 0.0,
    int numberPrintCompleted = 1,
    int numberPrintTemporary = 1,
    String cashierCompleted = '',
    DateTime? timeCompleted,
    DateTime? timeCreatedAt,
    String cashierPrint = '',
  }) async {
    try {
      var htmlData = paymentBillContent(
        order: order,
        orderLineItems: orderLineItems,
        price: price,
        receiptType: receiptType,
        note: note ?? '',
        customerPhone: customerPhone,
        numberOfPeople: numberOfPeople,
        paymentAmount: paymentAmount,
        paymentMethod: paymentMethod,
        printNumberOfPeople: printNumberOfPeople,
        vouchers: vouchers,
        numberPrintCompleted: numberPrintCompleted,
        numberPrintTemporary: numberPrintTemporary,
        cashierCompleted: cashierCompleted,
        timeCompleted: timeCompleted,
        timeCreatedAt: timeCreatedAt,
        cashierPrint: cashierPrint,
      );
      var bytes = await generateImageBill(htmlData);

      try {
        for (var printer in printers) {
          final xPrinter = PrinterNetworkManager(
            printer.ip,
            port: printer.port,
          );

          int retry = 2;
          while (retry < 3) {
            retry++;
            final PosPrintResult connectResult =
                await xPrinter.connect(timeout: const Duration(seconds: 10));
            if (connectResult == PosPrintResult.success) {
              try {
                final billStatus = await xPrinter.printTicket(bytes);
                await xPrinter.disconnect();
                // try {
                // await xPrinter.disconnect();
                // } catch (ex) {
                //   showLogs(ex.toString(), flags: 'xPrinter disconnect 1');
                //   rethrow;
                // }
                showLogs(billStatus.msg, flags: 'KQ in');
                if (billStatus != PosPrintResult.success) {
                  throw billStatus.msg;
                }
              } catch (ex) {
                showLogs(ex.toString(), flags: 'xPrinter disconnect');
                rethrow;
              }
            } else {
              // try {
              //   await xPrinter.disconnect();
              // } catch (ex) {
              //   showLogs(ex.toString(), flags: 'xPrinter disconnect 2');
              // }
              if (connectResult == PosPrintResult.timeout) {
                retry++;
                if (retry > 2) {
                  showLogs(connectResult.msg, flags: 'xPrinter connect ex');
                  throw connectResult.msg;
                }
              } else {
                showLogs(connectResult.msg, flags: 'xPrinter connect ex');
                throw connectResult.msg;
              }
            }
          }
        }
      } catch (ex) {
        showLogs(ex.toString(), flags: 'Lỗi in hóa đơn');
        return ex.toString();
      }

      return null;
    } catch (ex) {
      showLogs(ex.toString(), flags: 'Lỗi gen ảnh hóa đơn');
      return ex.toString();
    }
  }

  /// in bill xuống bếp
  Future<String?> printKitchenBill({
    required OrderModel order,
    List<ProductModel> product = const [],
    String note = '',
    required List<IpOrderModel> printers,
    bool printEachItem = false,
    int timeOrders = 1,
    bool cancel = false,
  }) async {
    List<int> bytes = [];

    String? error;
    for (var printer in printers) {
      List<ProductModel> productPrinter = [];
      for (var p in product) {
        var comboItem = ProductHelper().getComboDescription(p);
        // combo
        List<ComboItemModel> comboItemPrint = [];
        if (comboItem != null) {
          comboItemPrint =
              comboItem.where((e) => e.printerType == printer.type).toList();
          if (comboItemPrint.isNotEmpty) {
            String? description = p.description;
            try {
              description = jsonEncode(comboItemPrint);
            } catch (ex) {
              showLogs(ex.toString(), flags: 'encode món trong combo');
              //
            }
            productPrinter.add(p.copyWith(description: description));
          } else if (printer.type == p.printerType) {
            productPrinter.add(p.copyWith(description: ''));
          }
        } else {
          if (printer.type == p.printerType) {
            productPrinter.add(p);
          }
        }
      }
      // var productPrinter =
      //     product.where((e) => e.printerType == item.type).toList();

      if (productPrinter.isEmpty) {
        continue;
      }
      var htmlData = kitchenBillContent(
        order: order,
        product: productPrinter,
        note: note,
        timeOrders: timeOrders,
        cancel: cancel,
      );

      bytes = await generateImageBill(htmlData);
      final printerManager = PrinterNetworkManager(
        printer.ip,
        port: printer.port,
      );
      final PosPrintResult res = await printerManager.connect();
      if (res != PosPrintResult.success) {
        throw printer.messageConnectFail();
      }
      if (res == PosPrintResult.success) {
        var billStatus =
            await printerManager.printTicket(bytes, isDisconnect: false);
        if (billStatus != PosPrintResult.success) {
          return cancel
              ? "In bill tổng thất bại!\n${billStatus.msg}"
              : 'In bill hủy đồ thất bại\n${billStatus.msg}';
        }
        // chỉ in bill lẻ với bếp
        if (!cancel &&
            printEachItem &&
            productPrinter.length > 1 &&
            printer.type == 2) {
          for (var p in productPrinter) {
            List<int> byteDatas;
            var oddHtmlBill = kitchenBillContent(
              order: order,
              product: [p],
              note: note,
              timeOrders: timeOrders,
              totalBill: false,
              cancel: cancel,
            );
            byteDatas = await generateImageBill(oddHtmlBill);
            billStatus = await printerManager.printTicket(byteDatas,
                isDisconnect: false);
            if (billStatus != PosPrintResult.success) {
              return "In bill lẻ xuống bếp thất bại!\n${billStatus.msg}";
            }
          }
        }
        printerManager.disconnect();
        showLog(billStatus.msg, flags: 'billStatus');
      } else {
        error = res.msg;
      }
    }

    return error;
  }

  Future<List<int>> generateImageBill(String data) async {
    final billHtmlSetting = LocalStorage.getAppSettings().billHtmlSetting;
    // final fontSize = billHtmlSetting.fontSize;
    final profile = await CapabilityProfile.load();
    var paperSize = billHtmlSetting.paperSize.paperSize;
    final generator = Generator(paperSize, profile);
    List<int> bytes = [];

    var byteImage = await WebcontentConverter.contentToImage(content: data);
    if (byteImage.isEmpty) {
      throw "Lỗi tải ảnh bill 1";
    }
    final image_lib.Image? receipt = image_lib.decodeImage(byteImage);
    if (receipt == null) {
      throw "Lỗi tải ảnh bill";
    }
    showLog(receipt.length / 1024, flags: "receipt Kb");
    final image_lib.Image receiptResize = image_lib.copyResize(
      receipt,
      width: paperSize.width,
      interpolation: image_lib.Interpolation.linear,
    );
    showLog(receiptResize.length / 1024, flags: "resize Kb");
    bytes += generator.image(receiptResize);
    bytes += generator.cut();

    return bytes;
  }

  String kitchenBillContent({
    List<ProductModel> product = const [],
    required OrderModel order,
    int timeOrders = 1,
    String note = '',
    bool totalBill = true,
    bool cancel = false,
  }) {
    RestaurantModel? restaurant = LocalStorage.getDataLogin()?.restaurant;
    String dishTable = "";

    var finalNote = note;
    if (!totalBill &&
        (product.firstOrNull?.noteForProcessOrder ?? '').isNotEmpty) {
      finalNote = (product.firstOrNull?.noteForProcessOrder ?? '');
    }
    if (cancel) {
      finalNote = note;
    }

    for (final pc in product) {
      dishTable += '''
        <tr>
            <td width="75%">${pc.name}</td>
            <td width="10%" class="center">${cancel ? '-' : ''}${(pc.numberSelecting).abs()}</td>
            <td width="15%" style="text-align: right">${pc.unit}</td>
        </tr>
      ''';
      List<ComboItemModel>? comboItems =
          ProductHelper().getComboDescription(pc);
      if (comboItems != null) {
        // check xem có cần nhân số lượng combo với món trong combo k
        for (var ci in comboItems) {
          dishTable += '''
        <tr>
            <td width="75%">${'  - ${ci.getNameView()}'}</td>
            <td width="10%" class="center">'${cancel ? '-' : ''}${(ci.quantity * pc.numberSelecting).abs()}'</td>
            <td width="15%" style="text-align: right">${ci.unit}</td>
        </tr>
      ''';
        }
      }
    }
    return '''
<!DOCTYPE HTML>
<html style="margin: 0px;padding: 0px;">

<head>
    <meta http-equiv="content-type" content="text/html; charset=utf-8" />
    <style type="text/css">
        body {
            width: 302.36px;
        }

        h2,
        h3 {
            font-size: 16px;
        }

        p {
            margin-bottom: 0.25cm;
            line-height: 120%;
        }
        
        table, th, td {
          border:none;
          border-collapse: collapse;
        }

        .items {
            width: 100%;
            word-wrap: break-word;
            border-collapse: collapse;
        }

        .items th,
        .items td {
            word-wrap: break-word;
        
        }

        th {
            text-align: left;
        }

        hr {
            border: 0.5px solid black;
        }
        
        .right {
           text-align: right; 
        }
        .left {
           text-align: left; 
        }
        .center {
           text-align: center; 
        }
    </style>
</head>

<body style="margin: 0px;padding: 0px;">
    <p style="text-align: center">
    <h2 style="text-align: center">${restaurant?.name ?? ''}</h2>
    <h5 style="text-align: center; font-size:14px;">${restaurant?.address ?? ''}</h5>
    <h2 style="text-align: center;word-wrap: break-word;">${cancel ? 'HỦY ĐỒ - ' : ''}${order.getOrderMisc()} - Bàn ${order.name}</h2>
    <table class="items">
        <tr>
            <th width="75%">Tên món</th>
            <th width="10%" class="center">SL</th>
            <th width="15%" class="right">DVT</th>
        </tr>
        $dishTable
    </table>
    
    <hr>
    <span>
        <b>Ghi chú:</b> <br>$finalNote

    </span>
    <p></p>



    <p style="text-align: center">
        Powered by Aladdin.,JSC <br>
        ${DateTimeUtils.formatToString(time: DateTime.now(), newPattern: 'dd/MM/yyyy HH:mm:ss')}
    </p>
    <p style="text-align: center">
    ''
    </p>
</body>

</html>
''';
  }

  String paymentBillContent({
    List<LineItemDataBill> orderLineItems = const [],
    List<HistoryPolicyResultModel> vouchers = const [],
    required OrderModel order,
    String note = '',
    required ReceiptTypeEnum receiptType,
    bool printNumberOfPeople = false,
    String customerPhone = '',
    int numberOfPeople = 1,
    PaymentMethod? paymentMethod,
    double paymentAmount = 0,
    required PriceDataBill price,
    int numberPrintCompleted = 1,
    int numberPrintTemporary = 1,
    String cashierCompleted = '',
    DateTime? timeCompleted,
    DateTime? timeCreatedAt,
    String cashierPrint = '',
  }) {
    RestaurantModel? restaurant = LocalStorage.getDataLogin()?.restaurant;
    var user = LocalStorage.getDataLogin()?.user;
    String dishTable = "";

    bool isPaymentReceipt = receiptType == ReceiptTypeEnum.paymentReceipt;

    Map<double, double> mapTax = {};

    for (final pc in orderLineItems) {
      var tax = pc.getTaxView();
      if (tax > 0) {
        mapTax[tax] = (mapTax[tax] ?? 0.0) +
            pc.count *
                AppHelper.parseToDoubleValue(pc.price) *
                AppHelper.parseToDoubleValue(pc.tax);
      }

      dishTable += '''
          <tr>
            <td width="46%">${pc.name}</td>
            <td width="7%">${pc.count}</td>
            <td width="20%">${AppHelper.parseToPrice(pc.price)}</td>
            <td class="tax" width="7%">${pc.getTaxView() == pc.getTaxView().toInt() ? pc.getTaxView().toInt() : pc.getTaxView()}%</td>
            <td width="20%" style="text-align: right">${AppHelper.parseToPrice(pc.count * AppHelper.parseToDoubleValue(pc.price))}</td>
          </tr>
          ''';

      /// combo item
    }
    String voucherDetail = "";
    if (isPaymentReceipt)
      // ignore: curly_braces_in_flow_control_structures
      for (final v in vouchers) {
        var amount = v.total;
        if (amount < 0) continue;

        voucherDetail += '''
          <tr>
            <td colspan="4">${v.name}</td>
            <td style="text-align: right">${AppHelper.parseToPrice(amount)}</td>
          </tr>
        ''';
      }

    String taxDetail = "";
    if (isPaymentReceipt) {
      mapTax.forEach(
        (key, value) {
          if (key > 0) {
            taxDetail += '''
              <tr>
                <td colspan="4">Tiền thuế (${key == key.toInt() ? key.toInt() : key}%)</td>
                <td style="text-align: right">${AppHelper.parseToPrice(value)}</td>
              </tr>
            ''';
          }
        },
      );
    }

    return '''
<!DOCTYPE HTML>
<html style="margin: 0px;padding: 0px;">
<head>
    <meta http-equiv="content-type" content="text/html; charset=utf-8" />
    <style type="text/css">
    body {
     width: 302.36px;
     }
     h2, h3 {
     font-size: 16px;
     }
    
        p {
            margin-bottom: 0.25cm;
            line-height: 120%;
        }
        .items {
            width: 100%;
            word-wrap: break-word;
            border-collapse: collapse;
        }
        .infobill {
            width: 100%;
            word-wrap: break-word;
            border-collapse: collapse;
        }
        .infobill th,.infobill td {
            word-wrap: break-word;
        }
        .items th,.items td {
            word-wrap: break-word;
            border: 1px solid black;
        }
        th {
            text-align: left;
        }
        .tax{
            text-align: center;
        }
        .total {
            width: 100%;
            word-wrap: break-word;
            border-collapse: collapse;
        }
        .total td{
            padding-top: 10px;
        }
        hr {
            border: 1px solid black;
        }
        
    </style>
</head>
<body style="margin: 0px;padding: 0px;">
<p style="text-align: center">
<h2 style="text-align: center;text-transform: uppercase;word-wrap: break-word;">${restaurant?.name ?? ''}</h2>
<h5 style="text-align: center;text-transform: uppercase;word-wrap: break-word;">${restaurant?.address ?? ''}</h5>
<h2 style="text-align: center;text-transform: uppercase;word-wrap: break-word;">${receiptType.title}</h2>
<h2 style="text-align: center;text-transform: uppercase;word-wrap: break-word;">Bill ${order.getOrderMisc()} Bàn ${order.name}</h2>
<h3 style="text-align: center;word-wrap: break-word;">${receiptType.note}</h3>
<table class="infobill">
    <tr>
        <th width="50%">Người in bill:</th>
        <td width="50%">${cashierPrint.trim().isEmpty ? (user?.name ?? '') : cashierPrint.trim()}</td>
    </tr>
    <tr>
        <th width="50%">Người hoàn thành:</th>
        <td width="50%">${cashierCompleted.trim().isEmpty ? (user?.name ?? '') : cashierCompleted.trim()}</td>
    </tr>
    <tr>
        <th width="50%">Giờ vào:</th>
        <td width="50%">${_printDateTime(timeCreatedAt ?? DateTime.now())}</td>
    </tr>
    <tr>
        <th width="50%">Giờ ra:</th>
        <td width="50%">${_printDateTime(timeCompleted ?? DateTime.now())}</td>
    </tr>
    <tr>
        <th width="50%">Điện thoại KH:</th>
        <td width="50%">$customerPhone</td>
    </tr>
    <tr>
        <th width="50%">Số khách:</th>
        <td width="50%">${printNumberOfPeople ? max(0, numberOfPeople).toString() : ''}</td>
    </tr>
</table>
<p></p>
<table class="items">
    <tr>
        <th width="46%">Tên món</th>
        <th width="7%">SL</th>
        <th width="20%">Đ.Giá</th>
        <th width="7%">Thuế</th>
        <th width="20%">T.Tiền</th>
    </tr>
    $dishTable
</table>
<table class="total" style="margin-top: 10px;">
    <tr>
        <td style="font-weight: bold" width="80%" colspan="4">T.Tiền trước thuế</td>
        <td width="20%" style="text-align: right">${AppHelper.parseToPrice(price.totalPrice)}</td>
    </tr>
    <tr>
        <td style="font-weight: bold" colspan="4">Giảm tiền trước thuế</td>
        <td style="text-align: right">${AppHelper.parseToPrice(price.totalPriceVoucher)}</td>
    </tr>
    $voucherDetail

    <tr>
        <td colspan="4" style="font-weight: bold">Tổng tiền thuế</td>
        <td style="text-align: right">${AppHelper.parseToPrice(price.totalPriceTax)}</td>
    </tr>
    $taxDetail
                                  
    <tr>
        <td style="font-weight: bold" colspan="4">Giảm tiền sau thuế</td>
        <td style="text-align: right">0</td>
    </tr>
    
    <tr>
        <td style="font-weight: bold" colspan="4">Tiền thanh toán</td>
        <td style="text-align: right">${AppHelper.parseToPrice(price.totalPriceFinal)}</td>
    </tr>
</table>
</p>
<hr>
<span>
 <b>Ghi chú:</b> <br>
 $note 
  
</span>
<p></p>
<br>
<span>
  <b>Hình thức thanh toán</b>:<br>
  ${receiptType.showPaymentMethod ? '${paymentMethod?.name}:${AppHelper.parseToPrice(paymentAmount)}' : ''}<br>
</span>

<hr>
<p style="word-wrap: break-word;text-align: justify;">
    Khách hàng vui lòng cung cấp thông tin xuất hóa đơn GTGT tại thời điểm thanh toán.
	Trường hợp khách hàng không cung cấp thông tin xuất hóa đơn GTGT thì công ty 
	sẽ xuất hóa đơn Khách Lẻ và không xuất lại hóa đơn trong mọi trường hợp sau đó.
</p>
<p style="text-align: center">
    Powered by Aladdin.,JSC <br>
    Thời gian in: ${_printDateTime(DateTime.now())}
</p>
<p style="text-align: center">
    ${isPaymentReceipt ? '' : 'Lần in tạm tính: $numberPrintTemporary<br>'}
    ${isPaymentReceipt ? 'Lần in hoàn thành: $numberPrintCompleted' : ''}
</p>
<p></p>
</body>
</html>
''';
  }

  String _printDateTime(DateTime? value) {
    return DateTimeUtils.formatToString(
        time: value, newPattern: DateTimePatterns.dateTime1);
  }
}

class AppHelper {
  static double parseToDoubleValue(dynamic value) {
    double data =
        // (value is double || value is int)
        value is num ? (value * 1.0) : (double.tryParse(value) ?? 0.0);
    return data;
  }

  static String parseToPrice(
    dynamic value, {
    String symbol = '',
  }) {
    var price = parseToDoubleValue(value);
    return NumberFormat.currency(locale: 'vi', symbol: symbol).format(price);
  }
}
