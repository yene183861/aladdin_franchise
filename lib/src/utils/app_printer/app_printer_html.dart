import 'dart:convert';
import 'dart:math';

import 'package:aladdin_franchise/src/configs/enums/bill_setting.dart';
import 'package:aladdin_franchise/src/core/storages/local.dart';
import 'package:aladdin_franchise/src/data/enum/receipt_type.dart';
import 'package:aladdin_franchise/src/data/request/payment_receipt_print.dart';
import 'package:aladdin_franchise/src/data/response/close_shift.dart';
import 'package:aladdin_franchise/src/models/combo_item.dart';
import 'package:aladdin_franchise/src/models/data_bill.dart';
import 'package:aladdin_franchise/src/models/ip_order.dart';
import 'package:aladdin_franchise/src/models/order.dart';
import 'package:aladdin_franchise/src/models/payment_method/payment_method.dart';
import 'package:aladdin_franchise/src/models/policy_result.dart';
import 'package:aladdin_franchise/src/models/product.dart';
import 'package:aladdin_franchise/src/models/restaurant.dart';
import 'package:aladdin_franchise/src/utils/app_helper.dart';
import 'package:aladdin_franchise/src/utils/app_log.dart';
import 'package:aladdin_franchise/src/utils/app_util.dart';
import 'package:aladdin_franchise/src/utils/date_time.dart';
import 'package:aladdin_franchise/src/utils/product_helper.dart';
import 'package:flutter_esc_pos_network/flutter_esc_pos_network.dart';
import 'package:flutter_esc_pos_utils/flutter_esc_pos_utils.dart';
import 'package:image/image.dart' as image_lib;
import 'package:webcontent_converter/webcontent_converter.dart';

class AppPrinterHtmlUtils {
  AppPrinterHtmlUtils._();

  static final AppPrinterHtmlUtils _instance = AppPrinterHtmlUtils._();

  static AppPrinterHtmlUtils get instance => _instance;
  factory AppPrinterHtmlUtils() => _instance;

