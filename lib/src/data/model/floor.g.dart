// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'floor.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$FloorModelImpl _$$FloorModelImplFromJson(Map<String, dynamic> json) =>
    _$FloorModelImpl(
      name: json['name'] as String? ?? '',
      id: json['id'] as String? ?? '',
      restaurantId: (json['restaurant_id'] as num?)?.toInt() ?? -1,
      isDefault: json['is_default'] as bool? ?? false,
    );

Map<String, dynamic> _$$FloorModelImplToJson(_$FloorModelImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'id': instance.id,
      'restaurant_id': instance.restaurantId,
      'is_default': instance.isDefault,
    };
