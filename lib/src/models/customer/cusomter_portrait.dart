import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'cusomter_portrait.freezed.dart';
part 'cusomter_portrait.g.dart';

/// Chân dung khách hàng
@freezed
class CustomerPortrait with _$CustomerPortrait {
  @JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
  const factory CustomerPortrait({
    @Default("") String key,
    @Default("") String value,
  }) = _CustomerPortrait;

  factory CustomerPortrait.fromJson(Map<String, dynamic> json) =>
      _$CustomerPortraitFromJson(json);

  const CustomerPortrait._();

  String display() => value;

  static String getModelInterface() {
    return '''@Default("") String key,
    @Default("") String value,
    ''';
  }
}
