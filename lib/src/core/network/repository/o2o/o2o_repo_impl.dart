import 'dart:convert';

import 'package:aladdin_franchise/src/configs/api.dart';
import 'package:aladdin_franchise/src/configs/app.dart';
import 'package:aladdin_franchise/src/configs/enums/app_log_action.dart';
import 'package:aladdin_franchise/src/core/network/api/app_exception.dart';
import 'package:aladdin_franchise/src/core/network/repository/o2o/o2o_repository.dart';
import 'package:aladdin_franchise/src/core/network/api/rest_client.dart';
import 'package:aladdin_franchise/src/core/services/send_log/log_service.dart';
import 'package:aladdin_franchise/src/core/storages/local.dart';
import 'package:aladdin_franchise/src/models/error_log.dart';
import 'package:aladdin_franchise/src/models/o2o/chat_message_model.dart';
import 'package:aladdin_franchise/src/models/o2o/customer_info_model.dart';
import 'package:aladdin_franchise/src/models/o2o/o2o_order_model.dart';
import 'package:aladdin_franchise/src/models/o2o/request_order.dart';
import 'package:aladdin_franchise/src/models/order.dart';
import 'package:aladdin_franchise/src/utils/app_log.dart';

class OrderToOnlineRepositoryImpl extends OrderToOnlineRepository {
  final RestClient _client;

  OrderToOnlineRepositoryImpl(this._client);
  @override
  Future<List<O2OOrderModel>> getOrderToOnline() async {
    return [];
    // var log = ErrorLogModel(
    //   action: AppLogAction.getOrderToOnline,
    //   modelInterface: O2OOrderModel.getModelInterface(),
    // );
    // try {
    //   final loginData = LocalStorage.getDataLogin();
    //   final apiUrl =
    //       '${ApiConfig.getOrderToOnline}?restaurant_id=${loginData?.restaurant?.id ?? ''}';
    //   log = log.copyWith(api: apiUrl);
    //   final response = await restClient.get(Uri.parse(apiUrl));
    //   log = log.copyWith(
    //     response: [response.statusCode, response.body],
    //   );
    //   if (response.statusCode != 200) {
    //     throw AppException.fromHttpResponse(response);
    //   } else {
    //     var bodyJson = jsonDecode(response.body);
    //     final data = bodyJson['data'] as List;
    //     final result = data.map((e) => O2OOrderModel.fromJson(e)).toList();

    //     return result;
    //   }
    // } catch (ex) {
    //   showLog(ex, flags: 'getOrderToOnline ex');
    //   LogService.sendLogs(log.copyWith(errorMessage: ex.toString(), createAt: DateTime.now()));

    //   if (ex is AppException) rethrow;
    //   throw AppException(message: ex.toString());
    // }
  }

  @override
  Future<void> processO2oRequest({
    required int orderId,
    required int status,
    required int orderItemId,
    required List<RequestOrderItemModel> orderItems,
    String notes = '',
  }) async {
    return;
    // final apiUrl = ApiConfig.processO2oRequest;
    // var log = ErrorLogModel(
    //   action: AppLogAction.processO2oRequest,
    //   api: apiUrl,
    //   modelInterface: 'xác nhận status = 1, hủy status = 2',
    //   order: OrderModel(id: orderId),
    // );
    // try {
    //   final loginData = LocalStorage.getDataLogin();
    //   final list = jsonEncode(orderItems);
    //   final bodyRequest = jsonEncode(<String, dynamic>{
    //     "item_order_id": orderItemId,
    //     "status": status,
    //     "order_id": orderId,
    //     "restaurant_id": loginData?.restaurant?.id ?? 0,
    //     "items": list,
    //     "notes": notes,
    //   });
    //   log = log.copyWith(request: bodyRequest);
    //   final response = await restClient.post(Uri.parse(apiUrl), body: bodyRequest);
    //   log = log.copyWith(
    //     response: [response.statusCode, response.body],
    //   );
    //   if (response.statusCode != 200) {
    //     throw AppException.fromHttpResponse(response);
    //   }
    // } catch (ex) {
    //   showLog(ex, flags: 'processO2oRequest ex');
    //   LogService.sendLogs(log.copyWith(errorMessage: ex.toString(), createAt: DateTime.now()));

    //   if (ex is AppException) rethrow;
    //   throw AppException(message: ex.toString());
    // }
  }

  @override
  Future<List<ChatMessageModel>> getChatMessages({
    required int restaurantId,
    required int orderId,
  }) async {
    return [];
    // final dataLogin = LocalStorage.getDataLogin();
    // final apiUrl = "${dataLogin?.restaurant?.urlServerO2o}/$restaurantId/$orderId/$kDeviceId";
    // var log = ErrorLogModel(
    //   action: AppLogAction.getChatMessages,
    //   api: apiUrl,
    //   modelInterface: ChatMessageModel.getModelInterface(),
    //   order: OrderModel(id: orderId),
    // );
    // try {
    //   final response = await restClient.get(Uri.parse(apiUrl));
    //   log = log.copyWith(
    //     response: [response.statusCode, response.body],
    //   );
    //   if (response.statusCode == 200) {
    //     var bodyJson = jsonDecode(response.body);
    //     final result = (bodyJson as List).map((e) => ChatMessageModel.fromJson(e)).toList();
    //     return result;
    //   }
    //   throw AppException.fromHttpResponse(response);
    // } catch (ex) {
    //   showLog(ex, flags: 'getChatMessages ex');
    //   LogService.sendLogs(log.copyWith(errorMessage: ex.toString(), createAt: DateTime.now()));

    //   if (ex is AppException) rethrow;
    //   throw AppException(message: ex.toString());
    // }
  }

  @override
  Future<List<O2oCustomerInfoModel>> getO2OCustomerInfo({required int orderId}) async {
    return [];
    // final dataLogin = LocalStorage.getDataLogin();
    // final apiUrl = ApiConfig.getO2oCustomerInfo;
    // var log = ErrorLogModel(
    //   action: AppLogAction.getO2oCustomerInfo,
    //   api: apiUrl,
    //   order: OrderModel(id: orderId),
    // );
    // try {
    //   var bodyRequest = jsonEncode(<String, dynamic>{
    //     "restaurant_id": dataLogin?.restaurant?.id,
    //     "order_id": orderId,
    //   });
    //   log = log.copyWith(
    //     request: bodyRequest,
    //   );
    //   final response = await restClient.post(
    //     Uri.parse(apiUrl),
    //     body: bodyRequest,
    //   );
    //   log = log.copyWith(
    //     response: [response.statusCode, response.body],
    //   );
    //   if (response.statusCode == 200) {
    //     var bodyJson = jsonDecode(response.body);
    //     var customers = (bodyJson['data'] as List)
    //         .map((e) => O2oCustomerInfoModel.fromJson(e))
    //         .toList();
    //     return customers;
    //   }
    //   throw AppException.fromHttpResponse(response);
    // } catch (ex) {
    //   showLog(ex, flags: 'getO2OCustomerInfo ex');
    //   LogService.sendLogs(
    //       log.copyWith(errorMessage: ex.toString(), createAt: DateTime.now()));

    //   if (ex is AppException) rethrow;
    //   throw AppException(message: ex.toString());
    // }
  }
}
