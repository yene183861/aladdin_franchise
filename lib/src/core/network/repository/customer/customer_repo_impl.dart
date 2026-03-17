import 'dart:convert';

import 'package:aladdin_franchise/src/configs/api.dart';
import 'package:aladdin_franchise/src/configs/dev_config.dart';
import 'package:aladdin_franchise/src/configs/enums/app_log_action.dart';
import 'package:aladdin_franchise/src/core/network/api/app_exception.dart';
import 'package:aladdin_franchise/src/core/network/api/safe_call_api.dart';
import 'package:aladdin_franchise/src/core/network/repository/customer/customer_repository.dart';
import 'package:aladdin_franchise/src/core/network/repository/responses/customer.dart';
import 'package:aladdin_franchise/src/core/network/api/rest_client.dart';
import 'package:aladdin_franchise/src/core/network/repository/responses/customer_create.dart';
import 'package:aladdin_franchise/src/core/storages/local.dart';
import 'package:aladdin_franchise/src/models/customer/customer.dart';
import 'package:aladdin_franchise/src/models/error_log.dart';
import 'package:aladdin_franchise/src/models/order.dart';
import 'package:aladdin_franchise/src/utils/app_log.dart';

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
  Future<CustomerModel?> createCustomer({
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
      dataKey: 'data',
      parser: (json) {
        try {
          var id = json['id'];
          if (id == null) return null;
          var name = '${json['first_name'] ?? firstName} ${json['last_name'] ?? lastName}';
          var customer = CustomerModel(
            id: id,
            name: name,
            phone: json['phone'] ?? phone,
            phoneNumber: json['phone'] ?? phone,
            dob: json['birth_day'] ?? (birthday.isEmpty ? "0" : birthday),
          );
          return customer;
        } catch (ex) {
          return null;
        }
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
    return result.data;
  }

  @override
  Future<void> deleteCustomer(int orderId) async {
    bool useCoupon = DevConfig.useCoupon;
    var apiUrl = useCoupon
        ? "${ApiConfig.apiUrl}/api/v1/status-lock-order?order_id=$orderId"
        : "${ApiConfig.apiUrl}/api/v1/remove-customer-id-to-order";
    var body = jsonEncode({'order_id': orderId});
    var log = ErrorLogModel(
      action: AppLogAction.resetCustomer,
      api: apiUrl,
      order: OrderModel(id: orderId),
      request: useCoupon ? body : null,
    );
    var result = await safeCallApi(
      () {
        final url = Uri.parse(apiUrl);
        if (useCoupon) {
          return _client.get(url);
        }
        return _client.post(url, body: body);
      },
      log: log,
    );
    if (!result.isSuccess) {
      throw AppException(
        statusCode: result.statusCode,
        message: result.error,
      );
    }
  }
}
