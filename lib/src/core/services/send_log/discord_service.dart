import 'dart:convert';
import 'dart:io';

import 'package:aladdin_franchise/src/configs/api.dart';
import 'package:aladdin_franchise/src/configs/app.dart';
import 'package:aladdin_franchise/src/configs/enums/app_log_action.dart';
import 'package:aladdin_franchise/src/core/storages/local.dart';
import 'package:aladdin_franchise/src/models/error_log.dart';
import 'package:aladdin_franchise/src/models/restaurant.dart';
import 'package:aladdin_franchise/src/utils/app_log.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:network_info_plus/network_info_plus.dart';

class DiscordService {
  static void sendLogs(ErrorLogModel log) async {
    showLog('start send noti discord');
    try {
      var loginData = LocalStorage.getDataLogin();
      final makeDeviceId = LocalStorage.getMakeDeviceId();
      String? networkInfo, wifiName;
      try {
        networkInfo = await NetworkInfo().getWifiIP();
      } catch (ex) {
        //
      }

      try {
        wifiName = await NetworkInfo().getWifiName();
      } catch (ex) {
        //
      }
      final deviceId = LocalStorage.getDeviceId();
      var errorLog = log.copyWith(
        waiter: log.waiter ?? (loginData?.user),
        ipConfig: ApiConfig.apiUrl,
        ipNetwork: networkInfo.toString(),
        wifiName: wifiName.toString(),
        appVersion: AppConfig.appVersion,
        deviceId: deviceId,
        createAt: DateTime.now(),
        waiterId: log.waiterId ?? loginData?.waiterId,
        makeDeviceId: makeDeviceId,
      );
      var restaurant = kDebugMode
          ? const RestaurantModel(
              id: 3198,
              name: "Restaurant Debug Mode",
              logo: "",
            )
          : (loginData?.restaurant);
      var waiter = errorLog.waiter ?? (loginData?.user);
      var message = '''
```fix
🐛 ${errorLog.action.name} | ${restaurant?.name} - ${restaurant?.address}
```
*- Thời gian:${DateFormat("dd-MM-yyyy HH:mm:ss").format(errorLog.createAt)}
*- Đơn bàn: *
```
  ${errorLog.order?.toJson()}
```
*- Lỗi: 
```ini
[${errorLog.errorMessage}]
```
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

      await http.post(
        Uri.parse(errorLog.action.webhookDiscord),
        headers: {"Content-Type": 'application/json'},
        body: jsonEncode({
          "content":
              '\n${restaurant?.name ?? ''} - ${restaurant?.address ?? ''} - ${errorLog.action.name}',
          "embeds": [
            {
              "title": "",
              "description": message,
            }
          ],
        }),
      );
      showLog('success', flags: 'send noti discord result');
    } catch (ex) {
      showLog('error $ex', flags: 'send noti discord result');
    }
  }
}
