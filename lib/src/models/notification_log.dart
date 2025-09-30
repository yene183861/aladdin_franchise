import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'notification_log.freezed.dart';
part 'notification_log.g.dart';

@freezed
class NotificationLogModel with _$NotificationLogModel {
  @JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
  const factory NotificationLogModel({
    required DateTime createAt,
    required String error,
    required String title,
    required String logo,
  }) = _NotificationLogModel;

  factory NotificationLogModel.fromJson(Map<String, dynamic> json) =>
      _$NotificationLogModelFromJson(json);
}
