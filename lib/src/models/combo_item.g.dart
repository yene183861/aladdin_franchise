// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'combo_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ComboItemModelImpl _$$ComboItemModelImplFromJson(Map<String, dynamic> json) =>
    _$ComboItemModelImpl(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String? ?? '',
      nameEn: json['name_en'] as String? ?? '',
      image: json['image'] as String? ?? '',
      quantity: json['quantity'],
      printerType: (json['printer_type'] as num?)?.toInt(),
      unit: json['unit'] as String? ?? '',
    );

Map<String, dynamic> _$$ComboItemModelImplToJson(
        _$ComboItemModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'name_en': instance.nameEn,
      'image': instance.image,
      'quantity': instance.quantity,
      'printer_type': instance.printerType,
      'unit': instance.unit,
    };
