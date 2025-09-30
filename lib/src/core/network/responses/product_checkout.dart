import 'package:aladdin_franchise/src/models/order_history.dart';
import 'package:aladdin_franchise/src/models/product_checkout.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../models/customer/customer.dart';
import '../../../models/customer/customer_policy.dart';
import '../../../models/product_cancel.dart';

part 'product_checkout.freezed.dart';
part 'product_checkout.g.dart';

@freezed
class ProductCheckoutResponse with _$ProductCheckoutResponse {
  @JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
  const factory ProductCheckoutResponse({
    required int? status,
    List<ProductCheckoutResponseData>? data,
    dynamic message,
    List<CustomerPolicyModel>? coupons,
    CustomerModel? customer,
    @Default(1) @JsonKey(name: "numberOfAdults") int numberOfAdults,
  }) = _ProductCheckoutResponse;

  factory ProductCheckoutResponse.fromJson(Map<String, dynamic> json) =>
      _$ProductCheckoutResponseFromJson(json);

  static String getModelInterface() {
    return '''
    required int? status,
    List<ProductCheckoutResponseData>? data,
    dynamic message,
    ---
    ProductCheckoutRepositoryData{
      required int id,
      required List<ProductCheckoutModel> orderItem,
      ---
      ProductCheckoutModel{
        ${ProductCheckoutModel.getModelInterface()}
      }
    }
    ''';
  }
}

@freezed
class ProductCheckoutResponseData with _$ProductCheckoutResponseData {
  @JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
  const factory ProductCheckoutResponseData({
    required int id,
    required List<ProductCheckoutModel> orderItem,
    @Default(false) bool statusCancel,
    @Default([]) List<ProductCancelModel> itemCancels,
    @Default([]) List<OrderHistory> orderHistory,
  }) = _ProductCheckoutResponseData;

  factory ProductCheckoutResponseData.fromJson(Map<String, dynamic> json) =>
      _$ProductCheckoutResponseDataFromJson(json);
}
