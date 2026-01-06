import 'dart:io';
import 'dart:math';

import 'package:aladdin_franchise/src/configs/color.dart';
import 'package:aladdin_franchise/src/utils/app_log.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

final appLocalNotificationService = Platform.isAndroid ? AppLocalNotificationService() : null;

class AppLocalNotificationService {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> initLocalNotification() async {
    // Android initialization
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@drawable/ic_notification');

    // Ios initialization
    const DarwinInitializationSettings initializationSettingsIOS = DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );

    const InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future<void> requestPermissions() async {
    if (Platform.isAndroid) {
      final AndroidFlutterLocalNotificationsPlugin? androidImplementation =
          flutterLocalNotificationsPlugin
              .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>();
      final bool? granted = await androidImplementation?.requestNotificationsPermission();
    }
  }

  Future<void> showLocalNotification(
    String? title,
    String? body,
  ) async {
    try {
      var notificationDetails = NotificationDetails(
        android: AndroidNotificationDetails(
          'aladdin_franchise_channel',
          'Apos Franchise',
          playSound: true,
          channelDescription: "Thông báo order tại bàn",
          importance: Importance.max,
          priority: Priority.high,
          color: AppColors.mainColor,
          colorized: true,
        ),
        iOS: const DarwinNotificationDetails(
          sound: 'default.wav',
          presentAlert: true,
          presentBadge: true,
          presentSound: true,
        ),
      );
      await flutterLocalNotificationsPlugin.show(
        Random().nextInt(10000000),
        title,
        body,
        notificationDetails,
      );
    } catch (ex) {
      showLog(ex, flags: "showLocalNotification");
    }
  }
}
