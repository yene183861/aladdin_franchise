// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_history.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$OrderHistoryImpl _$$OrderHistoryImplFromJson(Map<String, dynamic> json) =>
    _$OrderHistoryImpl(
      id: (json['id'] as num?)?.toInt() ?? -1,
      createdAt: DateTime.parse(json['created_at'] as String),
      timesOrder: (json['times_order'] as num?)?.toInt() ?? 0,
      notes: json['notes'] as String? ?? '',
      products: (json['line_items'] as List<dynamic>?)
              ?.map((e) => ProductHistory.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$OrderHistoryImplToJson(_$OrderHistoryImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'created_at': instance.createdAt.toIso8601String(),
      'times_order': instance.timesOrder,
      'notes': instance.notes,
      'line_items': instance.products.map((e) => e.toJson()).toList(),
    };

_$ProductHistoryImpl _$$ProductHistoryImplFromJson(Map<String, dynamic> json) =>
    _$ProductHistoryImpl(
      id: (json['id'] as num?)?.toInt() ?? -1,
      orderTimeId: (json['order_time_id'] as num?)?.toInt() ?? -1,
      timesOrder: (json['times_order'] as num?)?.toInt() ?? -1,
      itemId: (json['item_id'] as num?)?.toInt() ?? -1,
      name: json['name'] as String? ?? '',
      unit: json['unit'] as String? ?? '',
      notes: json['notes'] as String? ?? '',
      quantity: (json['quantity'] as num?)?.toInt() ?? 0,
      quantityCancel: (json['quantity_cancel'] as num?)?.toInt() ?? 0,
      status: (json['status'] as num?)?.toInt() ?? 0,
      cancel: json['cancel'] as bool? ?? false,
      nameEn: json['name_en'] as String? ?? '',
      timeByOrderHistory: json['time_by_order_history'] == null
          ? null
          : DateTime.parse(json['time_by_order_history'] as String),
    );

Map<String, dynamic> _$$ProductHistoryImplToJson(
        _$ProductHistoryImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'order_time_id': instance.orderTimeId,
      'times_order': instance.timesOrder,
      'item_id': instance.itemId,
      'name': instance.name,
      'unit': instance.unit,
      'notes': instance.notes,
      'quantity': instance.quantity,
      'quantity_cancel': instance.quantityCancel,
      'status': instance.status,
      'cancel': instance.cancel,
      'name_en': instance.nameEn,
      'time_by_order_history': instance.timeByOrderHistory?.toIso8601String(),
    };
