import 'package:aladdin_franchise/src/core/network/api/safe_call_api.dart';
import 'package:aladdin_franchise/src/core/network/repository/responses/apply_policy.dart';
import 'package:aladdin_franchise/src/core/network/repository/responses/coupon.dart';
import 'package:aladdin_franchise/src/data/enum/discount_type.dart';
import 'package:aladdin_franchise/src/data/model/discount/voucher.dart';
import 'package:aladdin_franchise/src/models/customer/customer.dart';
import 'package:aladdin_franchise/src/models/customer/customer_policy.dart';
import 'package:aladdin_franchise/src/models/order.dart';
import 'package:aladdin_franchise/src/models/product_checkout.dart';

abstract class CouponRepository {
  /// checked
  Future<ApiResult<CouponResponseData>> addCoupon({
    required String code,
    required OrderModel order,
    required double totalOrder,
    required int numberOfAdults,
  });

  /// checked
  Future<ApiResult<bool>> deleteCoupon({
    required String idCode,
    required OrderModel order,
  });

  /// checked
  Future<ApiResult<ApplyPolicyResponseData>> applyPolicy({
    required List<CustomerPolicyModel> coupons,
    required List<CustomerPolicyModel> customerPolicy,
    required List<ProductCheckoutModel> products,
    required OrderModel order,
    CustomerModel? customer,
    required double totalOrder,
    required int pointUseToMoney,
    required int numberOfAdults,
  });

  /// checked
  Future<ApiResult<VoucherModel>> addVoucher({
    required OrderModel order,
    required double amount,
    required double totalBill,
    required DiscountTypeEnum type,
  });

  /// checked
  Future<ApiResult<void>> deleteVoucher(dynamic id);
}
