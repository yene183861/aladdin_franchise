// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ip_order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$IpOrderModelImpl _$$IpOrderModelImplFromJson(Map<String, dynamic> json) =>
    _$IpOrderModelImpl(
      ip: json['ip'] as String,
      port: (json['port'] as num).toInt(),
      type: (json['type'] as num?)?.toInt() ?? 1,
      name: json['name'] as String? ?? 'Máy in',
    );

Map<String, dynamic> _$$IpOrderModelImplToJson(_$IpOrderModelImpl instance) =>
    <String, dynamic>{
      'ip': instance.ip,
      'port': instance.port,
      'type': instance.type,
      'name': instance.name,
    };
