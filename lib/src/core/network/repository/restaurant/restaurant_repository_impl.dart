import 'dart:convert';

import 'package:aladdin_franchise/src/configs/api.dart';
import 'package:aladdin_franchise/src/configs/app.dart';
import 'package:aladdin_franchise/src/configs/enums/app_log_action.dart';
import 'package:aladdin_franchise/src/core/network/api/safe_call_api.dart';
import 'package:aladdin_franchise/src/core/network/api/rest_client.dart';
import 'package:aladdin_franchise/src/core/network/repository/restaurant/restaurant_repository.dart';
import 'package:aladdin_franchise/src/core/storages/local.dart';
import 'package:aladdin_franchise/src/models/atm_pos.dart';
import 'package:aladdin_franchise/src/models/error_log.dart';
import 'package:aladdin_franchise/src/models/history_order.dart';
import 'package:aladdin_franchise/src/models/param_family/bank_param.dart';
import 'package:aladdin_franchise/src/models/payment_method/payment_method.dart';
import 'package:aladdin_franchise/src/models/user_bank.dart';
import 'package:aladdin_franchise/src/utils/app_helper.dart';
import 'package:aladdin_franchise/src/utils/date_time.dart';

class RestaurantRepositoryImpl extends RestaurantRepository {
  final RestClient _client;

  RestaurantRepositoryImpl(this._client);

  @override
  Future<ApiResult<List<UserBankModel>>> getBanks(ApiBankParam apiBankParam) async {
    var loginData = LocalStorage.getDataLogin();
    final apiUrl = '${ApiConfig.apiUrl}/api/v1/get-bank-information'
        '?restaurant_id=${loginData?.restaurant?.id}'
        '&order_id=${apiBankParam.orderDataBill.id}'
        '&table_name=${apiBankParam.orderDataBill.tableName}'
        '&total_bill=${apiBankParam.priceFinal}';
    return safeCallApiList(
      () async {
        final url = Uri.parse(apiUrl);
        return _client.get(url);
      },
      dataKey: 'data',
      parser: (json) => UserBankModel.fromJson(json),
      log: ErrorLogModel(
        action: AppLogAction.getBanks,
        api: apiUrl,
      ),
    );
  }

  @override
  Future<ApiResult<List<PaymentMethod>>> getPaymentMethod({
    required int orderId,
  }) async {
    final makeDeviceId = LocalStorage.getMakeDeviceId();
    final apiUrl = '${ApiConfig.apiUrl}/api/v1/get-payment-method'
        '?order_id=$orderId'
        '&device_id=$makeDeviceId';
    return safeCallApiList(
      () async {
        final url = Uri.parse(apiUrl);
        return _client.get(url);
      },
      dataKey: 'data',
      parser: (json) => PaymentMethod.fromJson(json),
      log: ErrorLogModel(
        action: AppLogAction.getPaymentMethod,
        api: apiUrl,
      ),
    );
  }

