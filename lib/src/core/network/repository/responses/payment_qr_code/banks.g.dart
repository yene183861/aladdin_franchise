// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'banks.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BankPaymentResponseImpl _$$BankPaymentResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$BankPaymentResponseImpl(
      status: (json['status'] as num?)?.toInt() ?? -1,
      data: (json['data'] as List<dynamic>?)
              ?.map((e) => UserBankModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$BankPaymentResponseImplToJson(
        _$BankPaymentResponseImpl instance) =>
    <String, dynamic>{
      'status': instance.status,
      'data': instance.data,
    };
