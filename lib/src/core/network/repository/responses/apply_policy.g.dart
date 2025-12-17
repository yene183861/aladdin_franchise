// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'apply_policy.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ApplyPolicyResponseImpl _$$ApplyPolicyResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$ApplyPolicyResponseImpl(
      data: ApplyPolicyResponseData.fromJson(
          json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$ApplyPolicyResponseImplToJson(
        _$ApplyPolicyResponseImpl instance) =>
    <String, dynamic>{
      'data': instance.data.toJson(),
    };

_$ApplyPolicyResponseDataImpl _$$ApplyPolicyResponseDataImplFromJson(
        Map<String, dynamic> json) =>
    _$ApplyPolicyResponseDataImpl(
      status: (json['status'] as num).toInt(),
      data: (json['data'] as List<dynamic>)
          .map((e) => PolicyResultModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      dataCreateVouchers: json['dataCreateVouchers'],
    );

Map<String, dynamic> _$$ApplyPolicyResponseDataImplToJson(
        _$ApplyPolicyResponseDataImpl instance) =>
    <String, dynamic>{
      'status': instance.status,
      'data': instance.data.map((e) => e.toJson()).toList(),
      'dataCreateVouchers': instance.dataCreateVouchers,
    };
