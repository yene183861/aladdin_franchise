import 'package:aladdin_franchise/src/core/network/api/safe_call_api.dart';
import 'package:aladdin_franchise/src/models/minvoice/minvoice.dart';
import 'package:aladdin_franchise/src/models/order_invoice/order_invoice.dart';

abstract class InvoiceRepository {
  /// checked
  Future<ApiResult<OrderInvoice>> getOrderInvoice(int orderId);

  /// checked
  Future<ApiResult<void>> updateOrderInvoice(
      {required int orderId, required OrderInvoice orderInvoice});

  /// checked
  Future<ApiResult<MInvoiceInfo>> getMInvoiceTaxInfo(String taxCode);
}
