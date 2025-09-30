import 'package:aladdin_franchise/src/configs/enums/type_order.dart';
import 'package:aladdin_franchise/src/models/reservation/reservation.dart';
import 'package:aladdin_franchise/src/models/table.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'state.freezed.dart';

enum CreateNewOrderTabEnum {
  table,
  reservation,
}

extension CreateNewOrderTabEnumEx on CreateNewOrderTabEnum {
  int get index {
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
    // @Default([]) List<int> previousTableIds,
    @Default([]) List<int> tableIds,
    @Default(0) int tabIndexSelect,
    ReservationModel? reservationSelect,
    @Default('') String textSearchReservation,
    @Default(false) bool notifyReservation,
    @Default([]) List<ReservationModel> reservationsAssginTable,
    @Default(false) bool ignoreNotifyReservation,
    @Default(2) int typeOrderSelect,
  }) = _CreateNewOrderDialogState;
}
