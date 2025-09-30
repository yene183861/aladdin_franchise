import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'sale.freezed.dart';
part 'sale.g.dart';

@freezed
class SaleModel with _$SaleModel {
  @JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
  const factory SaleModel({
    @Default('') String name,
    @Default('') String code,
  }) = _SaleModel;

  factory SaleModel.fromJson(Map<String, dynamic> json) => _$SaleModelFromJson(json);
}
