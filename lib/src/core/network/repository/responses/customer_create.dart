import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'customer_create.freezed.dart';
part 'customer_create.g.dart';

@freezed
class CustomerCreateResponse with _$CustomerCreateResponse {
  @JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
  const factory CustomerCreateResponse({
    required CustomerCreateResponseData data,
  }) = _CustomerCreateResponse;

  factory CustomerCreateResponse.fromJson(Map<String, dynamic> json) =>
      _$CustomerCreateResponseFromJson(json);
}

@freezed
class CustomerCreateResponseData with _$CustomerCreateResponseData {
  @JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
  const factory CustomerCreateResponseData({
    required int status,
    dynamic data,
  }) = _CustomerCreateResponseData;

  factory CustomerCreateResponseData.fromJson(Map<String, dynamic> json) =>
      _$CustomerCreateResponseDataFromJson(json);
}
