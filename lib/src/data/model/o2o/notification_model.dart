import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

part 'notification_model.freezed.dart';
part 'notification_model.g.dart';

@freezed
class NotificationModel extends HiveObject with _$NotificationModel {
  @HiveType(typeId: 0, adapterName: 'NotificationModelAdapter')
  factory NotificationModel({
    @HiveField(0, defaultValue: '') required String title,
    @HiveField(1, defaultValue: '') required String body,
    @HiveField(2, defaultValue: null) DateTime? datetime,
    @Default(false) @HiveField(3, defaultValue: false) bool read,
    @HiveField(4, defaultValue: -1) required int orderId,
    @Default(false) @HiveField(5, defaultValue: false) bool requestPayment,
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
