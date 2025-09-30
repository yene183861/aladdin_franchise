import 'dart:convert';

import 'package:aladdin_franchise/generated/l10n.dart';
import 'package:aladdin_franchise/src/configs/api.dart';
import 'package:aladdin_franchise/src/configs/app.dart';
import 'package:aladdin_franchise/src/configs/data_fake.dart';
import 'package:aladdin_franchise/src/configs/enums/app_log_action.dart';
import 'package:aladdin_franchise/src/core/network/app_exception.dart';
import 'package:aladdin_franchise/src/core/network/responses/payment_method.dart';
import 'package:aladdin_franchise/src/core/network/responses/payment_qr_code/banks.dart';
import 'package:aladdin_franchise/src/core/network/responses/payment_qr_code/info_by_tax_code.dart';
import 'package:aladdin_franchise/src/core/network/rest_client.dart';
import 'package:aladdin_franchise/src/core/network/restaurant/restaurant_repository.dart';
import 'package:aladdin_franchise/src/core/services/send_log/log_service.dart';
import 'package:aladdin_franchise/src/core/storages/local.dart';
import 'package:aladdin_franchise/src/models/atm_pos.dart';
import 'package:aladdin_franchise/src/models/cashier.dart';
import 'package:aladdin_franchise/src/models/employee_sale.dart';
import 'package:aladdin_franchise/src/models/error_log.dart';
import 'package:aladdin_franchise/src/models/minvoice/minvoice.dart';
import 'package:aladdin_franchise/src/models/param_family/bank_param.dart';
import 'package:aladdin_franchise/src/models/payment_method/payment_method.dart';
import 'package:aladdin_franchise/src/models/user_bank.dart';
import 'package:aladdin_franchise/src/utils/app_helper.dart';
import 'package:aladdin_franchise/src/utils/app_log.dart';

import 'package:http/http.dart' as http;

class RestaurantRepositoryImpl extends RestaurantRepository {
  @override
  Future<List<UserBankModel>> getBanks(ApiBankParam apiBankParam) async {
    var log = const ErrorLogModel(action: AppLogAction.getBankPayment);
    try {
      if (useDataFake) {
        await delayFunc();
        return kBanks;
      }
      var loginData = LocalStorage.getDataLogin();
      final restaurantId = loginData?.restaurant?.id;
      final apiUrl = "${ApiConfig.getBankPayment}?restaurant_id=$restaurantId"
          "&order_id=${apiBankParam.orderDataBill.id}"
          "&table_name=${apiBankParam.orderDataBill.tableName}"
          "&total_bill=${apiBankParam.priceFinal}";
      log = log.copyWith(api: apiUrl);

      var response = await restClient.get(
        Uri.parse(apiUrl),
      );
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
      showLog(ex, flags: 'Error getBankPayment');
      LogService.sendLogs(
          log.copyWith(errorMessage: ex.toString(), createAt: DateTime.now()));

      if (ex is AppException) rethrow;
      throw AppException(message: ex.toString());
    }
  }

  @override
  Future<MInvoiceInfo> getMInvoiceTaxInfo(String taxCode) async {
    var apiUrl = "${ApiConfig.getInfoByTaxCode}?tax_code=$taxCode";
    var log = ErrorLogModel(
      action: AppLogAction.getInfoByTaxCode,
      api: apiUrl,
    );
    try {
      if (useDataFake) {
        await delayFunc();
        return MInvoiceInfo(
          taxCode: taxCode,
          name: 'cty a',
          accountNumber: '123333',
          address: 'Vĩnh Phúc',
          companyName: 'Cty a',
          email: 'test@gmail.com',
        );
      }
      var response = await restClient.get(
        Uri.parse(apiUrl),
      );
      log = log.copyWith(
        response: [response.statusCode, response.body],
      );
      if (response.statusCode == NetworkCodeConfig.ok) {
        final bodyJson = jsonDecode(response.body);
        final resData = InfoByTaxCodeResponse.fromJson(bodyJson);
        if (resData.data.isEmpty()) {
          // đang copy từ apos sang
          // ảo lắm: 200 nhưng data lại là "error": "Mã số thuế không đúng định dạng."
          var error = bodyJson['data']['error'] ?? S.current.no_data;
          throw AppException.fromMessage(error);
        }
        return resData.data;
      } else {
        throw AppException.fromStatusCode(response.statusCode);
      }
    } catch (ex) {
      showLog(ex, flags: 'Error getInfoByTaxCode');
      LogService.sendLogs(
          log.copyWith(errorMessage: ex.toString(), createAt: DateTime.now()));

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
      if (useDataFake) {
        await delayFunc();
        return kPaymentMethods;
      }
      var response = await restClient.get(
        Uri.parse(apiUrl),
      );
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
      showLog(ex, flags: 'Error getPaymentMethod');
      LogService.sendLogs(
          log.copyWith(errorMessage: ex.toString(), createAt: DateTime.now()));

      if (ex is AppException) rethrow;
      throw AppException(message: ex.toString());
    }
  }

