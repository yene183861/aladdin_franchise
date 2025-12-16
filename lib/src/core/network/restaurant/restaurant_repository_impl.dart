import 'dart:convert';

import 'package:aladdin_franchise/src/configs/api.dart';
import 'package:aladdin_franchise/src/configs/app.dart';
import 'package:aladdin_franchise/src/configs/enums/app_log_action.dart';
import 'package:aladdin_franchise/src/core/network/app_exception.dart';
import 'package:aladdin_franchise/src/core/network/responses/payment_method.dart';
import 'package:aladdin_franchise/src/core/network/responses/payment_qr_code/banks.dart';
import 'package:aladdin_franchise/src/core/network/responses/process_order.dart';
import 'package:aladdin_franchise/src/core/network/rest_client.dart';
import 'package:aladdin_franchise/src/core/network/restaurant/restaurant_repository.dart';
import 'package:aladdin_franchise/src/core/services/send_log/log_service.dart';
import 'package:aladdin_franchise/src/core/storages/local.dart';
import 'package:aladdin_franchise/src/models/atm_pos.dart';
import 'package:aladdin_franchise/src/models/employee_sale.dart';
import 'package:aladdin_franchise/src/models/error_log.dart';
import 'package:aladdin_franchise/src/models/history_order.dart';
import 'package:aladdin_franchise/src/models/param_family/bank_param.dart';
import 'package:aladdin_franchise/src/models/payment_method/payment_method.dart';
import 'package:aladdin_franchise/src/models/user_bank.dart';
import 'package:aladdin_franchise/src/utils/app_helper.dart';
import 'package:aladdin_franchise/src/utils/app_log.dart';
import 'package:aladdin_franchise/src/utils/date_time.dart';
import 'package:http/http.dart' as http;

class RestaurantRepositoryImpl extends RestaurantRepository {
  @override
  Future<List<UserBankModel>> getBanks(ApiBankParam apiBankParam) async {
    var log = const ErrorLogModel(action: AppLogAction.getBanks);
    try {
      var loginData = LocalStorage.getDataLogin();
      final restaurantId = loginData?.restaurant?.id;
      final apiUrl = "${ApiConfig.getBankPayment}?restaurant_id=$restaurantId"
          "&order_id=${apiBankParam.orderDataBill.id}"
          "&table_name=${apiBankParam.orderDataBill.tableName}"
          "&total_bill=${apiBankParam.priceFinal}";
      log = log.copyWith(api: apiUrl);

      var response = await restClient.get(Uri.parse(apiUrl));
      log = log.copyWith(
        response: [response.statusCode, response.body],
      );
      if (response.statusCode == NetworkCodeConfig.ok) {
        var bodyJson = jsonDecode(response.body);
        final resData = BankPaymentResponse.fromJson(bodyJson);
        return resData.data;
      } else {
        throw AppException.fromStatusCode(response.statusCode);
      }
    } catch (ex) {
      showLog(ex.toString(), flags: 'getBanks ex');
      LogService.sendLogs(log.copyWith(errorMessage: ex.toString(), createAt: DateTime.now()));

      if (ex is AppException) rethrow;
      throw AppException(message: ex.toString());
    }
  }

  @override
  Future<List<PaymentMethod>> getPaymentMethod({
    required int orderId,
  }) async {
    final makeDeviceId = LocalStorage.getMakeDeviceId();
    final apiUrl = "${ApiConfig.getPaymentMethod}"
        "?order_id=$orderId"
        "&device_id=$makeDeviceId";
    var log = ErrorLogModel(
      action: AppLogAction.getPaymentMethod,
      api: apiUrl,
    );
    try {
      var response = await restClient.get(Uri.parse(apiUrl));
      log = log.copyWith(
        response: [response.statusCode, response.body],
      );
      if (response.statusCode == NetworkCodeConfig.ok) {
        final bodyJson = jsonDecode(response.body);
        final resData = PaymentMethodResponse.fromJson(bodyJson);
        return resData.data;
      } else {
        throw AppException.fromStatusCode(response.statusCode);
      }
    } catch (ex) {
      showLog(ex.toString(), flags: 'getPaymentMethod ex');
      LogService.sendLogs(log.copyWith(errorMessage: ex.toString(), createAt: DateTime.now()));

      if (ex is AppException) rethrow;
      throw AppException(message: ex.toString());
    }
  }

