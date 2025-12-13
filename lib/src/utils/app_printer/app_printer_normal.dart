import 'package:aladdin_franchise/src/core/storages/local.dart';
import 'package:aladdin_franchise/src/data/response/close_shift.dart';
import 'package:aladdin_franchise/src/models/combo_item.dart';
import 'package:aladdin_franchise/src/models/ip_order.dart';
import 'package:aladdin_franchise/src/models/order.dart';
import 'package:aladdin_franchise/src/models/product.dart';
import 'package:aladdin_franchise/src/utils/app_helper.dart';
import 'package:aladdin_franchise/src/utils/app_log.dart';
import 'package:aladdin_franchise/src/utils/app_util.dart';
import 'package:aladdin_franchise/src/utils/product_helper.dart';
import 'package:flutter_esc_pos_network/flutter_esc_pos_network.dart';
import 'package:flutter_esc_pos_utils/flutter_esc_pos_utils.dart';
import 'package:intl/intl.dart';
import 'package:tiengviet/tiengviet.dart';

import '../../configs/app.dart';
import '../../models/restaurant.dart';
import 'app_printer_common.dart';

/// chỉ in bill xuống bếp mới dùng
class AppPrinterNormalUtils {
  AppPrinterNormalUtils._();

  static final AppPrinterNormalUtils _instance = AppPrinterNormalUtils._();

  static AppPrinterNormalUtils get instance => _instance;
  factory AppPrinterNormalUtils() => _instance;
  Future<String?> printKitchenBill({
    List<IpOrderModel> printers = const [],
    bool allowPrintSingleBill = false,
    List<ProductModel> products = const [],
    String? totalNote,
    bool cancel = false,
    required OrderModel order,
    int timeOrder = 1,
  }) async {
    try {
      if (printers.isEmpty) return null;
      for (var printer in printers) {
        final manager = PrinterNetworkManager(
          printer.ip,
          port: printer.port,
        );
        final PosPrintResult res = await manager.connect();
        if (res == PosPrintResult.success) {
          var error = await _printKitchenBill(
            printer: manager,
            allowPrintSingleBill: allowPrintSingleBill,
            products: products,
            totalNote: totalNote,
            cancel: cancel,
            order: order,
            timeOrder: timeOrder,
          );

          // final billStatus =
          //     await manager.printTicket(bytes, isDisconnect: false);
          manager.disconnect();
          if (error != null) {
            return error;
          }
        } else {}
      }

      return null;
    } catch (ex) {
      return ex.toString();
    }
  }

  Future<String?> _printKitchenBill({
    required PrinterNetworkManager printer,
    bool allowPrintSingleBill = false,
    List<ProductModel> products = const [],
    String? totalNote,
    bool cancel = false,
    required OrderModel order,
    int timeOrder = 1,
  }) async {
    try {
      if (products.isEmpty) return null;
      PosPrintResult resBill = PosPrintResult.success;

      /// danh sách các món k khởi tạo được ảnh (bill lẻ)
      List<ProductModel> productErrorImageBill = [];

      /// danh sách các món in lỗi (bill lẻ)
      List<ProductModel> productPrintError = [];

      /// in bill tổng
      try {
        List<int> ticket;
        try {
          ticket = await generateBill(
            order: order,
            billSingle: false,
            cancel: cancel,
            timeOrder: timeOrder,
            totalNote: totalNote,
            products: products,
            title: cancel ? 'HUY DO' : 'BILL GOI MON',
          );
        } catch (ex) {
          return 'Không tạo được bill';
        }
        resBill = await printer.printTicket(ticket, isDisconnect: false);
        if (resBill != PosPrintResult.success) {
          return resBill.msg;
        }
      } catch (ex) {
        return '';
      }
      // in bill lẻ
      // if (allowPrintSingleBill) {
      //   for (var item in products) {
      //     List<int> ticket = [];
      //     try {
      //       ticket = await _generateBill(
      //         order: order,
      //         billSingle: true,
      //         cancel: cancel,
      //         timeOrder: timeOrder,
      //         totalNote: totalNote,
      //         products: [item],
      //         title: cancel ? 'HUY DO - BILL LE' : 'GOI MON - BILL LE',
      //       );
      //       try {
      //         resBill = await printer.printTicket(ticket, isDisconnect: false);
      //         if (resBill != PosPrintResult.success) {
      //           productPrintError.add(item);
      //         }
      //       } catch (ex) {
      //         productPrintError.add(item);
      //       }
      //     } catch (ex) {
      //       productErrorImageBill.add(item);
      //     }
      //   }
      // }

      if (productPrintError.isNotEmpty || productErrorImageBill.isNotEmpty) {
        return 'Không thể in bill lẻ các món xuống bếp';
      }

      return null;
    } catch (ex) {
      return ex.toString();
    }
  }

