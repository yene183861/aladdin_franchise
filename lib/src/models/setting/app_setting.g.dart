// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_setting.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AppSettingModelImpl _$$AppSettingModelImplFromJson(
        Map<String, dynamic> json) =>
    _$AppSettingModelImpl(
      useFontScale: json['use_font_scale'] as bool? ?? true,
      fontScale: (json['font_scale'] as num?)?.toDouble() ?? 1.0,
    );

Map<String, dynamic> _$$AppSettingModelImplToJson(
        _$AppSettingModelImpl instance) =>
    <String, dynamic>{
      'use_font_scale': instance.useFontScale,
      'font_scale': instance.fontScale,
    };
