import 'dart:convert';

import 'package:aladdin_franchise/src/configs/api.dart';
import 'package:aladdin_franchise/src/configs/app.dart';
import 'package:aladdin_franchise/src/configs/data_fake.dart';
import 'package:aladdin_franchise/src/configs/enums/app_log_action.dart';
import 'package:aladdin_franchise/src/core/network/app_exception.dart';
import 'package:aladdin_franchise/src/core/network/responses/create_order.dart';
import 'package:aladdin_franchise/src/core/network/rest_client.dart';
import 'package:aladdin_franchise/src/core/services/firestore.dart';
import 'package:aladdin_franchise/src/core/services/send_log/log_service.dart';
import 'package:aladdin_franchise/src/core/storages/local.dart';
import 'package:aladdin_franchise/src/models/error_log.dart';
import 'package:aladdin_franchise/src/models/order.dart';
import 'package:aladdin_franchise/src/models/param/get_reservation_param.dart';
import 'package:aladdin_franchise/src/models/reservation/reservation.dart';
import 'package:aladdin_franchise/src/models/waiter.dart';

import 'reservation_repo.dart';

class ReservationRepositoryImpl extends ReservationRepository {
  @override
  Future<bool> checkReservationSync(GetReservationParam param) async {
    final apiUrl = ApiConfig.checkReservationSync;
    var log = ErrorLogModel(
      api: apiUrl,
      action: AppLogAction.checkCodeWaiter,
      modelInterface: 'bool',
    );
    try {
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
      action: AppLogAction.checkCodeWaiter,
      api: apiUrl,
      modelInterface: [ReservationModel.getModelInterface()],
    );
    try {
      if (useDataFake) {
        return [];
      }
      await checkReservationSync(param);
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
      action: AppLogAction.checkCodeWaiter,
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
      LogService.sendLogs(
          log.copyWith(errorMessage: ex.toString(), createAt: DateTime.now()));

      if (ex is AppException) rethrow;
      throw AppException(message: ex.toString());
    }
  }

  // @override
  // Future<CreateOrderResponse> createOrderWithReservation(
  //   List<int> tableIds,
  //   OrderModel order, {
  //   WaiterModel? waiterTransfer,
  //   ReservationModel? reservation,
  // }) async {
  //   var api = ApiConfig.createOrderWithReservation;
  //   var log = ErrorLogModel(
  //     action: AppLogAction.checkCodeWaiter,
  //     api: api,
  //     modelInterface: CreateOrderResponse.getModelInterface(),
  //     order: order,
  //   );
  //   try {
  //     var loginData = LocalStorage.getDataLogin();
  //     var body = jsonEncode(<String, dynamic>{
  //       "lat": "0",
  //       "long": "0",
  //       "order_id": order.id,
  //       "payment_type": 25,
  //       "restaurant_id": loginData?.restaurant?.id,
  //       "table_id": tableIds.toString(),
  //       "total": 0,
  //       "waiter_id": order.waiterId,
  //       "waiter_id_transfer": waiterTransfer?.id,
  //       "reservation_crm_id": reservation?.id,
  //       "sale_name": reservation?.saleName ?? '',
  //       "sale_code": reservation?.saleCode ?? '',
  //     });

  //     log = log.copyWith(request: body);
  //     var response = await restClient.post(Uri.parse(api), body: body);
  //     log = log.copyWith(
  //       response: [response.statusCode, response.body],
  //       request: body,
  //     );
  //     if (response.statusCode == NetworkCodeConfig.ok) {
  //       var json = jsonDecode(response.body);
  //       var result = CreateOrderResponse.fromJson(json);
  //       return result;
  //     } else {
  //       throw AppException.fromStatusCode(response.statusCode);
  //     }
  //   } catch (ex) {
  //     LogService.sendLogs(
  //         log.copyWith(errorMessage: ex.toString(), createAt: DateTime.now()));

  //     if (ex is AppException) rethrow;
  //     throw AppException(message: ex.toString());
  //   }
  // }
}
