/// Author: sondv
/// Created 23/02/2023 at 10:05

import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'id_card.freezed.dart';
part 'id_card.g.dart';

@freezed
class IDCardModel with _$IDCardModel {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory IDCardModel({
    required String id,
    required String firstName,
    required String lastName,
    required DateTime dob,
    required String gender,
    required String address,
  }) = _IDCardModel;
}
