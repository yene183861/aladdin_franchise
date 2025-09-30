import 'package:aladdin_franchise/src/core/network/responses/coupon.dart';
import 'package:aladdin_franchise/src/models/order.dart';

/// Author: sondv
/// Created 08/11/2023 at 08:17

abstract class CouponRepository {
  /// Success => CouponRepository
  ///
  /// Error => Exception
  Future<CouponResponse> getCouponByCode({
    required String code,
    required OrderModel order,
    required double totalOrder,
    required int numberOfAdults,
  });

  /// Success => true
  ///
  /// Error => Exception
  Future<bool> unblockCouponCode({
    required String idCode,
    required OrderModel order,
  });
}
