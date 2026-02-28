// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CustomerModelImpl _$$CustomerModelImplFromJson(Map<String, dynamic> json) =>
    _$CustomerModelImpl(
      id: json['id'],
      name: json['name'] as String? ?? '',
      phoneNumber: json['phoneNumber'] as String? ?? '',
      phone: json['phone'] as String? ?? '',
      dob: json['dob'] as String?,
      point: (json['point'] as num?)?.toInt(),
      level: json['level'] as String?,
      exchange: (json['exchange'] as num?)?.toInt(),
      gender: json['gender'] as String?,
      accumulatedMoney: (json['accumulatedMoney'] as num?)?.toDouble() ?? 0,
      levelApprove: json['levelApprove'] == null
          ? null
          : DateTime.parse(json['levelApprove'] as String),
    );

Map<String, dynamic> _$$CustomerModelImplToJson(_$CustomerModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'phoneNumber': instance.phoneNumber,
      'phone': instance.phone,
      'dob': instance.dob,
      'point': instance.point,
      'level': instance.level,
      'exchange': instance.exchange,
      'gender': instance.gender,
      'accumulatedMoney': instance.accumulatedMoney,
      'levelApprove': instance.levelApprove?.toIso8601String(),
    };