  @override
  Future<ApiResult<({String? url, String? qr, int? expiryMin, String? message, int? status})>>
      getPaymentGateway({
    required ApiBankParam apiBankParam,
    required int keyPaymentMethod,
  }) async {
    final loginData = LocalStorage.getDataLogin();
    final apiUrl = '${ApiConfig.apiUrl}/api/v2/get-payment-gateway'
        '?payment_method=$keyPaymentMethod'
        '&restaurant_id=${loginData?.restaurant?.id}'
        '&order_id=${apiBankParam.orderDataBill.id}'
        '&table_name=${apiBankParam.orderDataBill.tableName}'
        '&total_bill=${apiBankParam.priceFinal}';
    return safeCallApi(
      () async {
        final url = Uri.parse(apiUrl);
        return _client.get(url);
      },
      dataKey: 'data',
      parser: (json) {
        // Response: {status: 200, data: {"gateway_url": "https://newsandbox.payoo.com....", "qr": ""}}
        final String? url = json['data']?['gateway_url'];
        final String? qr = json['data']?['qr'];
        final int? expiryMin = json['data']?['expiry_min'];
        final String? message = json['message'];
        final int? status = json['status'];
        return (url: url, qr: qr, expiryMin: expiryMin, message: message, status: status);
      },
      log: ErrorLogModel(
        action: AppLogAction.getPaymentMethod,
        api: apiUrl,
      ),
    );
    // return (url: null, qr: null, expiryMin: null, message: null, status: null);
    //return "https://newsandbox.payoo.com.vn/v2/paynow/prepare?_token=1ePupay5CD3";
    // var log = const ErrorLogModel(action: AppLogAction.getPaymentGateway);
    // try {
    //   final loginData = LocalStorage.getDataLogin();
    //   final restaurantId = loginData?.restaurant?.id;
    //   final apiUrl = "${ApiConfig.getPaymentGateway}?"
    //       "payment_method=$keyPaymentMethod"
    //       "&restaurant_id=$restaurantId"
    //       "&order_id=${apiBankParam.orderDataBill.id}"
    //       "&table_name=${apiBankParam.orderDataBill.tableName}"
    //       "&total_bill=${apiBankParam.priceFinal}";
    //   log = log.copyWith(api: apiUrl);

    //   final response = await restClient.get(
    //     Uri.parse(apiUrl),
    //   );
    //   log = log.copyWith(
    //     response: [response.statusCode, response.body],
    //   );
    //   if (response.statusCode == NetworkCodeConfig.ok) {
    //     final data = jsonDecode(response.body);
    //     // Response: {status: 200, data: {"gateway_url": "https://newsandbox.payoo.com....", "qr": ""}}
    //     final String? url = data['data']?['gateway_url'];
    //     final String? qr = data['data']?['qr'];
    //     final int? expiryMin = data['data']?['expiry_min'];
    //     final String? message = data['message'];
    //     final int? status = data['status'];
    //     return (url: url, qr: qr, expiryMin: expiryMin, message: message, status: status);
    //   } else {
    //     throw AppException.fromStatusCode(response.statusCode);
    //   }
    // } catch (ex) {
    //   showLog(ex, flags: 'Error getPaymentGateway');
    //   LogService.sendLogs(log.copyWith(errorMessage: ex.toString(), createAt: DateTime.now()));

    //   if (ex is AppException) rethrow;
    //   throw AppException(message: ex.toString());
    // }
  }

  @override
  Future<ApiResult<List<AtmPosModel>>> getListAtmPos({
    required int orderId,
    required dynamic totalBill,
  }) async {
    final apiUrl = '${ApiConfig.apiUrl}/api/v2/list-pos';
    var body = jsonEncode({
      'order_id': orderId,
      'total_bill': totalBill,
    });
    return safeCallApiList(
      () async {
        final url = Uri.parse(apiUrl);
        return _client.post(url, body: body);
      },
      dataKey: 'data',
      parser: (json) => AtmPosModel.fromJson(json),
      log: ErrorLogModel(
        action: AppLogAction.getListAtmPos,
        api: apiUrl,
        request: body,
      ),
    );
    // var log = const ErrorLogModel(action: AppLogAction.getListAtmPos);
    // try {
    //   final apiUrl = ApiConfig.getListAtmPos;

    //   var bodyRequest = jsonEncode({
    //     'order_id': orderId,
    //     'total_bill': totalBill,
    //   });
    //   log = log.copyWith(api: apiUrl, request: bodyRequest);
    //   final response = await restClient.post(Uri.parse(apiUrl), body: bodyRequest);

    //   log = log.copyWith(
    //     response: [response.statusCode, response.body],
    //   );
    //   if (response.statusCode == NetworkCodeConfig.ok) {
    //     final data = jsonDecode(response.body);
    //     return (data['data'] as List).map((e) => AtmPosModel.fromJson(e)).toList();
    //   } else {
    //     throw AppException.fromStatusCode(response.statusCode);
    //   }
    // } catch (ex) {
    //   showLog(ex.toString(), flags: 'getListAtmPos ex');
    //   LogService.sendLogs(log.copyWith(errorMessage: ex.toString(), createAt: DateTime.now()));

    //   if (ex is AppException) rethrow;
    //   throw AppException(message: ex.toString());
    // }
  }

