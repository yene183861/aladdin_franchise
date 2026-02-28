import 'dart:convert';

import 'package:aladdin_franchise/src/configs/api.dart';
import 'package:aladdin_franchise/src/configs/app.dart';
import 'package:aladdin_franchise/src/configs/enums/app_log_action.dart';
import 'package:aladdin_franchise/src/core/network/api/app_exception.dart';
import 'package:aladdin_franchise/src/core/network/api/safe_call_api.dart';
import 'package:aladdin_franchise/src/core/network/api/rest_client.dart';
import 'package:aladdin_franchise/src/core/network/repository/restaurant/restaurant_repository.dart';
import 'package:aladdin_franchise/src/core/storages/local.dart';
import 'package:aladdin_franchise/src/data/enum/printer_type.dart';
import 'package:aladdin_franchise/src/data/model/o2o/o2o_config.dart';
import 'package:aladdin_franchise/src/data/model/restaurant/printer.dart';
import 'package:aladdin_franchise/src/models/atm_pos.dart';
import 'package:aladdin_franchise/src/models/error_log.dart';
import 'package:aladdin_franchise/src/models/history_order.dart';
import 'package:aladdin_franchise/src/models/param_family/bank_param.dart';
import 'package:aladdin_franchise/src/models/payment_method/payment_method.dart';
import 'package:aladdin_franchise/src/models/user_bank.dart';
import 'package:aladdin_franchise/src/utils/app_helper.dart';
import 'package:aladdin_franchise/src/utils/app_log.dart';
import 'package:aladdin_franchise/src/utils/date_time.dart';

class RestaurantRepositoryImpl extends RestaurantRepository {
  final RestClient _client;

  RestaurantRepositoryImpl(this._client);

