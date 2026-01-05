// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reservation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ReservationModelImpl _$$ReservationModelImplFromJson(
        Map<String, dynamic> json) =>
    _$ReservationModelImpl(
      id: json['id'],
      customer: json['customer'] == null
          ? null
          : ReservationCustomerModel.fromJson(
              json['customer'] as Map<String, dynamic>),
      status:
          json['status'] == null ? 1 : ParsingUtils.parseInt(json['status']),
      statusName: json['status_name'] as String? ?? '',
      reservationDate: json['reservation_date'] as String? ?? '2026-01-01',
      startTime: json['start_time'] as String? ?? '08:00',
      endTime: json['end_time'] as String? ?? '10:00',
      table: json['table'] as String?,
      isOnline: json['is_online'] == null
          ? false
          : ParsingUtils.parseBool(json['is_online']),
      tableId: json['table_id'] == null
          ? const []
          : ParsingUtils.parseListInt(json['table_id']),
      saleName: json['sale_name'] as String?,
      saleCode: json['sale_code'] as String?,
      isUpdate: json['is_update'] as bool? ?? false,
    );

Map<String, dynamic> _$$ReservationModelImplToJson(
        _$ReservationModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'customer': instance.customer?.toJson(),
      'status': instance.status,
      'status_name': instance.statusName,
      'reservation_date': instance.reservationDate,
      'start_time': instance.startTime,
      'end_time': instance.endTime,
      'table': instance.table,
      'is_online': instance.isOnline,
      'table_id': instance.tableId,
      'sale_name': instance.saleName,
      'sale_code': instance.saleCode,
      'is_update': instance.isUpdate,
    };
