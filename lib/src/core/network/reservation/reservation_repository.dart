import 'package:aladdin_franchise/src/models/param/get_reservation_param.dart';
import 'package:aladdin_franchise/src/models/reservation/reservation.dart';

abstract class ReservationRepository {
  Future<bool> syncReservation(GetReservationParam param);
  Future<List<ReservationModel>> getReservations();
  Future<ReservationModel> updateReservation(dynamic id, ReservationModel model);
}
