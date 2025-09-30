import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'request_service.freezed.dart';
part 'request_service.g.dart';

@freezed
class RequestServiceModel with _$RequestServiceModel {
  const factory RequestServiceModel({
    @Default('') String message,
    DateTime? dateTime,
  }) = _RequestServiceModel;

  const RequestServiceModel._();

  factory RequestServiceModel.fromJson(Map<String, dynamic> json) =>
      _$RequestServiceModelFromJson(json);
}
