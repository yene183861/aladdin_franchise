import 'package:aladdin_franchise/generated/assets.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

part 'notification.freezed.dart';
part 'notification.g.dart';

enum NotificationTypeEnum {
  print,
  other,
}

extension NotificationTypeEnumExt on NotificationTypeEnum {
  String get icon {
    switch (this) {
      case NotificationTypeEnum.print:
        return Assets.iconsChat;
      default:
        return Assets.iconsChat;
    }
  }

  Color? get color {
    switch (this) {
      case NotificationTypeEnum.print:
        return Colors.red;
      default:
        return null;
    }
  }
}

@freezed
class TestNotificationModel extends HiveObject with _$TestNotificationModel {
  @HiveType(typeId: 1, adapterName: 'TestNotificationModelAdapter')
  factory TestNotificationModel({
    @Default('') @HiveField(0, defaultValue: '') String title,
    @Default('') @HiveField(1, defaultValue: '') String body,
    @HiveField(2, defaultValue: null) DateTime? datetime,
    @Default(false) @HiveField(3, defaultValue: false) bool read,
    @HiveField(4, defaultValue: null) int? orderId,
    @HiveField(5, defaultValue: null) dynamic data,
    @HiveField(6, defaultValue: null) String? type,
  }) = _TestNotificationModel;
  TestNotificationModel._();

  TestNotificationModel markRead() {
    return TestNotificationModel(
      body: body,
      datetime: datetime,
      title: title,
      read: true,
      orderId: orderId,
    );
  }

  factory TestNotificationModel.fromJson(Map<String, dynamic> json) =>
      _$TestNotificationModelFromJson(json);
}
