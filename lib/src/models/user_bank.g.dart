// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_bank.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserBankModelImpl _$$UserBankModelImplFromJson(Map<String, dynamic> json) =>
    _$UserBankModelImpl(
      title: json['title'] as String? ?? '',
      bankName: json['bank_name'] as String? ?? '',
      fullName: json['full_name'] as String? ?? '',
      bankNumber:
          json['bank_number'] == null ? '' : _dataToString(json['bank_number']),
      bankBin: json['bank_bin'] as String? ?? '',
      useInvoice: json['use_invoice'] as bool?,
      qrCode: json['qr_code'] as String? ?? '',
      listPaymentId: (json['list_payment_id'] as List<dynamic>?)
              ?.map((e) => (e as num).toInt())
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$UserBankModelImplToJson(_$UserBankModelImpl instance) =>
    <String, dynamic>{
      'title': instance.title,
      'bank_name': instance.bankName,
      'full_name': instance.fullName,
      'bank_number': instance.bankNumber,
      'bank_bin': instance.bankBin,
      'use_invoice': instance.useInvoice,
      'qr_code': instance.qrCode,
      'list_payment_id': instance.listPaymentId,
    };
