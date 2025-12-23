import 'package:aladdin_franchise/src/core/network/api/safe_call_api.dart';
import 'package:aladdin_franchise/src/models/minvoice/minvoice.dart';
import 'package:aladdin_franchise/src/models/order_invoice/order_invoice.dart';

abstract class InvoiceRepository {
  Future<ApiResult<OrderInvoice>> getOrderInvoice(int orderId);

  Future<ApiResult<void>> updateOrderInvoice(
      {required int orderId, required OrderInvoice orderInvoice});

  Future<ApiResult<MInvoiceInfo>> getMInvoiceTaxInfo(String taxCode);
}
