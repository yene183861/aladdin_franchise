import 'package:aladdin_franchise/src/core/network/repository/responses/data_bill.dart';
import 'package:aladdin_franchise/src/models/customer/customer.dart';
import 'package:aladdin_franchise/src/models/customer/customer_policy.dart';
import 'package:aladdin_franchise/src/models/product_checkout.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'detail_history_order_model.freezed.dart';

@freezed
class DetailHistoryOrderModel with _$DetailHistoryOrderModel {
  const factory DetailHistoryOrderModel({
    CustomerModel? customer,
    @Default([]) List<CustomerPolicyModel> coupons,
    @Default([]) List<ProductCheckoutModel> productCheckout,
    DataBillResponseData? dataBill,
  }) = _DetailHistoryOrderModel;
}
