import 'package:aladdin_franchise/src/models/promotion_item.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'customer/customer_policy.dart';

part 'policy_result.freezed.dart';
part 'policy_result.g.dart';

@freezed
class PolicyResultModel with _$PolicyResultModel {
  @JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
  const factory PolicyResultModel({
    required String name,
    required double total,
    int? isType,
    @Default(0) int maxNumberSelected,
    @Default([]) List<PromotionItem> promotionItems,
  }) = _PolicyResultModel;

  factory PolicyResultModel.fromJson(Map<String, dynamic> json) =>
      _$PolicyResultModelFromJson(json);

  const PolicyResultModel._();

  /// Nếu mã tặng được phép chọn sản phẩm | isType == 5
  bool isPromotion() => isType == 5;
}

@freezed
class HistoryPolicyResultModel with _$HistoryPolicyResultModel {
  @JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
  const factory HistoryPolicyResultModel({
    required String name,
    @Default(0.0) double total,
    @Default([]) List<DiscountPolicy> listUse,
    int? isType,
    int? isCombo,
  }) = _HistoryPolicyResultModel;

  factory HistoryPolicyResultModel.fromJson(Map<String, dynamic> json) =>
      _$HistoryPolicyResultModelFromJson(json);
}

@freezed
class CreateVouchersModel with _$CreateVouchersModel {
  @JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
  const factory CreateVouchersModel({
    required String idPolicy,
    required String name,
    required double total,
    required int type,
    required int orderId,
    required int userId,
  }) = _CreateVouchersModel;

  factory CreateVouchersModel.fromJson(Map<String, dynamic> json) =>
      _$CreateVouchersModelFromJson(json);
}