  /// [billSingle] = false - bill lẻ
  /// nếu là bill lẻ thì products chỉ chứa 1 món
  Future<List<int>> generateBill({
    List<ProductModel> products = const [],
    String? title,
    String? totalNote,
    bool billSingle = false,
    bool cancel = false,
    required OrderModel order,
    int timeOrder = 1,
  }) async {
    if (products.isEmpty) return [];
    List<int> bytes = [];

    try {
      final profile = await CapabilityProfile.load();
      final generator = Generator(PaperSize.mm80, profile);
      RestaurantModel? restaurant = (LocalStorage.getDataLogin())?.restaurant;
      // header
      bytes += generator.text(
        TiengViet.parse(restaurant?.name ?? AppConfig.appName),
        styles: const PosStyles(
          bold: true,
          height: PosTextSize.size1,
          width: PosTextSize.size1,
          align: PosAlign.center,
        ),
      );
      bytes += generator.text(
        TiengViet.parse(restaurant?.address ?? "========="),
        styles: const PosStyles(
          align: PosAlign.center,
        ),
      );
      bytes += generator.emptyLines(1);
      // title bill
      // if (title != null) {
      //   bytes += generator.text(
      //     TiengViet.parse(title),
      //     styles: const PosStyles(
      //       bold: true,
      //       // height: PosTextSize.size2,
      //       // width: PosTextSize.size2,
      //       align: PosAlign.center,
      //     ),
      //   );
      // }
      bytes += generator.text(
        TiengViet.parse(
          "${title ?? ''}${((title ?? '').trim().isNotEmpty && (order.getOrderMisc() ?? '').trim().isNotEmpty) ? ' - ' : ''}"
          "${order.getOrderMisc() ?? ''} - Ban: ${order.name}",
        ),
        styles: const PosStyles(
          bold: true,
          // height: PosTextSize.size2,
          // width: PosTextSize.size2,
          align: PosAlign.center,
        ),
      );
      bytes += generator.emptyLines(1);
      // body
      bytes += generator.row(
        [
          PosColumn(
            text: "Ten mon",
            width: 9,
            styles: const PosStyles(
              bold: true,
              align: PosAlign.left,
            ),
          ),
          PosColumn(
            text: "SL",
            width: 1,
            styles: const PosStyles(
              bold: true,
              align: PosAlign.center,
            ),
          ),
          PosColumn(
            text: "DVT",
            width: 2,
            styles: const PosStyles(
              bold: true,
              align: PosAlign.center,
            ),
          ),
        ],
      );
      if (billSingle) {
        if (products.isNotEmpty) {
          bytes += _generateKitchenSingleBill(
            generator: generator,
            item: products.first,
            cancel: cancel,
            totalNote: totalNote ?? '',
          );
        }
      } else {
        bytes += generateKitchenTotalBill(
          generator: generator,
          items: products,
          cancel: cancel,
          totalNote: totalNote ?? '',
        );
      }

      bytes += generator.emptyLines(1);

      bytes += generator.text(
        "Powered by Aladdin.,JSC",
        styles: const PosStyles(
          align: PosAlign.center,
        ),
      );
      bytes += generator.text(
        DateFormat("dd/MM/yyyy HH:mm:ss").format(DateTime.now()),
        styles: const PosStyles(
          align: PosAlign.center,
        ),
      );
      bytes += generator.cut();
    } catch (ex) {
      showLogs(ex, flags: 'ex image');
      rethrow;
    }
    return bytes;
  }

  /// in các món trong bill tổng
  List<int> generateKitchenTotalBill({
    required Generator generator,
    List<ProductModel> items = const [],
    String totalNote = '',
    bool cancel = false,
  }) {
    if (items.isEmpty) return [];
    List<int> bytes = [];

    for (var p in items) {
      var comboItems = ProductHelper().getComboDescription(p);
      if (comboItems == null) {
        bytes += _generateItemNotCombo(
          generator: generator,
          item: p,
          cancel: cancel,
          printNote: false,
          totalNote: totalNote,
        );
      } else {
        bytes += _generateCombo(
          generator: generator,
          combo: p,
          cancel: cancel,
          comboItems: comboItems,
          printComboItem: true,
          totalNote: totalNote,
          printNote: false,
        );
      }
    }

    bytes += generator.hr();
    bytes += generator.text(TiengViet.parse('Ghi chú: '));
    bytes += generator.text(TiengViet.parse(totalNote.trim()));

    return bytes;
  }

