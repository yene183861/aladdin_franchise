import 'package:aladdin_franchise/generated/l10n.dart';
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
        return S.current.table;
      case TransferOrderTabEnum.waiter:
        return S.current.waiter;
    }
  }

  int get key {
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
    @Default([]) List<TableModel> tableSelects,
    WaiterModel? waiterSelect,
    @Default('') String searchWaiter,
    @Default(false) bool initTableCurrent,
    @Default(TransferOrderTabEnum.table) TransferOrderTabEnum tabSelect,
  }) = _TransferOrderState;

  factory TransferOrderState.fromJson(Map<String, dynamic> json) =>
      _$TransferOrderStateFromJson(json);
}
