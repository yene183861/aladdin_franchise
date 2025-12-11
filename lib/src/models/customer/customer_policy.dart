import 'dart:convert';

import 'package:aladdin_franchise/src/configs/const.dart';
import 'package:aladdin_franchise/src/models/customer/customer.dart';
import 'package:aladdin_franchise/src/models/payment_method/payment_method.dart';
import 'package:aladdin_franchise/src/models/promotion_item.dart';
import 'package:aladdin_franchise/src/utils/app_log.dart';
import 'package:aladdin_franchise/src/utils/language.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'customer_policy.freezed.dart';
part 'customer_policy.g.dart';

@freezed
class CustomerPolicyModel with _$CustomerPolicyModel {
  @JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
  const factory CustomerPolicyModel({
    required String id,
    required String name,
    int? type,
    @Default(false) bool only,
    @Default([]) @JsonKey(fromJson: parseDiscountPolicyFromJsonData) List<DiscountPolicy> discount,
    dynamic conditionApply,
    @Default([]) List<String> conditionApplyMessage,
    @JsonKey(fromJson: parseCustomerFromJsonData) CustomerModel? customer,
    @Default([]) List<PaymentMethod> paymentNotAllowed,
    @Default("") String programName,
    @Default(0) int isCombo,

    /// kiểu mã giảm:
    /// 5 - Tặng 0đ
    /// 6 - Giảm món theo số khách
    int? isType,
    @Default(0) int maxNumberSelected,
    @Default([]) List<PromotionItem> promotionItems,

    /// danh sách các sp được áp dụng của mã
    @Default([]) List<DiscountPolicy> discountCrm,
  }) = _CustomerPolicyModel;

  factory CustomerPolicyModel.fromJson(Map<String, dynamic> json) =>
      _$CustomerPolicyModelFromJson(json);

  /// Nếu mã tặng được phép chọn sản phẩm | isType == 5
  bool isPromotion() => isType == 5;

  /// Mã giảm tổng bill
  bool isTotalBill() => discount.every((element) => element.name == null);

  bool get applyComboItem => isCombo == 1;
  int get getDiscountItemsPerCustomer {
    int result = 1;
    try {
      final condition = conditionApply as Map;
      result = condition['discount_items_per_customer'] as int;
    } catch (ex) {
      //
    }
    return result <= 0 ? 1 : result;
  }

  static String getModelInterface() {
    return '''required String id,
    required String name,
    required int? type,
    bool? only,
    @Default([]) List<DiscountPolicy> discount,
    dynamic conditionApply,
    @Default([]) List<String> conditionApplyMessage,
    @JsonKey(fromJson: parseCustomerFromJsonData) CustomerModel? customer,
    @Default([]) List<PaymentMethod> paymentNotAllowed,
    @Default("") String programName,
    @Default(0) int isCombo,
    int? isType,
    @Default(0) int maxNumberSelected,
    @Default([]) List<PromotionItem> promotionItems,
    ---
    CustomerModel? parseCustomerFromJsonData(dynamic customerData)
    ''';
  }

  const CustomerPolicyModel._();
}

CustomerModel? parseCustomerFromJsonData(dynamic customerData) {
  try {
    if (customerData != null && customerData is List<dynamic> == false) {
      return CustomerModel.fromJson(customerData);
    }
    return null;
  } catch (ex) {
    rethrow;
  }
}

List<DiscountPolicy> parseDiscountPolicyFromJsonData(dynamic data) {
  try {
    if (data == null) return [];
    if (data is List) {
      return data.map((e) => DiscountPolicy.fromJson(e)).toList();
    }

    if (data is String) {
      var json = jsonDecode(data);
      return (json as List).map((e) => DiscountPolicy.fromJson(e)).toList();
    }
    return [];
  } catch (ex) {
    showLogs(ex, flags: 'parseDiscountPolicyFromJsonData ex');
    return [];
  }
}

@freezed
class DiscountPolicy with _$DiscountPolicy {
  @JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
  const factory DiscountPolicy({
    dynamic id,
    // name == null: áp dụng cho tổng bill
    // khác null => áp dụng cho sp (theo tên)
    String? name,
    int? type,
    @Default(0) double amount,
    @Default(0) int maxNumber,
    @Default('') String namePromotion,
    @Default('') String nameEnPromotion,
    @Default('') String nameZhPromotion,
    @Default(0) int numberSelect,
  }) = _DiscountPolicy;

  factory DiscountPolicy.fromJson(Map<String, dynamic> json) => _$DiscountPolicyFromJson(json);

  static String getModelInterface() {
    return '''dynamic id,
    String? name,
    required int type,
    required int amount,
    ''';
  }

  const DiscountPolicy._();

  String? getNameView({bool isPromotion = false}) {
    return !isPromotion
        ? name
        : AppLanguageUtils().getNameNormal({
            AppLanguageLocal.vietnamese: namePromotion,
            AppLanguageLocal.english: nameEnPromotion,
            AppLanguageLocal.chinese: nameZhPromotion,
          });
  }
}
