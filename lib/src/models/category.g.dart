// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CategoryModelImpl _$$CategoryModelImplFromJson(Map<String, dynamic> json) =>
    _$CategoryModelImpl(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String,
      slug: json['slug'] as String?,
      description: json['description'] as String?,
      image: json['image'] as String?,
      children: (json['children'] as List<dynamic>?)
          ?.map((e) => SubCategoryModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      titleEn: json['title_en'] as String? ?? '',
      language: json['language'] as Map<String, dynamic>? ?? const {},
    );

Map<String, dynamic> _$$CategoryModelImplToJson(_$CategoryModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'slug': instance.slug,
      'description': instance.description,
      'image': instance.image,
      'children': instance.children?.map((e) => e.toJson()).toList(),
      'title_en': instance.titleEn,
      'language': instance.language,
    };

_$SubCategoryModelImpl _$$SubCategoryModelImplFromJson(
        Map<String, dynamic> json) =>
    _$SubCategoryModelImpl(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String,
      slug: json['slug'] as String?,
      description: json['description'] as String?,
      image: json['image'] as String?,
      titleEn: json['title_en'] as String? ?? '',
      language: json['language'] as Map<String, dynamic>? ?? const {},
    );

Map<String, dynamic> _$$SubCategoryModelImplToJson(
        _$SubCategoryModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'slug': instance.slug,
      'description': instance.description,
      'image': instance.image,
      'title_en': instance.titleEn,
      'language': instance.language,
    };
