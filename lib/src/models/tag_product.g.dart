// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tag_product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TagProductModelImpl _$$TagProductModelImplFromJson(
        Map<String, dynamic> json) =>
    _$TagProductModelImpl(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      nameEn: json['name_en'] as String? ?? '',
    );

Map<String, dynamic> _$$TagProductModelImplToJson(
        _$TagProductModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'name_en': instance.nameEn,
    };