  Future<List<int>> generateImageBill(String data) async {
    final billHtmlSetting = LocalStorage.getPrintSetting().billHtmlSetting;
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

  Future<List<int>> getReceptBillContent(
    PaymentReceiptPrintRequest data,
    // {
    // required OrderModel order,
    // List<LineItemDataBill> orderLineItems = const [],
    // required PriceDataBill price,
    // String? note,
    // PaymentMethod? paymentMethod,
    // List<HistoryPolicyResultModel> vouchers = const [],
    // required ReceiptTypeEnum receiptType,
    // bool printNumberOfPeople = false,
    // String customerPhone = '',
    // int numberOfPeople = 1,
    // double paymentAmount = 0.0,
    // int numberPrintCompleted = 1,
    // int numberPrintTemporary = 1,
    // String cashierCompleted = '',
    // DateTime? timeCompleted,
    // DateTime? timeCreatedAt,
    // String cashierPrint = '',
    // String invoiceQr = '',
    // }
  ) async {
    var htmlData = _receiptBillContent(data
        // order: order,
        // orderLineItems: orderLineItems,
        // price: price,
        // receiptType: receiptType,
        // note: note ?? '',
        // customerPhone: customerPhone,
        // numberOfPeople: numberOfPeople,
        // paymentAmount: paymentAmount,
        // paymentMethod: paymentMethod,
        // printNumberOfPeople: printNumberOfPeople,
        // vouchers: vouchers,
        // numberPrintCompleted: numberPrintCompleted,
        // numberPrintTemporary: numberPrintTemporary,
        // cashierCompleted: cashierCompleted,
        // timeCompleted: timeCompleted,
        // timeCreatedAt: timeCreatedAt,
        // cashierPrint: cashierPrint,
        // invoiceQr: invoiceQr,
        );
    var bytes = await generateImageBill(htmlData);
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
    if (!totalBill && (product.firstOrNull?.note ?? '').isNotEmpty) {
      finalNote = (product.firstOrNull?.note ?? '');
    }
    if (cancel) {
      finalNote = note;
    }

    for (final pc in product) {
      if (totalBill) {
        dishTable += '''
        <tr>
            <td width="75%">${pc.name}</td>
            <td width="10%" class="center">${cancel ? '-' : ''}${(pc.numberSelecting).abs()}</td>
            <td width="15%" style="text-align: right">${pc.unit}</td>
        </tr>
      ''';
      }
      List<ComboItemModel>? comboItems = ProductHelper().getComboDescription(pc);
      // showLogs(comboItems, flags: 'comboItems');
      if (comboItems != null) {
        // check xem có cần nhân số lượng combo với món trong combo k
        for (var ci in comboItems) {
          // showLogs(ci.getNameView(), flags: 'ci 123');
          // showLogs(ci, flags: 'ci 123');
          dishTable += '''
        <tr>
            <td width="75%">${'${totalBill ? '  ' : ''}- ${ci.getNameView()}'}</td>
            <td width="10%" class="center">${cancel ? '-' : ''}${(ci.quantity * pc.numberSelecting).abs()}</td>
            <td width="15%" style="text-align: right">${ci.unit}</td>
        </tr>
      ''';
        }
      } else {
        if (!totalBill) {
          dishTable += '''
        <tr>
            <td width="75%">${pc.name}</td>
            <td width="10%" class="center">${cancel ? '-' : ''}${(pc.numberSelecting).abs()}</td>
            <td width="15%" style="text-align: right">${pc.unit}</td>
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
${_getRestaurantInfo()}
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
${_getTime()}
</body>

</html>
''';
  }

  String _receiptBillContent(
    PaymentReceiptPrintRequest data,
    //   {
    //   List<LineItemDataBill> orderLineItems = const [],
    //   List<HistoryPolicyResultModel> vouchers = const [],
    //   required OrderModel order,
    //   String note = '',
    //   required ReceiptTypeEnum receiptType,
    //   bool printNumberOfPeople = false,
    //   String customerPhone = '',
    //   int numberOfPeople = 1,
    //   PaymentMethod? paymentMethod,
    //   double paymentAmount = 0,
    //   required PriceDataBill price,
    //   int numberPrintCompleted = 1,
    //   int numberPrintTemporary = 1,
    //   String cashierCompleted = '',
    //   DateTime? timeCompleted,
    //   DateTime? timeCreatedAt,
    //   String cashierPrint = '',
    //   String invoiceQr = '',
    // }
  ) {
    var user = LocalStorage.getDataLogin()?.user;
    String dishTable = "";

    bool isPaymentReceipt = data.receiptType == ReceiptTypeEnum.paymentReceipt;

    Map<double, double> mapTax = {};

    for (final pc in data.orderLineItems) {
      var tax = pc.getTaxView();
      if (tax > 0) {
        mapTax[tax] = (mapTax[tax] ?? 0.0) +
            pc.count *
                (AppUtils.convertToDouble(pc.price) ?? 0.0) *
                (AppUtils.convertToDouble(pc.tax) ?? 0.0);
      }

      dishTable += '''
          <tr>
            <td width="46%">${pc.name}</td>
            <td width="7%">${pc.count}</td>
            <td width="20%">${AppUtils.formatCurrency(value: pc.price)}</td>
            <td class="tax" width="7%">${pc.getTaxView() == pc.getTaxView().toInt() ? pc.getTaxView().toInt() : pc.getTaxView()}%</td>
            <td width="20%" style="text-align: right">${AppUtils.formatCurrency(value: pc.count * (AppUtils.convertToDouble(pc.price) ?? 0.0))}</td>
          </tr>
          ''';

      /// combo item
    }
    String voucherDetail = "";
    if (isPaymentReceipt)
      // ignore: curly_braces_in_flow_control_structures
      for (final v in data.vouchers) {
        var amount = v.total;
        if (amount < 0) continue;

        voucherDetail += '''
          <tr>
            <td colspan="4">${v.name}</td>
            <td style="text-align: right">${AppUtils.formatCurrency(value: amount)}</td>
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
                <td style="text-align: right">${AppUtils.formatCurrency(value: value)}</td>
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

        h2,
        h3 {
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

        .infobill th,
        .infobill td {
            word-wrap: break-word;
        }

        .items th,
        .items td {
            word-wrap: break-word;
            border: 1px solid black;
        }

        th {
            text-align: left;
        }

        .tax {
            text-align: center;
        }

        .total {
            width: 100%;
            word-wrap: break-word;
            border-collapse: collapse;
        }

        .total td {
            padding-top: 10px;
        }

        hr {
            border: 1px solid black;
        }

        #qrcode_block {
            text-align: center;
        }

        .qrcode {
            display: inline-block;
        }
    </style>
     ${data.invoiceQr.trim().isNotEmpty ? '<script src="https://cdn.jsdelivr.net/npm/qrcodejs/qrcode.min.js"></script>' : ''}

</head>

<body style="margin: 0px;padding: 0px;">
${_getRestaurantInfo()}
    <h2 style="text-align: center;text-transform: uppercase;word-wrap: break-word;">${data.receiptType.title}</h2>
    <h2 style="text-align: center;text-transform: uppercase;word-wrap: break-word;">Bill ${data.order.getOrderMisc()} Bàn ${data.order.name}</h2>
    <h3 style="text-align: center;word-wrap: break-word;">${data.receiptType.note}</h3>
    <table class="infobill">
        <tr>
            <th width="50%">Người in bill:</th>
            <td width="50%">${data.cashierPrint.trim().isEmpty ? (user?.name ?? '') : data.cashierPrint.trim()}</td>
        </tr>
        <tr>
            <th width="50%">Người hoàn thành:</th>
            <td width="50%">${data.cashierCompleted.trim().isEmpty ? (user?.name ?? '') : data.cashierCompleted.trim()}</td>
        </tr>
        <tr>
            <th width="50%">Giờ vào:</th>
            <td width="50%">${_printDateTime(data.timeCreatedAt ?? DateTime.now())}</td>
        </tr>
        <tr>
            <th width="50%">Giờ ra:</th>
            <td width="50%">${_printDateTime(data.timeCompleted ?? DateTime.now())}</td>
        </tr>
        <tr>
            <th width="50%">Điện thoại KH:</th>
            <td width="50%">${data.customerPhone}</td>
        </tr>
        <tr>
            <th width="50%">Số khách:</th>
            <td width="50%">${data.printNumberOfPeople ? max(0, data.numberOfPeople).toString() : ''}</td>
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
            <td width="20%" style="text-align: right">${AppUtils.formatCurrency(value: data.price.totalPrice)}</td>
        </tr>
        <tr>
            <td style="font-weight: bold" colspan="4">Giảm tiền trước thuế</td>
            <td style="text-align: right">${AppUtils.formatCurrency(value: data.price.totalPriceVoucher)}</td>
        </tr>
        $voucherDetail

        <tr>
            <td colspan="4" style="font-weight: bold">Tổng tiền thuế</td>
            <td style="text-align: right">${AppUtils.formatCurrency(value: data.price.totalPriceTax)}</td>
        </tr>
        $taxDetail

        <tr>
            <td style="font-weight: bold" colspan="4">Giảm tiền sau thuế</td>
            <td style="text-align: right">0</td>
        </tr>

        <tr>
            <td style="font-weight: bold" colspan="4">Tiền thanh toán</td>
            <td style="text-align: right">${AppUtils.formatCurrency(value: data.price.totalPriceFinal)}</td>
        </tr>
    </table>
    <hr>
    <span>
        <b>Ghi chú:</b> <br>
        ${data.note}

    </span>
    <p></p>
    <br>
    <span>
        <b>Hình thức thanh toán</b>:<br>
        ${data.receiptType.showPaymentMethod ? '${data.paymentMethod?.name ?? ''}:${AppUtils.formatCurrency(value: data.paymentAmount)}' : ''}<br>
    </span>

    <hr>
    <p style="word-wrap: break-word;text-align: justify;">
        ${data.invoiceQr.trim().isNotEmpty ? 'Quý khách vui lòng quét QR để nhập thông tin hoá đơn:'
            ' Trong 60 phút sau khi in bill và trước 23h30 cùng ngày.'
            'Trường hợp khách hàng không nhập thông tin xuất hoá đơn GTGT trong khung giờ nêu trên'
            ' thì Công ty sẽ xuất hoá đơn Khách lẻ và không xuất lại hoá đơn trong mọi trường hợp sau đó. Xin cảm ơn Quý khách!' : 'Khách hàng vui lòng cung cấp thông tin xuất hóa đơn GTGT tại thời điểm thanh toán.'
            'Trường hợp khách hàng không cung cấp thông tin xuất hóa đơn GTGT thì công ty'
            'sẽ xuất hóa đơn Khách Lẻ và không xuất lại hóa đơn trong mọi trường hợp sau đó.'}
        ${data.invoiceQr.trim().isNotEmpty ? '<div id="qrcode"></div>' : ''}
${_getTime()}
    <p style="text-align: center">
        ${isPaymentReceipt ? '' : 'Lần in tạm tính: ${data.numberPrintTemporary}<br>'}
        ${isPaymentReceipt ? 'Lần in hoàn thành: ${data.numberPrintCompleted}' : ''}
    </p>
    ${data.invoiceQr.trim().isNotEmpty ? '''
    <script>
      window.onload = function() {
        const url = "${data.invoiceQr.trim()}";
        new QRCode(document.getElementById("qrcode"), {
            text: url,
            width: 128,
            height: 128
        });
      };
    </script>
    ''' : ''}

</body>

</html>
''';
  }

  String _printDateTime(DateTime? value) {
    return DateTimeUtils.formatToString(time: value, newPattern: DateTimePatterns.dateTime1);
  }

  Future<List<int>> getCloseShiftContent(CloseShiftResponseModel data) async {
    var htmlData = _closeShiftContent(data);
    var bytes = await generateImageBill(htmlData);
    return bytes;
  }

  String _closeShiftContent(CloseShiftResponseModel data) {
    var paymentMethod = '';
    try {
      for (var e in (data.totalPayment as Map).values) {
        paymentMethod += '''
          <tr>
              <td width="60%">${e['label'] ?? ''}</td>
              <td width="40%">${AppUtils.formatCurrency(value: (e['value'] ?? '').toString())}</td>
          </tr>
        ''';
      }
    } catch (ex) {
      //
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

        .infobill th,
        .infobill td {
            word-wrap: break-word;
        }

        .items th,
        .items td {
            word-wrap: break-word;
            border: 1px solid black;
        }

        th {
            text-align: left;
        }

        .tax {
            text-align: center;
        }

        .total {
            width: 100%;
            word-wrap: break-word;
            border-collapse: collapse;
        }

        .total td {
            padding-top: 10px;
        }

        hr {
            border: 1px solid black;
        }

        #qrcode_block {
            text-align: center;
        }

        .qrcode {
            display: inline-block;
        }
    </style>
</head>

<body style="margin: 0px;padding: 0px;">
${_getRestaurantInfo()}
    <h2 style="text-align: center;text-transform: uppercase;word-wrap: break-word;">
    MỞ: ${DateTimeUtils.formatToString(time: data.openShift, newPattern: DateTimePatterns.dateTimeNotSecond)}</h2>
    <h2 style="text-align: center;text-transform: uppercase;word-wrap: break-word;">
    ĐÓNG: ${DateTimeUtils.formatToString(time: data.lockShift, newPattern: DateTimePatterns.dateTimeNotSecond)}</h2>


    <table class="items">
        <tr>
            <td width="40%">Ca</td>
            <th width="60%">${data.shiftName.toUpperCase()}</th>

        </tr>
        <tr>
            <td width="40%">Thu ngân</td>
            <th width="60%">${data.cashierName}</th>

        </tr>
    </table>

    <h2 style="text-align: center;text-transform: uppercase;word-wrap: break-word;">SỐ LIỆU CHỐT</h2>
    <table class="items">
        <tr>
            <td width="60%">Số dư đầu</td>
            <td width="40%">${AppUtils.formatCurrency(value: data.openingBalances)}</td>

        </tr>
        <tr>
            <td width="60%">Tổng tiền bán</td>
            <td width="40%">${AppUtils.formatCurrency(value: data.totalAmount)}</td>

        </tr>
        $paymentMethod
        <tr>
            <td width="60%">Tổng giảm giá</td>
            <td width="40%">${AppUtils.formatCurrency(value: data.discountMoney)}</td>

        </tr>
        <tr>
            <td width="60%">Tổng chiết khấu</td>
            <td width="40%">${AppUtils.formatCurrency(value: data.percentBill)}</td>

        </tr>
        <tr>
            <td width="60%">Tổng hoá đơn</td>
            <td width="40%">${data.countInvoice}</td>

        </tr>
        <tr>
            <td width="60%">Dư cuối ca</td>
            <td width="40%">${AppUtils.formatCurrency(value: data.endofshiftBalance)}</td>

        </tr>
    </table>
    <p></p>
    <hr>
${_getTime()}
</body>

</html>
''';
  }

  String _getRestaurantInfo() {
    RestaurantModel? restaurant = LocalStorage.getDataLogin()?.restaurant;
    return '''
<h2 style="text-align: center;text-transform: uppercase;word-wrap: break-word;">${restaurant?.name ?? ''}</h2>
<h5 style="text-align: center;text-transform: uppercase;word-wrap: break-word;">${restaurant?.address ?? ''}</h5>
''';
  }

  String _getTime() {
    return '''
<p style="text-align: center">
    Powered by Aladdin.,JSC <br>
    Thời gian in: ${_printDateTime(DateTime.now())}
</p>
<p style="text-align: center"></p>
''';
  }
}
