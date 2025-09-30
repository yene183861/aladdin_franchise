// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'table.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TableModelImpl _$$TableModelImplFromJson(Map<String, dynamic> json) =>
    _$TableModelImpl(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String?,
      capacity: (json['capacity'] as num?)?.toInt(),
      status: (json['status'] as num?)?.toInt(),
      restaurantId: (json['restaurant_id'] as num?)?.toInt(),
      parentId: (json['parent_id'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$TableModelImplToJson(_$TableModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'capacity': instance.capacity,
      'status': instance.status,
      'restaurant_id': instance.restaurantId,
      'parent_id': instance.parentId,
    };
