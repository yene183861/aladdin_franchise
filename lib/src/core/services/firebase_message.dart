import 'dart:convert';

import 'package:aladdin_franchise/src/core/storages/local.dart';
import 'package:aladdin_franchise/src/utils/app_log.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../../models/restaurant.dart';

class FirebaseMessageService {
  static const String _messageKey =
      "AAAAYxRu8AI:APA91bG_EzM8f8ycFhtNj2DiBGnHBBuzFFwGMmGHbWU2qfoaDYh4NYGN47ri9b_AP4eDSQ2pRRKHraudPY_JXUGPHcXvurh2uR0AwW0xguOJcalKHqFsvyYsZ8ADhfaYthh65Ho6nq7l";
  static String fcmUrl = "https://fcm.googleapis.com/fcm/send";
  static Future<void> sendNotificationForAdmin(String errorMessage) async {
    try {
      var loginData = LocalStorage.getDataLogin();
      var restaurant = kDebugMode
          ? const RestaurantModel(
              id: 3198,
              name: "Restaurant Debug Mode",
              logo: "",
            )
          : loginData?.restaurant;
      await http.post(
        Uri.parse(fcmUrl),
        headers: {
          "Authorization": "key=$_messageKey",
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          "notification": {
            "title": "${restaurant?.name}",
            "body": "🐛 Có một sự cố mới!\n$errorMessage"
          },
          "to": "/topics/admin_logs",
        }),
      );
      showLog("done", flags: "sendNotificationForAdmin");
    } catch (ex) {
      showLog(ex, flags: "sendNotificationForAdmin Error");
    }
  }
}
