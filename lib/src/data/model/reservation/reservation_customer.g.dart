// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reservation_customer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ReservationCustomerModelImpl _$$ReservationCustomerModelImplFromJson(
        Map<String, dynamic> json) =>
    _$ReservationCustomerModelImpl(
      id: json['id'],
      name: json['name'] as String?,
      phoneNumber: json['phone_number'] as String?,
    );

Map<String, dynamic> _$$ReservationCustomerModelImplToJson(
        _$ReservationCustomerModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'phone_number': instance.phoneNumber,
    };
