// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'waiter.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$WaiterModelImpl _$$WaiterModelImplFromJson(Map<String, dynamic> json) =>
    _$WaiterModelImpl(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      fullName: json['full_name'] as String? ?? "No name",
      username: json['user_name'] as String? ?? "",
      password: json['password'] as String? ?? "",
    );

Map<String, dynamic> _$$WaiterModelImplToJson(_$WaiterModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'full_name': instance.fullName,
      'user_name': instance.username,
      'password': instance.password,
    };
