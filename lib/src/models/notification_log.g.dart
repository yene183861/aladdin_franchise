// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_log.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$NotificationLogModelImpl _$$NotificationLogModelImplFromJson(
        Map<String, dynamic> json) =>
    _$NotificationLogModelImpl(
      createAt: DateTime.parse(json['create_at'] as String),
      error: json['error'] as String,
      title: json['title'] as String,
      logo: json['logo'] as String,
    );

Map<String, dynamic> _$$NotificationLogModelImplToJson(
        _$NotificationLogModelImpl instance) =>
    <String, dynamic>{
      'create_at': instance.createAt.toIso8601String(),
      'error': instance.error,
      'title': instance.title,
      'logo': instance.logo,
    };
