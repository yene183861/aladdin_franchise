import 'package:aladdin_franchise/src/data/model/o2o/request_order.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'o2o_config.freezed.dart';
part 'o2o_config.g.dart';

@freezed
class O2oConfigModel with _$O2oConfigModel {
  @JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
  const factory O2oConfigModel({
    @Default(false) bool isEnabled,
    @Default(0) int confirmTimeout,
  }) = _O2oConfigModel;

  const O2oConfigModel._();

  factory O2oConfigModel.fromJson(Map<String, dynamic> json) => _$O2oConfigModelFromJson(json);
}
