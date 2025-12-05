import 'package:aladdin_franchise/src/models/ip_order.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'close_shift.freezed.dart';
part 'close_shift.g.dart';

@freezed
class CloseShiftResponseModel with _$CloseShiftResponseModel {
  @JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
  const factory CloseShiftResponseModel({
    @JsonKey(name: 'infoPrint') IpOrderModel? infoPrint,
    DateTime? openShift,
    DateTime? lockShift,
    @Default('') String shiftName,
    @Default(0) double openingBalances,
    @Default(0) double totalAmount,
    @Default(0) double discountMoney,
    @Default(0) double percentBill,
    @Default(0) int countInvoice,
    @Default(0) double endofshiftBalance,
    @Default('') String cashierName,
    dynamic totalPayment,
  }) = _CloseShiftResponseModel;

  factory CloseShiftResponseModel.fromJson(Map<String, dynamic> json) =>
      _$CloseShiftResponseModelFromJson(json);
}
