// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_receipt_print.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PaymentReceiptPrintRequestImpl _$$PaymentReceiptPrintRequestImplFromJson(
        Map<String, dynamic> json) =>
    _$PaymentReceiptPrintRequestImpl(
      order: OrderModel.fromJson(json['order'] as Map<String, dynamic>),
      price: json['price'] == null
          ? const PriceDataBill()
          : PriceDataBill.fromJson(json['price'] as Map<String, dynamic>),
      receiptType:
          $enumDecodeNullable(_$ReceiptTypeEnumEnumMap, json['receipt_type']) ??
              ReceiptTypeEnum.paymentReceipt,
      paymentMethod: json['payment_method'] == null
          ? null
          : PaymentMethod.fromJson(
              json['payment_method'] as Map<String, dynamic>),
      paymentAmount: (json['payment_amount'] as num?)?.toDouble() ?? 0.0,
      numberPrintCompleted:
          (json['number_print_completed'] as num?)?.toInt() ?? 1,
      numberPrintTemporary:
          (json['number_print_temporary'] as num?)?.toInt() ?? 0,
      orderLineItems: (json['order_line_items'] as List<dynamic>?)
              ?.map((e) => LineItemDataBill.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      vouchers: (json['vouchers'] as List<dynamic>?)
              ?.map((e) =>
                  HistoryPolicyResultModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      note: json['note'] as String? ?? '',
      printNumberOfPeople: json['print_number_of_people'] as bool? ?? false,
      customerPhone: json['customer_phone'] as String? ?? '',
      numberOfPeople: (json['number_of_people'] as num?)?.toInt() ?? 1,
      cashierCompleted: json['cashier_completed'] as String? ?? '',
      cashierPrint: json['cashier_print'] as String? ?? '',
      timeCompleted: json['time_completed'] == null
          ? null
          : DateTime.parse(json['time_completed'] as String),
      timeCreatedAt: json['time_created_at'] == null
          ? null
          : DateTime.parse(json['time_created_at'] as String),
      invoiceQr: json['invoice_qr'] as String? ?? '',
    );

Map<String, dynamic> _$$PaymentReceiptPrintRequestImplToJson(
        _$PaymentReceiptPrintRequestImpl instance) =>
    <String, dynamic>{
      'order': instance.order.toJson(),
      'price': instance.price.toJson(),
      'receipt_type': _$ReceiptTypeEnumEnumMap[instance.receiptType]!,
      'payment_method': instance.paymentMethod?.toJson(),
      'payment_amount': instance.paymentAmount,
      'number_print_completed': instance.numberPrintCompleted,
      'number_print_temporary': instance.numberPrintTemporary,
      'order_line_items':
          instance.orderLineItems.map((e) => e.toJson()).toList(),
      'vouchers': instance.vouchers.map((e) => e.toJson()).toList(),
      'note': instance.note,
      'print_number_of_people': instance.printNumberOfPeople,
      'customer_phone': instance.customerPhone,
      'number_of_people': instance.numberOfPeople,
      'cashier_completed': instance.cashierCompleted,
      'cashier_print': instance.cashierPrint,
      'time_completed': instance.timeCompleted?.toIso8601String(),
      'time_created_at': instance.timeCreatedAt?.toIso8601String(),
      'invoice_qr': instance.invoiceQr,
    };

const _$ReceiptTypeEnumEnumMap = {
  ReceiptTypeEnum.temporaryReceipt: 'temporaryReceipt',
  ReceiptTypeEnum.paymentReceipt: 'paymentReceipt',
};
