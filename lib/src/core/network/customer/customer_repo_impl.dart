import 'dart:convert';

import 'package:aladdin_franchise/generated/l10n.dart';
import 'package:aladdin_franchise/src/configs/api.dart';
import 'package:aladdin_franchise/src/configs/app.dart';
import 'package:aladdin_franchise/src/configs/const.dart';
import 'package:aladdin_franchise/src/configs/enums/app_log_action.dart';
import 'package:aladdin_franchise/src/core/network/app_exception.dart';
import 'package:aladdin_franchise/src/core/network/customer/customer_repository.dart';
import 'package:aladdin_franchise/src/core/network/responses/apply_policy.dart';
import 'package:aladdin_franchise/src/core/network/responses/customer.dart';
import 'package:aladdin_franchise/src/core/network/responses/customer_create.dart';
import 'package:aladdin_franchise/src/core/network/rest_client.dart';
import 'package:aladdin_franchise/src/core/services/send_log/log_service.dart';
import 'package:aladdin_franchise/src/core/storages/local.dart';
import 'package:aladdin_franchise/src/models/customer/customer.dart';
import 'package:aladdin_franchise/src/models/customer/customer_policy.dart';
import 'package:aladdin_franchise/src/models/error_log.dart';
import 'package:aladdin_franchise/src/models/order.dart';
import 'package:aladdin_franchise/src/models/product_checkout.dart';
import 'package:aladdin_franchise/src/utils/app_log.dart';
import 'package:http/http.dart';

/// Author: sondv
/// Created 08/11/2023 at 08:25

class CustomerRepositoryImpl extends CustomerRepository {
  void _throwLockedOrder(Response response) {
    if (response.statusCode == NetworkCodeConfig.locked) {
      throw AppException(
        statusCode: response.statusCode,
        message:
            jsonDecode(response.body)['message'] ?? S.current.msg_locked_order,
      );
    }
  }

  @override
  Future<CustomerResponse> findCustomer(
      {required String phoneNumber, required OrderModel order}) async {
    var apiUrl = ApiConfig.getInfoCustomer;
    var log = ErrorLogModel(
      action: AppLogAction.findCustomer,
      api: apiUrl,
      modelInterface: CustomerResponse.getModelInterface(),
      order: order,
    );
    try {
      final loginData = LocalStorage.getDataLogin();
      final body = jsonEncode(<String, dynamic>{
        "phone_number": phoneNumber,
        "restaurant_id": loginData?.restaurant?.id,
        "order_id": order.id,
      });
      final response = await restClient.post(
        Uri.parse(apiUrl),
        body: body,
      );
      log = log.copyWith(
        response: [response.statusCode, response.body],
        request: body,
      );
      if (response.statusCode == NetworkCodeConfig.ok) {
        final jsonRes = jsonDecode(response.body);
        final result = CustomerResponse.fromJson(jsonRes);
        return result;
      } else {
        _throwLockedOrder(response);
        throw AppException.fromHttpResponse(response);
      }
    } catch (ex) {
      LogService.sendLogs(
          log.copyWith(errorMessage: ex.toString(), createAt: DateTime.now()));

      showLog(ex, flags: "findCustomer");
      if (ex is AppException) rethrow;
      throw AppException(message: ex.toString());
    }
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
    final apiUrl = ApiConfig.createCustomer;
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
    var log = ErrorLogModel(
      action: AppLogAction.createCustomer,
      api: apiUrl,
      modelInterface: "bool",
      order: order,
      request: body,
    );
    try {
      final response = await restClient.post(
        Uri.parse(apiUrl),
        body: body,
      );
      log = log.copyWith(response: [response.statusCode, response.body]);
      if (response.statusCode == NetworkCodeConfig.ok) {
        var jsonRes = jsonDecode(response.body);
        CustomerCreateResponse.fromJson(jsonRes);
        return true;
      } else {
        _throwLockedOrder(response);
        throw AppException.fromHttpResponse(response);
      }
    } catch (ex) {
      showLog(ex, flags: 'createCustomer');
      LogService.sendLogs(
          log.copyWith(errorMessage: ex.toString(), createAt: DateTime.now()));
      if (ex is AppException) rethrow;
      throw AppException(message: ex.toString());
    }
  }

