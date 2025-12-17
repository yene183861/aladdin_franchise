import 'package:aladdin_franchise/src/core/services/send_log/discord_service.dart';
import 'package:aladdin_franchise/src/models/error_log.dart';

class LogService {
  static void sendLogs(ErrorLogModel errorLog) async {
    // return;
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
