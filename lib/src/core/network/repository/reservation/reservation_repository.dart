import 'package:aladdin_franchise/src/core/network/api/safe_call_api.dart';
import 'package:aladdin_franchise/src/models/param/get_reservation_param.dart';
import 'package:aladdin_franchise/src/models/reservation/reservation.dart';

abstract class ReservationRepository {
  /// checked
  Future<ApiResult<bool>> syncReservation(GetReservationParam param);

  /// checked
  Future<ApiResult<List<ReservationModel>>> getReservations(GetReservationParam param);

  /// checked
  Future<ApiResult<ReservationModel?>> updateReservation(dynamic id, ReservationModel model);

  /// checked
  Future<ApiResult<ReservationModel>> getReservationById({required dynamic id});
}
