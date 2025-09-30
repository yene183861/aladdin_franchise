import 'dart:convert';

import 'package:aladdin_franchise/generated/l10n.dart';
import 'package:aladdin_franchise/src/configs/api.dart';
import 'package:aladdin_franchise/src/configs/app.dart';
import 'package:aladdin_franchise/src/configs/data_fake.dart';
import 'package:aladdin_franchise/src/configs/enums/app_log_action.dart';
import 'package:aladdin_franchise/src/core/network/app_exception.dart';
import 'package:aladdin_franchise/src/core/network/coupon/coupon_repository.dart';
import 'package:aladdin_franchise/src/core/network/responses/coupon.dart';
import 'package:aladdin_franchise/src/core/network/rest_client.dart';
import 'package:aladdin_franchise/src/core/services/send_log/discord_service.dart';
import 'package:aladdin_franchise/src/core/services/send_log/log_service.dart';
import 'package:aladdin_franchise/src/core/services/send_log/telegram_service.dart';
import 'package:aladdin_franchise/src/core/storages/local.dart';
import 'package:aladdin_franchise/src/models/customer/customer_policy.dart';
import 'package:aladdin_franchise/src/models/error_log.dart';
import 'package:aladdin_franchise/src/models/order.dart';
import 'package:aladdin_franchise/src/utils/app_log.dart';
import 'package:http/http.dart';

/// Author: sondv
/// Created 08/11/2023 at 08:18

class CouponRepositoryImpl extends CouponRepository {
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
  Future<CouponResponse> getCouponByCode({
    required String code,
    required OrderModel order,
    required double totalOrder,
    required int numberOfAdults,
  }) async {
    var apiUrl = ApiConfig.getCouponByCode;
    var log = ErrorLogModel(
      action: AppLogAction.getCouponByCode,
      api: apiUrl,
      modelInterface: CouponResponse.getModelInterface(),
      order: order,
    );
    try {
      if (useDataFake) {
        await delayFunc();
        return CouponResponse(
            data: CouponResponseData(
          status: 200,
          data: [
            // CustomerPolicyModel(
            //   id: '1',
            //   name: code.trim().toUpperCase(),
            //   conditionApplyMessage: [
            //     'Áp dụng cho test',

            //   ],
            //   discount: [
            //     DiscountPolicy(type: type, amount: amount)
            //   ],
            // ),
          ],
        ));
      }
      final loginData = LocalStorage.getDataLogin();
      final body = jsonEncode(<String, dynamic>{
        "code": code,
        "restaurant": loginData?.restaurant?.id,
        "order_id": order.id,
        "total_order": totalOrder,
        "numberOfAdults": numberOfAdults,
      });
      final response = await restClient.post(
        Uri.parse(ApiConfig.getCouponByCode),
        body: body,
      );
      log = log.copyWith(
        request: body,
        response: [response.statusCode, response.body],
      );
      if (response.statusCode == NetworkCodeConfig.ok) {
        final jsonRes = jsonDecode(response.body);
        final result = CouponResponse.fromJson(jsonRes);
        return result;
      } else {
        _throwLockedOrder(response);
        throw AppException.fromHttpResponse(response);
      }
    } catch (ex) {
      showLog(ex, flags: "getCouponByCode");
      LogService.sendLogs(
          log.copyWith(errorMessage: ex.toString(), createAt: DateTime.now()));

      if (ex is AppException) rethrow;
      throw AppException(message: ex.toString());
    }
  }

  @override
  Future<bool> unblockCouponCode(
      {required String idCode, required OrderModel order}) async {
    final apiUrl = ApiConfig.unlockCouponCode;
    var log = ErrorLogModel(
      action: AppLogAction.unblockCouponCode,
      api: apiUrl,
      modelInterface: 'bool',
      order: order,
    );
    try {
      final body = jsonEncode(<String, dynamic>{
        "id": idCode,
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
      _throwLockedOrder(response);
      // if (response.statusCode == NetworkCodeConfig.locked) {
      //   throw AppException.fromMessage("Đơn bàn đã bị khoá thao tác do đang mở phiếu thanh toán!");
      // }
      if (response.statusCode == NetworkCodeConfig.ok) {
        return true;
      } else {
        throw AppException.fromHttpResponse(response);
      }
    } catch (ex) {
      showLog(ex, flags: "unblockCouponCode");
      LogService.sendLogs(
          log.copyWith(errorMessage: ex.toString(), createAt: DateTime.now()));

      if (ex is AppException) rethrow;
      throw AppException(message: ex.toString());
    }
  }
}
