import 'package:aladdin_franchise/src/models/table.dart';
import 'package:aladdin_franchise/src/models/waiter.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'state.freezed.dart';
part 'state.g.dart';

enum TransferOrderTabEnum {
  table,
  waiter,
}

extension TransferOrderTabEnumEx on TransferOrderTabEnum {
  String get title {
    switch (this) {
      case TransferOrderTabEnum.table:
        return 'Danh sách bàn';
      case TransferOrderTabEnum.waiter:
        return 'Phục vụ';
    }
  }

  int get index {
    switch (this) {
      case TransferOrderTabEnum.table:
        return 0;
      case TransferOrderTabEnum.waiter:
        return 1;
    }
  }
}

@freezed
class TransferOrderState with _$TransferOrderState {
  @JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
  const factory TransferOrderState({
    required List<TableModel> tableSelects,
    required WaiterModel? waiterSelect,
    required String searchWaiter,
    required bool initTableCurrent,
    @Default(0) int tabIndexSelect,
  }) = _TransferOrderState;

  factory TransferOrderState.fromJson(Map<String, dynamic> json) =>
      _$TransferOrderStateFromJson(json);
}
