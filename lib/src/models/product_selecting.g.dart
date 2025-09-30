// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_selecting.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProductSelectingModelImpl _$$ProductSelectingModelImplFromJson(
        Map<String, dynamic> json) =>
    _$ProductSelectingModelImpl(
      orderId: (json['order_id'] as num).toInt(),
      products: (json['products'] as List<dynamic>)
          .map((e) => ProductModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$ProductSelectingModelImplToJson(
        _$ProductSelectingModelImpl instance) =>
    <String, dynamic>{
      'order_id': instance.orderId,
      'products': instance.products.map((e) => e.toJson()).toList(),
    };
