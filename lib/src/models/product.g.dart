// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProductModelImpl _$$ProductModelImplFromJson(Map<String, dynamic> json) =>
    _$ProductModelImpl(
      id: (json['id'] as num).toInt(),
      categoryId: (json['category_id'] as num?)?.toInt() ?? -1,
      name: json['name'] as String? ?? '',
      language: json['language'] as Map<String, dynamic>? ?? const {},
      printerType: (json['printer_type'] as num?)?.toInt(),
      slug: json['slug'] as String?,
      menuNumber: (json['menu_number'] as num?)?.toInt(),
      unitPrice: json['unit_price'] as String? ?? "0",
      outOfStock: json['out_of_stock'] as bool? ?? false,
      internalUse: json['internal_use'] as bool? ?? false,
      discountPrice: json['discount_price'] as String?,
      unit: json['unit'] as String? ?? '',
      tax: (json['tax'] as num?)?.toDouble() ?? 0.0,
      currencyCode: json['currency_code'] as String?,
      image: json['image'] as String?,
      description: json['description'] as String?,
      numberSelecting: (json['number_selecting'] as num?)?.toInt() ?? 0,
      note: json['note'] as String?,
      tags: (json['tags'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList(),
      quantityPromotion: (json['quantity_promotion'] as num?)?.toInt() ?? 0,
      unitPriceDiscount: (json['unit_price_discount'] as num?)?.toInt() ?? 0,
      quantityDiscount: (json['quantity_discount'] as num?)?.toInt() ?? 0,
      withComboDiscount: (json['with_combo_discount'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$$ProductModelImplToJson(_$ProductModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'category_id': instance.categoryId,
      'name': instance.name,
      'language': instance.language,
      'printer_type': instance.printerType,
      'slug': instance.slug,
      'menu_number': instance.menuNumber,
      'unit_price': instance.unitPrice,
      'out_of_stock': instance.outOfStock,
      'internal_use': instance.internalUse,
      'discount_price': instance.discountPrice,
      'unit': instance.unit,
      'tax': instance.tax,
      'currency_code': instance.currencyCode,
      'image': instance.image,
      'description': instance.description,
      'number_selecting': instance.numberSelecting,
      'note': instance.note,
      'tags': instance.tags,
      'quantity_promotion': instance.quantityPromotion,
      'unit_price_discount': instance.unitPriceDiscount,
      'quantity_discount': instance.quantityDiscount,
      'with_combo_discount': instance.withComboDiscount,
    };
