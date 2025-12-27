import 'dart:convert';

import 'package:aladdin_franchise/src/configs/api.dart';
import 'package:aladdin_franchise/src/configs/enums/app_log_action.dart';
import 'package:aladdin_franchise/src/core/network/api/app_exception.dart';
import 'package:aladdin_franchise/src/core/network/api/safe_call_api.dart';
import 'package:aladdin_franchise/src/core/network/repository/coupon/coupon_repository.dart';
import 'package:aladdin_franchise/src/core/network/repository/responses/apply_policy.dart';
import 'package:aladdin_franchise/src/core/network/repository/responses/coupon.dart';
import 'package:aladdin_franchise/src/core/network/api/rest_client.dart';
import 'package:aladdin_franchise/src/core/storages/local.dart';
import 'package:aladdin_franchise/src/data/enum/discount_type.dart';
import 'package:aladdin_franchise/src/data/model/discount/voucher.dart';
import 'package:aladdin_franchise/src/models/customer/customer.dart';
import 'package:aladdin_franchise/src/models/customer/customer_policy.dart';
import 'package:aladdin_franchise/src/models/error_log.dart';
import 'package:aladdin_franchise/src/models/order.dart';
import 'package:aladdin_franchise/src/models/product_checkout.dart';

class CouponRepositoryImpl extends CouponRepository {
  final RestClient _client;

  CouponRepositoryImpl(this._client);

  @override
  Future<CouponResponseData> addCoupon({
    required String code,
    required OrderModel order,
    required double totalOrder,
    required int numberOfAdults,
  }) async {
    final api = "${ApiConfig.apiUrl}/api/v1/mock-api-coupon";
    final loginData = LocalStorage.getDataLogin();
    final body = jsonEncode(<String, dynamic>{
      "code": code,
      "restaurant": loginData?.restaurant?.id,
      "order_id": order.id,
      "total_order": totalOrder,
      "numberOfAdults": numberOfAdults,
    });
    var result = await safeCallApi(
      () {
        final url = Uri.parse(api);
        return _client.post(url, body: body);
      },
      wrapperResponse: true,
      parser: (json) => CouponResponseData.fromJson(json),
      log: ErrorLogModel(
        action: AppLogAction.addCoupon,
        api: api,
        order: order,
        request: body,
      ),
    );
    if (!result.isSuccess) {
      throw AppException(
        statusCode: result.statusCode,
        message: result.error,
      );
    }
    return result.data ??
        const CouponResponseData(
          status: 200,
          data: [],
        );
  }

  @override
  Future<bool> deleteCoupon({required String idCode, required OrderModel order}) async {
    final apiUrl = "${ApiConfig.apiUrl}/api/v1/mock-api-block-coupon";
    final body = jsonEncode(<String, dynamic>{
      "id": idCode,
      "order_id": order.id,
    });
    var result = await safeCallApi(
      () {
        final url = Uri.parse(apiUrl);
        return _client.post(url, body: body);
      },
      ignoreCheckStatus: true,
      parser: (json) => true,
      log: ErrorLogModel(
        action: AppLogAction.deleteCoupon,
        api: apiUrl,
        order: order,
        request: body,
      ),
    );
    if (!result.isSuccess) {
      throw AppException(
        statusCode: result.statusCode,
        message: result.error,
      );
    }
    return result.data ?? false;
  }

  @override
  Future<ApplyPolicyResponseData> applyPolicy({
    required List<CustomerPolicyModel> coupons,
    required List<CustomerPolicyModel> customerPolicy,
    required List<ProductCheckoutModel> products,
    required OrderModel order,
    CustomerModel? customer,
    required double totalOrder,
    required int pointUseToMoney,
    required int numberOfAdults,
  }) async {
    final apiUrl = "${ApiConfig.apiUrl}/api/v1/mock-api-policy";
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
                    amount: pointUseToMoney * 1.0,
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
    var result = await safeCallApi(
      () {
        final url = Uri.parse(apiUrl);
        return _client.post(url, body: body);
      },
      wrapperResponse: true,
      parser: (json) => ApplyPolicyResponseData.fromJson(json),
      log: ErrorLogModel(
        action: AppLogAction.applyPolicy,
        api: apiUrl,
        order: order,
        request: body,
      ),
    );
    if (!result.isSuccess) {
      throw AppException(
        statusCode: result.statusCode,
        message: result.error,
      );
    }

    return result.data ??
        const ApplyPolicyResponseData(
          status: 200,
          data: [],
          dataCreateVouchers: null,
        );
  }

  @override
  Future<VoucherModel> addVoucher({
    required OrderModel order,
    required double amount,
    required double totalBill,
    required DiscountTypeEnum type,
  }) async {
    var apiUrl = "${ApiConfig.apiUrl}/api/v1/calculate-discount-code";
    final loginData = LocalStorage.getDataLogin();
    final body = jsonEncode(<String, dynamic>{
      "restaurant_id": loginData?.restaurant?.id,
      "order_id": order.id,
      "amount": type == DiscountTypeEnum.percent ? amount.toInt() : amount,
      "total_bill": totalBill,
      "type": type.key,
    });
    var result = await safeCallApi(
      () {
        final url = Uri.parse(apiUrl);
        return _client.post(url, body: body);
      },
      dataKey: 'data',
      parser: (json) => VoucherModel.fromJson(json),
      log: ErrorLogModel(
        action: AppLogAction.addVoucher,
        api: apiUrl,
        order: order,
        request: body,
      ),
    );
    if (!result.isSuccess) {
      throw AppException(
        statusCode: result.statusCode,
        message: result.error,
      );
    }

    return result.data ?? const VoucherModel();
  }

  @override
  Future<void> deleteVoucher(dynamic id) async {
    var apiUrl = "${ApiConfig.apiUrl}/api/v1/delete-voucher";
    final body = jsonEncode(<String, dynamic>{"voucher_id": id});
    var result = await safeCallApi(
      () {
        final url = Uri.parse(apiUrl);
        return _client.post(url, body: body);
      },
      log: ErrorLogModel(
        action: AppLogAction.deleteVoucher,
        api: apiUrl,
        request: body,
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
