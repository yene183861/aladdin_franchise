// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_bill.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PriceDataBillImpl _$$PriceDataBillImplFromJson(Map<String, dynamic> json) =>
    _$PriceDataBillImpl(
      totalPrice: json['total_price'] ?? 0,
      totalPriceVoucher: json['total_price_voucher'] ?? 0,
      totalPriceTax: json['total_price_tax'] ?? 0,
      totalPriceFinal: json['total_price_final'] ?? 0,
      receivedAmount: (json['received_amount'] as num?)?.toDouble() ?? 0,
    );

Map<String, dynamic> _$$PriceDataBillImplToJson(_$PriceDataBillImpl instance) =>
    <String, dynamic>{
      'total_price': instance.totalPrice,
      'total_price_voucher': instance.totalPriceVoucher,
      'total_price_tax': instance.totalPriceTax,
      'total_price_final': instance.totalPriceFinal,
      'received_amount': instance.receivedAmount,
    };

_$OrderDataBillImpl _$$OrderDataBillImplFromJson(Map<String, dynamic> json) =>
    _$OrderDataBillImpl(
      id: (json['id'] as num?)?.toInt() ?? -1,
      code: json['code'] as String? ?? '',
      tableName: json['table_name'] as String? ?? '',
      paymentMethod: (json['payment_method'] as num?)?.toInt(),
      amountChildren: (json['amount_children'] as num?)?.toInt() ?? 0,
      amountAdult: (json['amount_adult'] as num?)?.toInt() ?? 0,
      portrait: json['portrait'] as String?,
      numberPrintCompleted:
          (json['number_print_completed'] as num?)?.toInt() ?? 0,
      numberPrintTemporary:
          (json['number_print_temporary'] as num?)?.toInt() ?? 0,
      imageConfirms: (json['image_confirms'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      customerRatings: json['customer_ratings'] as List<dynamic>? ?? const [],
      listPaymentMethod: (json['list_payment_method'] as List<dynamic>?)
              ?.map((e) =>
                  PaymentMethodDataBill.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$OrderDataBillImplToJson(_$OrderDataBillImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'code': instance.code,
      'table_name': instance.tableName,
      'payment_method': instance.paymentMethod,
      'amount_children': instance.amountChildren,
      'amount_adult': instance.amountAdult,
      'portrait': instance.portrait,
      'number_print_completed': instance.numberPrintCompleted,
      'number_print_temporary': instance.numberPrintTemporary,
      'image_confirms': instance.imageConfirms,
      'customer_ratings': instance.customerRatings,
      'list_payment_method':
          instance.listPaymentMethod.map((e) => e.toJson()).toList(),
    };

_$PaymentMethodDataBillImpl _$$PaymentMethodDataBillImplFromJson(
        Map<String, dynamic> json) =>
    _$PaymentMethodDataBillImpl(
      keyMethod: (json['key_method'] as num?)?.toInt() ?? 0,
      method: json['method'] as String? ?? '',
      paymentAmount: (json['payment_amount'] as num?)?.toDouble() ?? 0.0,
    );

Map<String, dynamic> _$$PaymentMethodDataBillImplToJson(
        _$PaymentMethodDataBillImpl instance) =>
    <String, dynamic>{
      'key_method': instance.keyMethod,
      'method': instance.method,
      'payment_amount': instance.paymentAmount,
    };

_$LineItemDataBillImpl _$$LineItemDataBillImplFromJson(
        Map<String, dynamic> json) =>
    _$LineItemDataBillImpl(
      id: (json['id'] as num?)?.toInt() ?? -1,
      name: json['name'] as String? ?? '',
      price: json['price'] ?? 0,
      count: (json['count'] as num?)?.toInt() ?? 0,
      unit: json['unit'] as String? ?? '_',
      tax: json['tax'] ?? '',
      nameEn: json['name_en'] as String? ?? '',
      codeProduct: json['code_product'] as String? ?? '',
      listItem: (json['list_item'] as List<dynamic>?)
              ?.map((e) =>
                  SubLineItemDataBill.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$LineItemDataBillImplToJson(
        _$LineItemDataBillImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'price': instance.price,
      'count': instance.count,
      'unit': instance.unit,
      'tax': instance.tax,
      'name_en': instance.nameEn,
      'code_product': instance.codeProduct,
      'list_item': instance.listItem.map((e) => e.toJson()).toList(),
    };

_$SubLineItemDataBillImpl _$$SubLineItemDataBillImplFromJson(
        Map<String, dynamic> json) =>
    _$SubLineItemDataBillImpl(
      id: (json['id'] as num?)?.toInt() ?? -1,
      name: json['name'] as String? ?? '',
      price: json['price'],
      count: (json['count'] as num?)?.toInt() ?? 0,
      unit: json['unit'] as String? ?? '_',
      tax: json['tax'],
      type: (json['type'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$SubLineItemDataBillImplToJson(
        _$SubLineItemDataBillImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'price': instance.price,
      'count': instance.count,
      'unit': instance.unit,
      'tax': instance.tax,
      'type': instance.type,
    };

_$PaymentDataBillCheckImpl _$$PaymentDataBillCheckImplFromJson(
        Map<String, dynamic> json) =>
    _$PaymentDataBillCheckImpl(
      notes: json['notes'] as String? ?? '',
      totalPayment: (json['total_payment'] as num?)?.toDouble() ?? 0,
      paymentQrCode: (json['payment_qr_code'] as num?)?.toDouble() ?? 0,
    );

Map<String, dynamic> _$$PaymentDataBillCheckImplToJson(
        _$PaymentDataBillCheckImpl instance) =>
    <String, dynamic>{
      'notes': instance.notes,
      'total_payment': instance.totalPayment,
      'payment_qr_code': instance.paymentQrCode,
    };

_$ProductCheckoutUpdateTaxModelImpl
    _$$ProductCheckoutUpdateTaxModelImplFromJson(Map<String, dynamic> json) =>
        _$ProductCheckoutUpdateTaxModelImpl(
          menuItemId: (json['menu_item_id'] as num?)?.toInt() ?? 0,
          name: json['name'] as String? ?? '',
          unit: json['unit'] as String? ?? '',
          codeProduct: json['code_product'] as String? ?? '',
          tax: (json['tax'] as num?)?.toDouble() ?? 0,
          unitPrice: json['unit_price'] as String? ?? '',
          priceAfterDiscount:
              (json['price_after_discount'] as num?)?.toDouble() ?? 0,
          quantity: json['quantity'] as String? ?? '0',
          priceNew: (json['price_new'] as num?)?.toDouble() ?? 0,
          priceTax: (json['price_tax'] as num?)?.toDouble() ?? 0,
          total: (json['total'] as num?)?.toDouble() ?? 0,
          discount: (json['discount'] as num?)?.toDouble() ?? 0,
        );

Map<String, dynamic> _$$ProductCheckoutUpdateTaxModelImplToJson(
        _$ProductCheckoutUpdateTaxModelImpl instance) =>
    <String, dynamic>{
      'menu_item_id': instance.menuItemId,
      'name': instance.name,
      'unit': instance.unit,
      'code_product': instance.codeProduct,
      'tax': instance.tax,
      'unit_price': instance.unitPrice,
      'price_after_discount': instance.priceAfterDiscount,
      'quantity': instance.quantity,
      'price_new': instance.priceNew,
      'price_tax': instance.priceTax,
      'total': instance.total,
      'discount': instance.discount,
    };
