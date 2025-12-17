import 'dart:convert';

import 'package:aladdin_franchise/src/configs/api.dart';
import 'package:aladdin_franchise/src/configs/enums/app_log_action.dart';
import 'package:aladdin_franchise/src/core/network/api/rest_client.dart';
import 'package:aladdin_franchise/src/core/network/api/safe_call_api.dart';
import 'package:aladdin_franchise/src/core/storages/local.dart';
import 'package:aladdin_franchise/src/models/error_log.dart';
import 'package:aladdin_franchise/src/models/param/get_reservation_param.dart';
import 'package:aladdin_franchise/src/models/reservation/reservation.dart';

import 'reservation_repository.dart';

class ReservationRepositoryImpl extends ReservationRepository {
  final RestClient _client;

  ReservationRepositoryImpl(this._client);
  @override
  Future<ApiResult<bool>> syncReservation(GetReservationParam param) async {
    final uri = "${ApiConfig.apiUrl}/api/v1/reservation/sync";
    var body = param.toJson();
    return safeCallApi(
      () async {
        final url = Uri.parse(uri);
        return _client.post(
          url,
          body: jsonEncode(body),
        );
      },
      wrapperResponse: true,
      dataKey: 'data',
      log: ErrorLogModel(
        action: AppLogAction.syncReservation,
        api: uri,
        request: body,
      ),
    );
  }

  @override
  Future<ApiResult<List<ReservationModel>>> getReservations() async {
    var param = GetReservationParam(
      retaurantId: LocalStorage.getDataLogin()?.restaurant?.id ?? 0,
      startDate: DateTime.now(),
      endDate: DateTime.now(),
    );
    final uri = "${ApiConfig.apiUrl}/api/v1/reservation?${param.toParamRequest()}";
    var syn = await syncReservation(param);
    if (!syn.isSuccess) {
      return ApiResult.failure(syn.statusCode, syn.error);
    }
    return safeCallApiList(
      () async {
        final url = Uri.parse(uri);
        return _client.get(url);
      },
      wrapperResponse: true,
      dataKey: 'data',
      parser: (json) => ReservationModel.fromJson(json),
      log: ErrorLogModel(
        action: AppLogAction.getReservations,
        api: uri,
      ),
    );
  }

  @override
  Future<ApiResult<ReservationModel>> updateReservation(dynamic id, ReservationModel model) async {
    final uri = '${ApiConfig.apiUrl}/api/v1/reservation/status/$id';
    var reservationModel = model.toJson();
    //   // hình như bên anh T.A cần convert sang thế này
    reservationModel['status'] = reservationModel['status'].toString();
    var body = jsonEncode(reservationModel);
    return safeCallApi(
      () async {
        final url = Uri.parse(uri);
        return _client.put(url, body: body);
      },
      wrapperResponse: true,
      parser: (json) => ReservationModel.fromJson(json),
      log: ErrorLogModel(
        action: AppLogAction.updateReservation,
        api: uri,
        request: body,
      ),
    );

    // final url = '${ApiConfig.updateReservation}/$id';
    // var log = ErrorLogModel(
    //   action: AppLogAction.updateReservation,
    //   api: url,
    //   modelInterface: ReservationModel.getModelInterface(),
    // );
    // try {
    //   var reservationModel = model.toJson();
    //   // hình như bên anh T.A cần convert sang thế này
    //   reservationModel['status'] = reservationModel['status'].toString();
    //   var body = jsonEncode(reservationModel);
    //   log = log.copyWith(request: body);
    //   var response = await restClient.put(Uri.parse(url), body: body);
    //   log = log.copyWith(
    //     response: [response.statusCode, response.body],
    //   );
    //   if (response.statusCode == NetworkCodeConfig.ok) {
    //     return model;
    //   } else {
    //     throw AppException.fromStatusCode(response.statusCode);
    //   }
    // } catch (ex) {
    //   showLog(ex.toString(), flags: 'updateReservation ex');
    //   LogService.sendLogs(log.copyWith(errorMessage: ex.toString(), createAt: DateTime.now()));

    //   if (ex is AppException) rethrow;
    //   throw AppException(message: ex.toString());
    // }
  }
}
