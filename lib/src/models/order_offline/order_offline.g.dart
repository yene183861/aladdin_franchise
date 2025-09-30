// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_offline.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$OrderOfflineImpl _$$OrderOfflineImplFromJson(Map<String, dynamic> json) =>
    _$OrderOfflineImpl(
      order: OrderModel.fromJson(json['order'] as Map<String, dynamic>),
      lastUpdate: DateTime.parse(json['lastUpdate'] as String),
      coupons: (json['coupons'] as List<dynamic>?)
          ?.map((e) => CustomerPolicyModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      customer: json['customer'] == null
          ? null
          : CustomerModel.fromJson(json['customer'] as Map<String, dynamic>),
      orderItem: (json['orderItem'] as List<dynamic>?)
              ?.map((e) =>
                  ProductCheckoutModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      itemCancels: (json['itemCancels'] as List<dynamic>?)
              ?.map(
                  (e) => ProductCancelModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      orderHistory: (json['orderHistory'] as List<dynamic>?)
              ?.map((e) => OrderHistory.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$OrderOfflineImplToJson(_$OrderOfflineImpl instance) =>
    <String, dynamic>{
      'order': instance.order,
      'lastUpdate': instance.lastUpdate.toIso8601String(),
      'coupons': instance.coupons,
      'customer': instance.customer,
      'orderItem': instance.orderItem,
      'itemCancels': instance.itemCancels,
      'orderHistory': instance.orderHistory,
    };
