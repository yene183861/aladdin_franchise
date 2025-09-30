import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:aladdin_franchise/src/configs/enums/app_log_action.dart';
import 'package:aladdin_franchise/src/core/services/send_log/discord_service.dart';
import 'package:aladdin_franchise/src/models/error_log.dart';
import 'package:flutter/services.dart';

class LocalNetworkService {
  static const MethodChannel _channel = MethodChannel('native_ping');

  static Future<bool> checkPrinter(String ip, int port) async {
    if (Platform.isAndroid) {
      try {
        final bool result = await _channel.invokeMethod('ping', {'ip': ip});
        return result;
      } catch (e) {
        DiscordService.sendLogs(
          ErrorLogModel(
            action: AppLogAction.pingPrinter,
            errorMessage: "$e",
            request: "$ip:$port",
          ),
        );

        return false;
      }
    } else if (Platform.isWindows) {
      final resPingWin = await _pingWindows(ip);
      return resPingWin;
    } else {
      return false;
    }
  }

  static Future<bool> _pingWindows(String ip) async {
    try {
      final process =
          await Process.start('ping', ['-n', '4', '-w', '1000', ip]);
      bool hasReply = false;

      final stdoutLines = process.stdout
          .transform(utf8.decoder)
          .transform(const LineSplitter());

      await for (final line in stdoutLines) {
        if (line.toLowerCase().contains('reply from') &&
            line.toLowerCase().contains("ttl=")) {
          hasReply = true;
          break;
        }
      }

      await process.exitCode;

      return hasReply;
    } catch (e) {
      DiscordService.sendLogs(
        ErrorLogModel(
          action: AppLogAction.pingPrinter,
          errorMessage: "$e",
          request: ip,
        ),
      );

      return false;
    }
  }
}
