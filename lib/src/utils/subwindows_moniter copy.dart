import 'dart:async';

import 'package:aladdin_franchise/src/data/model/restaurant/printer.dart';
import 'package:aladdin_franchise/src/utils/app_log.dart';
import 'package:aladdin_franchise/src/utils/app_printer/app_printer_common.dart';

class PrinterMonitor {
  static final PrinterMonitor _instance = PrinterMonitor._internal();

  factory PrinterMonitor() => _instance;

  static PrinterMonitor get instance => _instance;

  PrinterMonitor._internal();

  Timer? _timer;
  bool _checking = false;
  Map<PrinterModel, bool> _data = {};
  late StreamController<Map<PrinterModel, bool>> printerBoardcastController;
  Map<PrinterModel, bool> get printerCheck => _data;

  void init([List<PrinterModel> printers = const []]) async {
    printerBoardcastController = StreamController<Map<PrinterModel, bool>>.broadcast();
    await checkPrinters(printers);
  }

  void start(
      {Duration interval = const Duration(minutes: 5), List<PrinterModel> printers = const []}) {
    _timer?.cancel();
    _timer = Timer.periodic(interval, (_) async {
      if (_checking) return;
      await checkPrinters(printers);
    });
  }

  Future<void> checkPrinters(List<PrinterModel> printers) async {
    _checking = true;
    for (var printer in printers) {
      var result = await AppPrinterCommon.pingPrinter(printer.ip ?? '', port: printer.port ?? 9100);
      _data[printer] = result;
      printerBoardcastController.add(_data);
    }
    _checking = false;
  }

  void stop() {
    _timer?.cancel();
    _timer = null;
    _checking = false;
  }
}