  @override
  Future<ApplyPolicyResponse> applyPolicy({
    required List<CustomerPolicyModel> coupons,
    required List<CustomerPolicyModel> customerPolicy,
    required List<ProductCheckoutModel> products,
    required OrderModel order,
    CustomerModel? customer,
    required double totalOrder,
    required int pointUseToMoney,
    required int numberOfAdults,
  }) async {
    final apiUrl = ApiConfig.applyPolicy;
    var log = ErrorLogModel(
      action: AppLogAction.applyPolicy,
      api: apiUrl,
      order: order,
      modelInterface: ApplyPolicyResponse.getModelInterface(),
    );
    try {
      final loginData = LocalStorage.getDataLogin();
      if (customer == null && coupons.isNotEmpty) {
        for (final c in coupons) {
          if (c.customer != null) {
            customer = c.customer;
            break;
          }
        }
      }
      final body = jsonEncode(<String, dynamic>{
        "list_coupon": jsonEncode(coupons),
        "list_customer_policy": jsonEncode(customerPolicy),
        "list_food": jsonEncode(products),
        "point_use": pointUseToMoney > 0
            ? jsonEncode(
                CustomerPolicyModel(
                  id: 'pointuse',
                  name: 'POINTUSE',
                  type: 16,
                  discount: [
                    DiscountPolicy(
                      type: 2,
                      amount: pointUseToMoney,
                    ),
                  ],
                ),
              )
            : "",
        "order_id": order.id,
        "phone": customer?.phoneNumber ?? "",
        "customer_crm_id": customer?.id,
        "restaurant_id": loginData?.restaurant?.id,
        "total_order": totalOrder,
        "numberOfAdults": numberOfAdults,
      });
      log = log.copyWith(request: body);
      final response = await restClient.post(
        Uri.parse(apiUrl),
        body: body,
      );
      log = log.copyWith(response: [response.statusCode, response.body]);
      final Map<String, dynamic> jsonRes = jsonDecode(response.body);
      if (response.statusCode == NetworkCodeConfig.ok) {
        final data = ApplyPolicyResponse.fromJson(jsonRes);
        return data;
      } else {
        _throwLockedOrder(response);
        // Nếu response trả về có retry thì sẽ bỏ qua thử lại áp dụng mã giảm giá
        final messageResponse = jsonRes['message'];
        if (messageResponse != null) {
          throw AppException.fromMessage(
              "${jsonRes.containsKey("retry") ? kIgnoreRetryApplyPolicy : ""}$messageResponse");
        }
        // if (response.statusCode == NetworkCodeConfig.locked) {
        //   throw AppException(
        //       statusCode: response.statusCode,
        //       message: '"Tài nguyên đang được truy cập bị khóa."');
        // }
        throw AppException.fromStatusCode(response.statusCode);
      }
    } catch (ex) {
      showLogs(ex, flags: "error applyPolicy");
      LogService.sendLogs(
          log.copyWith(errorMessage: ex.toString(), createAt: DateTime.now()));
      if (ex is AppException) rethrow;
      throw AppException(message: ex.toString());
    }
  }

  @override
  Future<String> getLinkZaloOA() async {
    var apiUrl = ApiConfig.getLinkZaloOA;
    var log = ErrorLogModel(
      action: AppLogAction.getLinkZaloOA,
      api: apiUrl,
      modelInterface: 'String',
    );
    try {
      String link = '';
      var response = await restClient.get(Uri.parse(apiUrl));
      log = log.copyWith(
        response: [response.statusCode, response.body],
      );
      if (response.statusCode == NetworkCodeConfig.ok) {
        var data = jsonDecode(response.body);
        showLog(data, flags: 'getLinkZaloOA');
        // Response: {data: {status: 200, data: https://zalo.me/2655992220757318023}}
        link = data['data']['data'];
        if (link.isEmpty) {
          throw AppException.fromMessage(
              S.current.unvailable_link_registration_zalo_oa);
        }
        return link;
      } else {
        throw AppException.fromStatusCode(response.statusCode);
      }
    } catch (ex) {
      showLog(ex, flags: 'error getLinkZaloOA');
      LogService.sendLogs(
          log.copyWith(errorMessage: ex.toString(), createAt: DateTime.now()));

      if (ex is AppException) rethrow;
      throw AppException(message: ex.toString());
    }
  }
}
