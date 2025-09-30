// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer_policy.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CustomerPolicyModelImpl _$$CustomerPolicyModelImplFromJson(
        Map<String, dynamic> json) =>
    _$CustomerPolicyModelImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      type: (json['type'] as num?)?.toInt(),
      only: json['only'] as bool? ?? false,
      discount: (json['discount'] as List<dynamic>?)
              ?.map((e) => DiscountPolicy.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      conditionApply: json['condition_apply'],
      conditionApplyMessage: (json['condition_apply_message'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      customer: parseCustomerFromJsonData(json['customer']),
      paymentNotAllowed: (json['payment_not_allowed'] as List<dynamic>?)
              ?.map((e) => PaymentMethod.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      programName: json['program_name'] as String? ?? "",
      isCombo: (json['is_combo'] as num?)?.toInt() ?? 0,
      isType: (json['is_type'] as num?)?.toInt(),
      maxNumberSelected: (json['max_number_selected'] as num?)?.toInt() ?? 0,
      promotionItems: (json['promotion_items'] as List<dynamic>?)
              ?.map((e) => PromotionItem.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      discountCrm: (json['discount_crm'] as List<dynamic>?)
              ?.map((e) => DiscountPolicy.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$CustomerPolicyModelImplToJson(
        _$CustomerPolicyModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'type': instance.type,
      'only': instance.only,
      'discount': instance.discount.map((e) => e.toJson()).toList(),
      'condition_apply': instance.conditionApply,
      'condition_apply_message': instance.conditionApplyMessage,
      'customer': instance.customer?.toJson(),
      'payment_not_allowed':
          instance.paymentNotAllowed.map((e) => e.toJson()).toList(),
      'program_name': instance.programName,
      'is_combo': instance.isCombo,
      'is_type': instance.isType,
      'max_number_selected': instance.maxNumberSelected,
      'promotion_items':
          instance.promotionItems.map((e) => e.toJson()).toList(),
      'discount_crm': instance.discountCrm.map((e) => e.toJson()).toList(),
    };

_$DiscountPolicyImpl _$$DiscountPolicyImplFromJson(Map<String, dynamic> json) =>
    _$DiscountPolicyImpl(
      id: json['id'],
      name: json['name'] as String?,
      type: (json['type'] as num).toInt(),
      amount: (json['amount'] as num).toInt(),
      maxNumber: (json['max_number'] as num?)?.toInt() ?? 0,
      namePromotion: json['name_promotion'] as String? ?? '',
      nameEnPromotion: json['name_en_promotion'] as String? ?? '',
      nameZhPromotion: json['name_zh_promotion'] as String? ?? '',
      numberSelect: (json['number_select'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$$DiscountPolicyImplToJson(
        _$DiscountPolicyImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'type': instance.type,
      'amount': instance.amount,
      'max_number': instance.maxNumber,
      'name_promotion': instance.namePromotion,
      'name_en_promotion': instance.nameEnPromotion,
      'name_zh_promotion': instance.nameZhPromotion,
      'number_select': instance.numberSelect,
    };
