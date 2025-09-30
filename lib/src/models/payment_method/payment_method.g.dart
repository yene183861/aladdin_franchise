// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_method.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PaymentMethodImpl _$$PaymentMethodImplFromJson(Map<String, dynamic> json) =>
    _$PaymentMethodImpl(
      key: (json['key'] as num?)?.toInt() ?? -1,
      name: json['name'] as String? ?? 'Phương thức thanh toán',
      nameEn: json['name_en'] as String? ?? 'Payment method',
      isVat: json['is_vat'] as bool?,
      isBank: json['is_bank'] as bool? ?? false,
      isGateway: json['is_gateway'] as bool? ?? false,
      isCash: json['is_cash'] as bool? ?? false,
      isAtm: json['is_atm'] as bool? ?? false,
      requireEditTax: json['require_edit_tax'] as bool? ?? false,
      paymentAmount: json['payment_amount'],
      keyMethod: (json['key_method'] as num?)?.toInt() ?? -1,
      method: json['method'] as String? ?? 'Phương thức thanh toán',
    );

Map<String, dynamic> _$$PaymentMethodImplToJson(_$PaymentMethodImpl instance) =>
    <String, dynamic>{
      'key': instance.key,
      'name': instance.name,
      'name_en': instance.nameEn,
      'is_vat': instance.isVat,
      'is_bank': instance.isBank,
      'is_gateway': instance.isGateway,
      'is_cash': instance.isCash,
      'is_atm': instance.isAtm,
      'require_edit_tax': instance.requireEditTax,
      'payment_amount': instance.paymentAmount,
      'key_method': instance.keyMethod,
      'method': instance.method,
    };
