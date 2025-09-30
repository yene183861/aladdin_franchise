/// Author: sondv
/// Created 13/03/2024 at 13:16

import 'package:aladdin_franchise/src/models/user_bank.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'banks.freezed.dart';
part 'banks.g.dart';

@freezed
class BankPaymentResponse with _$BankPaymentResponse {
  const factory BankPaymentResponse({
    @Default(-1) int status,
    @Default([]) List<UserBankModel> data,
  }) = _BankPaymentResponse;

  factory BankPaymentResponse.fromJson(Map<String, dynamic> json) =>
      _$BankPaymentResponseFromJson(json);
}
