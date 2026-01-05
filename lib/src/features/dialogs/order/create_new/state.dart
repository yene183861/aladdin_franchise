import 'package:aladdin_franchise/src/configs/enums/type_order.dart';
import 'package:aladdin_franchise/src/data/model/reservation/reservation.dart';
import 'package:aladdin_franchise/src/models/table.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'state.freezed.dart';

enum CreateNewOrderTabEnum {
  table,
  reservation,
}

extension CreateNewOrderTabEnumExt on CreateNewOrderTabEnum {
  int get key {
    switch (this) {
      case CreateNewOrderTabEnum.table:
        return 0;
      case CreateNewOrderTabEnum.reservation:
        return 1;

      default:
        return 0;
    }
  }

  String get title {
    switch (this) {
      case CreateNewOrderTabEnum.table:
        return 'Danh sách bàn';
      case CreateNewOrderTabEnum.reservation:
        return 'Lịch đặt bàn';

      default:
        return '';
    }
  }
}

@freezed
class CreateNewOrderDialogState with _$CreateNewOrderDialogState {
  const factory CreateNewOrderDialogState({
    @Default([]) List<TableModel> tableSelect,
    @Default([]) List<int> tableIds,
    @Default(CreateNewOrderTabEnum.table) CreateNewOrderTabEnum tabSelect,
    ReservationModel? reservationSelect,
    @Default(false) bool notifyReservation,
    @Default([]) List<ReservationModel> reservationsAssginTable,
    @Default(false) bool ignoreNotifyReservation,
    TypeOrderEnum? typeOrder,
    @Default(false) bool useReservation,
  }) = _CreateNewOrderDialogState;
}
