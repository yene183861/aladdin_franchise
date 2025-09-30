// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_invoice.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$OrderInvoiceImpl _$$OrderInvoiceImplFromJson(Map<String, dynamic> json) =>
    _$OrderInvoiceImpl(
      isValidate: json['is_validate'] as bool? ?? true,
      name: json['name'] as String? ?? '',
      taxCode: json['tax_code'] as String? ?? '',
      companyName: json['company_name'] as String? ?? '',
      address: json['address'] as String? ?? '',
      email: json['email'] as String? ?? '',
      bank: json['bank'] as String? ?? '',
      accountNumber: json['account_number'] as String? ?? '',
      phone: json['phone'] as String? ?? '',
      maDvqhns: json['ma_dvqhns'] as String? ?? '',
      cccdan: json['cccdan'] as String? ?? '',
    );

Map<String, dynamic> _$$OrderInvoiceImplToJson(_$OrderInvoiceImpl instance) =>
    <String, dynamic>{
      'is_validate': instance.isValidate,
      'name': instance.name,
      'tax_code': instance.taxCode,
      'company_name': instance.companyName,
      'address': instance.address,
      'email': instance.email,
      'bank': instance.bank,
      'account_number': instance.accountNumber,
      'phone': instance.phone,
      'ma_dvqhns': instance.maDvqhns,
      'cccdan': instance.cccdan,
    };
