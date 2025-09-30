import 'package:aladdin_franchise/src/configs/app.dart';
import 'package:aladdin_franchise/src/models/table.dart';
import 'package:aladdin_franchise/src/models/reservation/reservation.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'state.dart';

final createNewOrderDialogProvider = StateNotifierProvider.autoDispose<
    CreateNewOrderDialogNotifier, CreateNewOrderDialogState>((ref) {
  return CreateNewOrderDialogNotifier(ref);
});

class CreateNewOrderDialogNotifier
    extends StateNotifier<CreateNewOrderDialogState> {
  CreateNewOrderDialogNotifier(this.ref)
      : super(
          CreateNewOrderDialogState(
            typeOrderSelect: kTypeOrder,
          ),
        );
  final Ref ref;

  void onChangeTabIndexSelect(int index) {
    state = state.copyWith(tabIndexSelect: index);
  }

  void onChangeTableSelect(
      {required TableModel value, bool onSelected = false}) {
    var tableIds = List<int>.from(state.tableIds);
    var table = List<TableModel>.from(state.tableSelect);
    if (onSelected) {
      table.add(value);
      tableIds.add(value.id);
    } else {
      table.remove(value);
      tableIds.remove(value.id);
    }
    state = state.copyWith(tableSelect: table, tableIds: tableIds);
  }

  void onChangeListTableSelect(List<TableModel> tableSelect) {
    var tableIds = List<int>.from(state.tableIds);
    var table = List<TableModel>.from(state.tableSelect);

    for (var item in tableSelect) {
      tableIds.add(item.id);
      table.add(item);
    }
    state = state.copyWith(
        tableSelect: table.toSet().toList(),
        tableIds: tableIds.toSet().toList());
  }

  void onChangeTextSearchReservation(String value) {
    state = state.copyWith(textSearchReservation: value);
  }

  void onChangeReservationSelect(ReservationModel? item) {
    state = state.copyWith(reservationSelect: item);
  }

  void onChangeNotifyReservation(bool value) {
    state = state.copyWith(notifyReservation: value);
  }

  void onChangeReservationsAssginTable(List<ReservationModel> value) {
    state = state.copyWith(reservationsAssginTable: value);

    if (state.reservationSelect == null &&
        state.reservationsAssginTable.isNotEmpty &&
        !state.notifyReservation) {
      onChangeNotifyReservation(true);
    }
  }

  void onChangeIgnoreNotifyReservation() {
    state =
        state.copyWith(ignoreNotifyReservation: !state.ignoreNotifyReservation);
  }

  void onChangeTypeOrderSelect(int typeOrder) {
    if (typeOrder != state.typeOrderSelect) {
      state = state.copyWith(
        tableSelect: [],
        tableIds: [],
        reservationSelect: null,
      );
    }
    state = state.copyWith(typeOrderSelect: typeOrder);
  }
}