  /// in bill lẻ
  List<int> _generateKitchenSingleBill({
    required Generator generator,
    required ProductModel item,
    String totalNote = '',
    bool cancel = false,
  }) {
    List<int> bytes = [];

    var comboItems = ProductHelper().getComboDescription(item);
    if (comboItems == null) {
      bytes += _generateItemNotCombo(
        generator: generator,
        item: item,
        cancel: cancel,
        totalNote: totalNote,
        printNote: true,
      );
    } else {
      bytes += _generateCombo(
        generator: generator,
        combo: item,
        cancel: cancel,
        comboItems: comboItems,
        printComboItem: true,
        totalNote: totalNote,
        printNote: true,
        oddBill: true,
      );
    }

    // var notePrint = note.isEmpty ? totalNote.trim() : note;
    // if (notePrint.isEmpty) {
    //   bytes += generator.hr();
    //   bytes += generator.text(TiengViet.parse('Ghi chú: '));
    //   bytes += generator.text(TiengViet.parse(notePrint.trim()));
    // }

    return bytes;
  }

  /// gen các món thường (k phải combo)
  ///
  /// SL lấy theo numberSelecting
  ///
  /// [printNote] = false - có in ghi chú
  List<int> _generateItemNotCombo({
    required Generator generator,
    ProductModel? item,
    bool cancel = false,
    bool printNote = false,
    String? totalNote,
  }) {
    if (item == null) return [];
    List<int> bytes = [];
    bytes += generator.row(
      [
        PosColumn(
          text: AppPrinterCommon.splitTextPrint(TiengViet.parse(item.name)),
          width: 9,
          styles: const PosStyles(
            align: PosAlign.left,
          ),
        ),
        PosColumn(
          text: "${cancel ? '-' : ''}${item.numberSelecting.abs()}",
          width: 1,
          styles: const PosStyles(
            align: PosAlign.center,
          ),
        ),
        PosColumn(
          text: TiengViet.parse(item.unit),
          width: 2,
          styles: const PosStyles(
            align: PosAlign.center,
          ),
        ),
      ],
    );

    if (printNote) {
      bytes += generator.hr();
      bytes += generator.text(TiengViet.parse('Ghi chú: '));
      bytes +=
          generator.text(TiengViet.parse((item.noteForProcessOrder ?? totalNote ?? '').trim()));
    }
    return bytes;
  }

  /// in combo
  ///
  /// SL lấy theo numberSelecting
  ///
  /// [printComboItem] = true - có in từng món trong combo
  ///
  /// [oddBill] = false - bill lẻ
  ///
  /// [printNote] = false - có in ghi chú
  List<int> _generateCombo({
    required Generator generator,
    ProductModel? combo,
    List<ComboItemModel> comboItems = const [],
    bool cancel = false,
    bool printComboItem = true,
    String? totalNote,
    bool printNote = false,
    bool oddBill = false,
  }) {
    List<int> bytes = [];
    if (combo != null && !oddBill) {
      bytes += generator.row(
        [
          PosColumn(
            text: AppPrinterCommon.splitTextPrint(TiengViet.parse(combo.name)),
            width: 9,
            styles: const PosStyles(
              align: PosAlign.left,
            ),
          ),
          PosColumn(
            text: "${cancel ? '-' : ''}${combo.numberSelecting.abs()}",
            width: 1,
            styles: const PosStyles(
              align: PosAlign.center,
            ),
          ),
          PosColumn(
            text: TiengViet.parse(combo.unit),
            width: 2,
            styles: const PosStyles(
              align: PosAlign.center,
            ),
          ),
        ],
      );
    }

    if (printComboItem) {
      for (var item in comboItems) {
        bytes += _generateOnlyComboItem(
          generator: generator,
          cancel: cancel,
          item: item,
          oddBill: oddBill,
        );
      }
    }

    if (printNote) {
      bytes += generator.hr();
      bytes += generator.text(TiengViet.parse("Ghi chú:"));
      bytes +=
          generator.text(TiengViet.parse((combo?.noteForProcessOrder ?? totalNote ?? '').trim()));
    }
    return bytes;
  }

