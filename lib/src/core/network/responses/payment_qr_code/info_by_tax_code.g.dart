// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'info_by_tax_code.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$InfoByTaxCodeResponseImpl _$$InfoByTaxCodeResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$InfoByTaxCodeResponseImpl(
      status: (json['status'] as num?)?.toInt() ?? -1,
      data: json['data'] == null
          ? const MInvoiceInfo()
          : MInvoiceInfo.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$InfoByTaxCodeResponseImplToJson(
        _$InfoByTaxCodeResponseImpl instance) =>
    <String, dynamic>{
      'status': instance.status,
      'data': instance.data,
    };
