import 'package:aladdin_franchise/src/models/customer/customer_policy.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'customer.freezed.dart';
part 'customer.g.dart';

@freezed
class CustomerResponse with _$CustomerResponse {
  @JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
  const factory CustomerResponse({
    required CustomerResponseData data,
  }) = _CustomerResponse;

  factory CustomerResponse.fromJson(Map<String, dynamic> json) =>
      _$CustomerResponseFromJson(json);

  static String getModelInterface() {
    return '''required CustomerResponseData data,
    ---
    CustomerResponseData{
      required int status,
      required dynamic customer,
      required List<CustomerPolicyModel>? data,
      ---
      CustomerPolicyModel{
        required String id,
        required String name,
        required int? type,
        required List<DiscountPolicy> discount,
        ---
        DiscountPolicy{
          String? id,
          String? name,
          required int type,
          required int amount,
        }
        ---
        CustomerModel{
          required dynamic id,
          required String name,
          required String phoneNumber,
          required String? dob,
          required int? point,
          required String? level,
          required int? exchange,
        }
      }
    }
    ''';
  }
}

@freezed
class CustomerResponseData with _$CustomerResponseData {
  @JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
  const factory CustomerResponseData({
    required int status,
    required dynamic customer,
    required List<CustomerPolicyModel>? data,
  }) = _CustomerResponseData;

  factory CustomerResponseData.fromJson(Map<String, dynamic> json) =>
      _$CustomerResponseDataFromJson(json);
}
