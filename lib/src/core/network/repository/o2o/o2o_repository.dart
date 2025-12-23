import 'package:aladdin_franchise/src/core/network/api/safe_call_api.dart';
import 'package:aladdin_franchise/src/models/o2o/chat_message_model.dart';
import 'package:aladdin_franchise/src/models/o2o/customer_info_model.dart';
import 'package:aladdin_franchise/src/models/o2o/o2o_order_model.dart';
import 'package:aladdin_franchise/src/models/o2o/request_order.dart';

abstract class OrderToOnlineRepository {
  Future<ApiResult<List<O2OOrderModel>>> getOrderToOnline();

  /// nếu xác nhận thì status = 1, hủy status = 2
  Future<ApiResult<void>> processO2oRequest({
    required int orderId,
    required int status,
    required int orderItemId,
    required List<RequestOrderItemModel> orderItems,
    String notes = '',
  });

  Future<ApiResult<List<ChatMessageModel>>> getChatMessages({
    required int restaurantId,
    required int orderId,
  });

  Future<ApiResult<List<O2oCustomerInfoModel>>> getO2OCustomerInfo({required int orderId});
}
