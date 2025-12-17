import 'package:aladdin_franchise/src/core/network/repository/responses/customer.dart';
import 'package:aladdin_franchise/src/models/order.dart';

abstract class CustomerRepository {
  Future<CustomerResponse> findCustomer({required String phoneNumber, required OrderModel order});

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

  Future<void> resetCustomer({
    required int orderId,
  });
}
