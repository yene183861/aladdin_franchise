import 'package:aladdin_franchise/generated/l10n.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'request_order.freezed.dart';
part 'request_order.g.dart';

// 0 là khách vừa orders, 1 là xác nhận, 2 là hủy bỏ
enum RequestProcessingStatus {
  all,
  waiting,
  accept,
  cancel,
}

extension RequestProcessingStatusEx on RequestProcessingStatus {
  int get type {
    switch (this) {
      case RequestProcessingStatus.waiting:
        return 0;
      case RequestProcessingStatus.accept:
        return 1;
      case RequestProcessingStatus.cancel:
        return 2;
      default:
        return 0;
    }
  }

  Color get color {
    switch (this) {
      case RequestProcessingStatus.waiting:
        return Colors.blue;
      case RequestProcessingStatus.accept:
        return Colors.green;
      case RequestProcessingStatus.cancel:
        return Colors.red;
      default:
        return Colors.amber.shade800;
    }
  }

  String get title {
    switch (this) {
      case RequestProcessingStatus.waiting:
        return S.current.wait_for_handling;
      case RequestProcessingStatus.accept:
        return S.current.accepted;
      case RequestProcessingStatus.cancel:
        return S.current.canceled;
      default:
        return S.current.all;
    }
  }
}

RequestProcessingStatus convertRequestProcessingStatus(int type) {
  switch (type) {
    case 0:
      return RequestProcessingStatus.waiting;
    case 1:
      return RequestProcessingStatus.accept;
    case 2:
      return RequestProcessingStatus.cancel;
    default:
      return RequestProcessingStatus.waiting;
  }
}

@freezed
class RequestOrderItemModel with _$RequestOrderItemModel {
  @JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
  const factory RequestOrderItemModel({
    @JsonKey(includeToJson: false) int? id,
    @JsonKey(includeToJson: false) int? menuItemId,
    @Default('') String codeProduct,
    @Default(0) @JsonKey(includeToJson: false) int quantity,
    @Default('') @JsonKey(includeToJson: false) String note,
    @Default('') @JsonKey(includeToJson: false) String image,
    @Default('') @JsonKey(includeToJson: false) String name,
    @Default('') String noteRestaurant,
    // @JsonKey(includeToJson: false) int? printerType,
    @Default('') @JsonKey(includeToJson: false) String unit,
  }) = _RequestOrderItemModel;

  const RequestOrderItemModel._();

  factory RequestOrderItemModel.fromJson(Map<String, dynamic> json) =>
      _$RequestOrderItemModelFromJson(json);

  static String getModelInterface() {
    return '''
    @Default('') dynamic id,
    @Default('') String codeProduct,
    @Default(0) int quantity,
    @Default('') String note,
    @Default('') String image,
    @Default('') String name,
    @Default('') String noteRestaurant,
    ''';
  }
}

@freezed
class RequestOrderModel with _$RequestOrderModel {
  @JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
  const factory RequestOrderModel({
    @Default(-1) dynamic id,
    @Default(0) int status,
    @Default([]) List<RequestOrderItemModel> listItem,
    DateTime? timeOrder,
    @Default('') String sender,
    @Default('') String notes,
    @Default(1) int orderTimes,
  }) = _RequestOrderModel;

  const RequestOrderModel._();

  RequestProcessingStatus get requestProcessingStatus => convertRequestProcessingStatus(status);

  bool get isProcessed => requestProcessingStatus != RequestProcessingStatus.waiting;
  bool get isCanceled => requestProcessingStatus == RequestProcessingStatus.cancel;
  bool get isAccepted => requestProcessingStatus == RequestProcessingStatus.accept;

  factory RequestOrderModel.fromJson(Map<String, dynamic> json) =>
      _$RequestOrderModelFromJson(json);

  String get userSender {
    var value = sender.trim();
    if (value.isEmpty) return S.current.customers;
    return value != 'user' ? value : S.current.customers;
  }

  static String getModelInterface() {
    return '''
    @Default(-1) dynamic id,
    @Default(0) int status,
    @Default([]) List<RequestOrderItemModel> listItem,
    DateTime? timeOrder,
    @Default('') String sender,
    @Default('') String notes,
    @Default(1) int orderTimes,

    ===========================
    RequestOrderItemModel - interface

    ${RequestOrderItemModel.getModelInterface()}
    ''';
  }
}

@freezed
class RedisO2oProcessedRequestModel with _$RedisO2oProcessedRequestModel {
  @JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
  const factory RedisO2oProcessedRequestModel({
    int? orderId,
    String? tableName,
    @Default(0) int status,
    @Default([]) List<RequestOrderItemModel> items,
    @Default('') String notes,
  }) = _RedisO2oProcessedRequestModel;

  const RedisO2oProcessedRequestModel._();

  factory RedisO2oProcessedRequestModel.fromJson(Map<String, dynamic> json) =>
      _$RedisO2oProcessedRequestModelFromJson(json);
}
