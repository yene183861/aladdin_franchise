import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_bank.freezed.dart';
part 'user_bank.g.dart';

/// [listPaymentId] - Bank được gắn với những phương thức thanh toán nào
///
/// [useInvoice] - Bank được sử dụng khi =>  null: Tất cả | true:Lấy hoá đơn | false: Không lấy hoá đơn
///
///
@freezed
class UserBankModel with _$UserBankModel {
  @JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
  const factory UserBankModel({
    @Default('') String title,
    @Default('') String bankName,
    @Default('') String fullName,
    @Default('') @JsonKey(fromJson: _dataToString) String bankNumber,
    @Default('') String bankBin,
    bool? useInvoice,
    @Default('') String qrCode,
    @Default([]) List<int> listPaymentId,
  }) = _UserBankModel;

  factory UserBankModel.fromJson(Map<String, dynamic> json) => _$UserBankModelFromJson(json);

  const UserBankModel._();

  bool isError() => bankBin.isEmpty || bankNumber.isEmpty;
}

String _dataToString(dynamic data) {
  return data.toString();
}
