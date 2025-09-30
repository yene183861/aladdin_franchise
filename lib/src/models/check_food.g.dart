// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'check_food.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CheckFoodModelImpl _$$CheckFoodModelImplFromJson(Map<String, dynamic> json) =>
    _$CheckFoodModelImpl(
      orderId: (json['order_id'] as num).toInt(),
      productId: (json['product_id'] as num).toInt(),
    );

Map<String, dynamic> _$$CheckFoodModelImplToJson(
        _$CheckFoodModelImpl instance) =>
    <String, dynamic>{
      'order_id': instance.orderId,
      'product_id': instance.productId,
    };