  /// từng 1 item trong combo
  ///
  /// [oddBill] - true - bill lẻ
  List<int> _generateOnlyComboItem({
    required Generator generator,
    ComboItemModel? item,
    bool cancel = false,
    bool oddBill = true,
  }) {
    if (item == null) return [];
    List<int> bytes = [];
    bytes += generator.row(
      [
        PosColumn(
          text: AppPrinterCommon.splitTextPrint(
              TiengViet.parse("${oddBill ? '' : '- '}${item.name}")),
          width: 9,
          styles: const PosStyles(
            align: PosAlign.left,
          ),
        ),
        PosColumn(
          text: "${cancel ? '-' : ''}${item.quantity.abs()}",
          width: 1,
          styles: const PosStyles(
            align: PosAlign.center,
          ),
        ),
        PosColumn(
          text: TiengViet.parse(item.unit),
          width: 2,
          styles: const PosStyles(
            align: PosAlign.center,
          ),
        ),
      ],
    );

    return bytes;
  }

  Future<List<int>> getCloseShift(CloseShiftResponseModel data) async {
    List<int> bytes = [];

    try {
      final profile = await CapabilityProfile.load();
      final generator = Generator(PaperSize.mm80, profile);
      RestaurantModel? restaurant = (LocalStorage.getDataLogin())?.restaurant;
      // header
      bytes += generator.text(
        TiengViet.parse(restaurant?.name ?? AppConfig.appName),
        styles: const PosStyles(
          bold: true,
          height: PosTextSize.size1,
          width: PosTextSize.size1,
          align: PosAlign.center,
        ),
      );
      bytes += generator.text(
        TiengViet.parse(restaurant?.address ?? "========="),
        styles: const PosStyles(
          align: PosAlign.center,
        ),
      );
      bytes += generator.emptyLines(1);
      // title bill
      // if (title != null) {
      //   bytes += generator.text(
      //     TiengViet.parse(title),
      //     styles: const PosStyles(
      //       bold: true,
      //       // height: PosTextSize.size2,
      //       // width: PosTextSize.size2,
      //       align: PosAlign.center,
      //     ),
      //   );
      // }
      bytes += generator.text(
        TiengViet.parse(
          "Mở: ${data.openShift == null ? '' : DateFormat("yyyy-MM-dd HH:mm").format(data.openShift!)}",
        ),
        styles: const PosStyles(
          bold: true,
          align: PosAlign.center,
        ),
      );
      bytes += generator.text(
        TiengViet.parse(
          "Đóng: ${data.lockShift == null ? '' : DateFormat("yyyy-MM-dd HH:mm").format(data.lockShift!)}",
        ),
        styles: const PosStyles(
          bold: true,
          align: PosAlign.center,
        ),
      );
      bytes += generator.emptyLines(1);
      // body
      bytes += generator.row(
        [
          PosColumn(
            text: TiengViet.parse('Ca'),
            width: 4,
            styles: const PosStyles(
              align: PosAlign.left,
            ),
          ),
          PosColumn(
            text: TiengViet.parse(data.shiftName),
            width: 8,
            styles: const PosStyles(
              bold: true,
              align: PosAlign.left,
            ),
          ),
        ],
      );
      bytes += generator.row(
        [
          PosColumn(
            text: TiengViet.parse('Thu ngân'),
            width: 4,
            styles: const PosStyles(
              align: PosAlign.left,
            ),
          ),
          PosColumn(
            text: TiengViet.parse(data.cashierName),
            width: 8,
            styles: const PosStyles(
              bold: true,
              align: PosAlign.left,
            ),
          ),
        ],
      );

      bytes += generator.emptyLines(1);
      bytes += generator.text(
        TiengViet.parse('SỐ LIỆU CHỐT'),
        styles: const PosStyles(
          align: PosAlign.center,
          bold: true,
        ),
      );
      bytes += generator.emptyLines(1);
      try {
        for (var e in (data.totalPayment as Map).values) {
          bytes += generator.row(
            [
              PosColumn(
                text: TiengViet.parse(e['label'] ?? ''),
                width: 4,
                styles: const PosStyles(
                  align: PosAlign.left,
                ),
              ),
              PosColumn(
                text: AppUtils.formatCurrency(value: (e['value'] ?? '').toString()),
                width: 8,
                styles: const PosStyles(
                  align: PosAlign.left,
                ),
              ),
            ],
          );
        }
      } catch (ex) {
        //
      }

      bytes += generator.emptyLines(1);

      bytes += generator.text(
        "Powered by Aladdin.,JSC",
        styles: const PosStyles(
          align: PosAlign.center,
        ),
      );
      bytes += generator.text(
        DateFormat("dd/MM/yyyy HH:mm:ss").format(DateTime.now()),
        styles: const PosStyles(
          align: PosAlign.center,
        ),
      );
      bytes += generator.cut();
    } catch (ex) {
      showLogs(ex, flags: 'ex image');
      rethrow;
    }
    return bytes;
  }
}
