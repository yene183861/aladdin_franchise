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
      status: json['status'] == null ? 1 : numberFromDataString(json['status']),
      statusName: json['status_name'] as String? ?? '',
      reservationDate: json['reservation_date'] as String,
      startTime: json['start_time'] as String,
      endTime: json['end_time'] as String,
      table: json['table'] as String?,
      guest: json['guest'] == null ? 1 : numberFromDataString(json['guest']),
      amountAdult: numberFromDataString(json['amount_adult']),
      amountChildren: numberFromDataString(json['amount_children']),
      hasBirthday: json['has_birthday'] == null
          ? false
          : boolFromDataString(json['has_birthday']),
      rejectReason: json['reject_reason'] as String? ?? '',
      isOnline: json['is_online'] == null
          ? false
          : boolFromDataString(json['is_online']),
      tableId: json['table_id'] == null
          ? const []
          : listIntFromDataString(json['table_id']),
      infoOrder: json['info_order'] as String? ?? '',
      fromSale: json['from_sale'] == null
          ? false
          : boolFromDataString(json['from_sale']),
      note: json['note'] as String? ?? '',
      isUpdate: boolFromDataString(json['is_update']),
      saleName: json['sale_name'] as String?,
      saleCode: json['sale_code'] as String?,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
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
      'guest': instance.guest,
      'amount_adult': instance.amountAdult,
      'amount_children': instance.amountChildren,
      'has_birthday': instance.hasBirthday,
      'reject_reason': instance.rejectReason,
      'is_online': instance.isOnline,
      'table_id': instance.tableId,
      'info_order': instance.infoOrder,
      'from_sale': instance.fromSale,
      'note': instance.note,
      'is_update': instance.isUpdate,
      'sale_name': instance.saleName,
      'sale_code': instance.saleCode,
      'created_at': instance.createdAt?.toIso8601String(),
    };

_$ReservationCustomerModelImpl _$$ReservationCustomerModelImplFromJson(
        Map<String, dynamic> json) =>
    _$ReservationCustomerModelImpl(
      id: json['id'],
      name: json['name'] as String,
      firstName: json['first_name'] as String?,
      lastName: json['last_name'] as String,
      phoneNumber: json['phone_number'] as String,
      dob: json['dob'] as String?,
      email: json['email'] as String?,
      isZaloOa: boolFromDataString(json['is_zalo_oa']),
    );

Map<String, dynamic> _$$ReservationCustomerModelImplToJson(
        _$ReservationCustomerModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'phone_number': instance.phoneNumber,
      'dob': instance.dob,
      'email': instance.email,
      'is_zalo_oa': instance.isZaloOa,
    };
