import 'package:aladdin_franchise/src/data/model/discount/voucher.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'add_voucher.freezed.dart';
part 'add_voucher.g.dart';

@freezed
class VoucherResponse with _$VoucherResponse {
  @JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
  const factory VoucherResponse({
    @Default('') String status,
    @Default('') String message,
    VoucherModel? data,
  }) = _VoucherResponse;

  factory VoucherResponse.fromJson(Map<String, dynamic> json) => _$VoucherResponseFromJson(json);
}
