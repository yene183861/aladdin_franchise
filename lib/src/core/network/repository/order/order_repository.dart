import 'dart:io';

import 'package:aladdin_franchise/src/core/network/api/safe_call_api.dart';
import 'package:aladdin_franchise/src/core/network/repository/responses/create_order.dart';
import 'package:aladdin_franchise/src/core/network/repository/responses/data_bill.dart';
import 'package:aladdin_franchise/src/core/network/repository/responses/order.dart';
import 'package:aladdin_franchise/src/core/network/repository/responses/process_order.dart';
import 'package:aladdin_franchise/src/core/network/repository/responses/product_checkout.dart';
import 'package:aladdin_franchise/src/data/model/reservation/reservation.dart';
import 'package:aladdin_franchise/src/models/comment.dart';
import 'package:aladdin_franchise/src/models/customer/cusomter_portrait.dart';
import 'package:aladdin_franchise/src/models/customer/customer_policy.dart';
import 'package:aladdin_franchise/src/models/customer/customer_rating.dart';
import 'package:aladdin_franchise/src/models/data_bill.dart';
import 'package:aladdin_franchise/src/models/ip_order.dart';
import 'package:aladdin_franchise/src/models/order.dart';
import 'package:aladdin_franchise/src/models/param_family/bank_param.dart';
import 'package:aladdin_franchise/src/models/payment_method/payment_method.dart';
import 'package:aladdin_franchise/src/models/policy_result.dart';
import 'package:aladdin_franchise/src/models/product.dart';
import 'package:aladdin_franchise/src/models/product_checkout.dart';
import 'package:aladdin_franchise/src/models/waiter.dart';

abstract class OrderRepository {
  Future<OrdersResponseData> getOrders({int? typeOrder});

  Future<CreateOrderResponse> createAndUpdateOrder(
    List<int> tableIds,
    OrderModel order, {
    WaiterModel? waiterTransfer,
    int? typeOrder,
    ReservationModel? reservation,
    bool updateSaleInfo = true,
  });

  Future<ProductCheckoutResponse> getProductCheckout(OrderModel? order);

  /// Lấy ip máy in
  ///
  /// printerType: [1] in thanh toán, [2,4] in bếp & bar
  Future<List<IpOrderModel>> getIpPrinterOrder(
      OrderModel order, List<int> printerType);

  /// Success => true
  ///
  /// Error => Exception
  Future<bool> payment({
    required OrderModel order,
    required List<IpOrderModel> infoPrint,
    required List<ProductCheckoutModel> products,
    required List<CustomerPolicyModel> vouchers,
    // required List<PolicyResultModel> vouchers,
    required dynamic createVouchers,
    CommentModel? comment,
    required int numberOfAdults,
    required int numberOfChildren,
    required String note,
    required bool flagInvoice,
    required ListCustomerRating customerRatings,
    //required PaymentDataBillCheck paymentDataBillCheck,
    required List<File> imageBills,
    int? paymentMethod,
    CustomerPortrait? customerPortrait,
    required bool statusPaymentCompleted,
    dynamic totalPaymentCompleted,
  });

  /// gọi hoặc huỷ món
  ///
  /// cancel: true - huy mon | false - goi mon
  Future<ProcessOrderResponse> processOrderItem({
    required OrderModel order,
    required double total,
    List<ProductModel> products = const [],
    List<ProductCheckoutModel> productCheckout = const [],
    String? note,
    bool cancel = false,
  });

  Future<DataBillResponseData> getDataBill({required int orderId});

  /// Kiểm tra tình trạng máy in dành cho gọi món, huỷ món
  ///
  /// Kiểm tra tuỳ thuộc vào loại món ăn được yêu cầu (printerCheck)
  Future<List<IpOrderModel>> getPrinterBill(
    OrderModel order,
    List<int> printerCheck,
  );

  /// @order_id
  ///
  /// [statusLock]: 1 khoá, 0 mở khoá
  Future<bool> lockOrder({
    required int orderId,
    required int statusLock,
  });

  /// [arrMethod] : keyPaymentMethod--priceFinal
  Future<String?> completeBill({
    required OrderModel order,
    String description = '',
    List<String> arrMethod = const [],
    int amountChildren = 0,
    int amountAdult = 1,
    required String portrait,
    required dynamic totalPrice,
    required dynamic totalPriceVoucher,
    required dynamic totalPriceTax,
    required dynamic totalPriceFinal,
    required String eSaleName,
    required String eSaleCode,
    int isPrintPeople = 0,
  });

  /// tax: dạng 0.08
  /// truyền lên server phải đổi về 8
  Future<List<ProductCheckoutUpdateTaxModel>> updateTax({
    required OrderModel order,
    required List<ProductCheckoutModel> pc,
    PaymentMethod? paymentMethod,
  });

  Future<bool> checkStatusLockOrder(int orderId);

  Future<({String? qrData, String? message, dynamic status})>
      getQrBankDynamicPayment({
    required ApiBankParam apiBankParam,
    required int keyPaymentMethod,
    required String bankCode,
  });
}
