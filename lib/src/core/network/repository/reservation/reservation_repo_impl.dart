import 'dart:convert';

import 'package:aladdin_franchise/src/configs/api.dart';
import 'package:aladdin_franchise/src/configs/enums/app_log_action.dart';
import 'package:aladdin_franchise/src/core/network/api/rest_client.dart';
import 'package:aladdin_franchise/src/core/network/api/safe_call_api.dart';
import 'package:aladdin_franchise/src/models/error_log.dart';
import 'package:aladdin_franchise/src/models/param/get_reservation_param.dart';
import 'package:aladdin_franchise/src/models/reservation/reservation.dart';

import 'reservation_repository.dart';

class ReservationRepositoryImpl extends ReservationRepository {
  final RestClient _client;

  ReservationRepositoryImpl(this._client);
  @override
  Future<ApiResult<bool>> syncReservation(GetReservationParam param) async {
    final apiUrl = "${ApiConfig.apiUrl}/api/v1/reservation/sync";
    var body = jsonEncode(param.toJson());
    return safeCallApi(
      () async {
        final url = Uri.parse(apiUrl);
        return _client.post(url, body: body);
      },
      wrapperResponse: true,
      dataKey: 'data',
      log: ErrorLogModel(
        action: AppLogAction.syncReservation,
        api: apiUrl,
        request: body,
      ),
    );
  }

  @override
  Future<ApiResult<List<ReservationModel>>> getReservations(GetReservationParam param) async {
    final apiUrl = "${ApiConfig.apiUrl}/api/v1/reservation?${param.toParamRequest()}";
    var syn = await syncReservation(param);
    if (!syn.isSuccess) {
      return ApiResult.failure(syn.statusCode, syn.error);
    }
    return safeCallApiList(
      () async {
        final url = Uri.parse(apiUrl);
        return _client.get(url);
      },
      wrapperResponse: true,
      dataKey: 'data',
      parser: (json) => ReservationModel.fromJson(json),
      log: ErrorLogModel(
        action: AppLogAction.getReservations,
        api: apiUrl,
      ),
    );
  }

  @override
  Future<ApiResult<ReservationModel?>> updateReservation(dynamic id, ReservationModel model) async {
    final apiUrl = '${ApiConfig.apiUrl}/api/v1/reservation/status/$id';
    var reservationModel = model.toJson();
    // bên anh T.A cần convert sang thế này
    reservationModel['status'] = reservationModel['status'].toString();
    var body = jsonEncode(reservationModel);
    return safeCallApi(
      () async {
        final url = Uri.parse(apiUrl);
        return _client.put(url, body: body);
      },
      wrapperResponse: true,
      dataKey: 'data',
      parser: (json) {
        if (json == null) return null;
        return ReservationModel.fromJson(json);
      },
      log: ErrorLogModel(
        action: AppLogAction.updateReservation,
        api: apiUrl,
        request: body,
      ),
    );
  }

  @override
  Future<ApiResult<ReservationModel>> getReservationById({required dynamic id}) async {
    final apiUrl = "${ApiConfig.apiUrl}/api/v1/reservation/detail/$id";
    return safeCallApi(
      () async {
        final url = Uri.parse(apiUrl);
        return _client.get(url);
      },
      wrapperResponse: true,
      dataKey: 'data',
      parser: (json) => ReservationModel.fromJson(json),
      log: ErrorLogModel(
        action: AppLogAction.getReservationById,
        api: apiUrl,
      ),
    );
  }
}
