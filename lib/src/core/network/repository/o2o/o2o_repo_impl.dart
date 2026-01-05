import 'dart:convert';

import 'package:aladdin_franchise/src/configs/api.dart';
import 'package:aladdin_franchise/src/configs/app.dart';
import 'package:aladdin_franchise/src/configs/enums/app_log_action.dart';
import 'package:aladdin_franchise/src/core/network/api/app_exception.dart';
import 'package:aladdin_franchise/src/core/network/api/safe_call_api.dart';
import 'package:aladdin_franchise/src/core/network/repository/o2o/o2o_repository.dart';
import 'package:aladdin_franchise/src/core/network/api/rest_client.dart';
import 'package:aladdin_franchise/src/core/storages/local.dart';
import 'package:aladdin_franchise/src/models/error_log.dart';
import 'package:aladdin_franchise/src/models/o2o/chat_message_model.dart';
import 'package:aladdin_franchise/src/models/o2o/customer_info_model.dart';
import 'package:aladdin_franchise/src/models/o2o/o2o_order_model.dart';
import 'package:aladdin_franchise/src/models/o2o/request_order.dart';
import 'package:aladdin_franchise/src/models/order.dart';

class OrderToOnlineRepositoryImpl extends OrderToOnlineRepository {
  final RestClient _client;

  OrderToOnlineRepositoryImpl(this._client);

  @override
  Future<List<O2OOrderModel>> getOrderToOnline() async {
    final loginData = LocalStorage.getDataLogin();
    final apiUrl =
        "${ApiConfig.apiUrl}/api/v1/user-order-line-item?restaurant_id=${loginData?.restaurant?.id ?? ''}";
    var result = await safeCallApiList(
      () {
        final url = Uri.parse(apiUrl);
        return _client.get(url);
      },
      dataKey: 'data',
      parser: (json) => O2OOrderModel.fromJson(json),
      log: ErrorLogModel(
        action: AppLogAction.getOrderToOnline,
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
  Future<bool> processO2oRequest({
    required int orderId,
    required int status,
    required int orderItemId,
    required List<RequestOrderItemModel> orderItems,
    String notes = '',
  }) async {
    final loginData = LocalStorage.getDataLogin();
    final apiUrl = "${ApiConfig.apiUrl}/api/v1/update-status-user-order";
    final body = jsonEncode(<String, dynamic>{
      "item_order_id": orderItemId,
      "status": status,
      "order_id": orderId,
      "restaurant_id": loginData?.restaurant?.id ?? 0,
      "items": jsonEncode(orderItems),
      "notes": notes,
    });
    var result = await safeCallApi(
      () {
        final url = Uri.parse(apiUrl);
        return _client.post(url, body: body);
      },
      dataKey: 'data',
      log: ErrorLogModel(
        action: AppLogAction.processO2oRequest,
        api: apiUrl,
        order: OrderModel(id: orderId),
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
  Future<List<ChatMessageModel>> getChatMessages({
    required int restaurantId,
    required int orderId,
  }) async {
    final dataLogin = LocalStorage.getDataLogin();
    final apiUrl = "${dataLogin?.restaurant?.urlServerO2o}/$restaurantId/$orderId/$kDeviceId";
    var result = await safeCallApiList(
      () {
        final url = Uri.parse(apiUrl);
        return _client.get(url);
      },
      parser: (json) => ChatMessageModel.fromJson(json),
      log: ErrorLogModel(
        action: AppLogAction.getChatMessages,
        api: apiUrl,
        order: OrderModel(id: orderId),
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
  Future<List<O2oCustomerInfoModel>> getO2OCustomerInfo({required int orderId}) async {
    final dataLogin = LocalStorage.getDataLogin();
    final apiUrl = "${ApiConfig.apiUrl}/api/v1/get-customer-info";
    var body = jsonEncode(<String, dynamic>{
      "restaurant_id": dataLogin?.restaurant?.id,
      "order_id": orderId,
    });
    var result = await safeCallApiList(
      () {
        final url = Uri.parse(apiUrl);
        return _client.post(
          url,
          body: body,
        );
      },
      dataKey: 'data',
      parser: (json) => O2oCustomerInfoModel.fromJson(json),
      wrapperResponse: true,
      log: ErrorLogModel(
        action: AppLogAction.getO2oCustomerInfo,
        api: apiUrl,
        order: OrderModel(id: orderId),
        request: body,
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
}
