import 'package:aladdin_franchise/src/configs/enums/type_order.dart';
import 'package:aladdin_franchise/src/data/model/reservation/reservation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'state.freezed.dart';

@freezed
class ReservationSectionState with _$ReservationSectionState {
  const factory ReservationSectionState({
    ReservationModel? reservationSelect,
    ReservationModel? reservationInit,
    @Default('') String textSearch,
    TypeOrderEnum? typeOrder,
  }) = _ReservationSectionState;
}
