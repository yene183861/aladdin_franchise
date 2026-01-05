// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reservation_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ReservationRequestModelImpl _$$ReservationRequestModelImplFromJson(
        Map<String, dynamic> json) =>
    _$ReservationRequestModelImpl(
      restaurantId: (json['restaurant_id'] as num).toInt(),
      reservationDateStart:
          DateTime.parse(json['reservation_date_start'] as String),
      reservationDateEnd:
          DateTime.parse(json['reservation_date_end'] as String),
    );

Map<String, dynamic> _$$ReservationRequestModelImplToJson(
        _$ReservationRequestModelImpl instance) =>
    <String, dynamic>{
      'restaurant_id': instance.restaurantId,
      'reservation_date_start':
          ParsingUtils.formatDateTime(instance.reservationDateStart),
      'reservation_date_end':
          ParsingUtils.formatDateTime(instance.reservationDateEnd),
    };
