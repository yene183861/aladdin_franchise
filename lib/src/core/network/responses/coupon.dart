import 'package:aladdin_franchise/src/models/customer/customer_policy.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'coupon.freezed.dart';
part 'coupon.g.dart';

@freezed
class CouponResponse with _$CouponResponse {
  @JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
  const factory CouponResponse({
    required CouponResponseData data,
  }) = _CouponResponse;

  factory CouponResponse.fromJson(Map<String, dynamic> json) =>
      _$CouponResponseFromJson(json);

  static String getModelInterface() {
    return '''required CouponResponseData data,
    CouponResponseData{
      required int status,
      required List<CustomerPolicyModel> data,
      ---
      CustomerPolicyModel{
        ${CustomerPolicyModel.getModelInterface()}
        ---
        DiscountPolicy{
          ${DiscountPolicy.getModelInterface()}
        }
      }
    }
    ''';
  }
}

@freezed
class CouponResponseData with _$CouponResponseData {
  @JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
  const factory CouponResponseData({
    required int status,
    required List<CustomerPolicyModel> data,
    @Default("") String message,
  }) = _CouponResponseData;

  factory CouponResponseData.fromJson(Map<String, dynamic> json) =>
      _$CouponResponseDataFromJson(json);
}