  @override
  Future<
      ({
        String? url,
        String? qr,
        int? expiryMin,
        String? message,
        int? status
      })> getPaymentGateway({
    required ApiBankParam apiBankParam,
    required int keyPaymentMethod,
  }) async {
    //return "https://newsandbox.payoo.com.vn/v2/paynow/prepare?_token=1ePupay5CD3";
    var log = const ErrorLogModel(action: AppLogAction.getPaymentGateway);
    try {
      if (useDataFake) {
        await delayFunc();
        return (
          url: 'https://google.com',
          qr: '1222',
          expiryMin: 15,
          message: '',
          status: 200,
        );
      }
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
        return (
          url: url,
          qr: qr,
          expiryMin: expiryMin,
          message: message,
          status: status
        );
      } else {
        throw AppException.fromStatusCode(response.statusCode);
      }
    } catch (ex) {
      showLog(ex, flags: 'Error getPaymentGateway');
      LogService.sendLogs(
          log.copyWith(errorMessage: ex.toString(), createAt: DateTime.now()));

      if (ex is AppException) rethrow;
      throw AppException(message: ex.toString());
    }
  }

  @override
  Future<List<AtmPosModel>> getListAtmPos({
    required int orderId,
    required dynamic totalBill,
  }) async {
    var log = const ErrorLogModel(action: AppLogAction.getListPos);
    try {
      if (useDataFake) {
        await delayFunc();
        return kAtmPos;
      }
      final apiUrl = ApiConfig.getListAtmPos;

      var bodyRequest = jsonEncode({
        'order_id': orderId,
        'total_bill': totalBill,
      });
      log = log.copyWith(api: apiUrl, request: bodyRequest);
      final response =
          await restClient.post(Uri.parse(apiUrl), body: bodyRequest);

      log = log.copyWith(
        response: [response.statusCode, response.body],
      );
      if (response.statusCode == NetworkCodeConfig.ok) {
        final data = jsonDecode(response.body);
        return (data['data'] as List)
            .map((e) => AtmPosModel.fromJson(e))
            .toList();
      } else {
        throw AppException.fromStatusCode(response.statusCode);
      }
    } catch (ex) {
      showLog(ex, flags: 'Error getListPos');
      LogService.sendLogs(
          log.copyWith(errorMessage: ex.toString(), createAt: DateTime.now()));

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
      if (useDataFake) {
        await delayFunc();
        return;
      }
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

      var response = await http.Client()
          .post(Uri.parse(apiUrl), headers: defaultHeaders, body: bodyRequest);

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
      showLog(ex, flags: 'Error posCallback');
      LogService.sendLogs(
          log.copyWith(errorMessage: ex.toString(), createAt: DateTime.now()));

      if (ex is AppException) rethrow;
      throw AppException(message: ex.toString());
    }
  }

  // @override
  // Future<List<CashierModel>> getCashiers() async {
  //   var log = const ErrorLogModel(action: AppLogAction.getCashiers);
  //   try {
  //     var restaurantId = LocalStorage.getDataLogin()?.restaurant?.id ?? -1;
  //     var apiUrl = '${ApiConfig.getCashiers}?restaurant_id=$restaurantId';
  //     log = log.copyWith(api: apiUrl);

  //     if (restaurantId == -1) {
  //       // xem xét ném 401
  //       throw S.current.invalid_restaurant_info;
  //     }
  //     final response = await restClient.get(Uri.parse(apiUrl));

  //     log = log.copyWith(
  //       response: [response.statusCode, response.body],
  //     );
  //     if (response.statusCode == NetworkCodeConfig.ok) {
  //       return (jsonDecode(response.body)['data'] as List)
  //           .map((e) => CashierModel.fromJson(e))
  //           .toList();
  //     } else {
  //       throw AppException.fromStatusCode(response.statusCode);
  //     }
  //   } catch (ex) {
  //     showLog(ex, flags: 'Error getListCashiers');
  //     LogService.sendLogs(
  //         log.copyWith(errorMessage: ex.toString(), createAt: DateTime.now()));

  //     if (ex is AppException) rethrow;
  //     throw AppException(message: ex.toString());
  //   }
  // }

  @override
  Future<List<EmployeeSaleModel>> getEmployeeSales() async {
    var log = const ErrorLogModel(action: AppLogAction.getEmployeeSales);
    try {
      if (useDataFake) {
        await delayFunc();
        return kSales;
      }
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
      showLogs(ex, flags: 'error getEmployeeSales');
      LogService.sendLogs(
          log.copyWith(errorMessage: ex.toString(), createAt: DateTime.now()));

      if (ex is AppException) rethrow;
      throw AppException(message: ex.toString());
    }
  }
}
