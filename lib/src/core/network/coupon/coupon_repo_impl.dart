import 'dart:convert';

import 'package:aladdin_franchise/src/configs/api.dart';
import 'package:aladdin_franchise/src/configs/app.dart';
import 'package:aladdin_franchise/src/configs/const.dart';
import 'package:aladdin_franchise/src/configs/enums/app_log_action.dart';
import 'package:aladdin_franchise/src/core/network/app_exception.dart';
import 'package:aladdin_franchise/src/core/network/check_locked_order.dart';
import 'package:aladdin_franchise/src/core/network/coupon/coupon_repository.dart';
import 'package:aladdin_franchise/src/core/network/responses/apply_policy.dart';
import 'package:aladdin_franchise/src/core/network/responses/coupon.dart';
import 'package:aladdin_franchise/src/core/network/rest_client.dart';
import 'package:aladdin_franchise/src/core/services/send_log/log_service.dart';
import 'package:aladdin_franchise/src/core/storages/local.dart';
import 'package:aladdin_franchise/src/models/customer/customer.dart';
import 'package:aladdin_franchise/src/models/customer/customer_policy.dart';
import 'package:aladdin_franchise/src/models/error_log.dart';
import 'package:aladdin_franchise/src/models/order.dart';
import 'package:aladdin_franchise/src/models/product_checkout.dart';
import 'package:aladdin_franchise/src/utils/app_log.dart';

class CouponRepositoryImpl extends CouponRepository {
  // void _throwLockedOrder(Response response) {
  //   if (response.statusCode == NetworkCodeConfig.locked) {
  //     throw AppException(
  //       statusCode: response.statusCode,
  //       message: jsonDecode(response.body)['message'] ?? S.current.msg_locked_order,
  //     );
  //   }
  // }

  @override
  Future<CouponResponse> addCoupon({
    required String code,
    required OrderModel order,
    required double totalOrder,
    required int numberOfAdults,
  }) async {
    var apiUrl = ApiConfig.addCoupon;
    var log = ErrorLogModel(
      action: AppLogAction.addCoupon,
      api: apiUrl,
      modelInterface: CouponResponse.getModelInterface(),
      order: order,
    );
    try {
      final loginData = LocalStorage.getDataLogin();
      final body = jsonEncode(<String, dynamic>{
        "code": code,
        "restaurant": loginData?.restaurant?.id,
        "order_id": order.id,
        "total_order": totalOrder,
        "numberOfAdults": numberOfAdults,
      });
      log = log.copyWith(
        request: body,
      );
      final response = await restClient.post(
        Uri.parse(apiUrl),
        body: body,
      );
      log = log.copyWith(
        response: [response.statusCode, response.body],
      );
      if (response.statusCode == NetworkCodeConfig.ok) {
        final jsonRes = jsonDecode(response.body);
        final result = CouponResponse.fromJson(jsonRes);
        return result;
      } else {
        checkLockedOrder(response);
        throw AppException.fromHttpResponse(response);
      }
    } catch (ex) {
      showLog(ex, flags: "addCoupon ex");
      LogService.sendLogs(log.copyWith(errorMessage: ex.toString(), createAt: DateTime.now()));

      if (ex is AppException) rethrow;
      throw AppException(message: ex.toString());
    }
  }

  @override
  Future<bool> deleteCoupon({required String idCode, required OrderModel order}) async {
    final apiUrl = ApiConfig.deleteCoupon;
    var log = ErrorLogModel(
      action: AppLogAction.deleteCoupon,
      api: apiUrl,
      modelInterface: 'bool',
      order: order,
    );
    try {
      final body = jsonEncode(<String, dynamic>{
        "id": idCode,
        "order_id": order.id,
      });
      log = log.copyWith(
        request: body,
      );
      final response = await restClient.post(
        Uri.parse(apiUrl),
        body: body,
      );
      log = log.copyWith(
        response: [response.statusCode, response.body],
      );
      checkLockedOrder(response);

      if (response.statusCode == NetworkCodeConfig.ok) {
        return true;
      } else {
        throw AppException.fromHttpResponse(response);
      }
    } catch (ex) {
      showLog(ex, flags: "deleteCoupon ex");
      LogService.sendLogs(log.copyWith(errorMessage: ex.toString(), createAt: DateTime.now()));

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
        checkLockedOrder(response);
        // Nếu response trả về có retry thì sẽ bỏ qua thử lại áp dụng mã giảm giá
        final messageResponse = jsonRes['message'];
        if (messageResponse != null) {
          throw AppException.fromMessage(
              "${jsonRes.containsKey("retry") ? kIgnoreRetryApplyPolicy : ""}$messageResponse");
        }

        throw AppException.fromStatusCode(response.statusCode);
      }
    } catch (ex) {
      showLogs(ex, flags: "error applyPolicy");
      LogService.sendLogs(log.copyWith(errorMessage: ex.toString(), createAt: DateTime.now()));
      if (ex is AppException) rethrow;
      throw AppException(message: ex.toString());
    }
  }
}
