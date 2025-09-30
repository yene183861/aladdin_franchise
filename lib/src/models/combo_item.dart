import 'package:aladdin_franchise/src/configs/app.dart';
import 'package:aladdin_franchise/src/configs/const.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'combo_item.freezed.dart';
part 'combo_item.g.dart';

@freezed
class ComboItemModel with _$ComboItemModel {
  @JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
  const factory ComboItemModel({
    int? id,
    @Default('') String name,
    @Default('') String nameEn,
    @Default('') String image,
    @Default(1) int quantity,

    /// check trường này
    @Default(-1) int printerType,

    /// check trường này
    @Default('') String unit,
  }) = _ComboItemModel;

  factory ComboItemModel.fromJson(Map<String, dynamic> json) =>
      _$ComboItemModelFromJson(json);

  const ComboItemModel._();
  String getNameView() => kAppLanguageLocal == AppLanguageLocal.vietnamese
      ? name
      : nameEn.trim().isEmpty
          ? name
          : nameEn;
}
