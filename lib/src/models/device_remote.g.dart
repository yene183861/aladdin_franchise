// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'device_remote.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DeviceRemoteModelImpl _$$DeviceRemoteModelImplFromJson(
        Map<String, dynamic> json) =>
    _$DeviceRemoteModelImpl(
      id: json['id'] as String,
      value: (json['value'] as num).toInt(),
      token: json['token'] as String?,
    );

Map<String, dynamic> _$$DeviceRemoteModelImplToJson(
        _$DeviceRemoteModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'value': instance.value,
      'token': instance.token,
    };

_$DataRemoteModelImpl _$$DataRemoteModelImplFromJson(
        Map<String, dynamic> json) =>
    _$DataRemoteModelImpl(
      type: json['type'] as String?,
      styleId: json['style_id'] as String?,
      ipConfig: json['ip_config'] as String?,
      enableOrderOnline: json['enable_order_online'] as String?,
    );

Map<String, dynamic> _$$DataRemoteModelImplToJson(
        _$DataRemoteModelImpl instance) =>
    <String, dynamic>{
      'type': instance.type,
      'style_id': instance.styleId,
      'ip_config': instance.ipConfig,
      'enable_order_online': instance.enableOrderOnline,
    };
