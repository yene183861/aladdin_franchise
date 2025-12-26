import 'package:aladdin_franchise/src/core/network/api/safe_call_api.dart';
import 'package:aladdin_franchise/src/core/network/repository/responses/customer.dart';
import 'package:aladdin_franchise/src/models/order.dart';

abstract class CustomerRepository {
  /// checked
  Future<ApiResult<CustomerResponseData>> findCustomer(
      {required String phoneNumber, required OrderModel order});

  /// checked
  Future<ApiResult<bool>> createCustomer({
    required String phone,
    required String firstName,
    required String lastName,
    required String birthday,
    required OrderModel order,
    required String? gender,
    String? idCardNumber,
    String? address,
  });

  /// checked
  Future<ApiResult<void>> deleteCustomer(int orderId);
}
