// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'policy_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PolicyResultModelImpl _$$PolicyResultModelImplFromJson(
        Map<String, dynamic> json) =>
    _$PolicyResultModelImpl(
      name: json['name'] as String,
      total: (json['total'] as num).toDouble(),
      isType: (json['is_type'] as num?)?.toInt(),
      maxNumberSelected: (json['max_number_selected'] as num?)?.toInt() ?? 0,
      promotionItems: (json['promotion_items'] as List<dynamic>?)
              ?.map((e) => PromotionItem.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$PolicyResultModelImplToJson(
        _$PolicyResultModelImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'total': instance.total,
      'is_type': instance.isType,
      'max_number_selected': instance.maxNumberSelected,
      'promotion_items':
          instance.promotionItems.map((e) => e.toJson()).toList(),
    };

_$HistoryPolicyResultModelImpl _$$HistoryPolicyResultModelImplFromJson(
        Map<String, dynamic> json) =>
    _$HistoryPolicyResultModelImpl(
      name: json['name'] as String,
      total: (json['total'] as num?)?.toDouble() ?? 0.0,
      listUse: (json['list_use'] as List<dynamic>?)
              ?.map((e) => DiscountPolicy.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      isType: (json['is_type'] as num?)?.toInt(),
      isCombo: (json['is_combo'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$HistoryPolicyResultModelImplToJson(
        _$HistoryPolicyResultModelImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'total': instance.total,
      'list_use': instance.listUse.map((e) => e.toJson()).toList(),
      'is_type': instance.isType,
      'is_combo': instance.isCombo,
    };

_$CreateVouchersModelImpl _$$CreateVouchersModelImplFromJson(
        Map<String, dynamic> json) =>
    _$CreateVouchersModelImpl(
      idPolicy: json['id_policy'] as String,
      name: json['name'] as String,
      total: (json['total'] as num).toDouble(),
      type: (json['type'] as num).toInt(),
      orderId: (json['order_id'] as num).toInt(),
      userId: (json['user_id'] as num).toInt(),
    );

Map<String, dynamic> _$$CreateVouchersModelImplToJson(
        _$CreateVouchersModelImpl instance) =>
    <String, dynamic>{
      'id_policy': instance.idPolicy,
      'name': instance.name,
      'total': instance.total,
      'type': instance.type,
      'order_id': instance.orderId,
      'user_id': instance.userId,
    };
