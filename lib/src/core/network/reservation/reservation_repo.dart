import 'package:aladdin_franchise/src/core/network/responses/create_order.dart';
import 'package:aladdin_franchise/src/models/order.dart';
import 'package:aladdin_franchise/src/models/param/get_reservation_param.dart';
import 'package:aladdin_franchise/src/models/reservation/reservation.dart';
import 'package:aladdin_franchise/src/models/waiter.dart';

abstract class ReservationRepository {
  Future<bool> checkReservationSync(GetReservationParam param);
  Future<List<ReservationModel>> getReservations();
  Future<ReservationModel> updateReservation(
      dynamic id, ReservationModel model);

  // Future<CreateOrderResponse> createOrderWithReservation(
  //   List<int> tableIds,
  //   OrderModel order, {
  //   WaiterModel? waiterTransfer,
  //   ReservationModel? reservation,
  // });
}
