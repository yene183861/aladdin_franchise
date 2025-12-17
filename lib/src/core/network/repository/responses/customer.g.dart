// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CustomerResponseImpl _$$CustomerResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$CustomerResponseImpl(
      data: CustomerResponseData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$CustomerResponseImplToJson(
        _$CustomerResponseImpl instance) =>
    <String, dynamic>{
      'data': instance.data.toJson(),
    };

_$CustomerResponseDataImpl _$$CustomerResponseDataImplFromJson(
        Map<String, dynamic> json) =>
    _$CustomerResponseDataImpl(
      status: (json['status'] as num).toInt(),
      customer: json['customer'],
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => CustomerPolicyModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$CustomerResponseDataImplToJson(
        _$CustomerResponseDataImpl instance) =>
    <String, dynamic>{
      'status': instance.status,
      'customer': instance.customer,
      'data': instance.data?.map((e) => e.toJson()).toList(),
    };
