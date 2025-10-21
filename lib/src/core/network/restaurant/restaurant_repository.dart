import 'package:aladdin_franchise/src/models/atm_pos.dart';
import 'package:aladdin_franchise/src/models/employee_sale.dart';
import 'package:aladdin_franchise/src/models/history_order.dart';
import 'package:aladdin_franchise/src/models/param_family/bank_param.dart';
import 'package:aladdin_franchise/src/models/payment_method/payment_method.dart';
import 'package:aladdin_franchise/src/models/user_bank.dart';

abstract class RestaurantRepository {
  Future<List<UserBankModel>> getBanks(ApiBankParam apiBankParam);
  Future<List<PaymentMethod>> getPaymentMethod({required int orderId});
  Future<({String? url, String? qr, int? expiryMin, String? message, int? status})>
      getPaymentGateway({
    required ApiBankParam apiBankParam,
    required int keyPaymentMethod,
  });

  /// danh sách máy cà thẻ
  Future<List<AtmPosModel>> getListAtmPos({
    required int orderId,
    required dynamic totalBill,
  });

  Future<void> atmPosCallback({
    required String urlPos,
    // tổng tiền cuối ? (thấy note trên posman vậy)
    required dynamic orderId,
  });

  /// danh sách nv sale
  Future<List<EmployeeSaleModel>> getEmployeeSales();

  Future<List<HistoryOrderModel>> getOrderHistoryList({
    required DateTime startDate,
    required DateTime endDate,
  });
}
