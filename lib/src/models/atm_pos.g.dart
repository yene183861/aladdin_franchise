// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'atm_pos.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AtmPosModelImpl _$$AtmPosModelImplFromJson(Map<String, dynamic> json) =>
    _$AtmPosModelImpl(
      id: (json['id'] as num?)?.toInt() ?? -1,
      name: json['name'] as String? ?? '',
      setting: (json['setting'] as num?)?.toInt() ?? 1,
      url: json['url'] as String? ?? '',
    );

Map<String, dynamic> _$$AtmPosModelImplToJson(_$AtmPosModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'setting': instance.setting,
      'url': instance.url,
    };
