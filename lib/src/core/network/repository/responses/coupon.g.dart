// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coupon.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CouponResponseImpl _$$CouponResponseImplFromJson(Map<String, dynamic> json) =>
    _$CouponResponseImpl(
      data: CouponResponseData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$CouponResponseImplToJson(
        _$CouponResponseImpl instance) =>
    <String, dynamic>{
      'data': instance.data.toJson(),
    };

_$CouponResponseDataImpl _$$CouponResponseDataImplFromJson(
        Map<String, dynamic> json) =>
    _$CouponResponseDataImpl(
      status: (json['status'] as num).toInt(),
      data: (json['data'] as List<dynamic>)
          .map((e) => CustomerPolicyModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      message: json['message'] as String? ?? "",
    );

Map<String, dynamic> _$$CouponResponseDataImplToJson(
        _$CouponResponseDataImpl instance) =>
    <String, dynamic>{
      'status': instance.status,
      'data': instance.data.map((e) => e.toJson()).toList(),
      'message': instance.message,
    };
