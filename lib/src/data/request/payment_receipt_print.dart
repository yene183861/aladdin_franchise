import 'package:aladdin_franchise/src/data/enum/receipt_type.dart';
import 'package:aladdin_franchise/src/models/data_bill.dart';
import 'package:aladdin_franchise/src/models/order.dart';
import 'package:aladdin_franchise/src/models/payment_method/payment_method.dart';
import 'package:aladdin_franchise/src/models/policy_result.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'payment_receipt_print.freezed.dart';
part 'payment_receipt_print.g.dart';

@freezed
class PaymentReceiptPrintRequest with _$PaymentReceiptPrintRequest {
  @JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
  factory PaymentReceiptPrintRequest({
    required OrderModel order,
    @Default(PriceDataBill()) PriceDataBill price,
    @Default(ReceiptTypeEnum.paymentReceipt) ReceiptTypeEnum receiptType,
    PaymentMethod? paymentMethod,
    @Default(0.0) double paymentAmount,
    @Default(1) int numberPrintCompleted,
    @Default(0) int numberPrintTemporary,
    @Default([]) List<LineItemDataBill> orderLineItems,
    @Default([]) List<HistoryPolicyResultModel> vouchers,
    @Default('') String note,
    @Default(false) bool printNumberOfPeople,
    @Default('') String customerPhone,
    @Default(1) int numberOfPeople,
    @Default('') String cashierCompleted,
    @Default('') String cashierPrint,
    DateTime? timeCompleted,
    DateTime? timeCreatedAt,
    @Default('') String invoiceQr,
  }) = _PaymentReceiptPrintRequest;
  PaymentReceiptPrintRequest._();

  factory PaymentReceiptPrintRequest.fromJson(Map<String, Object?> json) =>
      _$PaymentReceiptPrintRequestFromJson(json);
}
