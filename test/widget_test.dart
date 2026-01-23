// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'dart:convert';

import 'package:aladdin_franchise/src/data/enum/print_type.dart';
import 'package:aladdin_franchise/src/data/model/notification.dart';
import 'package:aladdin_franchise/src/utils/app_log.dart';
import 'package:aladdin_franchise/src/utils/date_time.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:aladdin_franchise/main.dart';

void main() {
  var t = NotificationDataModel(
    id: DateTimeUtils.formatToString(time: DateTime.now(), newPattern: DateTimePatterns.dateTime3),
    type: PrintTypeEnum.order,
  );
  var enc = jsonEncode(t);
  showLogs(enc, flags: 'enc');
  var dec = NotificationDataModel.fromJson(jsonDecode(enc));
  showLogs(dec, flags: 'dec');
}
