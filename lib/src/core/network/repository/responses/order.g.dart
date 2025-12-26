// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$OrdersResponseDataImpl _$$OrdersResponseDataImplFromJson(
        Map<String, dynamic> json) =>
    _$OrdersResponseDataImpl(
      notUse: (json['not_use'] as List<dynamic>)
          .map((e) => TableModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      using: (json['using'] as List<dynamic>)
          .map((e) => TableModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      userUsing: (json['user_using'] as List<dynamic>)
          .map((e) => OrderModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      waiters: (json['waiters'] as List<dynamic>?)
          ?.map((e) => WaiterModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      ipOrder: json['ip_order'],
    );

Map<String, dynamic> _$$OrdersResponseDataImplToJson(
        _$OrdersResponseDataImpl instance) =>
    <String, dynamic>{
      'not_use': instance.notUse.map((e) => e.toJson()).toList(),
      'using': instance.using.map((e) => e.toJson()).toList(),
      'user_using': instance.userUsing.map((e) => e.toJson()).toList(),
      'waiters': instance.waiters?.map((e) => e.toJson()).toList(),
      'ip_order': instance.ipOrder,
    };
