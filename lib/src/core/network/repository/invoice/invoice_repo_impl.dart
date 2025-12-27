import 'dart:convert';

import 'package:aladdin_franchise/src/configs/api.dart';
import 'package:aladdin_franchise/src/configs/enums/app_log_action.dart';
import 'package:aladdin_franchise/src/core/network/api/app_exception.dart';
import 'package:aladdin_franchise/src/core/network/api/safe_call_api.dart';
import 'package:aladdin_franchise/src/core/network/repository/invoice/invoice_repository.dart';
import 'package:aladdin_franchise/src/core/network/api/rest_client.dart';
import 'package:aladdin_franchise/src/models/error_log.dart';
import 'package:aladdin_franchise/src/models/minvoice/minvoice.dart';
import 'package:aladdin_franchise/src/models/order.dart';
import 'package:aladdin_franchise/src/models/order_invoice/order_invoice.dart';

class InvoiceRepositoryImpl extends InvoiceRepository {
  final RestClient _client;

  InvoiceRepositoryImpl(this._client);

  @override
  Future<OrderInvoice> getOrderInvoice(int orderId) async {
    var apiUrl = "${ApiConfig.apiUrl}/api/v1/get-invoice-information?order_id=$orderId";
    var result = await safeCallApi(
      () {
        final url = Uri.parse(apiUrl);
        return _client.get(url);
      },
      dataKey: 'data',
      parser: (json) {
        if (json == null) return const OrderInvoice();
        return OrderInvoice.fromJson(json);
      },
      log: ErrorLogModel(
        action: AppLogAction.getOrderInvoice,
        api: apiUrl,
        order: OrderModel(id: orderId),
      ),
    );
    if (!result.isSuccess) {
      throw AppException(
        statusCode: result.statusCode,
        message: result.error,
      );
    }
    return result.data ?? const OrderInvoice();
  }

  @override
  Future<void> updateOrderInvoice(
      {required int orderId, required OrderInvoice orderInvoice}) async {
    var apiUrl = "${ApiConfig.apiUrl}/api/v1/save-invoice";
    var body = jsonEncode(<String, dynamic>{
      "order_id": orderId,
      "invoice": orderInvoice.toJson(),
    });
    var result = await safeCallApi(
      () {
        final url = Uri.parse(apiUrl);
        return _client.post(url, body: body);
      },
      log: ErrorLogModel(
        action: AppLogAction.updateOrderInvoice,
        api: apiUrl,
        request: body,
        order: OrderModel(id: orderId),
      ),
    );
    if (!result.isSuccess) {
      throw AppException(
        statusCode: result.statusCode,
        message: result.error,
      );
    }
    return;
  }

  @override
  Future<MInvoiceInfo> getMInvoiceTaxInfo(String taxCode) async {
    var apiUrl = "${ApiConfig.apiUrl}/api/v1/get-information-tax?tax_code=$taxCode";

    var result = await safeCallApi(
      () {
        final url = Uri.parse(apiUrl);
        return _client.get(url);
      },
      dataKey: 'data',
      parser: (json) {
        if (json['error'] != null) {
          throw AppException(
            statusCode: 404,
            message: (json['error'] ?? '').toString(),
          );
        }
        return MInvoiceInfo.fromJson(json);
      },
      log: ErrorLogModel(
        action: AppLogAction.getInfoByTaxCode,
        api: apiUrl,
      ),
    );
    if (!result.isSuccess) {
      throw AppException(
        statusCode: result.statusCode,
        message: result.error,
      );
    }
    return result.data ?? const MInvoiceInfo();
  }
}
