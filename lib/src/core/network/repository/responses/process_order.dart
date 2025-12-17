import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'process_order.freezed.dart';
part 'process_order.g.dart';

@freezed
class ProcessOrderResponse with _$ProcessOrderResponse {
  @JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
  const factory ProcessOrderResponse({
    required int status,
    dynamic message,
    int? timesOrder,
  }) = _ProcessOrderResponse;

  factory ProcessOrderResponse.fromJson(Map<String, dynamic> json) =>
      _$ProcessOrderResponseFromJson(json);

  static String getModelInterface() {
    return '''required int status,
    dynamic message,
    int? timesOrder,
    ''';
  }
}
