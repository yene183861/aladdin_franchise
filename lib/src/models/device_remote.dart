import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'device_remote.freezed.dart';
part 'device_remote.g.dart';

@freezed
class DeviceRemoteModel with _$DeviceRemoteModel {
  @JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
  const factory DeviceRemoteModel({
    required String id,
    required int value,
    required String? token,
  }) = _DeviceRemoteModel;

  factory DeviceRemoteModel.fromJson(Map<String, dynamic> json) =>
      _$DeviceRemoteModelFromJson(json);
}

@freezed
class DataRemoteModel with _$DataRemoteModel {
  @JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
  const factory DataRemoteModel({
    required String? type,
    required String? styleId,
    required String? ipConfig,
    required String? enableOrderOnline,
  }) = _DataRemoteModel;

  factory DataRemoteModel.fromJson(Map<String, dynamic> json) => _$DataRemoteModelFromJson(json);
}
