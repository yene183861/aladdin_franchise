// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'table_layout_setting.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TableLayoutSettingModelImpl _$$TableLayoutSettingModelImplFromJson(
        Map<String, dynamic> json) =>
    _$TableLayoutSettingModelImpl(
      topChairs: (json['top_chairs'] as num?)?.toInt() ?? 0,
      bottomChairs: (json['bottom_chairs'] as num?)?.toInt() ?? 0,
      leftChairs: (json['left_chairs'] as num?)?.toInt() ?? 0,
      rightChairs: (json['right_chairs'] as num?)?.toInt() ?? 0,
      chairWidth: (json['chair_width'] as num?)?.toDouble() ?? 40.0,
      chairHeight: (json['chair_height'] as num?)?.toDouble() ?? 12.0,
      chairToChairSpacing:
          (json['chair_to_chair_spacing'] as num?)?.toDouble() ?? 12.0,
      chairToTableSpacing:
          (json['chair_to_table_spacing'] as num?)?.toDouble() ?? 6.0,
      tableEdge: (json['table_edge'] as num?)?.toDouble() ?? 16.0,
      minTableHeight: (json['min_table_height'] as num?)?.toDouble() ?? 200.0,
      minTableWidth: (json['min_table_width'] as num?)?.toDouble() ?? 250.0,
      availableTableColor:
          (json['available_table_color'] as num?)?.toInt() ?? 4294967295,
      usingTableColor:
          (json['using_table_color'] as num?)?.toInt() ?? 4294221325,
      reservedTableColor:
          (json['reserved_table_color'] as num?)?.toInt() ?? 4279179051,
      borderRadius: (json['border_radius'] as num?)?.toDouble() ?? 8,
      restaurantId: (json['restaurant_id'] as num?)?.toInt() ?? -1,
    );

Map<String, dynamic> _$$TableLayoutSettingModelImplToJson(
        _$TableLayoutSettingModelImpl instance) =>
    <String, dynamic>{
      'top_chairs': instance.topChairs,
      'bottom_chairs': instance.bottomChairs,
      'left_chairs': instance.leftChairs,
      'right_chairs': instance.rightChairs,
      'chair_width': instance.chairWidth,
      'chair_height': instance.chairHeight,
      'chair_to_chair_spacing': instance.chairToChairSpacing,
      'chair_to_table_spacing': instance.chairToTableSpacing,
      'table_edge': instance.tableEdge,
      'min_table_height': instance.minTableHeight,
      'min_table_width': instance.minTableWidth,
      'available_table_color': instance.availableTableColor,
      'using_table_color': instance.usingTableColor,
      'reserved_table_color': instance.reservedTableColor,
      'border_radius': instance.borderRadius,
      'restaurant_id': instance.restaurantId,
    };
