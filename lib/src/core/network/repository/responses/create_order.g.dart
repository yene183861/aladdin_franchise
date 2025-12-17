// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CreateOrderResponseImpl _$$CreateOrderResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$CreateOrderResponseImpl(
      status: (json['status'] as num).toInt(),
      message: json['message'],
      orderId: (json['order_id'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$CreateOrderResponseImplToJson(
        _$CreateOrderResponseImpl instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'order_id': instance.orderId,
    };
