// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer_create.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CustomerCreateResponseImpl _$$CustomerCreateResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$CustomerCreateResponseImpl(
      data: CustomerCreateResponseData.fromJson(
          json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$CustomerCreateResponseImplToJson(
        _$CustomerCreateResponseImpl instance) =>
    <String, dynamic>{
      'data': instance.data.toJson(),
    };

_$CustomerCreateResponseDataImpl _$$CustomerCreateResponseDataImplFromJson(
        Map<String, dynamic> json) =>
    _$CustomerCreateResponseDataImpl(
      status: (json['status'] as num).toInt(),
      data: json['data'],
    );

Map<String, dynamic> _$$CustomerCreateResponseDataImplToJson(
        _$CustomerCreateResponseDataImpl instance) =>
    <String, dynamic>{
      'status': instance.status,
      'data': instance.data,
    };
