// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'history_order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$HistoryOrderModelImpl _$$HistoryOrderModelImplFromJson(
        Map<String, dynamic> json) =>
    _$HistoryOrderModelImpl(
      orderCode: json['order_code'] as String? ?? '',
      tableName: json['table_name'] as String? ?? '',
      notes: json['notes'] as String? ?? '',
      orderCreated: json['order_created'] == null
          ? null
          : DateTime.parse(json['order_created'] as String),
      orderStatus: (json['order_status'] as num?)?.toInt() ?? 15,
      orderStatusName: json['order_status_name'] as String? ?? '',
      orderExcute: json['order_excute'] == null
          ? const HistoryOrderExcuteModel()
          : HistoryOrderExcuteModel.fromJson(
              json['order_excute'] as Map<String, dynamic>),
      customer: json['customer'] == null
          ? null
          : CustomerModel.fromJson(json['customer'] as Map<String, dynamic>),
      coupons: (json['coupons'] as List<dynamic>?)
              ?.map((e) =>
                  CustomerPolicyModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      price: json['price'] == null
          ? null
          : PriceDataBill.fromJson(json['price'] as Map<String, dynamic>),
      orderItems: (json['order_items'] as List<dynamic>?)
              ?.map((e) => ProductCheckoutHistoryModel.fromJson(
                  e as Map<String, dynamic>))
              .toList() ??
          const [],
      orderHistories: (json['order_histories'] as List<dynamic>?)
              ?.map((e) => ProductCheckoutHistoryModel.fromJson(
                  e as Map<String, dynamic>))
              .toList() ??
          const [],
      orderType:
          (json['order_type'] as num?)?.toInt() ?? AppConfig.orderOfflineValue,
    );

Map<String, dynamic> _$$HistoryOrderModelImplToJson(
        _$HistoryOrderModelImpl instance) =>
    <String, dynamic>{
      'order_code': instance.orderCode,
      'table_name': instance.tableName,
      'notes': instance.notes,
      'order_created': instance.orderCreated?.toIso8601String(),
      'order_status': instance.orderStatus,
      'order_status_name': instance.orderStatusName,
      'order_excute': instance.orderExcute,
      'customer': instance.customer,
      'coupons': instance.coupons,
      'price': instance.price,
      'order_items': instance.orderItems,
      'order_histories': instance.orderHistories,
      'order_type': instance.orderType,
    };

_$HistoryOrderExcuteModelImpl _$$HistoryOrderExcuteModelImplFromJson(
        Map<String, dynamic> json) =>
    _$HistoryOrderExcuteModelImpl(
      flag: (json['flag'] as num?)?.toInt() ?? 0,
      order: (json['order'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$$HistoryOrderExcuteModelImplToJson(
        _$HistoryOrderExcuteModelImpl instance) =>
    <String, dynamic>{
      'flag': instance.flag,
      'order': instance.order,
    };

_$HistoryOrderProductModelImpl _$$HistoryOrderProductModelImplFromJson(
        Map<String, dynamic> json) =>
    _$HistoryOrderProductModelImpl(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String? ?? '',
      codeProduct: json['code_product'] as String? ?? '',
      quantity: json['quantity'] as String? ?? '-1',
      unitPrice: json['unit_price'] as String? ?? '0',
      printerType: (json['printer_type'] as num?)?.toInt(),
      timesOrder: (json['times_order'] as num?)?.toInt() ?? 0,
      notes: json['notes'] as String? ?? '',
    );

Map<String, dynamic> _$$HistoryOrderProductModelImplToJson(
        _$HistoryOrderProductModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'code_product': instance.codeProduct,
      'quantity': instance.quantity,
      'unit_price': instance.unitPrice,
      'printer_type': instance.printerType,
      'times_order': instance.timesOrder,
      'notes': instance.notes,
    };
