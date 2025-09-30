import 'package:aladdin_franchise/src/models/customer/customer.dart';
import 'package:aladdin_franchise/src/models/customer/customer_policy.dart';
import 'package:aladdin_franchise/src/models/policy_result.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'info_policy_checkout.freezed.dart';
part 'info_policy_checkout.g.dart';

@freezed
class InfoPolicyCheckoutModel with _$InfoPolicyCheckoutModel {
  @JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
  const factory InfoPolicyCheckoutModel({
    required int orderId,
    CustomerModel? customer,
    List<CustomerPolicyModel>? customerPolicies,
    List<CustomerPolicyModel>? customerPolicySelects,
    List<CustomerPolicyModel>? coupons,
    List<PolicyResultModel>? vouchers,
    dynamic createVouchers,
    double? totalDiscount,
    int? pointUse,
  }) = _InfoPolicyCheckoutModel;

  factory InfoPolicyCheckoutModel.fromJson(Map<String, dynamic> json) =>
      _$InfoPolicyCheckoutModelFromJson(json);

  const InfoPolicyCheckoutModel._();
  bool isEmpty() =>
      customer == null &&
      (customerPolicies?.isEmpty ?? true) &&
      (customerPolicySelects?.isEmpty ?? true) &&
      (coupons?.isEmpty ?? true) &&
      createVouchers.isEmpty;
}
