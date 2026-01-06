// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'request_order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RequestOrderItemModelImpl _$$RequestOrderItemModelImplFromJson(
        Map<String, dynamic> json) =>
    _$RequestOrderItemModelImpl(
      id: (json['id'] as num?)?.toInt(),
      menuItemId: (json['menu_item_id'] as num?)?.toInt(),
      codeProduct: json['code_product'] as String? ?? '',
      quantity: (json['quantity'] as num?)?.toInt() ?? 0,
      note: json['note'] as String? ?? '',
      image: json['image'] as String? ?? '',
      name: json['name'] as String? ?? '',
      noteRestaurant: json['note_restaurant'] as String? ?? '',
      unit: json['unit'] as String? ?? '',
    );

Map<String, dynamic> _$$RequestOrderItemModelImplToJson(
        _$RequestOrderItemModelImpl instance) =>
    <String, dynamic>{
      'code_product': instance.codeProduct,
      'note_restaurant': instance.noteRestaurant,
    };

_$RequestOrderModelImpl _$$RequestOrderModelImplFromJson(
        Map<String, dynamic> json) =>
    _$RequestOrderModelImpl(
      id: json['id'] ?? -1,
      status: (json['status'] as num?)?.toInt() ?? 0,
      listItem: (json['list_item'] as List<dynamic>?)
              ?.map((e) =>
                  RequestOrderItemModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      timeOrder: json['time_order'] == null
          ? null
          : DateTime.parse(json['time_order'] as String),
      sender: json['sender'] as String? ?? '',
      notes: json['notes'] as String? ?? '',
      orderTimes: (json['order_times'] as num?)?.toInt() ?? 1,
    );

Map<String, dynamic> _$$RequestOrderModelImplToJson(
        _$RequestOrderModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'status': instance.status,
      'list_item': instance.listItem.map((e) => e.toJson()).toList(),
      'time_order': instance.timeOrder?.toIso8601String(),
      'sender': instance.sender,
      'notes': instance.notes,
      'order_times': instance.orderTimes,
    };

_$RedisO2oProcessedRequestModelImpl
    _$$RedisO2oProcessedRequestModelImplFromJson(Map<String, dynamic> json) =>
        _$RedisO2oProcessedRequestModelImpl(
          orderId: (json['order_id'] as num?)?.toInt(),
          tableName: json['table_name'] as String?,
          status: (json['status'] as num?)?.toInt() ?? 0,
          items: (json['items'] as List<dynamic>?)
                  ?.map((e) =>
                      RequestOrderItemModel.fromJson(e as Map<String, dynamic>))
                  .toList() ??
              const [],
          notes: json['notes'] as String? ?? '',
        );

Map<String, dynamic> _$$RedisO2oProcessedRequestModelImplToJson(
        _$RedisO2oProcessedRequestModelImpl instance) =>
    <String, dynamic>{
      'order_id': instance.orderId,
      'table_name': instance.tableName,
      'status': instance.status,
      'items': instance.items.map((e) => e.toJson()).toList(),
      'notes': instance.notes,
    };
