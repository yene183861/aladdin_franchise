import 'dart:convert';

import 'package:aladdin_franchise/src/configs/api.dart';
import 'package:aladdin_franchise/src/configs/enums/app_log_action.dart';
import 'package:aladdin_franchise/src/core/network/api/app_exception.dart';
import 'package:aladdin_franchise/src/core/network/api/safe_call_api.dart';
import 'package:aladdin_franchise/src/core/network/repository/customer/customer_repository.dart';
import 'package:aladdin_franchise/src/core/network/repository/responses/customer.dart';
import 'package:aladdin_franchise/src/core/network/api/rest_client.dart';
import 'package:aladdin_franchise/src/core/network/repository/responses/customer_create.dart';
import 'package:aladdin_franchise/src/core/storages/local.dart';
import 'package:aladdin_franchise/src/models/error_log.dart';
import 'package:aladdin_franchise/src/models/order.dart';

class CustomerRepositoryImpl extends CustomerRepository {
  final RestClient _client;

  CustomerRepositoryImpl(this._client);

  @override
  Future<CustomerResponseData> findCustomer(
      {required String phoneNumber, required OrderModel order}) async {
    var apiUrl = "${ApiConfig.apiUrl}/api/v1/mock-api-promotion";

    final loginData = LocalStorage.getDataLogin();
    final body = jsonEncode(<String, dynamic>{
      "phone_number": phoneNumber,
      "restaurant_id": loginData?.restaurant?.id,
      "order_id": order.id,
    });
    var result = await safeCallApi(
      () {
        final url = Uri.parse(apiUrl);
        return _client.post(url, body: body);
      },
      wrapperResponse: true,
      parser: (json) => CustomerResponseData.fromJson(json),
      log: ErrorLogModel(
        action: AppLogAction.findCustomer,
        api: apiUrl,
        request: body,
        order: order,
      ),
    );
    if (!result.isSuccess) {
      throw AppException(
        statusCode: result.statusCode,
        message: result.error,
      );
    }
    return result.data ?? const CustomerResponseData(status: 200, customer: null, data: []);
  }

  @override
  Future<bool> createCustomer({
    required String phone,
    required String firstName,
    required String lastName,
    required String birthday,
    required OrderModel order,
    required String? gender,
    String? idCardNumber,
    String? address,
  }) async {
    var apiUrl = "${ApiConfig.apiUrl}/api/v1/mock-api-customer";
    final body = jsonEncode(<String, dynamic>{
      "phone": phone,
      "first_name": firstName,
      "last_name": lastName,
      "birthday": birthday.isEmpty ? "0" : birthday,
      "gender": gender,
      "id_card_number": idCardNumber,
      "address": address,
      "order_id": order.id,
    });
    var result = await safeCallApi(
      () {
        final url = Uri.parse(apiUrl);
        return _client.post(url, body: body);
      },
      wrapperResponse: true,
      parser: (json) {
        CustomerCreateResponseData.fromJson(json);
        return true;
      },
      log: ErrorLogModel(
        action: AppLogAction.createCustomer,
        api: apiUrl,
        request: body,
        order: order,
      ),
    );
    if (!result.isSuccess) {
      throw AppException(
        statusCode: result.statusCode,
        message: result.error,
      );
    }
    return true;
  }

  @override
  Future<void> deleteCustomer(int orderId) async {
    var apiUrl = "${ApiConfig.apiUrl}/api/v1/status-lock-order?order_id=$orderId";
    var result = await safeCallApi(
      () {
        final url = Uri.parse(apiUrl);
        return _client.get(url);
      },
      log: ErrorLogModel(
        action: AppLogAction.resetCustomer,
        api: apiUrl,
        order: OrderModel(id: orderId),
      ),
    );
    if (!result.isSuccess) {
      throw AppException(
        statusCode: result.statusCode,
        message: result.error,
      );
    }
  }
}
