/// Author: sondv
/// Created 13/03/2024 at 13:19

import 'package:aladdin_franchise/src/models/order_invoice/order_invoice.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'order_invoice_info.freezed.dart';
part 'order_invoice_info.g.dart';

@freezed
class OrderInvoiceInfoResponse with _$OrderInvoiceInfoResponse {
  const factory OrderInvoiceInfoResponse({
    @Default(-1) int status,
    @Default(OrderInvoice()) OrderInvoice data,
  }) = _OrderInvoiceInfoResponse;

  factory OrderInvoiceInfoResponse.fromJson(Map<String, dynamic> json) =>
      _$OrderInvoiceInfoResponseFromJson(json);
}
