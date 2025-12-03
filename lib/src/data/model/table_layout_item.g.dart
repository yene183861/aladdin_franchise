// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'table_layout_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TableLayoutItemModelImpl _$$TableLayoutItemModelImplFromJson(
        Map<String, dynamic> json) =>
    _$TableLayoutItemModelImpl(
      table: json['table'] == null
          ? null
          : TableModel.fromJson(json['table'] as Map<String, dynamic>),
      xPos: (json['x_pos'] as num?)?.toDouble() ?? 0.0,
      yPos: (json['y_pos'] as num?)?.toDouble() ?? 0.0,
      id: json['id'] as String? ?? '',
      topChair: (json['top_chair'] as num?)?.toInt() ?? 2,
      bottomChair: (json['bottom_chair'] as num?)?.toInt() ?? 2,
      leftChair: (json['left_chair'] as num?)?.toInt() ?? 1,
      rightChair: (json['right_chair'] as num?)?.toInt() ?? 1,
      floorId: json['floor_id'] as String? ?? '',
      restaurantId: (json['restaurant_id'] as num?)?.toInt() ?? -1,
      typeOrder: (json['type_order'] as num?)?.toInt() ?? 2,
    );

Map<String, dynamic> _$$TableLayoutItemModelImplToJson(
        _$TableLayoutItemModelImpl instance) =>
    <String, dynamic>{
      'table': instance.table?.toJson(),
      'x_pos': instance.xPos,
      'y_pos': instance.yPos,
      'id': instance.id,
      'top_chair': instance.topChair,
      'bottom_chair': instance.bottomChair,
      'left_chair': instance.leftChair,
      'right_chair': instance.rightChair,
      'floor_id': instance.floorId,
      'restaurant_id': instance.restaurantId,
      'type_order': instance.typeOrder,
    };
