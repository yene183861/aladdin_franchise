// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_time.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$OrderTimeModelImpl _$$OrderTimeModelImplFromJson(Map<String, dynamic> json) =>
    _$OrderTimeModelImpl(
      orderId: (json['order_id'] as num).toInt(),
      products: (json['products'] as List<dynamic>)
          .map((e) => ProductOrderTimeModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$OrderTimeModelImplToJson(
        _$OrderTimeModelImpl instance) =>
    <String, dynamic>{
      'order_id': instance.orderId,
      'products': instance.products.map((e) => e.toJson()).toList(),
    };

_$ProductOrderTimeModelImpl _$$ProductOrderTimeModelImplFromJson(
        Map<String, dynamic> json) =>
    _$ProductOrderTimeModelImpl(
      productId: (json['product_id'] as num).toInt(),
      numberOfProduct: (json['number_of_product'] as num).toInt(),
      time: DateTime.parse(json['time'] as String),
      note: json['note'] as String?,
    );

Map<String, dynamic> _$$ProductOrderTimeModelImplToJson(
        _$ProductOrderTimeModelImpl instance) =>
    <String, dynamic>{
      'product_id': instance.productId,
      'number_of_product': instance.numberOfProduct,
      'time': instance.time.toIso8601String(),
      'note': instance.note,
    };
