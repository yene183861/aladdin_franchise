// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_checkout.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProductCheckoutResponseImpl _$$ProductCheckoutResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$ProductCheckoutResponseImpl(
      status: (json['status'] as num?)?.toInt(),
      data: (json['data'] as List<dynamic>?)
          ?.map((e) =>
              ProductCheckoutResponseData.fromJson(e as Map<String, dynamic>))
          .toList(),
      message: json['message'],
      coupons: (json['coupons'] as List<dynamic>?)
          ?.map((e) => CustomerPolicyModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      customer: json['customer'] == null
          ? null
          : CustomerModel.fromJson(json['customer'] as Map<String, dynamic>),
      numberOfAdults: (json['numberOfAdults'] as num?)?.toInt() ?? 1,
    );

Map<String, dynamic> _$$ProductCheckoutResponseImplToJson(
        _$ProductCheckoutResponseImpl instance) =>
    <String, dynamic>{
      'status': instance.status,
      'data': instance.data?.map((e) => e.toJson()).toList(),
      'message': instance.message,
      'coupons': instance.coupons?.map((e) => e.toJson()).toList(),
      'customer': instance.customer?.toJson(),
      'numberOfAdults': instance.numberOfAdults,
    };

_$ProductCheckoutResponseDataImpl _$$ProductCheckoutResponseDataImplFromJson(
        Map<String, dynamic> json) =>
    _$ProductCheckoutResponseDataImpl(
      id: (json['id'] as num).toInt(),
      orderItem: (json['order_item'] as List<dynamic>)
          .map((e) => ProductCheckoutModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      statusCancel: json['status_cancel'] as bool? ?? false,
      itemCancels: (json['item_cancels'] as List<dynamic>?)
              ?.map(
                  (e) => ProductCancelModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      orderHistory: (json['order_history'] as List<dynamic>?)
              ?.map((e) => OrderHistory.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$ProductCheckoutResponseDataImplToJson(
        _$ProductCheckoutResponseDataImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'order_item': instance.orderItem.map((e) => e.toJson()).toList(),
      'status_cancel': instance.statusCancel,
      'item_cancels': instance.itemCancels.map((e) => e.toJson()).toList(),
      'order_history': instance.orderHistory.map((e) => e.toJson()).toList(),
    };
