import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'chat_message_model.freezed.dart';
part 'chat_message_model.g.dart';

@freezed
class ChatMessageModel with _$ChatMessageModel {
  @JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
  const factory ChatMessageModel({
    @Default(-1) dynamic id,
    @Default(-1) dynamic restaurantId,
    @Default(-1) dynamic orderId,
    @Default(-1) dynamic deviceId,
    @Default('') String sender,
    @Default('') String userName,
    @Default('') String message,
    @Default('') String table,
    required DateTime createdAt,
  }) = _ChatMessageModel;

  const ChatMessageModel._();

  factory ChatMessageModel.fromJson(Map<String, dynamic> json) => _$ChatMessageModelFromJson(json);

  static String getModelInterface() {
    return '''
    @Default(-1) dynamic id,
    @Default(-1) dynamic restaurantId,
    @Default(-1) dynamic orderId,
    @Default(-1) dynamic deviceId,
    @Default('') String sender,
    @Default('') String userName,
    @Default('') String message,
    @Default('') String table,
    required DateTime createdAt,
''';
  }
}
