// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'o2o_order_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$O2OOrderModelImpl _$$O2OOrderModelImplFromJson(Map<String, dynamic> json) =>
    _$O2OOrderModelImpl(
      orderId: (json['order_id'] as num?)?.toInt() ?? -1,
      qrOrderO2o: (json['qr_order_o2o'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      restaurantId: (json['restaurant_id'] as num?)?.toInt() ?? -1,
      tableName: json['table_name'] as String? ?? '',
      items: (json['items'] as List<dynamic>?)
              ?.map(
                  (e) => RequestOrderModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      orderCode: json['order_code'] as String? ?? '',
      userId: (json['user_id'] as num?)?.toInt() ?? -1,
    );

Map<String, dynamic> _$$O2OOrderModelImplToJson(_$O2OOrderModelImpl instance) =>
    <String, dynamic>{
      'order_id': instance.orderId,
      'qr_order_o2o': instance.qrOrderO2o,
      'restaurant_id': instance.restaurantId,
      'table_name': instance.tableName,
      'items': instance.items.map((e) => e.toJson()).toList(),
      'order_code': instance.orderCode,
      'user_id': instance.userId,
    };
