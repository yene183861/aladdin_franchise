import 'package:aladdin_franchise/src/core/network/api/safe_call_api.dart';
import 'package:aladdin_franchise/src/models/param/get_reservation_param.dart';
import 'package:aladdin_franchise/src/models/reservation/reservation.dart';

abstract class ReservationRepository {
  Future<ApiResult<bool>> syncReservation(GetReservationParam param);
  Future<ApiResult<List<ReservationModel>>> getReservations();
  Future<ApiResult<ReservationModel>> updateReservation(dynamic id, ReservationModel model);
}
