import 'dart:convert';

import 'package:aladdin_franchise/src/configs/api.dart';
import 'package:aladdin_franchise/src/configs/app.dart';
import 'package:aladdin_franchise/src/configs/enums/app_log_action.dart';
import 'package:aladdin_franchise/src/core/network/app_exception.dart';
import 'package:aladdin_franchise/src/core/network/check_locked_order.dart';
import 'package:aladdin_franchise/src/core/network/invoice/invoice_repository.dart';
import 'package:aladdin_franchise/src/core/network/responses/payment_qr_code/order_invoice_info.dart';
import 'package:aladdin_franchise/src/core/network/rest_client.dart';
import 'package:aladdin_franchise/src/core/services/send_log/log_service.dart';
import 'package:aladdin_franchise/src/models/error_log.dart';
import 'package:aladdin_franchise/src/models/order_invoice/order_invoice.dart';
import 'package:aladdin_franchise/src/utils/app_log.dart';

class InvoiceRepositoryImpl extends InvoiceRepository {
  @override
  Future<OrderInvoice> getOrderInvoice(int orderId) async {
    var apiUrl = "${ApiConfig.getOrderInvoice}?order_id=$orderId";
    var log = ErrorLogModel(
      action: AppLogAction.getOrderInvoice,
      api: apiUrl,
    );
    try {
      var response = await restClient.get(
        Uri.parse(apiUrl),
      );
      log = log.copyWith(
        response: [response.statusCode, response.body],
      );
      if (response.statusCode == NetworkCodeConfig.ok) {
        var bodyJson = jsonDecode(response.body);
        final resData = OrderInvoiceInfoResponse.fromJson(bodyJson);
        return resData.data;
      } else {
        throw AppException.fromStatusCode(response.statusCode);
      }
    } catch (ex) {
      showLog(ex, flags: 'getOrderInvoice ex');
      LogService.sendLogs(log.copyWith(errorMessage: ex.toString(), createAt: DateTime.now()));

      if (ex is AppException) rethrow;
      throw AppException(message: ex.toString());
    }
  }

  @override
  Future<void> updateOrderInvoice(
      {required int orderId, required OrderInvoice orderInvoice}) async {
    var apiUrl = ApiConfig.updateOrderInvoice;
    var log = ErrorLogModel(
      action: AppLogAction.updateOrderInvoice,
      api: apiUrl,
    );
    try {
      var bodyRequest = jsonEncode(<String, dynamic>{
        "order_id": orderId,
        "invoice": orderInvoice.toJson(),
      });
      log = log.copyWith(
        request: bodyRequest,
      );
      var response = await restClient.post(
        Uri.parse(apiUrl),
        body: bodyRequest,
      );
      log = log.copyWith(
        response: [response.statusCode, response.body],
      );
      if (response.statusCode != 200) {
        checkLockedOrder(response);
        throw AppException.fromStatusCode(response.statusCode);
      }
    } catch (ex) {
      showLog(ex.toString(), flags: 'updateOrderInvoice ex');
      LogService.sendLogs(log.copyWith(errorMessage: ex.toString(), createAt: DateTime.now()));

      if (ex is AppException) rethrow;
      throw AppException(message: ex.toString());
    }
  }
}
