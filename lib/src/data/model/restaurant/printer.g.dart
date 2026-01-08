// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'printer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PrinterModelImpl _$$PrinterModelImplFromJson(Map<String, dynamic> json) =>
    _$PrinterModelImpl(
      ip: json['ip'] as String?,
      port: (json['port'] as num?)?.toInt(),
      type: (json['type'] as num?)?.toInt() ?? 1,
      name: json['name'] as String? ?? 'Máy in',
      typeAreaLocation: (json['type_area_location'] as num?)?.toInt() ?? 1,
    );

Map<String, dynamic> _$$PrinterModelImplToJson(_$PrinterModelImpl instance) =>
    <String, dynamic>{
      'ip': instance.ip,
      'port': instance.port,
      'type': instance.type,
      'name': instance.name,
      'type_area_location': instance.typeAreaLocation,
    };
