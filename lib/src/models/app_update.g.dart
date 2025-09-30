// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_update.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AppUpdateModelImpl _$$AppUpdateModelImplFromJson(Map<String, dynamic> json) =>
    _$AppUpdateModelImpl(
      version: json['version'] as String,
      note: json['note'] as String? ?? '',
      apkLink: json['apk_link'] as String? ?? '',
      windowsLink: json['windows_link'] as String? ?? '',
      timeRelease: dateTimeFromDynamic(json['time_release']),
      active: json['active'] as bool? ?? true,
      versionCode: (json['version_code'] as num?)?.toInt() ?? 0,
      only: json['only'] as List<dynamic>? ?? const [],
      isRequired: json['is_required'] as bool? ?? false,
    );

Map<String, dynamic> _$$AppUpdateModelImplToJson(
        _$AppUpdateModelImpl instance) =>
    <String, dynamic>{
      'version': instance.version,
      'note': instance.note,
      'apk_link': instance.apkLink,
      'windows_link': instance.windowsLink,
      'time_release': instance.timeRelease.toIso8601String(),
      'active': instance.active,
      'version_code': instance.versionCode,
      'only': instance.only,
      'is_required': instance.isRequired,
    };

_$AppUpdateNewImpl _$$AppUpdateNewImplFromJson(Map<String, dynamic> json) =>
    _$AppUpdateNewImpl(
      version: json['version'] as String? ?? '',
      note: json['note'] as String? ?? '',
      timeRelease: json['time_release'] == null
          ? null
          : DateTime.parse(json['time_release'] as String),
      active: json['active'] as bool? ?? false,
      mobileAppLink: json['mobile_app_link'] as String? ?? '',
      desktopAppLink: json['desktop_app_link'] as String? ?? '',
      versionCode: (json['version_code'] as num?)?.toInt() ?? 0,
      only: json['only'] as List<dynamic>? ?? const [],
      isRequired: json['is_required'] as bool? ?? false,
    );

Map<String, dynamic> _$$AppUpdateNewImplToJson(_$AppUpdateNewImpl instance) =>
    <String, dynamic>{
      'version': instance.version,
      'note': instance.note,
      'time_release': instance.timeRelease?.toIso8601String(),
      'active': instance.active,
      'mobile_app_link': instance.mobileAppLink,
      'desktop_app_link': instance.desktopAppLink,
      'version_code': instance.versionCode,
      'only': instance.only,
      'is_required': instance.isRequired,
    };
