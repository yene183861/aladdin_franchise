import 'package:aladdin_franchise/src/core/network/responses/apply_policy.dart';
import 'package:aladdin_franchise/src/core/network/responses/coupon.dart';
import 'package:aladdin_franchise/src/models/customer/customer.dart';
import 'package:aladdin_franchise/src/models/customer/customer_policy.dart';
import 'package:aladdin_franchise/src/models/order.dart';
import 'package:aladdin_franchise/src/models/product_checkout.dart';

abstract class CouponRepository {
  Future<CouponResponse> addCoupon({
    required String code,
    required OrderModel order,
    required double totalOrder,
    required int numberOfAdults,
  });

  Future<bool> deleteCoupon({
    required String idCode,
    required OrderModel order,
  });

  Future<ApplyPolicyResponse> applyPolicy({
    required List<CustomerPolicyModel> coupons,
    required List<CustomerPolicyModel> customerPolicy,
    required List<ProductCheckoutModel> products,
    required OrderModel order,
    CustomerModel? customer,
    required double totalOrder,
    required int pointUseToMoney,
    required int numberOfAdults,
  });
}
