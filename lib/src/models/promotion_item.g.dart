// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'promotion_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PromotionItemImpl _$$PromotionItemImplFromJson(Map<String, dynamic> json) =>
    _$PromotionItemImpl(
      menuItemId: (json['menu_item_id'] as num).toInt(),
      quantity: (json['quantity'] as num).toInt(),
      idPolicy: json['id_policy'] as String,
      unitPrice: json['unit_price'] as String? ?? '0',
      name: json['name'] as String? ?? '',
      nameEn: json['name_en'] as String? ?? '',
      namePromotion: json['name_promotion'] as String? ?? '',
      nameEnPromotion: json['name_en_promotion'] as String? ?? '',
    );

Map<String, dynamic> _$$PromotionItemImplToJson(_$PromotionItemImpl instance) =>
    <String, dynamic>{
      'menu_item_id': instance.menuItemId,
      'quantity': instance.quantity,
      'id_policy': instance.idPolicy,
      'unit_price': instance.unitPrice,
      'name': instance.name,
      'name_en': instance.nameEn,
      'name_promotion': instance.namePromotion,
      'name_en_promotion': instance.nameEnPromotion,
    };
