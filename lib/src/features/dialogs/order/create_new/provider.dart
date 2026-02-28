import 'package:aladdin_franchise/src/configs/app.dart';
import 'package:aladdin_franchise/src/configs/enums/type_order.dart';
import 'package:aladdin_franchise/src/core/storages/local.dart';
import 'package:aladdin_franchise/src/data/enum/reservation_status.dart';
import 'package:aladdin_franchise/src/data/model/reservation/reservation.dart';
import 'package:aladdin_franchise/src/features/dialogs/order/reservation/provider.dart';
import 'package:aladdin_franchise/src/models/table.dart';
import 'package:aladdin_franchise/src/utils/app_log.dart';
import 'package:flutter/foundation.dart';

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
  bool statusReservationsDialogOpen = false;

  /// danh sách lịch đặt bàn đã lọc theo type, search
  List<ReservationModel> filteredReservations = [];

  void init([Set<TableModel> tableSelectInit = const {}]) {
    state = state.copyWith(tableSelect: tableSelectInit);
    if (tableSelectInit.isNotEmpty) {
      var typeOrder = tableSelectInit.firstOrNull?.typeOrder;
      state = state.copyWith(
        typeOrder: typeOrder == null ? null : convertToTypeOrderEnum(typeOrder),
        reservationSelect: null,
      );
      updateReservationSectionState();
      onCheckReservation();
    }
  }

  void onChangeTabSelect(CreateNewOrderTabEnum value) {
    state = state.copyWith(tabSelect: value);
  }

  void onChangeTableSelect({required TableModel value, bool onSelected = false}) async {
    var tableSelect = Set<TableModel>.from(state.tableSelect);
    TypeOrderEnum? typeOrder = state.typeOrder;
    if (onSelected) {
      tableSelect.add(value);
      typeOrder = convertToTypeOrderEnum(value.typeOrder);
      tableSelect.removeWhere((e) => typeOrder != null && e.typeOrder != typeOrder.type);
    } else {
      tableSelect.removeWhere((e) => e.id == value.id);
    }
    await onChangeTypeOrder(tableSelect.isEmpty ? null : typeOrder);
    state = state.copyWith(tableSelect: tableSelect);
    updateReservationSectionState();
    onCheckReservation();
  }

  Future<void> onChangeTypeOrder(TypeOrderEnum? value) async {
    if (value != null && state.typeOrder != value) {
      state = state.copyWith(
        tableSelect: {},
        typeOrder: value,
        reservationSelect:
            state.reservationSelect?.typeOrder == value ? state.reservationSelect : null,
      );
    } else {
      state = state.copyWith(typeOrder: value);
    }
    updateReservationSectionState();
    onCheckReservation();
  }

  void onChangeReservationSelect(ReservationModel? item, List<TableModel> tables) async {
    state = state.copyWith(reservationSelect: item);
    if (item != null) {
      var tableSelect = tables.where((e) => item.getTableIds.contains(e.id)).toSet();
      var first = tableSelect.firstOrNull;
      if (first != null) {
        onChangeTableSelect(value: first, onSelected: true);
      }
      state = state.copyWith(
        tableSelect: {
          ...tableSelect,
          ...state.tableSelect,
        },
        reservationSelect: item,
      );
    } else {
      updateReservationSectionState();
    }
  }

  void onChangeNotifyReservation(bool value) {
    state = state.copyWith(notifyReservation: value);
  }

  void onChangeHoldingReservations(List<ReservationModel> value) {
    state = state.copyWith(holdingReservations: value);
    if (state.reservationSelect == null &&
        state.holdingReservations.isNotEmpty &&
        !state.notifyReservation) {
      onChangeNotifyReservation(true);
    }
  }

  void onChangeIgnoreReservationWarning() {
    state = state.copyWith(ignoreReservationWarning: !state.ignoreReservationWarning);
  }

  void updateReservationSectionState() {
    if (state.useReservation) {
      var reservation = state.reservationSelect;
      try {
        ref.read(reservationSectionProvider.notifier).onChangeReservationSelect(reservation, null);
        ref.read(reservationSectionProvider.notifier).onChangeTypeOrder(state.typeOrder);
      } catch (ex) {
        //
      }
    }
  }

  void saveFilteredReservations(List<ReservationModel> value) {
    filteredReservations = value;
    onCheckReservation();
  }

  /// lọc các lịch đặt để hiển thị popup cảnh báo, thoả mãn tất cả:
  /// + reservationSelect == null
  /// + status = accept
  /// + [now - 30p; now + 30p]
  /// + có ít nhất 1 bàn đang chọn trùng với lịch giữ chỗ
  void onCheckReservation() {
    if (state.tableSelect.isNotEmpty) {
      var tableIds = state.tableSelect.map((e) => e.id).toSet();
      var check = filteredReservations.where((e) {
        var start = e.startDateTime;
        var diffMinutes = start.difference(DateTime.now()).inMinutes.abs();
        if (diffMinutes <= (kDebugMode ? 120 : 30) &&
            state.reservationSelect == null &&
            e.getReservationStatus == ReservationStatusEnum.accept &&
            tableIds.intersection(e.getTableIds).isNotEmpty) {
          return true;
        }
        return false;
      }).toList();
      onChangeHoldingReservations(check);
    } else {
      onChangeHoldingReservations([]);
    }
  }

  void onChangeStatusReservationsDialogOpen(bool value) {
    statusReservationsDialogOpen = value;
  }
}
