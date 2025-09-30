// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'restaurant_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RestaurantConfigModelImpl _$$RestaurantConfigModelImplFromJson(
        Map<String, dynamic> json) =>
    _$RestaurantConfigModelImpl(
      address: json['address'] as String,
      ip: json['ip'] as String,
      name: json['name'] as String,
      orderOnline: json['order_online'] as bool,
      style: (json['style'] as num).toInt(),
      isLocal: json['is_local'] as bool?,
      active: json['active'] as bool?,
      tags: json['tags'] as String? ?? '',
    );

Map<String, dynamic> _$$RestaurantConfigModelImplToJson(
        _$RestaurantConfigModelImpl instance) =>
    <String, dynamic>{
      'address': instance.address,
      'ip': instance.ip,
      'name': instance.name,
      'order_online': instance.orderOnline,
      'style': instance.style,
      'is_local': instance.isLocal,
      'active': instance.active,
      'tags': instance.tags,
    };

_$RestaurantFeatureConfigModelImpl _$$RestaurantFeatureConfigModelImplFromJson(
        Map<String, dynamic> json) =>
    _$RestaurantFeatureConfigModelImpl(
      useKds: json['use_kds'] as bool? ?? false,
      useReception: json['use_reception'] as bool? ?? false,
      autoOrder: json['auto_order'] as bool? ?? false,
    );

Map<String, dynamic> _$$RestaurantFeatureConfigModelImplToJson(
        _$RestaurantFeatureConfigModelImpl instance) =>
    <String, dynamic>{
      'use_kds': instance.useKds,
      'use_reception': instance.useReception,
      'auto_order': instance.autoOrder,
    };
