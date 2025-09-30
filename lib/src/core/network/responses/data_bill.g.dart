// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_bill.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DataBillResponseImpl _$$DataBillResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$DataBillResponseImpl(
      data: DataBillResponseData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$DataBillResponseImplToJson(
        _$DataBillResponseImpl instance) =>
    <String, dynamic>{
      'data': instance.data.toJson(),
    };

_$DataBillResponseDataImpl _$$DataBillResponseDataImplFromJson(
        Map<String, dynamic> json) =>
    _$DataBillResponseDataImpl(
      price: json['price'] == null
          ? const PriceDataBill()
          : PriceDataBill.fromJson(json['price'] as Map<String, dynamic>),
      order: json['order'] == null
          ? const OrderDataBill()
          : OrderDataBill.fromJson(json['order'] as Map<String, dynamic>),
      orderLineItems: (json['orderLineItems'] as List<dynamic>?)
              ?.map((e) => LineItemDataBill.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      vouchers: (json['vouchers'] as List<dynamic>?)
              ?.map((e) =>
                  HistoryPolicyResultModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      description: json['description'] as String? ?? '',
      print: json['print'] == null
          ? null
          : DataBillPrint.fromJson(json['print'] as Map<String, dynamic>),
      sale: json['sale'] == null
          ? null
          : DataBillSale.fromJson(json['sale'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$DataBillResponseDataImplToJson(
        _$DataBillResponseDataImpl instance) =>
    <String, dynamic>{
      'price': instance.price,
      'order': instance.order,
      'orderLineItems': instance.orderLineItems,
      'vouchers': instance.vouchers,
      'description': instance.description,
      'print': instance.print,
      'sale': instance.sale,
    };

_$DataBillPrintImpl _$$DataBillPrintImplFromJson(Map<String, dynamic> json) =>
    _$DataBillPrintImpl(
      order: json['order'] == null
          ? null
          : OrderPrintModel.fromJson(json['order'] as Map<String, dynamic>),
      infoPrint: json['infoPrint'] == null
          ? null
          : DataBillInfoPrintModel.fromJson(
              json['infoPrint'] as Map<String, dynamic>),
      orderLineItems: (json['orderLineItems'] as List<dynamic>?)
              ?.map((e) => LineItemDataBill.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      vouchers: (json['vouchers'] as List<dynamic>?)
              ?.map((e) =>
                  HistoryPolicyResultModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      description: json['description'] as String? ?? '',
      paymentMethod: json['payment_method'] as String? ?? '',
      listPaymentMethod: (json['list_payment_method'] as List<dynamic>?)
              ?.map((e) => PaymentMethod.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      price: json['price'] == null
          ? null
          : PriceDataBill.fromJson(json['price'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$DataBillPrintImplToJson(_$DataBillPrintImpl instance) =>
    <String, dynamic>{
      'order': instance.order,
      'infoPrint': instance.infoPrint,
      'orderLineItems': instance.orderLineItems,
      'vouchers': instance.vouchers,
      'description': instance.description,
      'payment_method': instance.paymentMethod,
      'list_payment_method': instance.listPaymentMethod,
      'price': instance.price,
    };

_$DataBillSaleImpl _$$DataBillSaleImplFromJson(Map<String, dynamic> json) =>
    _$DataBillSaleImpl(
      eSaleCode: json['e_sale_code'] as String? ?? '',
      eSaleName: json['e_sale_name'] as String? ?? '',
    );

Map<String, dynamic> _$$DataBillSaleImplToJson(_$DataBillSaleImpl instance) =>
    <String, dynamic>{
      'e_sale_code': instance.eSaleCode,
      'e_sale_name': instance.eSaleName,
    };

_$DataBillInfoPrintModelImpl _$$DataBillInfoPrintModelImplFromJson(
        Map<String, dynamic> json) =>
    _$DataBillInfoPrintModelImpl(
      ip: json['ip'] as String? ?? '',
      port: (json['port'] as num?)?.toInt() ?? -1,
    );

Map<String, dynamic> _$$DataBillInfoPrintModelImplToJson(
        _$DataBillInfoPrintModelImpl instance) =>
    <String, dynamic>{
      'ip': instance.ip,
      'port': instance.port,
    };

_$OrderPrintModelImpl _$$OrderPrintModelImplFromJson(
        Map<String, dynamic> json) =>
    _$OrderPrintModelImpl(
      code: json['code'] as String? ?? '',
      tableName: json['table_name'] as String? ?? '',
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      timeCompleted: json['time_completed'] == null
          ? null
          : DateTime.parse(json['time_completed'] as String),
      cashierCompleted: json['cashier_completed'] as String? ?? '',
      cashierPrint: json['cashier_print'] as String? ?? '',
      phoneNumber: json['phone_number'] as String? ?? '',
      amountPeople: (json['amount_people'] as num?)?.toInt() ?? 0,
      amountChildren: (json['amount_children'] as num?)?.toInt() ?? 0,
      amountAdult: (json['amount_adult'] as num?)?.toInt() ?? 0,
      isPrintPeople: json['is_print_people'] as bool? ?? false,
      numberPrintCompleted:
          (json['number_print_completed'] as num?)?.toInt() ?? 0,
      numberPrintTemporary:
          (json['number_print_temporary'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$$OrderPrintModelImplToJson(
        _$OrderPrintModelImpl instance) =>
    <String, dynamic>{
      'code': instance.code,
      'table_name': instance.tableName,
      'created_at': instance.createdAt?.toIso8601String(),
      'time_completed': instance.timeCompleted?.toIso8601String(),
      'cashier_completed': instance.cashierCompleted,
      'cashier_print': instance.cashierPrint,
      'phone_number': instance.phoneNumber,
      'amount_people': instance.amountPeople,
      'amount_children': instance.amountChildren,
      'amount_adult': instance.amountAdult,
      'is_print_people': instance.isPrintPeople,
      'number_print_completed': instance.numberPrintCompleted,
      'number_print_temporary': instance.numberPrintTemporary,
    };
