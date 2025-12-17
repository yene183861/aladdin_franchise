/// Author: sondv
/// Created 13/03/2024 at 13:18

import 'package:aladdin_franchise/src/models/minvoice/minvoice.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'info_by_tax_code.freezed.dart';
part 'info_by_tax_code.g.dart';

@freezed
class InfoByTaxCodeResponse with _$InfoByTaxCodeResponse {
  const factory InfoByTaxCodeResponse({
    @Default(-1) int status,
    @Default(MInvoiceInfo()) MInvoiceInfo data,
  }) = _InfoByTaxCodeResponse;

  factory InfoByTaxCodeResponse.fromJson(Map<String, dynamic> json) =>
      _$InfoByTaxCodeResponseFromJson(json);
}
