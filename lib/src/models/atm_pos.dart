import 'dart:convert';

import 'package:aladdin_franchise/generated/l10n.dart';
import 'package:aladdin_franchise/src/models/table.dart';
import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'atm_pos.freezed.dart';
part 'atm_pos.g.dart';

@freezed
class AtmPosModel with _$AtmPosModel {
  @JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
  const factory AtmPosModel({
    @Default(-1) int id,
    @Default('') String name,
    // 1 - tĩnh, 2 - động
    @Default(1) int setting,
    @Default('') String url,
  }) = _AtmPosModel;

  factory AtmPosModel.fromJson(Map<String, dynamic> json) =>
      _$AtmPosModelFromJson(json);

  const AtmPosModel._();
}
