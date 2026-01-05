import 'package:aladdin_franchise/src/configs/enums/type_order.dart';
import 'package:aladdin_franchise/src/core/storages/local.dart';
import 'package:aladdin_franchise/src/data/enum/reservation_status.dart';
import 'package:aladdin_franchise/src/data/model/reservation/reservation.dart';
import 'package:aladdin_franchise/src/features/dialogs/order/reservation/provider.dart';
import 'package:aladdin_franchise/src/models/table.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'state.dart';

final createNewOrderDialogProvider =
    StateNotifierProvider.autoDispose<CreateNewOrderDialogNotifier, CreateNewOrderDialogState>(
        (ref) {
  return CreateNewOrderDialogNotifier(ref);
});

class CreateNewOrderDialogNotifier extends StateNotifier<CreateNewOrderDialogState> {
  CreateNewOrderDialogNotifier(this.ref)
      : super(
          CreateNewOrderDialogState(
              useReservation: LocalStorage.getDataLogin()?.restaurant?.reservationStatus ?? false),
        );
  final Ref ref;

  /// danh sách lịch đặt bàn đã lọc theo type, search
  List<ReservationModel> filteredReservations = [];

  void onChangeTabSelect(CreateNewOrderTabEnum value) {
    state = state.copyWith(tabSelect: value);
  }

  void onChangeTableSelect({required TableModel value, bool onSelected = false}) async {
    var tableIds = List<int>.from(state.tableIds);
    var table = List<TableModel>.from(state.tableSelect);
    if (onSelected) {
      var typeOrder = convertToTypeOrderEnum(value.typeOrder);
      await onChangeTypeOrder(typeOrder);
      tableIds = List<int>.from(state.tableIds);
      table = List<TableModel>.from(state.tableSelect);
    }

    if (onSelected) {
      table.add(value);
      tableIds.add(value.id);
    } else {
      table.remove(value);
      tableIds.remove(value.id);
    }
    state = state.copyWith(
      tableSelect: table,
      tableIds: tableIds,
    );
    updateReservationState(tableIds);
    onCheckReservation();
  }

  Future<void> onChangeTypeOrder(TypeOrderEnum? value) async {
    if (value != null && state.typeOrder != value) {
      state = state.copyWith(
        tableSelect: [],
        tableIds: [],
        typeOrder: value,
        reservationSelect: null,
      );
    } else {
      state = state.copyWith(typeOrder: value);
    }
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
      tableIds: tableIds.toSet().toList(),
    );
    updateReservationState(tableIds);
    onCheckReservation();
  }

  void onChangeReservationSelect(ReservationModel? item, List<TableModel> tables) async {
    state = state.copyWith(reservationSelect: item);
    if (item != null) {
      var type = item.typeOrder;
      await onChangeTypeOrder(type);
      state = state.copyWith(reservationSelect: item);
      var tableSelect = tables.where((e) => (item.tableId ?? []).contains(e.id)).toList();
      onChangeListTableSelect(tableSelect);
    } else {
      if (state.tableIds.isEmpty) {
        state = state.copyWith(typeOrder: null);
        updateReservationState();
      }
    }
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
    state = state.copyWith(ignoreNotifyReservation: !state.ignoreNotifyReservation);
  }

  void updateReservationState([List<int>? tableIds]) {
    if (state.useReservation) {
      TypeOrderEnum? type = state.typeOrder;
      if ((tableIds ?? state.tableIds).isEmpty) {
        type = null;
      }

      var reservation = state.reservationSelect;
      if (type != null && reservation != null && reservation.typeOrder != type) {
        reservation = null;
      }
      state = state.copyWith(reservationSelect: reservation);
      ref.read(reservationSectionProvider.notifier).onChangeReservationSelect(reservation, null);
      ref.read(reservationSectionProvider.notifier).onChangeTypeOrder(type);
    }
  }

  void applyReservationFilters(List<ReservationModel> value) {
    filteredReservations = value;
    onCheckReservation();
  }

  void onCheckReservation() {
    if (state.tableIds.isNotEmpty) {
      var check = filteredReservations.where((e) {
        if (state.typeOrder != null && e.typeOrder != state.typeOrder) return false;
        var start = e.startDateTime;
        var diffMinutes = start.difference(DateTime.now()).inMinutes.abs();
        if (diffMinutes <= 30 &&
            state.reservationSelect == null &&
            e.reservationStatus == ReservationStatusEnum.accept &&
            state.tableIds.toSet().intersection((e.tableId ?? []).toSet()).isNotEmpty) {
          return true;
        }
        return false;
      }).toList();
      onChangeReservationsAssginTable(check);
    } else {
      onChangeReservationsAssginTable([]);
    }
  }

  // void logState() {
  //   showLogs(null, flags: 'createNewOrderDialogProvider');
  //   showLog(state.typeOrder, flags: 'typeOrder');
  //   showLog(state.reservationSelect, flags: 'reservationSelect');
  // }
}
