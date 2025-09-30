import 'package:aladdin_franchise/src/core/network/responses/apply_policy.dart';
import 'package:aladdin_franchise/src/core/network/responses/customer.dart';
import 'package:aladdin_franchise/src/models/customer/customer.dart';
import 'package:aladdin_franchise/src/models/customer/customer_policy.dart';
import 'package:aladdin_franchise/src/models/order.dart';
import 'package:aladdin_franchise/src/models/product_checkout.dart';

/// Author: sondv
/// Created 08/11/2023 at 08:22

abstract class CustomerRepository {
  /// Success => CustomerRepository
  ///
  /// Error => Exception
  Future<CustomerResponse> findCustomer(
      {required String phoneNumber, required OrderModel order});

  /// Success => true
  ///
  /// Error => Exception
  Future<bool> createCustomer({
    required String phone,
    required String firstName,
    required String lastName,
    required String birthday,
    required OrderModel order,
    required String? gender,
    String? idCardNumber,
    String? address,
  });

  /// Success => ApplyPolicyRepository
  ///
  /// Error => Exception
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

  /// Lấy link đăng ký zalo OA
  Future<String> getLinkZaloOA();
}
