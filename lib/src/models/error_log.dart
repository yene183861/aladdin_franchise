import 'dart:io';

import 'package:aladdin_franchise/src/configs/enums/app_log_action.dart';
import 'package:aladdin_franchise/src/models/order.dart';
import 'package:aladdin_franchise/src/models/user.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'error_log.freezed.dart';
part 'error_log.g.dart';

@freezed
class ErrorLogModel with _$ErrorLogModel {
  @JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
  const factory ErrorLogModel({
    @JsonKey(toJson: _actionToName) required AppLogAction action,
    UserModel? waiter,
    String? ipConfig,
    String? ipNetwork,
    String? wifiName,
    String? errorMessage,
    dynamic createAt,
    OrderModel? order,
    String? api,
    dynamic request,
    dynamic response,
    dynamic modelInterface,
    String? appVersion,
    int? deviceId,
    int? waiterId,
    String? makeDeviceId,
  }) = _ErrorLogModel;

  factory ErrorLogModel.fromJson(Map<String, dynamic> json) =>
      _$ErrorLogModelFromJson(json);
}

String _actionToName(AppLogAction action) {
  return "${Platform.isWindows ? 'PC-' : ''}${action.name}";
}
