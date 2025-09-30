/// Author: sondv
/// Created 29/03/2024 at 11:42

import 'package:aladdin_franchise/src/models/payment_method/payment_method.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'payment_method.freezed.dart';
part 'payment_method.g.dart';

@freezed
class PaymentMethodResponse with _$PaymentMethodResponse {
  const factory PaymentMethodResponse({
    required List<PaymentMethod> data,
  }) = _PaymentMethodResponse;

  factory PaymentMethodResponse.fromJson(Map<String, dynamic> json) =>
      _$PaymentMethodResponseFromJson(json);
}
