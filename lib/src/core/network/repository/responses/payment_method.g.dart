// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_method.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PaymentMethodResponseImpl _$$PaymentMethodResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$PaymentMethodResponseImpl(
      data: (json['data'] as List<dynamic>)
          .map((e) => PaymentMethod.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$PaymentMethodResponseImplToJson(
        _$PaymentMethodResponseImpl instance) =>
    <String, dynamic>{
      'data': instance.data,
    };
