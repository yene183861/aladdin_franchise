// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProductResponseImpl _$$ProductResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$ProductResponseImpl(
      data: ProductResponseData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$ProductResponseImplToJson(
        _$ProductResponseImpl instance) =>
    <String, dynamic>{
      'data': instance.data.toJson(),
    };

_$ProductResponseDataImpl _$$ProductResponseDataImplFromJson(
        Map<String, dynamic> json) =>
    _$ProductResponseDataImpl(
      status: (json['status'] as num).toInt(),
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => ProductModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$ProductResponseDataImplToJson(
        _$ProductResponseDataImpl instance) =>
    <String, dynamic>{
      'status': instance.status,
      'data': instance.data?.map((e) => e.toJson()).toList(),
    };
