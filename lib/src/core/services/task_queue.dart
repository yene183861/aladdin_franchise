import 'dart:async';
import 'dart:io';

import 'package:aladdin_franchise/src/configs/enums/app_log_action.dart';
import 'package:aladdin_franchise/src/configs/enums/bill_setting.dart';
import 'package:aladdin_franchise/src/core/services/send_log/discord_service.dart';
import 'package:aladdin_franchise/src/core/storages/local.dart';
import 'package:aladdin_franchise/src/models/error_log.dart';
import 'package:aladdin_franchise/src/utils/app_log.dart';
import 'package:flutter_esc_pos_network/flutter_esc_pos_network.dart';
import 'package:flutter_esc_pos_utils/flutter_esc_pos_utils.dart';

class PrinterTaskQueue {
  static PrinterTaskQueue get instance => _instance;
  static final PrinterTaskQueue _instance = PrinterTaskQueue._internal();
  factory PrinterTaskQueue() => _instance;
  PrinterTaskQueue._internal();

  List<_PrintTaskModel> _queue = [];

  // final _queue = StreamController<_PrintTaskModel>();
  bool _isProcessing = false;

  void init() {
    // _queue.stream.asyncMap((task) => _processTask(task)).listen((_) {});
    // _queue.stream.listen(_processTask);
  }

  Future<void> dispose() async {
    // await _queue.close();
  }

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
          throw connectResult.msg;
        }

        final res = await printerManager.printTicket(data, isDisconnect: false);

        if (res == PosPrintResult.success) {
          success = true;
          await Future.delayed(const Duration(seconds: 1));
        } else {
          error = "⚠️ Không in được: ${res.msg}";
          showLogs(error, flags: '_processTask');
        }
      } catch (e) {
        error = "❌ Lỗi in: $e";
        showLogs(error, flags: '_processTask');
      } finally {
        await printerManager.disconnect();
      }
    } catch (ex) {
      error = "❌ Lỗi in: $ex";
      showLogs(error, flags: '_processTask');
    }

    if (error != null) {
      try {
        var log = ErrorLogModel(
          action: AppLogAction.print,
          createAt: DateTime.now(),
          errorMessage: error,
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
