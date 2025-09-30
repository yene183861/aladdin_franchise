// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_checkout.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProductCheckoutModelImpl _$$ProductCheckoutModelImplFromJson(
        Map<String, dynamic> json) =>
    _$ProductCheckoutModelImpl(
      id: (json['id'] as num).toInt(),
      quantity: (json['quantity'] as num).toInt(),
      unitPrice: json['unit_price'] as String,
      name: json['name'] as String,
      unit: json['unit'] as String,
      tax: (json['tax'] as num?)?.toDouble() ?? 0.0,
      totalOrdered: (json['total_ordered'] as num?)?.toDouble() ?? 0.0,
      quantityCancel: (json['quantity_cancel'] as num?)?.toInt() ?? 0,
      printerType: (json['printer_type'] as num?)?.toInt(),
      quantityCompleted: (json['quantity_completed'] as num?)?.toInt() ?? 0,
      cancelType:
          (json['cancel_type'] as num?)?.toInt() ?? ProductCancelType.directly,
      nameEn: json['name_en'] as String? ?? '',
      codeProduct: json['code_product'] as String? ?? '',
      language: json['language'] as Map<String, dynamic>? ?? const {},
      quantityPromotion: (json['quantity_promotion'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$$ProductCheckoutModelImplToJson(
        _$ProductCheckoutModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'quantity': instance.quantity,
      'unit_price': instance.unitPrice,
      'name': instance.name,
      'unit': instance.unit,
      'tax': instance.tax,
      'total_ordered': instance.totalOrdered,
      'quantity_cancel': instance.quantityCancel,
      'printer_type': instance.printerType,
      'quantity_completed': instance.quantityCompleted,
      'cancel_type': instance.cancelType,
      'name_en': instance.nameEn,
      'code_product': instance.codeProduct,
      'language': instance.language,
      'quantity_promotion': instance.quantityPromotion,
    };

_$ProductCheckoutHistoryModelImpl _$$ProductCheckoutHistoryModelImplFromJson(
        Map<String, dynamic> json) =>
    _$ProductCheckoutHistoryModelImpl(
      id: (json['id'] as num?)?.toInt() ?? 0,
      name: json['name'] as String? ?? '',
      nameEn: json['name_name'] as String? ?? '',
      price: json['price'] as String? ?? '',
      dollarSign: json['dollar_sign'] as String? ?? '',
      count: (json['count'] as num?)?.toInt() ?? 0,
      totalPrice: (json['total_price'] as num?)?.toDouble() ?? 0.0,
      unit: json['unit'] as String? ?? '',
      tax: json['tax'] as String? ?? '',
      codeProduct: json['code_product'] as String? ?? '',
      printerType: (json['printer_type'] as num?)?.toInt(),
      timesOrder: (json['times_order'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$ProductCheckoutHistoryModelImplToJson(
        _$ProductCheckoutHistoryModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'name_name': instance.nameEn,
      'price': instance.price,
      'dollar_sign': instance.dollarSign,
      'count': instance.count,
      'total_price': instance.totalPrice,
      'unit': instance.unit,
      'tax': instance.tax,
      'code_product': instance.codeProduct,
      'printer_type': instance.printerType,
      'times_order': instance.timesOrder,
    };
