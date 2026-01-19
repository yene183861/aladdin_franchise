import 'package:aladdin_franchise/generated/assets.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

part 'notification.freezed.dart';
part 'notification.g.dart';

enum NotificationTypeEnum {
  print,
  other,
  o2oPayment,
  o2oWaiter,
}

extension NotificationTypeEnumExt on NotificationTypeEnum {
  String get icon {
    switch (this) {
      case NotificationTypeEnum.print:
        return Assets.iconsChat;
      case NotificationTypeEnum.o2oPayment:
        return Assets.iconsChat;
      case NotificationTypeEnum.o2oWaiter:
        return Assets.iconsChat;
      default:
        return Assets.iconsChat;
    }
  }

  Color? get color {
    switch (this) {
      case NotificationTypeEnum.print:
        return Colors.white;
      case NotificationTypeEnum.print:
        return Colors.white;
      case NotificationTypeEnum.print:
        return Colors.white;

      default:
        return null;
    }
  }

  Color? get readColor {
    switch (this) {
      case NotificationTypeEnum.print:
        return Colors.red;
      case NotificationTypeEnum.print:
        return Colors.red;
      case NotificationTypeEnum.print:
        return Colors.red;

      default:
        return null;
    }
  }
}

@freezed
class NotificationModel extends HiveObject with _$NotificationModel {
  @HiveType(typeId: 0, adapterName: 'NotificationModelAdapter')
  factory NotificationModel({
    @Default('') @HiveField(0, defaultValue: '') String title,
    @Default('') @HiveField(1, defaultValue: '') String body,
    @HiveField(2, defaultValue: null) DateTime? datetime,
    @Default(false) @HiveField(3, defaultValue: false) bool read,
    @HiveField(4, defaultValue: null) int? orderId,
    @HiveField(5, defaultValue: null) dynamic data,
    @HiveField(6, defaultValue: null) String? type,
    @Default('') @HiveField(7, defaultValue: '') String id,
    @Default(false) @HiveField(8, defaultValue: false) bool viewed,
  }) = _NotificationModel;
  NotificationModel._();

  NotificationModel markRead() {
    return NotificationModel(
      body: body,
      datetime: datetime,
      title: title,
      read: true,
      orderId: orderId,
    );
  }

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      _$NotificationModelFromJson(json);
}
