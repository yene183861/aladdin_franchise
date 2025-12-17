import 'dart:async';

import 'package:aladdin_franchise/src/configs/enums/app_log_action.dart';
import 'package:aladdin_franchise/src/configs/enums/bill_setting.dart';
import 'package:aladdin_franchise/src/core/services/send_log/discord_service.dart';
import 'package:aladdin_franchise/src/core/storages/local.dart';
import 'package:aladdin_franchise/src/models/error_log.dart';
import 'package:aladdin_franchise/src/utils/app_log.dart';
import 'package:aladdin_franchise/src/utils/app_printer/app_printer_common.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_esc_pos_network/flutter_esc_pos_network.dart';
import 'package:flutter_esc_pos_utils/flutter_esc_pos_utils.dart';

class PrintQueue {
  static PrintQueue get instance => _instance;
  static final PrintQueue _instance = PrintQueue._internal();
  factory PrintQueue() => _instance;
  PrintQueue._internal();

  final List<_PrintTaskModel> _queue = [];

  bool _isProcessing = false;

  void addTask({
    required String ip,
    int port = 9100,
    Duration timeout = const Duration(seconds: 5),
    required Future<List<int>> Function(Generator generator) buildReceipt,
    Function(bool success, String? error)? onComplete,
  }) {
    final task = _PrintTaskModel(
      ip: ip,
      port: port,
      timeout: timeout,
      buildReceipt: buildReceipt,
      onComplete: onComplete,
    );

    _queue.add(task);
    _tryProcessNext();
  }

  void _tryProcessNext() {
    if (_isProcessing || _queue.isEmpty) return;
    _isProcessing = true;

    final task = _queue.removeAt(0);
    _processTask(task).then((_) {
      _isProcessing = false;
      _tryProcessNext();
    });
  }

  Future<void> _processTask(_PrintTaskModel task) async {
    if (kDebugMode) return;
    String? error;
    bool success = false;
    PrinterNetworkManager? printerManager;
    final profile = await CapabilityProfile.load();
    printerManager = PrinterNetworkManager(task.ip, port: task.port);

    var paperSize = LocalStorage.getPrintSetting().billHtmlSetting.paperSize;
    final generator = Generator(paperSize.paperSize, profile);
    List<int> data = [];
    try {
      data = await task.buildReceipt(generator);
      try {
        var connectResult = await printerManager.connect();
        if (connectResult != PosPrintResult.success) {
          throw AppPrinterCommon.posPrintResultMessage(connectResult) ?? '';
        }

        final res = await printerManager.printTicket(data, isDisconnect: false);

        if (res == PosPrintResult.success) {
          success = true;
          await Future.delayed(const Duration(seconds: 1));
        } else {
          error = "⚠️ Không in được: ${AppPrinterCommon.posPrintResultMessage(res) ?? ''}";
          showLogs(error, flags: '_processTask 1');
        }
      } catch (e) {
        error = "❌ Lỗi in: $e";
        showLogs(error, flags: '_processTask 2');
      } finally {
        try {
          await printerManager.disconnect();
        } catch (ex) {
          //
        }
      }
    } catch (ex) {
      error = "❌ Lỗi in: $ex";
      showLogs(error, flags: '_processTask 3');
    }

    if (error != null) {
      try {
        var log = ErrorLogModel(
          action: AppLogAction.print,
          createAt: DateTime.now(),
          errorMessage: '_processTask\n$error',
        );
        DiscordService.sendLogs(log);
      } catch (e) {
        showLogs(e, flags: '_processTask send log');
        //
      }
    }

    task.onComplete?.call(success, error);
  }
}

class _PrintTaskModel {
  final String ip;
  final int port;
  final Duration timeout;
  final Future<List<int>> Function(Generator generator) buildReceipt;
  final Function(bool success, String? error)? onComplete;

  _PrintTaskModel({
    required this.ip,
    required this.port,
    required this.timeout,
    required this.buildReceipt,
    this.onComplete,
  });
}
