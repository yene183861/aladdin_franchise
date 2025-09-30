// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'check_code.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CheckCodeResponseImpl _$$CheckCodeResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$CheckCodeResponseImpl(
      data:
          CheckCodeResponseData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$CheckCodeResponseImplToJson(
        _$CheckCodeResponseImpl instance) =>
    <String, dynamic>{
      'data': instance.data.toJson(),
    };

_$CheckCodeResponseDataImpl _$$CheckCodeResponseDataImplFromJson(
        Map<String, dynamic> json) =>
    _$CheckCodeResponseDataImpl(
      checkCode: json['checkCode'] as bool,
      appCheck: json['appCheck'] as String?,
    );

Map<String, dynamic> _$$CheckCodeResponseDataImplToJson(
        _$CheckCodeResponseDataImpl instance) =>
    <String, dynamic>{
      'checkCode': instance.checkCode,
      'appCheck': instance.appCheck,
    };
