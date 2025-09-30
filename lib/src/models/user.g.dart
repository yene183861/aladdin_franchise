// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserModelImpl _$$UserModelImplFromJson(Map<String, dynamic> json) =>
    _$UserModelImpl(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String?,
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      username: json['username'] as String?,
      image: json['image'] as String?,
      address: json['address'] as String?,
      status: (json['status'] as num?)?.toInt(),
      applied: (json['applied'] as num?)?.toInt(),
      myrole: json['myrole'] as String?,
      mystatus: json['mystatus'] as String?,
    );

Map<String, dynamic> _$$UserModelImplToJson(_$UserModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'phone': instance.phone,
      'username': instance.username,
      'image': instance.image,
      'address': instance.address,
      'status': instance.status,
      'applied': instance.applied,
      'myrole': instance.myrole,
      'mystatus': instance.mystatus,
    };
