import 'dart:convert';

import 'package:aladdin_franchise/src/configs/api.dart';
import 'package:aladdin_franchise/src/configs/app.dart';
import 'package:aladdin_franchise/src/configs/enums/app_log_action.dart';
import 'package:aladdin_franchise/src/core/network/api/app_exception.dart';
import 'package:aladdin_franchise/src/core/network/repository/customer/customer_repository.dart';
import 'package:aladdin_franchise/src/core/network/repository/responses/customer.dart';
import 'package:aladdin_franchise/src/core/network/repository/responses/customer_create.dart';
import 'package:aladdin_franchise/src/core/network/api/rest_client.dart';
import 'package:aladdin_franchise/src/core/services/send_log/log_service.dart';
import 'package:aladdin_franchise/src/core/storages/local.dart';
import 'package:aladdin_franchise/src/models/error_log.dart';
import 'package:aladdin_franchise/src/models/order.dart';
import 'package:aladdin_franchise/src/utils/app_log.dart';

class CustomerRepositoryImpl extends CustomerRepository {final RestClient _client;

  CustomerRepositoryImpl(this._client);
  @override
  Future<CustomerResponse> findCustomer(
      {required String phoneNumber, required OrderModel order}) async {
    return CustomerResponse(
        data: CustomerResponseData(
      status: 200,
      data: [],
      customer: null,
    ));
    // var apiUrl = ApiConfig.getInfoCustomer;
    // var log = ErrorLogModel(
    //   action: AppLogAction.findCustomer,
    //   api: apiUrl,
    //   modelInterface: CustomerResponse.getModelInterface(),
    //   order: order,
    // );
    // try {
    //   final loginData = LocalStorage.getDataLogin();
    //   final body = jsonEncode(<String, dynamic>{
    //     "phone_number": phoneNumber,
    //     "restaurant_id": loginData?.restaurant?.id,
    //     "order_id": order.id,
    //   });
    //   log = log.copyWith(request: body);
    //   final response = await restClient.post(
    //     Uri.parse(apiUrl),
    //     body: body,
    //   );
    //   log = log.copyWith(response: [response.statusCode, response.body]);
    //   if (response.statusCode == NetworkCodeConfig.ok) {
    //     final jsonRes = jsonDecode(response.body);
    //     final result = CustomerResponse.fromJson(jsonRes);
    //     return result;
    //   } else {
    //     checkLockedOrder(response);
    //     throw AppException.fromHttpResponse(response);
    //   }
    // } catch (ex) {
    //   LogService.sendLogs(log.copyWith(errorMessage: ex.toString(), createAt: DateTime.now()));

    //   showLog(ex, flags: "findCustomer ex");
    //   if (ex is AppException) rethrow;
    //   throw AppException(message: ex.toString());
    // }
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
    return true;
    // final apiUrl = ApiConfig.createCustomer;
    // final body = jsonEncode(<String, dynamic>{
    //   "phone": phone,
    //   "first_name": firstName,
    //   "last_name": lastName,
    //   "birthday": birthday.isEmpty ? "0" : birthday,
    //   "gender": gender,
    //   "id_card_number": idCardNumber,
    //   "address": address,
    //   "order_id": order.id,
    // });
    // var log = ErrorLogModel(
    //   action: AppLogAction.createCustomer,
    //   api: apiUrl,
    //   modelInterface: "bool",
    //   order: order,
    //   request: body,
    // );
    // try {
    //   final response = await restClient.post(
    //     Uri.parse(apiUrl),
    //     body: body,
    //   );
    //   log = log.copyWith(response: [response.statusCode, response.body]);
    //   if (response.statusCode == NetworkCodeConfig.ok) {
    //     var jsonRes = jsonDecode(response.body);
    //     CustomerCreateResponse.fromJson(jsonRes);
    //     return true;
    //   } else {
    //     throw AppException.fromHttpResponse(response);
    //   }
    // } catch (ex) {
    //   showLog(ex, flags: 'createCustomer ex');
    //   LogService.sendLogs(log.copyWith(errorMessage: ex.toString(), createAt: DateTime.now()));
    //   if (ex is AppException) rethrow;
    //   throw AppException(message: ex.toString());
    // }
  }

  @override
  Future<void> resetCustomer({required int orderId}) async {
    return;
    // final apiUrl = "${ApiConfig.statusLockOrder}?order_id=$orderId";
    // var log = ErrorLogModel(
    //   action: AppLogAction.resetCustomer,
    //   api: apiUrl,
    // );
    // try {
    //   final response = await restClient.get(Uri.parse(apiUrl));
    //   log = log.copyWith(
    //     response: [response.statusCode, response.body],
    //   );
    //   if (response.statusCode != 200) {
    //     checkLockedOrder(response);
    //     throw AppException.fromHttpResponse(response);
    //   }
    // } catch (ex) {
    //   showLog(ex.toString(), flags: 'resetCustomer ex');
    //   LogService.sendLogs(log.copyWith(errorMessage: ex.toString(), createAt: DateTime.now()));

    //   if (ex is AppException) rethrow;
    //   throw AppException(message: ex.toString());
    // }
  }
}
