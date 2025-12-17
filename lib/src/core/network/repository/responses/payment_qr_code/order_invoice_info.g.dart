// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_invoice_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$OrderInvoiceInfoResponseImpl _$$OrderInvoiceInfoResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$OrderInvoiceInfoResponseImpl(
      status: (json['status'] as num?)?.toInt() ?? -1,
      data: json['data'] == null
          ? const OrderInvoice()
          : OrderInvoice.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$OrderInvoiceInfoResponseImplToJson(
        _$OrderInvoiceInfoResponseImpl instance) =>
    <String, dynamic>{
      'status': instance.status,
      'data': instance.data,
    };
