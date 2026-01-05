import 'package:aladdin_franchise/src/data/model/reservation/reservation.dart';
import 'package:aladdin_franchise/src/data/request/reservation_request.dart';

abstract class ReservationRepository {
  Future<bool> syncReservation(ReservationRequestModel param);

  Future<List<ReservationModel>> getReservations(ReservationRequestModel param);

  Future<ReservationModel?> updateReservation(dynamic id, ReservationModel model);

  Future<ReservationModel?> getReservationById(dynamic id);
}
