import 'package:aladdin_franchise/src/configs/enums/type_order.dart';
import 'package:aladdin_franchise/src/models/reservation/reservation.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'state.dart';

final reservationSectionProvider =
    StateNotifierProvider.autoDispose<ReservationSectionNotifier, ReservationSectionState>((ref) {
  return ReservationSectionNotifier(ref);
});

class ReservationSectionNotifier extends StateNotifier<ReservationSectionState> {
  ReservationSectionNotifier(this.ref) : super(const ReservationSectionState());
  final Ref ref;

  void init(
    dynamic initReservationId,
    Function(ReservationModel?)? onChangeItem,
    TypeOrderEnum? typeOrder,
  ) {
    state = state.copyWith(typeOrder: typeOrder);
    if (initReservationId != null) {
      var res = ReservationModel(
        id: initReservationId,
        reservationDate: '',
        startTime: '',
        endTime: '',
      );
      state = state.copyWith(
        reservationInit: res,
        reservationSelect: res,
      );
      onChangeItem?.call(res);
    }
  }

  void onChangeTextSearch(String? value) {
    state = state.copyWith(textSearch: value ?? '');
  }

  void onChangeReservationSelect(
    ReservationModel? value,
    Function(ReservationModel?)? onChangeItem,
  ) {
    state = state.copyWith(reservationSelect: value);
    onChangeItem?.call(value);
  }

  void onChangeReservationInit(ReservationModel? value) {
    state = state.copyWith(reservationInit: value);
  }

  void onChangeTypeOrder(TypeOrderEnum? value) {
    state = state.copyWith(typeOrder: value);
  }
}
