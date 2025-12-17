// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'process_order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProcessOrderResponseImpl _$$ProcessOrderResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$ProcessOrderResponseImpl(
      status: (json['status'] as num).toInt(),
      message: json['message'],
      timesOrder: (json['times_order'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$ProcessOrderResponseImplToJson(
        _$ProcessOrderResponseImpl instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'times_order': instance.timesOrder,
    };