  @override
  Future<({String? url, String? qr, int? expiryMin, String? message, int? status})>
      getPaymentGateway({
    required ApiBankParam apiBankParam,
    required int keyPaymentMethod,
  }) async {
    //return "https://newsandbox.payoo.com.vn/v2/paynow/prepare?_token=1ePupay5CD3";
    var log = const ErrorLogModel(action: AppLogAction.getPaymentGateway);
    try {
      final loginData = LocalStorage.getDataLogin();
      final restaurantId = loginData?.restaurant?.id;
      final apiUrl = "${ApiConfig.getPaymentGateway}?"
          "payment_method=$keyPaymentMethod"
          "&restaurant_id=$restaurantId"
          "&order_id=${apiBankParam.orderDataBill.id}"
          "&table_name=${apiBankParam.orderDataBill.tableName}"
          "&total_bill=${apiBankParam.priceFinal}";
      log = log.copyWith(api: apiUrl);

      final response = await restClient.get(
        Uri.parse(apiUrl),
      );
      log = log.copyWith(
        response: [response.statusCode, response.body],
      );
      if (response.statusCode == NetworkCodeConfig.ok) {
        final data = jsonDecode(response.body);
        // Response: {status: 200, data: {"gateway_url": "https://newsandbox.payoo.com....", "qr": ""}}
        final String? url = data['data']?['gateway_url'];
        final String? qr = data['data']?['qr'];
        final int? expiryMin = data['data']?['expiry_min'];
        final String? message = data['message'];
        final int? status = data['status'];
        return (url: url, qr: qr, expiryMin: expiryMin, message: message, status: status);
      } else {
        throw AppException.fromStatusCode(response.statusCode);
      }
    } catch (ex) {
      showLog(ex, flags: 'Error getPaymentGateway');
      LogService.sendLogs(log.copyWith(errorMessage: ex.toString(), createAt: DateTime.now()));

      if (ex is AppException) rethrow;
      throw AppException(message: ex.toString());
    }
  }

  @override
  Future<List<AtmPosModel>> getListAtmPos({
    required int orderId,
    required dynamic totalBill,
  }) async {
    var log = const ErrorLogModel(action: AppLogAction.getListAtmPos);
    try {
      final apiUrl = ApiConfig.getListAtmPos;

      var bodyRequest = jsonEncode({
        'order_id': orderId,
        'total_bill': totalBill,
      });
      log = log.copyWith(api: apiUrl, request: bodyRequest);
      final response = await restClient.post(Uri.parse(apiUrl), body: bodyRequest);

      log = log.copyWith(
        response: [response.statusCode, response.body],
      );
      if (response.statusCode == NetworkCodeConfig.ok) {
        final data = jsonDecode(response.body);
        return (data['data'] as List).map((e) => AtmPosModel.fromJson(e)).toList();
      } else {
        throw AppException.fromStatusCode(response.statusCode);
      }
    } catch (ex) {
      showLog(ex.toString(), flags: 'getListAtmPos ex');
      LogService.sendLogs(log.copyWith(errorMessage: ex.toString(), createAt: DateTime.now()));

      if (ex is AppException) rethrow;
      throw AppException(message: ex.toString());
    }
  }

