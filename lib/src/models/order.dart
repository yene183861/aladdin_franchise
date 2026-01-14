import 'dart:convert';

import 'package:aladdin_franchise/generated/l10n.dart';
import 'package:aladdin_franchise/src/configs/app.dart';
import 'package:aladdin_franchise/src/models/table.dart';
import 'package:aladdin_franchise/src/utils/app_log.dart';
import 'package:aladdin_franchise/src/utils/parsing_util.dart';
import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'order.freezed.dart';
part 'order.g.dart';

@freezed
class OrderModel with _$OrderModel {
  @JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
  const factory OrderModel({
    @Default(-1) int id,
    @Default('') String name,
    @Default('') String misc,
    // 0 false | 1 true Đơn bàn bị khôi phục lại
    @Default(0) int isRestore,
    int? waiterId,
    // qr order tại bàn
    @Default([]) @JsonKey(includeToJson: false) List<String> qrO2O,
    // @Default('') @JsonKey(includeToJson: false) String orderCode,

    /// chuỗi "1,2"
    @Default('') String tableId,
    DateTime? createdAt,
    @Default(AppConfig.orderOfflineValue)
    @JsonKey(includeToJson: false, includeFromJson: false)
    int typeOrder,
    @Default(null) @JsonKey(includeToJson: false) dynamic reservationCrmId,
  }) = _OrderModel;

  factory OrderModel.fromJson(Map<String, dynamic> json) => _$OrderModelFromJson(json);

  const OrderModel._();

  String getNameView() => (isRestore == 1) ? "$name (${S.current.restore.toUpperCase()})" : name;

  bool isInvalid() => id == -1;

  String? getOrderMisc() {
    try {
      final miscMap = jsonDecode(misc);
      final orderCode = miscMap['order_code'];
      if (orderCode != null) {
        return orderCode;
      }
    } catch (ex) {
      return null;
    }
  }

  List<int> get getTableIds {
    if (tableId.trim().isEmpty) return [];
    var str =
        tableId.trim().split(',').map((e) => int.tryParse(e.trim())).whereType<int>().toList();
    return str;
  }
}
