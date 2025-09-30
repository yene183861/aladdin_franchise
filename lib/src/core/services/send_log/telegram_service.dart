import 'dart:io';

import 'package:aladdin_franchise/src/configs/app.dart';
import 'package:aladdin_franchise/src/configs/enums/app_log_action.dart';
import 'package:aladdin_franchise/src/core/storages/local.dart';
import 'package:aladdin_franchise/src/models/error_log.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../../../models/restaurant.dart';
import '../../../utils/app_log.dart';

class TelegramNotiService {
  static const String _botToken =
      "8165782136:AAF0jJzNnRIcIL7yJtgNp2uwNeFe7rAjFn4";
  static const String _chatId = "-1002671430940";
  static const String _parseMode = "Markdown";
  static void sendLogs(ErrorLogModel errorLog) async {
    showLog('start send noti telegram');
    try {
      var loginData = LocalStorage.getDataLogin();
      var restaurant = kDebugMode
          ? const RestaurantModel(
              id: 3198,
              name: "Restaurant Debug Mode",
              logo: "",
            )
          : (loginData?.restaurant);
      var waiter = errorLog.waiter ?? (loginData?.user);
      var message = '''
`🐛 ${errorLog.action.name} | ${restaurant?.name} - ${restaurant?.address}`
*- Thời gian: * ${DateFormat("dd-MM-yyyy HH:mm:ss").format(DateTime.now())}
*- Đơn bàn: *
```
  ${errorLog.order?.toJson()}
```
*- Lỗi: * ${errorLog.errorMessage}
*- API: * ```${errorLog.api}```
*- IP Config: * ```${errorLog.ipConfig}```
*- Info Network: ${errorLog.ipNetwork} - Wifi: ${errorLog.wifiName}
*- Device Id: ${errorLog.deviceId}
*- Make device id: ${errorLog.makeDeviceId}
*- App Version: ${AppConfig.appVersion}
*- Phục vụ: ${waiter?.id}/${waiter?.name} | ${waiter?.username}/${waiter?.email}
*- Waiter Id: ${errorLog.waiterId}
*- Platform: ${Platform.isAndroid ? 'Android' : 'Windows'}
*- Request: *
```
  ${errorLog.request}
```
*- Response: *
```
  ${errorLog.response}
```
--------------------------
      ''';
      await http.get(Uri.parse(
        "https://api.telegram.org/bot$_botToken/sendMessage?chat_id=$_chatId&message_thread_id=${errorLog.action.telegramTopic}&text=$message&parse_mode=$_parseMode",
      ));
      showLog('success', flags: 'send noti telegram result');
    } catch (ex) {
      showLog('error $ex', flags: 'send noti telegram result');
    }
  }
}
