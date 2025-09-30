// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'info_policy_checkout.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$InfoPolicyCheckoutModelImpl _$$InfoPolicyCheckoutModelImplFromJson(
        Map<String, dynamic> json) =>
    _$InfoPolicyCheckoutModelImpl(
      orderId: (json['order_id'] as num).toInt(),
      customer: json['customer'] == null
          ? null
          : CustomerModel.fromJson(json['customer'] as Map<String, dynamic>),
      customerPolicies: (json['customer_policies'] as List<dynamic>?)
          ?.map((e) => CustomerPolicyModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      customerPolicySelects: (json['customer_policy_selects'] as List<dynamic>?)
          ?.map((e) => CustomerPolicyModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      coupons: (json['coupons'] as List<dynamic>?)
          ?.map((e) => CustomerPolicyModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      vouchers: (json['vouchers'] as List<dynamic>?)
          ?.map((e) => PolicyResultModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      createVouchers: json['create_vouchers'],
      totalDiscount: (json['total_discount'] as num?)?.toDouble(),
      pointUse: (json['point_use'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$InfoPolicyCheckoutModelImplToJson(
        _$InfoPolicyCheckoutModelImpl instance) =>
    <String, dynamic>{
      'order_id': instance.orderId,
      'customer': instance.customer?.toJson(),
      'customer_policies':
          instance.customerPolicies?.map((e) => e.toJson()).toList(),
      'customer_policy_selects':
          instance.customerPolicySelects?.map((e) => e.toJson()).toList(),
      'coupons': instance.coupons?.map((e) => e.toJson()).toList(),
      'vouchers': instance.vouchers?.map((e) => e.toJson()).toList(),
      'create_vouchers': instance.createVouchers,
      'total_discount': instance.totalDiscount,
      'point_use': instance.pointUse,
    };
