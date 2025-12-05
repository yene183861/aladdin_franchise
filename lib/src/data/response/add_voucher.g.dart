// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_voucher.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$VoucherResponseImpl _$$VoucherResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$VoucherResponseImpl(
      status: json['status'] as String? ?? '',
      message: json['message'] as String? ?? '',
      data: json['data'] == null
          ? null
          : VoucherModel.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$VoucherResponseImplToJson(
        _$VoucherResponseImpl instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data?.toJson(),
    };
