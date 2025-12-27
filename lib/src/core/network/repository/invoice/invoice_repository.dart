import 'package:aladdin_franchise/src/models/minvoice/minvoice.dart';
import 'package:aladdin_franchise/src/models/order_invoice/order_invoice.dart';

abstract class InvoiceRepository {
  Future<OrderInvoice> getOrderInvoice(int orderId);

  Future<void> updateOrderInvoice({required int orderId, required OrderInvoice orderInvoice});

  Future<MInvoiceInfo> getMInvoiceTaxInfo(String taxCode);
}
