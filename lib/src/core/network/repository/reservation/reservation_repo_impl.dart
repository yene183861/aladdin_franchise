import 'dart:convert';

import 'package:aladdin_franchise/src/configs/api.dart';
import 'package:aladdin_franchise/src/configs/enums/app_log_action.dart';
import 'package:aladdin_franchise/src/core/network/api/app_exception.dart';
import 'package:aladdin_franchise/src/core/network/api/rest_client.dart';
import 'package:aladdin_franchise/src/core/network/api/safe_call_api.dart';
import 'package:aladdin_franchise/src/data/model/reservation/reservation.dart';
import 'package:aladdin_franchise/src/data/request/reservation_request.dart';
import 'package:aladdin_franchise/src/models/error_log.dart';
import 'package:aladdin_franchise/src/models/param/get_reservation_param.dart';

import 'reservation_repository.dart';

class ReservationRepositoryImpl extends ReservationRepository {
  final RestClient _client;

  ReservationRepositoryImpl(this._client);
  @override
  Future<bool> syncReservation(ReservationRequestModel param) async {
    final apiUrl = "${ApiConfig.apiUrl}/api/v1/reservation/sync";
    var body = jsonEncode(param.toJson());
    var result = await safeCallApi(
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
    if (!result.isSuccess) {
      throw AppException(
        statusCode: result.statusCode,
        message: result.error,
      );
    }

    return result.data ?? false;
  }

  @override
  Future<List<ReservationModel>> getReservations(ReservationRequestModel param) async {
    final apiUrl = "${ApiConfig.apiUrl}/api/v1/reservation?${param.toParamRequest()}";
    await syncReservation(param);
    var result = await safeCallApiList(
      () async {
        final url = Uri.parse(apiUrl);
        return _client.get(url);
      },
      wrapperResponse: true,
      dataKey: 'data',
      parser: (json) {
        var item = ReservationModel.fromJson(json);
        item = item.copyWith(rawData: json);
        return item;
      },
      log: ErrorLogModel(
        action: AppLogAction.getReservations,
        api: apiUrl,
      ),
    );
    if (!result.isSuccess) {
      throw AppException(
        statusCode: result.statusCode,
        message: result.error,
      );
    }

    return result.data ?? [];
  }

  @override
  Future<ReservationModel?> updateReservation(dynamic id, ReservationModel model) async {
    final apiUrl = '${ApiConfig.apiUrl}/api/v1/reservation/status/$id';
    var update = Map<String, dynamic>.from(model.rawData ?? {});
    update.addAll({
      'status': model.status.toString(),
      'status_name': model.statusName,
      'table': model.table,
      'table_id': model.tableId,
      'is_update': false,
    });
    var body = jsonEncode(update);
    var result = await safeCallApi(
      () async {
        final url = Uri.parse(apiUrl);
        return _client.put(url, body: body);
      },
      wrapperResponse: true,
      dataKey: 'data',
      parser: (json) {
        if (json == null) return null;
        var item = ReservationModel.fromJson(json);
        item = item.copyWith(rawData: json);
        return item;
      },
      log: ErrorLogModel(
        action: AppLogAction.updateReservation,
        api: apiUrl,
        request: body,
      ),
    );
    if (!result.isSuccess) {
      throw AppException(
        statusCode: result.statusCode,
        message: result.error,
      );
    }

    return result.data;
  }

  @override
  Future<ReservationModel?> getReservationById(dynamic id) async {
    final apiUrl = "${ApiConfig.apiUrl}/api/v1/reservation/detail/$id";
    var result = await safeCallApi(
      () async {
        final url = Uri.parse(apiUrl);
        return _client.get(url);
      },
      wrapperResponse: true,
      dataKey: 'data',
      parser: (json) {
        var item = ReservationModel.fromJson(json);
        item = item.copyWith(rawData: json);
        return item;
      },
      log: ErrorLogModel(
        action: AppLogAction.getReservationById,
        api: apiUrl,
      ),
    );
    if (!result.isSuccess) {
      throw AppException(
        statusCode: result.statusCode,
        message: result.error,
      );
    }

    return result.data;
  }
}
