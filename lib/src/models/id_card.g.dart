// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'id_card.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$IDCardModelImpl _$$IDCardModelImplFromJson(Map<String, dynamic> json) =>
    _$IDCardModelImpl(
      id: json['id'] as String,
      firstName: json['first_name'] as String,
      lastName: json['last_name'] as String,
      dob: DateTime.parse(json['dob'] as String),
      gender: json['gender'] as String,
      address: json['address'] as String,
    );

Map<String, dynamic> _$$IDCardModelImplToJson(_$IDCardModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'dob': instance.dob.toIso8601String(),
      'gender': instance.gender,
      'address': instance.address,
    };
