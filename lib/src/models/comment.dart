import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'comment.freezed.dart';
part 'comment.g.dart';

@freezed
class CommentModel with _$CommentModel {
  @JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
  const factory CommentModel({
    int? star,
    List<String>? commentCheckbox,
    String? textarea,
  }) = _CommentModel;

  factory CommentModel.fromJson(Map<String, dynamic> json) => _$CommentModelFromJson(json);
}
