// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$OrderModelImpl _$$OrderModelImplFromJson(Map<String, dynamic> json) =>
    _$OrderModelImpl(
      id: (json['id'] as num?)?.toInt() ?? -1,
      name: json['name'] as String? ?? '',
      misc: json['misc'] as String? ?? '',
      isRestore: (json['is_restore'] as num?)?.toInt() ?? 0,
      waiterId: (json['waiter_id'] as num?)?.toInt(),
      qrO2O: (json['qr_o2_o'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      tableId: json['table_id'] as String? ?? '',
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      reservationCrmId: json['reservation_crm_id'] ?? null,
    );

Map<String, dynamic> _$$OrderModelImplToJson(_$OrderModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'misc': instance.misc,
      'is_restore': instance.isRestore,
      'waiter_id': instance.waiterId,
      'table_id': instance.tableId,
      'created_at': instance.createdAt?.toIso8601String(),
    };
