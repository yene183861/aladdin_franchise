import 'package:aladdin_franchise/src/core/services/send_log/discord_service.dart';
import 'package:aladdin_franchise/src/models/error_log.dart';
import 'package:flutter/foundation.dart';

import 'telegram_service.dart';

class LogService {
  static void sendLogs(ErrorLogModel errorLog) async {
    if (kDebugMode) return;
    DiscordService.sendLogs(errorLog);
    TelegramNotiService.sendLogs(errorLog);
  }
}
