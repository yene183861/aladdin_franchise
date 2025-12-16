import 'dart:convert';

import 'package:aladdin_franchise/src/configs/api.dart';
import 'package:aladdin_franchise/src/configs/app.dart';
import 'package:aladdin_franchise/src/configs/enums/app_log_action.dart';
import 'package:aladdin_franchise/src/core/network/app_exception.dart';
import 'package:aladdin_franchise/src/core/network/rest_client.dart';
import 'package:aladdin_franchise/src/core/services/send_log/log_service.dart';
import 'package:aladdin_franchise/src/core/storages/local.dart';
import 'package:aladdin_franchise/src/models/error_log.dart';
import 'package:aladdin_franchise/src/models/param/get_reservation_param.dart';
import 'package:aladdin_franchise/src/models/reservation/reservation.dart';
import 'package:aladdin_franchise/src/utils/app_log.dart';
import 'package:flutter/foundation.dart';

import 'reservation_repository.dart';

class ReservationRepositoryImpl extends ReservationRepository {
  @override
  Future<bool> syncReservation(GetReservationParam param) async {
    final apiUrl = ApiConfig.syncReservation;
    var log = ErrorLogModel(
      api: apiUrl,
      action: AppLogAction.syncReservation,
      modelInterface: 'bool',
    );
    try {
      // if (kDebugMode) return true;
      var bodyRequest = jsonEncode(param.toJson());
      log = log.copyWith(request: bodyRequest);
      var response = await restClient.post(
        Uri.parse(apiUrl),
        body: bodyRequest,
      );
      log = log.copyWith(
        response: [response.statusCode, response.body],
      );

      if (response.statusCode == NetworkCodeConfig.ok) {
        var body = jsonDecode(response.body);
        body = body['data'];
        if (body['status'] != NetworkCodeConfig.ok) {
          throw AppException.fromStatusCode(body['status']);
        }
        return body['data'];
      } else {
        throw AppException.fromStatusCode(response.statusCode);
      }
    } catch (ex) {
      showLog(ex.toString(), flags: 'syncReservation ex');
      LogService.sendLogs(
          log.copyWith(errorMessage: ex.toString(), createAt: DateTime.now()));

      if (ex is AppException) rethrow;
      throw AppException(message: ex.toString());
    }
  }

  @override
  Future<List<ReservationModel>> getReservations() async {
    final loginData = LocalStorage.getDataLogin();
    var param = GetReservationParam(
      retaurantId: loginData?.restaurant?.id ?? 0,
      startDate: DateTime.now(),
      endDate: DateTime.now(),
    );
    var apiUrl = "${ApiConfig.getReservations}?${param.toParamRequest()}";
    var log = ErrorLogModel(
      action: AppLogAction.getReservations,
      api: apiUrl,
      modelInterface: [ReservationModel.getModelInterface()],
    );
    try {
      await syncReservation(param);
      // if (kDebugMode) return [];
      var response = await restClient.get(Uri.parse(apiUrl));
      log = log.copyWith(
        response: [response.statusCode, response.body],
      );
      if (response.statusCode == NetworkCodeConfig.ok) {
        final bodyJson = jsonDecode(response.body);
        final result = (bodyJson['data']['data'] as List)
            .map((e) => ReservationModel.fromJson(e))
            .toList();
        return result;
      } else {
        throw AppException.fromStatusCode(response.statusCode);
      }
    } catch (ex) {
      showLog(ex.toString(), flags: 'getReservations ex');
      LogService.sendLogs(
          log.copyWith(errorMessage: ex.toString(), createAt: DateTime.now()));

      if (ex is AppException) rethrow;
      throw AppException(message: ex.toString());
    }
  }

  @override
  Future<ReservationModel> updateReservation(
      dynamic id, ReservationModel model) async {
    final url = '${ApiConfig.updateReservation}/$id';
    var log = ErrorLogModel(
      action: AppLogAction.updateReservation,
      api: url,
      modelInterface: ReservationModel.getModelInterface(),
    );
    try {
      var reservationModel = model.toJson();
      // hình như bên anh T.A cần convert sang thế này
      reservationModel['status'] = reservationModel['status'].toString();
      var body = jsonEncode(reservationModel);
      log = log.copyWith(request: body);
      var response = await restClient.put(Uri.parse(url), body: body);
      log = log.copyWith(
        response: [response.statusCode, response.body],
      );
      if (response.statusCode == NetworkCodeConfig.ok) {
        return model;
      } else {
        throw AppException.fromStatusCode(response.statusCode);
      }
    } catch (ex) {
      showLog(ex.toString(), flags: 'updateReservation ex');
      LogService.sendLogs(
          log.copyWith(errorMessage: ex.toString(), createAt: DateTime.now()));

      if (ex is AppException) rethrow;
      throw AppException(message: ex.toString());
    }
  }
}
