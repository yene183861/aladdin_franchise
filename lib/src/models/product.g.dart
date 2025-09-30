// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProductModelImpl _$$ProductModelImplFromJson(Map<String, dynamic> json) =>
    _$ProductModelImpl(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String? ?? '',
      slug: json['slug'] as String?,
      menuNumber: (json['menu_number'] as num?)?.toInt(),
      unitPrice: json['unit_price'] as String? ?? "0",
      discountPrice: json['discount_price'] as String?,
      currencyCode: json['currency_code'] as String?,
      image: json['image'] as String?,
      description: json['description'] as String?,
      numberSelecting: (json['number_selecting'] as num?)?.toInt() ?? 0,
      unit: json['unit'] as String? ?? 'unit',
      printerType: (json['printer_type'] as num?)?.toInt(),
      tax: json['tax'],
      categoryId: (json['category_id'] as num).toInt(),
      noteForProcessOrder: json['note_for_process_order'] as String?,
      tags: (json['tags'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList(),
      active: json['active'] as bool? ?? true,
      nameEn: json['name_en'] as String? ?? '',
      outOfStock: json['out_of_stock'] as bool? ?? false,
      internalUse: json['internal_use'] as bool? ?? false,
      language: json['language'] as Map<String, dynamic>? ?? const {},
      unitPriceDiscount: (json['unit_price_discount'] as num?)?.toInt() ?? 0,
      quantityDiscount: (json['quantity_discount'] as num?)?.toInt() ?? 0,
      withComboDiscount: (json['with_combo_discount'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$$ProductModelImplToJson(_$ProductModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'slug': instance.slug,
      'menu_number': instance.menuNumber,
      'unit_price': instance.unitPrice,
      'discount_price': instance.discountPrice,
      'currency_code': instance.currencyCode,
      'image': instance.image,
      'description': instance.description,
      'number_selecting': instance.numberSelecting,
      'unit': instance.unit,
      'printer_type': instance.printerType,
      'tax': instance.tax,
      'category_id': instance.categoryId,
      'note_for_process_order': instance.noteForProcessOrder,
      'tags': instance.tags,
      'active': instance.active,
      'name_en': instance.nameEn,
      'out_of_stock': instance.outOfStock,
      'internal_use': instance.internalUse,
      'language': instance.language,
    };
