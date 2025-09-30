import 'package:aladdin_franchise/src/models/table.dart';
import 'package:aladdin_franchise/src/models/waiter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'state.dart';

final transferOrderProvider = StateNotifierProvider.autoDispose<
    TransferOrderNotifier, TransferOrderState>((ref) {
  return TransferOrderNotifier();
});

class TransferOrderNotifier extends StateNotifier<TransferOrderState> {
  TransferOrderNotifier()
      : super(const TransferOrderState(
          tableSelects: [],
          waiterSelect: null,
          searchWaiter: '',
          initTableCurrent: false,
        ));

  void updateTableSelect(TableModel table) {
    var tableSelects = List<TableModel>.from(state.tableSelects);
    if (tableSelects.contains(table)) {
      tableSelects.remove(table);
    } else {
      tableSelects.add(table);
    }
    state = state.copyWith(tableSelects: tableSelects);
  }

  void changeWaiter(WaiterModel? waiter) {
    state = state.copyWith(waiterSelect: waiter);
  }

  void changeSearch(String keyword) {
    state = state.copyWith(searchWaiter: keyword.trim().toLowerCase());
  }

  void updateInitTableCurrent() {
    state = state.copyWith(initTableCurrent: true);
  }

  void onChangeTabIndexSelect(int value) {
    state = state.copyWith(tabIndexSelect: value);
  }
}
