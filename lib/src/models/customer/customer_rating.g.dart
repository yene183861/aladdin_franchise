// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer_rating.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CustomerRatingImpl _$$CustomerRatingImplFromJson(Map<String, dynamic> json) =>
    _$CustomerRatingImpl(
      key: (json['key'] as num?)?.toInt() ?? -1,
      name: json['name'] as String? ?? '',
      maxStar: (json['max_star'] as num?)?.toInt() ?? 0,
      star: (json['star'] as num?)?.toInt() ?? 0,
      note: json['note'] as String? ?? '',
      nameEn: json['name_en'] as String? ?? '',
      hints: (json['hints'] as List<dynamic>?)
              ?.map(
                  (e) => CustomerRatingHint.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$CustomerRatingImplToJson(
        _$CustomerRatingImpl instance) =>
    <String, dynamic>{
      'key': instance.key,
      'name': instance.name,
      'max_star': instance.maxStar,
      'star': instance.star,
      'note': instance.note,
      'name_en': instance.nameEn,
      'hints': instance.hints.map((e) => e.toJson()).toList(),
    };

_$CustomerRatingHintImpl _$$CustomerRatingHintImplFromJson(
        Map<String, dynamic> json) =>
    _$CustomerRatingHintImpl(
      star: (json['star'] as num?)?.toInt() ?? 0,
      content: json['content'] as String? ?? '',
    );

Map<String, dynamic> _$$CustomerRatingHintImplToJson(
        _$CustomerRatingHintImpl instance) =>
    <String, dynamic>{
      'star': instance.star,
      'content': instance.content,
    };

_$CustomerRatingSaveLocalImpl _$$CustomerRatingSaveLocalImplFromJson(
        Map<String, dynamic> json) =>
    _$CustomerRatingSaveLocalImpl(
      orderId: (json['order_id'] as num).toInt(),
      customerRating: (json['customer_rating'] as List<dynamic>)
          .map((e) => CustomerRating.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$CustomerRatingSaveLocalImplToJson(
        _$CustomerRatingSaveLocalImpl instance) =>
    <String, dynamic>{
      'order_id': instance.orderId,
      'customer_rating':
          instance.customerRating.map((e) => e.toJson()).toList(),
    };
