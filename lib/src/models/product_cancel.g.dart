// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_cancel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProductCancelModelImpl _$$ProductCancelModelImplFromJson(
        Map<String, dynamic> json) =>
    _$ProductCancelModelImpl(
      id: (json['id'] as num).toInt(),
      menuItemId: (json['menu_item_id'] as num).toInt(),
      quantity: (json['quantity'] as num?)?.toInt() ?? 0,
      name: json['name'] as String? ?? '',
      note: json['note'] as String? ?? '',
      nameEn: json['name_en'] as String? ?? '',
    );

Map<String, dynamic> _$$ProductCancelModelImplToJson(
        _$ProductCancelModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'menu_item_id': instance.menuItemId,
      'quantity': instance.quantity,
      'name': instance.name,
      'note': instance.note,
      'name_en': instance.nameEn,
    };
