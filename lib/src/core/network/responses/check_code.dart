import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'check_code.freezed.dart';
part 'check_code.g.dart';

@freezed
class CheckCodeResponse with _$CheckCodeResponse {
  @JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
  const factory CheckCodeResponse({
    required CheckCodeResponseData data,
  }) = _CheckCodeResponse;

  factory CheckCodeResponse.fromJson(Map<String, dynamic> json) =>
      _$CheckCodeResponseFromJson(json);

  static String getModelInterface() {
    return '''required CheckCodeResponseData data
    CheckCodeResponseData{
      required bool checkCode,
      String? appCheck,
    }
    ''';
  }
}

@freezed
class CheckCodeResponseData with _$CheckCodeResponseData {
  @JsonSerializable(explicitToJson: true)
  const factory CheckCodeResponseData({
    required bool checkCode,
    String? appCheck,
  }) = _CheckCodeResponseData;

  factory CheckCodeResponseData.fromJson(Map<String, dynamic> json) =>
      _$CheckCodeResponseDataFromJson(json);
}
