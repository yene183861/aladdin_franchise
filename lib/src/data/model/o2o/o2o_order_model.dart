import 'package:aladdin_franchise/src/data/model/o2o/request_order.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'o2o_order_model.freezed.dart';
part 'o2o_order_model.g.dart';

@freezed
class O2OOrderModel with _$O2OOrderModel {
  @JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
  const factory O2OOrderModel({
    @Default(-1) int orderId,
    @Default([]) List<String> qrOrderO2o,
    @Default(-1) int restaurantId,
    @Default('') String tableName,
    @Default([]) List<RequestOrderModel> items,
    @Default('') String orderCode,
    @Default(-1) int userId,
  }) = _O2OOrderModel;

  const O2OOrderModel._();

  factory O2OOrderModel.fromJson(Map<String, dynamic> json) =>
      _$O2OOrderModelFromJson(json);

  static String getModelInterface() {
    return '''
    @Default(-1) int orderId,
    @Default([]) List<String> qrOrderO2o,
    @Default(-1) int restaurantId,
    @Default('') String tableName,
    @Default([]) List<RequestOrderModel> items,
    @Default('') String orderCode,
    @Default(-1) int userId,

    ===========================
    RequestOrderModel - interface

    ${RequestOrderModel.getModelInterface()}
    ''';
  }
}
