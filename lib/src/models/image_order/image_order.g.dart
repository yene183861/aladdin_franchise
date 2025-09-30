// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'image_order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ImageOrderLocalImpl _$$ImageOrderLocalImplFromJson(
        Map<String, dynamic> json) =>
    _$ImageOrderLocalImpl(
      orderId: (json['orderId'] as num).toInt(),
      paths:
          (json['paths'] as List<dynamic>?)?.map((e) => e as String).toList() ??
              const [],
    );

Map<String, dynamic> _$$ImageOrderLocalImplToJson(
        _$ImageOrderLocalImpl instance) =>
    <String, dynamic>{
      'orderId': instance.orderId,
      'paths': instance.paths,
    };
