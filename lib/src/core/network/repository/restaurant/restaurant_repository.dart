import 'package:aladdin_franchise/src/core/network/api/safe_call_api.dart';
import 'package:aladdin_franchise/src/models/atm_pos.dart';
import 'package:aladdin_franchise/src/models/employee_sale.dart';
import 'package:aladdin_franchise/src/models/history_order.dart';
import 'package:aladdin_franchise/src/models/param_family/bank_param.dart';
import 'package:aladdin_franchise/src/models/payment_method/payment_method.dart';
import 'package:aladdin_franchise/src/models/user_bank.dart';

abstract class RestaurantRepository {
  /// checked
  Future<ApiResult<List<UserBankModel>>> getBanks(ApiBankParam apiBankParam);

  /// checked
  Future<ApiResult<List<PaymentMethod>>> getPaymentMethod({required int orderId});
  Future<ApiResult<({String? url, String? qr, int? expiryMin, String? message, int? status})>>
      getPaymentGateway({
    required ApiBankParam apiBankParam,
    required int keyPaymentMethod,
  });

  /// danh sách máy cà thẻ
  Future<ApiResult<List<AtmPosModel>>> getListAtmPos({
    required int orderId,
    required dynamic totalBill,
  });

  Future<ApiResult<void>> atmPosCallback({
    required String urlPos,
    // tổng tiền cuối ? (thấy note trên posman vậy)
    required dynamic orderId,
  });

  /// checked
  Future<ApiResult<List<HistoryOrderModel>>> getOrderHistoryList({
    required DateTime startDate,
    required DateTime endDate,
  });
}
