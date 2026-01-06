// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'request_service.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RequestServiceModelImpl _$$RequestServiceModelImplFromJson(
        Map<String, dynamic> json) =>
    _$RequestServiceModelImpl(
      message: json['message'] as String? ?? '',
      dateTime: json['dateTime'] == null
          ? null
          : DateTime.parse(json['dateTime'] as String),
    );

Map<String, dynamic> _$$RequestServiceModelImplToJson(
        _$RequestServiceModelImpl instance) =>
    <String, dynamic>{
      'message': instance.message,
      'dateTime': instance.dateTime?.toIso8601String(),
    };
