// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'minvoice.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MInvoiceInfoImpl _$$MInvoiceInfoImplFromJson(Map<String, dynamic> json) =>
    _$MInvoiceInfoImpl(
      isValidate: json['is_validate'] as bool? ?? true,
      name: json['name'] as String? ?? '',
      taxCode: json['ma_so_thue'] as String? ?? '',
      companyName: json['ten_cty'] as String? ?? '',
      address: json['dia_chi'] as String? ?? '',
      email: json['email'] as String? ?? '',
      bank: json['bank'] as String? ?? '',
      accountNumber: json['account_number'] as String? ?? '',
      phone: json['phone'] as String? ?? '',
    );

Map<String, dynamic> _$$MInvoiceInfoImplToJson(_$MInvoiceInfoImpl instance) =>
    <String, dynamic>{
      'is_validate': instance.isValidate,
      'name': instance.name,
      'ma_so_thue': instance.taxCode,
      'ten_cty': instance.companyName,
      'dia_chi': instance.address,
      'email': instance.email,
      'bank': instance.bank,
      'account_number': instance.accountNumber,
      'phone': instance.phone,
    };
