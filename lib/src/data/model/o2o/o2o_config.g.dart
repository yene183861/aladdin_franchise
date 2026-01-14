// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'o2o_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$O2oConfigModelImpl _$$O2oConfigModelImplFromJson(Map<String, dynamic> json) =>
    _$O2oConfigModelImpl(
      isEnabled: json['is_enabled'] as bool? ?? false,
      confirmTimeout: (json['confirm_timeout'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$$O2oConfigModelImplToJson(
        _$O2oConfigModelImpl instance) =>
    <String, dynamic>{
      'is_enabled': instance.isEnabled,
      'confirm_timeout': instance.confirmTimeout,
    };