  @override
  Future<ApiResult<void>> atmPosCallback({
    required String urlPos,
    // tổng tiền cuối ? (thấy note trên posman vậy)
    required dynamic orderId,
  }) async {
    final apiUrl = '${ApiConfig.apiUrl}/api/v2/pos-callback';
    var body = jsonEncode({
      'urlPos': urlPos,
      'orderId': orderId,
    });
    await AppHelper.initTokenAndTypeOrder();
    var defaultHeaders = <String, String>{
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $kToken',
      'x-status-order': '$kTypeOrder',
      'x-location': kAppLanguageLocal,
      'x-device-id': kDeviceId,
    };
    return safeCallApiList(
      () async {
        final url = Uri.parse(apiUrl);
        return _client.post(
          url,
          body: body,
          headers: defaultHeaders,
        );
      },
      parser: (json) => AtmPosModel.fromJson(json),
      log: ErrorLogModel(
        action: AppLogAction.getListAtmPos,
        api: apiUrl,
        request: body,
      ),
    );
    // var log = const ErrorLogModel(action: AppLogAction.posCallback);
    // try {
    //   final apiUrl = ApiConfig.atmPosCallback;
    //   var bodyRequest = jsonEncode({
    //     'urlPos': urlPos,
    //     'orderId': orderId,
    //   });
    //   log = log.copyWith(api: apiUrl, request: bodyRequest);
    //   await AppHelper.initTokenAndTypeOrder();
    //   var defaultHeaders = <String, String>{
    //     'Content-Type': 'application/json',
    //     'Accept': 'application/json',
    //     'Authorization': 'Bearer $kToken',
    //     'x-status-order': '$kTypeOrder',
    //     'x-location': kAppLanguageLocal,
    //     'x-device-id': kDeviceId,
    //   };

    //   var response =
    //       await http.Client().post(Uri.parse(apiUrl), headers: defaultHeaders, body: bodyRequest);

    //   log = log.copyWith(response: [response.statusCode, response.body]);
    //   if (response.statusCode == NetworkCodeConfig.ok) {
    //     return;
    //   } else {
    //     showLog(jsonDecode(response.body), flags: 'response posCallback');

    //     var error = jsonDecode(response.body)['message'];
    //     if (error != null) {
    //       throw AppException.fromMessage(error);
    //     }
    //     throw AppException.fromStatusCode(response.statusCode);
    //   }
    // } catch (ex) {
    //   showLog(ex.toString(), flags: 'atmPosCallback ex');
    //   LogService.sendLogs(log.copyWith(errorMessage: ex.toString(), createAt: DateTime.now()));

    //   if (ex is AppException) rethrow;
    //   throw AppException(message: ex.toString());
    // }
  }

  @override
  Future<ApiResult<List<HistoryOrderModel>>> getOrderHistoryList({
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    final apiUrl = '${ApiConfig.apiUrl}/api/v2/order-history'
        '?restaurant_id=${LocalStorage.getDataLogin()?.restaurant?.id}'
        '&start_date=${DateTimeUtils.formatToString(time: startDate, newPattern: 'yyyy-MM-dd')}'
        '&end_date=${DateTimeUtils.formatToString(time: endDate, newPattern: 'yyyy-MM-dd')}';
    return safeCallApiList(
      () async {
        final url = Uri.parse(apiUrl);
        return _client.get(url);
      },
      wrapperResponse: true,
      dataKey: 'data_histories',
      parser: (json) => HistoryOrderModel.fromJson(json),
      log: ErrorLogModel(
        action: AppLogAction.historyOrder,
        api: apiUrl,
      ),
    );
  }
}