  @override
  Future<List<UserBankModel>> getBanks(ApiBankParam apiBankParam) async {
    var loginData = LocalStorage.getDataLogin();
    final apiUrl = '${ApiConfig.apiUrl}/api/v1/get-bank-information'
        '?restaurant_id=${loginData?.restaurant?.id}'
        '&order_id=${apiBankParam.orderDataBill.id}'
        '&table_name=${apiBankParam.orderDataBill.tableName}'
        '&total_bill=${apiBankParam.priceFinal}';
    var result = await safeCallApiList(
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
    if (!result.isSuccess) {
      throw AppException(
        statusCode: result.statusCode,
        message: result.error,
      );
    }

    return result.data ?? [];
  }

  @override
  Future<List<PaymentMethod>> getPaymentMethod({
    required int orderId,
  }) async {
    final makeDeviceId = LocalStorage.getMakeDeviceId();
    final apiUrl = '${ApiConfig.apiUrl}/api/v1/get-payment-method'
        '?order_id=$orderId'
        '&device_id=$makeDeviceId';
    var result = await safeCallApiList(
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
    if (!result.isSuccess) {
      throw AppException(
        statusCode: result.statusCode,
        message: result.error,
      );
    }
    return result.data ?? [];
  }

  @override
  Future<({String? url, String? qr, int? expiryMin, String? message, int? status})>
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
    final result = await safeCallApi(
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
    if (!result.isSuccess) {
      throw AppException(
        statusCode: result.statusCode,
        message: result.error,
      );
    }
    return result.data ?? (url: null, qr: null, expiryMin: null, message: null, status: null);
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
  Future<List<AtmPosModel>> getListAtmPos({
    required int orderId,
    required dynamic totalBill,
  }) async {
    final apiUrl = '${ApiConfig.apiUrl}/api/v2/list-pos';
    var body = jsonEncode({
      'order_id': orderId,
      'total_bill': totalBill,
    });
    var result = await safeCallApiList(
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
    if (!result.isSuccess) {
      throw AppException(
        statusCode: result.statusCode,
        message: result.error,
      );
    }
    return result.data ?? [];
  }

  @override
  Future<void> atmPosCallback({
    required String urlPos,
    // tổng tiền cuối ? (thấy note trên posman vậy)
    required dynamic orderId,
  }) async {
    final apiUrl = '${ApiConfig.apiUrl}/api/v2/pos-callback';
    var body = jsonEncode({
      'urlPos': urlPos,
      'orderId': orderId,
    });

    var result = await safeCallApi(
      () async {
        final url = Uri.parse(apiUrl);
        return _client.post(url, body: body);
      },
      dataKey: 'data',
      log: ErrorLogModel(
        action: AppLogAction.posCallback,
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
    return;
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
  Future<List<HistoryOrderModel>> getOrderHistoryList({
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    final apiUrl = '${ApiConfig.apiUrl}/api/v2/order-history'
        '?restaurant_id=${LocalStorage.getDataLogin()?.restaurant?.id}'
        '&start_date=${DateTimeUtils.formatToString(time: startDate, newPattern: 'yyyy-MM-dd')}'
        '&end_date=${DateTimeUtils.formatToString(time: endDate, newPattern: 'yyyy-MM-dd')}';
    var result = await safeCallApiList(
      () async {
        final url = Uri.parse(apiUrl);
        return _client.get(url);
      },
      wrapperResponse: true,
      dataKey: 'data_histories',
      parser: (json) {
        return HistoryOrderModel.fromJson(json);
      },
      log: ErrorLogModel(
        action: AppLogAction.historyOrder,
        api: apiUrl,
      ),
    );
    if (!result.isSuccess) {
      throw AppException(
        statusCode: result.statusCode,
        message: result.error,
      );
    }
    return result.data ?? [];
  }

  @override
  Future<List<PrinterModel>> getListPrinters() async {
    final apiUrl = '${ApiConfig.apiUrl}/api/v2/printers-list';
    var result = await safeCallApiList(
      () async {
        final url = Uri.parse(apiUrl);
        return _client.get(url);
      },
      wrapperResponse: true,
      parser: (json) => PrinterModel.fromJson(json),
      log: ErrorLogModel(
        action: AppLogAction.historyOrder,
        api: apiUrl,
      ),
    );
    if (!result.isSuccess) {
      throw AppException(
        statusCode: result.statusCode,
        message: result.error,
      );
    }
    return result.data ?? [];
  }

  @override
  Future<O2oConfigModel> getO2oAutoAcceptConfig() async {
    final apiUrl = '${ApiConfig.apiUrl}/api/v1/o2o/settings/auto-confirm';
    var result = await safeCallApi(
      () async {
        final url = Uri.parse(apiUrl);
        return _client.get(url);
      },
      parser: (json) => O2oConfigModel.fromJson(json),
      log: ErrorLogModel(
        action: AppLogAction.historyOrder,
        api: apiUrl,
      ),
    );
    if (!result.isSuccess) {
      throw AppException(
        statusCode: result.statusCode,
        message: result.error,
      );
    }
    showLogs(result.data ?? const O2oConfigModel(),
        flags: ' result.data ?? const O2oConfigModel()');
    return result.data ?? const O2oConfigModel();
  }

  @override
  Future<void> setO2oAutoAcceptConfig({
    bool? isEnabled,
    int? confirmTimeout,
    bool? changePrintDeviceId = false,
  }) async {
    final apiUrl = '${ApiConfig.apiUrl}/api/v1/o2o/settings/auto-confirm';
    var body = jsonEncode({
      if (isEnabled != null) 'is_enabled': isEnabled,
      if (confirmTimeout != null) 'confirm_timeout': confirmTimeout,
      if (changePrintDeviceId != null) 'printer_device_id': changePrintDeviceId ? kDeviceId : null,
    });
    var result = await safeCallApi(
      () async {
        final url = Uri.parse(apiUrl);
        return _client.post(url, body: body);
      },
      log: ErrorLogModel(
        action: AppLogAction.historyOrder,
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

  @override
  Future<void> sendPrintData(dynamic data) async {
    final apiUrl = '${ApiConfig.apiUrl}/api/v2/broadcast-pos-print';
    var body = jsonEncode({
      'restaurant_id': LocalStorage.getDataLogin()?.restaurant?.id,
      'data': data,
    });
    var result = await safeCallApi(
      () async {
        final url = Uri.parse(apiUrl);
        return _client.post(url, body: body);
      },
      ignoreResponse: true,
      log: ErrorLogModel(
        action: AppLogAction.historyOrder,
        api: apiUrl,
        request: body,
      ),
    );
    if (!result.isSuccess) {
      showLogs(result.error, flags: 'érrror send sendPrintData');
      throw AppException(
        statusCode: result.statusCode,
        message: result.error,
      );
    }
  }
}
