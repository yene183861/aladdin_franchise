import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

part 'notification.freezed.dart';
part 'notification.g.dart';

@freezed
class TestNotificationModel extends HiveObject with _$TestNotificationModel {
  @HiveType(typeId: 0, adapterName: 'TestNotificationModelAdapter')
  factory TestNotificationModel({
    @HiveField(0, defaultValue: '') required String title,
    @HiveField(1, defaultValue: '') required String body,
    @HiveField(2, defaultValue: null) DateTime? datetime,
    @Default(false) @HiveField(3, defaultValue: false) bool read,
    @HiveField(4, defaultValue: -1) required int orderId,
    @HiveField(5, defaultValue: null) dynamic data,
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