  @override
  Future<void> atmPosCallback({
    required String urlPos,
    // tổng tiền cuối ? (thấy note trên posman vậy)
    required dynamic orderId,
  }) async {
    var log = const ErrorLogModel(action: AppLogAction.posCallback);
    try {
      final apiUrl = ApiConfig.atmPosCallback;
      var bodyRequest = jsonEncode({
        'urlPos': urlPos,
        'orderId': orderId,
      });
      log = log.copyWith(api: apiUrl, request: bodyRequest);
      await AppHelper.initTokenAndTypeOrder();
      var defaultHeaders = <String, String>{
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $kToken',
        'x-status-order': '$kTypeOrder',
        'x-location': kAppLanguageLocal,
        'x-device-id': kDeviceId,
      };

      var response =
          await http.Client().post(Uri.parse(apiUrl), headers: defaultHeaders, body: bodyRequest);

      log = log.copyWith(response: [response.statusCode, response.body]);
      if (response.statusCode == NetworkCodeConfig.ok) {
        return;
      } else {
        showLog(jsonDecode(response.body), flags: 'response posCallback');

        var error = jsonDecode(response.body)['message'];
        if (error != null) {
          throw AppException.fromMessage(error);
        }
        throw AppException.fromStatusCode(response.statusCode);
      }
    } catch (ex) {
      showLog(ex.toString(), flags: 'atmPosCallback ex');
      LogService.sendLogs(log.copyWith(errorMessage: ex.toString(), createAt: DateTime.now()));

      if (ex is AppException) rethrow;
      throw AppException(message: ex.toString());
    }
  }

  @override
  Future<List<EmployeeSaleModel>> getEmployeeSales() async {
    var log = const ErrorLogModel(action: AppLogAction.getEmployeeSales);
    try {
      var restaurantId = LocalStorage.getDataLogin()?.restaurant?.id ?? -1;
      var apiUrl = '${ApiConfig.getEmployeeSales}?restaurant_id=$restaurantId';
      log = log.copyWith(api: apiUrl);

      final response = await restClient.get(Uri.parse(apiUrl));

      log = log.copyWith(
        response: [response.statusCode, response.body],
      );
      if (response.statusCode == NetworkCodeConfig.ok) {
        var body = jsonDecode(response.body);
        if (body['status'] != 200) {
          throw AppException.fromStatusCode(body['status']);
        }
        return (jsonDecode(response.body)['data'] as List)
            .map((e) => EmployeeSaleModel.fromJson(e))
            .toList();
      } else {
        throw AppException.fromStatusCode(response.statusCode);
      }
    } catch (ex) {
      showLog(ex.toString(), flags: 'getEmployeeSales ex');
      LogService.sendLogs(log.copyWith(errorMessage: ex.toString(), createAt: DateTime.now()));

      if (ex is AppException) rethrow;
      throw AppException(message: ex.toString());
    }
  }

  @override
  Future<List<HistoryOrderModel>> getOrderHistoryList({
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    var api =
        '${ApiConfig.historyOrder}?restaurant_id=${LocalStorage.getDataLogin()?.restaurant?.id}'
        '&start_date=${DateTimeUtils.formatToString(time: startDate, newPattern: 'yyyy-MM-dd')}'
        '&end_date=${DateTimeUtils.formatToString(time: endDate, newPattern: 'yyyy-MM-dd')}';
    var log = ErrorLogModel(
      action: AppLogAction.historyOrder,
      api: api,
      modelInterface: ProcessOrderResponse.getModelInterface(),
    );
    try {
      final response = await restClient.get(Uri.parse(api));
      log = log.copyWith(
        response: [response.statusCode, response.body],
      );

      if (response.statusCode == NetworkCodeConfig.ok) {
        var data = jsonDecode(response.body)['data']['data_histories'];
        return (data as List).map((e) => HistoryOrderModel.fromJson(e)).toList();
      } else {
        throw AppException.fromStatusCode(response.statusCode);
      }
    } catch (ex) {
      showLog(ex.toString(), flags: 'getOrderHistoryList ex');
      LogService.sendLogs(log.copyWith(errorMessage: ex.toString(), createAt: DateTime.now()));

      if (ex is AppException) rethrow;
      throw AppException(message: ex.toString());
    }
  }
}
