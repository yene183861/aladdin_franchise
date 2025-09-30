import 'dart:io';

import 'package:aladdin_franchise/src/core/network/responses/create_order.dart';
import 'package:aladdin_franchise/src/core/network/responses/data_bill.dart';
import 'package:aladdin_franchise/src/core/network/responses/order.dart';
import 'package:aladdin_franchise/src/core/network/responses/process_order.dart';
import 'package:aladdin_franchise/src/core/network/responses/product_checkout.dart';
import 'package:aladdin_franchise/src/models/comment.dart';
import 'package:aladdin_franchise/src/models/customer/cusomter_portrait.dart';
import 'package:aladdin_franchise/src/models/customer/customer_rating.dart';
import 'package:aladdin_franchise/src/models/data_bill.dart';
import 'package:aladdin_franchise/src/models/history_order.dart';
import 'package:aladdin_franchise/src/models/ip_order.dart';
import 'package:aladdin_franchise/src/models/o2o/chat_message_model.dart';
import 'package:aladdin_franchise/src/models/o2o/customer_info_model.dart';
import 'package:aladdin_franchise/src/models/o2o/o2o_order_model.dart';
import 'package:aladdin_franchise/src/models/o2o/request_order.dart';
import 'package:aladdin_franchise/src/models/order.dart';
import 'package:aladdin_franchise/src/models/order_invoice/order_invoice.dart';
import 'package:aladdin_franchise/src/models/payment_method/payment_method.dart';
import 'package:aladdin_franchise/src/models/policy_result.dart';
import 'package:aladdin_franchise/src/models/product.dart';
import 'package:aladdin_franchise/src/models/product_checkout.dart';
import 'package:aladdin_franchise/src/models/reservation/reservation.dart';
import 'package:aladdin_franchise/src/models/sale.dart';
import 'package:aladdin_franchise/src/models/waiter.dart';

/// Author: sondv
/// Created 08/11/2023 at 08:30

abstract class OrderRepository {
  /// Success => OrdersRepository
  ///
  /// Error => Exception
  Future<OrdersResponse> getOrders({int? typeOrder});

  /// Success => CreateOrderRepository
  ///
  /// Error => Exception
  Future<CreateOrderResponse> createAndUpdateOrder(
    List<int> tableIds,
    OrderModel order, {
    WaiterModel? waiterTransfer,
    int? typeOrder,
    ReservationModel? reservation,
  });

  /// Gọi món
  ///
  /// Success => ProcessOrderRepository
  ///
  /// Error => Exception
  Future<ProcessOrderResponse> processOrder({
    required OrderModel order,
    required List<ProductModel> products,
    required double total,
    String? orderNote,
  });

  /// Lấy danh sách món đã gọi
  ///
  /// Success => ProductCheckoutRepository
  ///
  /// Error => Exception
  Future<ProductCheckoutResponse> getProductCheckout(OrderModel? order);

  /// Huỷ món
  ///
  /// Success => ProcessOrderRepository
  ///
  /// Error => Exception
  Future<ProcessOrderResponse> cancelDishInOrder({
    required OrderModel order,
    required List<ProductCheckoutModel> products,
    required double total,
    required String contentCancelOrder,
  });
// cả thêm, cả huỷ
  Future<ProcessOrderResponse> updateProductInOrder({
    required OrderModel order,
    required List<ProductModel> products,
    required double total,
    String noteCancel = 'Khách huỷ món',
    String totalNote = '',
  });

  /// Lấy ip máy in
  ///
  /// printerType: [1] in thanh toán, [2,4] in bếp & bar
  Future<({List<IpOrderModel> printers, String? error})> getIpPrinterOrder(
      OrderModel order, List<int> printerType);

  /// Success => true
  ///
  /// Error => Exception
  Future<bool> payment({
    required OrderModel order,
    required List<IpOrderModel> infoPrint,
    required List<ProductCheckoutModel> products,
    required List<PolicyResultModel> vouchers,
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

  /// Success => true
  ///
  /// Error => false
  ///
  /// status: 3 - huy mon | 2 - goi mon
  Future<({bool result, String? error})> processOrderPrintBill({
    required OrderModel order,
    required List<IpOrderModel> infoPrint,
    List<ProductModel>? products,
    List<ProductCheckoutModel>? productCheckout,
    required int status,
    int? timesOrder,
    String? contentCancelOrder,
    String? orderNote,
  });

  Future<DataBillResponse> getDataBill({required int orderId});

  /// Thu hồi yêu cầu huỷ
  // Future<void> confirmRecallCancel({
  //   required int lineItemId,
  // });

  /// Kiểm tra tình trạng máy in dành cho gọi món, huỷ món
  ///
  /// Kiểm tra tuỳ thuộc vào loại món ăn được yêu cầu (printerCheck)
  ///
  /// @param printerCheck: Loại máy in cần check tuỳ theo danh sách món ăn
  ///
  /// @return (List<IpOrderModel>, String? error)
  Future<({List<IpOrderModel> printers, String? error})> getPrinterBill(
    OrderModel order,
    List<int> printerCheck,
  );

  Future<OrderInvoice> getOrderInvoice(int orderId);

  /// Dùng để (thêm / cập nhật) thông tin hoá đơn
  Future<void> updateOrderInvoice(
      {required int orderId, required OrderInvoice orderInvoice});

  /// Gửi đánh giá theo order
  Future<void> sendPaymentRating({
    required int orderId,
    required ListCustomerRating customerRatings,
  });

  /// @order_id
  ///
  /// @status_lock: 1 khoá, 0 mở khoá
  Future<void> lockOrder({
    required int orderId,
    required int statusLock,
  });

  Future<void> removeCustomerForOrder({
    required int orderId,
  });

  // Future<bool> checkStatusLockOrder({
  //   required int orderId,
  // });
// hoàn thành bill
  Future<void> completeBill({
    required OrderModel order,
    String description = '',
    // cấu trúc: keyPaymentMethod--priceFinal,
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

  Future<List<HistoryOrderModel>> getHistoryOrder({
    required DateTime startDate,
    required DateTime endDate,
  });

  /// chốt ca
  Future<void> closingShift();
  Future<List<ProductCheckoutUpdateTaxModel>> updateTax({
    required OrderModel order,
    required List<ProductCheckoutModel> pc,
    required PaymentMethod paymentMethod,
  });

  // o2o
  Future<List<O2OOrderModel>> getOrderToOnline();

  /// nếu xác nhận thì status = 1, hủy status = 2
  Future<void> updateStatusRequestOrderO2O({
    required int orderId,
    required int status,
    required int orderItemId,
    required List<RequestOrderItemModel> orderItems,
    String notes = '',
  });

  Future<bool> checkStatusLockOrder({
    required int orderId,
  });

  Future<List<ChatMessageModel>> getChatMessages({
    required int restaurantId,
    required int orderId,
  });

  Future<List<O2oCustomerInfoModel>> getO2OCustomerInfo({required int orderId});
}
