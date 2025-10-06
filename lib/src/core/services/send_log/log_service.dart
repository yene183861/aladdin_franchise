import 'package:aladdin_franchise/src/configs/data_fake.dart';
import 'package:aladdin_franchise/src/core/services/send_log/discord_service.dart';
import 'package:aladdin_franchise/src/core/services/send_log/telegram_service.dart';
import 'package:aladdin_franchise/src/models/error_log.dart';
import 'package:aladdin_franchise/src/utils/app_log.dart';

class LogService {
  static void sendLogs(ErrorLogModel errorLog) async {
    if (useDataFake) return;
    try {
      DiscordService.sendLogs(errorLog);
    } catch (ex) {
      //
    }
    // try {
    //   TelegramNotiService.sendLogs(errorLog);
    // } catch (ex) {
    //   showLogs(ex.toString(), flags: 'error tele');
    //   //
    // }
  }
}
