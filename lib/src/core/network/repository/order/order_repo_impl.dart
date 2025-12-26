import 'dart:convert';
import 'dart:io';

import 'package:aladdin_franchise/src/configs/api.dart';
import 'package:aladdin_franchise/src/configs/app.dart';
import 'package:aladdin_franchise/src/configs/enums/app_log_action.dart';
import 'package:aladdin_franchise/src/core/network/api/app_exception.dart';
import 'package:aladdin_franchise/src/core/network/api/safe_call_api.dart';
import 'package:aladdin_franchise/src/core/network/repository/order/order_repository.dart';
import 'package:aladdin_franchise/src/core/network/repository/responses/create_order.dart';
import 'package:aladdin_franchise/src/core/network/repository/responses/data_bill.dart';
import 'package:aladdin_franchise/src/core/network/repository/responses/order.dart';
import 'package:aladdin_franchise/src/core/network/repository/responses/process_order.dart';
import 'package:aladdin_franchise/src/core/network/repository/responses/product_checkout.dart';
import 'package:aladdin_franchise/src/core/network/api/rest_client.dart';
import 'package:aladdin_franchise/src/core/storages/local.dart';
import 'package:aladdin_franchise/src/models/comment.dart';
import 'package:aladdin_franchise/src/models/customer/cusomter_portrait.dart';
import 'package:aladdin_franchise/src/models/customer/customer_policy.dart';
import 'package:aladdin_franchise/src/models/customer/customer_rating.dart';
import 'package:aladdin_franchise/src/models/data_bill.dart';
import 'package:aladdin_franchise/src/models/error_log.dart';
import 'package:aladdin_franchise/src/models/ip_order.dart';
import 'package:aladdin_franchise/src/models/order.dart';
import 'package:aladdin_franchise/src/models/payment_method/payment_method.dart';
import 'package:aladdin_franchise/src/models/product.dart';
import 'package:aladdin_franchise/src/models/product_checkout.dart';
import 'package:aladdin_franchise/src/models/reservation/reservation.dart';
import 'package:aladdin_franchise/src/models/waiter.dart';
import 'package:aladdin_franchise/src/utils/app_log.dart';
import 'package:aladdin_franchise/src/utils/app_printer/app_printer_common.dart';

class OrderRepositoryImpl extends OrderRepository {
  final RestClient _client;

  OrderRepositoryImpl(this._client);

  @override
  Future<ApiResult<OrdersResponseData>> getOrders({int? typeOrder}) async {
    var apiUrl = "${ApiConfig.apiUrl}/api/v2/list-table-using";
    return safeCallApi(
      () {
        final url = Uri.parse(apiUrl);
        return _client.get(url, typeOrder: typeOrder);
      },
      dataKey: 'data',
      parser: (json) {
        var res = OrdersResponseData.fromJson(json);
        return OrdersResponseData(
          notUse: res.notUse.map((e) => e.copyWith(typeOrder: typeOrder ?? kTypeOrder)).toList(),
          using: res.using.map((e) => e.copyWith(typeOrder: typeOrder ?? kTypeOrder)).toList(),
          userUsing:
              res.userUsing.map((e) => e.copyWith(typeOrder: typeOrder ?? kTypeOrder)).toList(),
          waiters: res.waiters ?? [],
          ipOrder: res.ipOrder,
        );
      },
      log: ErrorLogModel(
        action: AppLogAction.getOrders,
        api: apiUrl,
      ),
    );
  }

  @override
  Future<ApiResult<CreateOrderResponse>> createAndUpdateOrder(
    List<int> tableIds,
    OrderModel order, {
    WaiterModel? waiterTransfer,
    int? typeOrder,
    ReservationModel? reservation,
    bool updateSaleInfo = true,
  }) {
    var apiUrl = "${ApiConfig.apiUrl}/api/v1/make-dine-in-orders";
    var loginData = LocalStorage.getDataLogin();
    Map<String, dynamic> body = {
      "lat": "0",
      "long": "0",
      "order_id": order.id,
      "payment_type": 25,
      "restaurant_id": loginData?.restaurant?.id,
      "table_id": tableIds.toString(),
      "total": 0,
      "waiter_id": loginData?.waiterId,
      "waiter_id_transfer": waiterTransfer?.id,
      "reservation_crm_id": reservation?.id,
      if (updateSaleInfo) "sale_name": reservation?.saleName ?? '',
      if (updateSaleInfo) "sale_code": reservation?.saleCode ?? '',
    };

    return safeCallApi(
      () {
        final url = Uri.parse(apiUrl);

        return _client.post(url, typeOrder: typeOrder, body: jsonEncode(body));
      },
      parser: (json) => CreateOrderResponse.fromJson(json),
      log: ErrorLogModel(
        action: AppLogAction.createAndUpdateOrder,
        api: apiUrl,
        request: body,
      ),
    );
  }

  @override
  Future<ApiResult<ProductCheckoutResponse>> getProductCheckout(OrderModel? order) async {
    var apiUrl = '${ApiConfig.apiUrl}/api/v1/orders-for-table?order_id=${order?.id}';
    return safeCallApi(
      () {
        final url = Uri.parse(apiUrl);
        return _client.get(url);
      },
      parser: (json) => ProductCheckoutResponse.fromJson(json),
      log: ErrorLogModel(
        action: AppLogAction.getProductCheckout,
        api: apiUrl,
        order: order,
      ),
    );
  }

  @override
  Future<ApiResult<List<IpOrderModel>>> getIpPrinterOrder(
    OrderModel order,
    List<int> printerType,
  ) async {
    var apiUrl =
        "${ApiConfig.apiUrl}/api/v2/list-table-using?type_order=${order.id}&printer_type=$printerType";
    return safeCallApi(
      () {
        final url = Uri.parse(apiUrl);
        return _client.get(url);
      },
      dataKey: 'data',
      parser: (json) {
        List<IpOrderModel> printers = [];
        var res = OrdersResponseData.fromJson(json);
        printers = res.ipOrder == null
            ? []
            : res.ipOrder.map<IpOrderModel>((e) => IpOrderModel.fromJson(e)).toList();
        return printers;
      },
      log: ErrorLogModel(
        action: AppLogAction.getIpPrinterOrder,
        api: apiUrl,
        order: order,
      ),
    );
  }

  @override
  Future<ApiResult<bool>> payment({
    required OrderModel order,
    required List<IpOrderModel> infoPrint,
    required List<ProductCheckoutModel> products,
    required List<CustomerPolicyModel> vouchers,
    required createVouchers,
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
  }) async {
    var apiUrl = "${ApiConfig.apiUrl}/api/v1/in-bill-tmp";
    var loginData = LocalStorage.getDataLogin();
    List<String> images = [];
    for (final image in imageBills) {
      List<int> imageBytes = await image.readAsBytes();
      String base64File = base64Encode(imageBytes);
      images.add(base64File);
    }
    var body = jsonEncode(<String, dynamic>{
      "restaurant": loginData?.restaurant,
      "order": {
        "code": order.misc,
        "table_name": order.name,
      },
      "infoPrint": infoPrint,
      "orderLineItems": products
          .map((e) => {
                "id": e.id,
                "name": e.getNameView(),
                "price": e.unitPrice,
                "dollarSign": "vnđ",
                "count": e.quantity,
                "unit": e.unit,
                "tax": e.tax,
                "printer_type": e.printerType,
              })
          .toList(),
      "vouchers": vouchers
          .map((e) => {
                'id': e.id,
                'name': e.name,
                'total': e.discount.fold(0.0, (pValue, e) => pValue + e.amount)
              })
          .toList(),
      "createVouchers": createVouchers,
      "comment": comment,
      "order_id": order.id,
      "numberOfPeople": numberOfAdults + numberOfChildren,
      "numberOfAdults": numberOfAdults,
      "numberOfChildren": numberOfChildren,
      "note": note,
      "flag_invoice": flagInvoice,
      "customer_rating":
          customerRatings.where((element) => element.isEmptyOrError() == false).toList(),
      //"payment": paymentDataBillCheck.toJson(),
      "files": images,
      "payment_method": paymentMethod,
      "portrait": customerPortrait?.key,
      "status_payment_completed": statusPaymentCompleted ? 1 : 0,
      "total_payment_completed": totalPaymentCompleted,
    });
    return safeCallApi(
      () {
        final url = Uri.parse(apiUrl);
        return _client.post(url, body: body);
      },
      parser: (json) {
        if (int.tryParse(json) != 1) {
          /// 200 - nhưng response k phải 1
          throw AppException(statusCode: 200, message: "Thanh toán in bill lỗi");
        }
        return true;
      },
      log: ErrorLogModel(
        action: AppLogAction.payment,
        api: apiUrl,
        order: order,
      ),
    );
  }

  @override
  Future<ApiResult<ProcessOrderResponse>> processOrderItem({
    required OrderModel order,
    required double total,
    List<ProductModel> products = const [],
    List<ProductCheckoutModel> productCheckout = const [],
    String? note,
    bool cancel = false,
  }) async {
    final apiUrl = '${ApiConfig.apiUrl}/api/v1/confirm-orders';
    var loginData = LocalStorage.getDataLogin();
    final body = jsonEncode(<String, dynamic>{
      "order_id": order.id,
      "total": total,
      "restaurant_id": loginData?.restaurant?.id,
      if (cancel) "content_cancel_order": note else "description": note,
      "items": cancel
          ? jsonEncode(productCheckout
              .map((e) => {
                    "instructions": "",
                    "restaurant_id": 0,
                    "menu_item_variation_id": "",
                    "menuItem_id": e.id,
                    "unit_price": e.unitPrice,
                    "quantity": e.quantityCancel,
                    "discounted_price": 0,
                    "options": [],
                  })
              .toList())
          : jsonEncode(products
              .map(
                (e) => {
                  "instructions": "",
                  "restaurant_id": 0,
                  "menu_item_variation_id": "",
                  "menuItem_id": e.id,
                  "unit_price": e.unitPrice,
                  "quantity": e.numberSelecting,
                  "discounted_price": e.discountPrice,
                  "options": [],
                  "note": e.note ?? "",
                },
              )
              .toList()),
    });

    return safeCallApi(
      () async {
        final url = Uri.parse(apiUrl);
        return _client.post(url, body: body);
      },
      parser: (json) => ProcessOrderResponse.fromJson(json),
      log: ErrorLogModel(
        action: AppLogAction.processOrder,
        api: apiUrl,
        request: body,
        order: order,
      ),
    );
  }

  @override
  Future<ApiResult<DataBillResponseData>> getDataBill({required int orderId}) async {
    var apiUrl = "${ApiConfig.apiUrl}/api/v1/get-data-bill-order?order_id=$orderId";
    return safeCallApi(
      () {
        final url = Uri.parse(apiUrl);
        return _client.get(url);
      },
      dataKey: 'data',
      parser: (json) {
        var jsonData = json;
        var sale = json['sale'];
        if (sale is List && sale.isEmpty) {
          jsonData['sale'] = null;
        }
        var res = DataBillResponseData.fromJson(jsonData);
        return res;
      },
      log: ErrorLogModel(
        action: AppLogAction.getDataBill,
        api: apiUrl,
        order: OrderModel(id: orderId),
      ),
    );
  }

  // @override
  // Future<void> confirmRecallCancel({required int lineItemId}) async {
  //   var urlApi = ApiConfig.confirmCancelLineItem;
  //   var log = ErrorLogModel(
  //     action: AppLogAction.confirmRecallCancel,
  //     api: ApiConfig.confirmCancelLineItem,
  //   );
  //   try {
  //     var bodyRequest = jsonEncode(<String, dynamic>{
  //       "line_item_id": lineItemId,
  //       "cancel_line_item_id": lineItemId,
  //       "confirm": false,
  //     });
  //     var response = await restClient.post(
  //       Uri.parse(urlApi),
  //       body: bodyRequest,
  //     );
  //     log = log.copyWith(
  //       request: bodyRequest,
  //       response: [response.statusCode, response.body],
  //     );
  //     if (response.statusCode != 200) {
  //       throw AppException.fromStatusCode(response.statusCode);
  //     }
  //   } catch (ex) {
  //     FirestoreService.pushErrorLogs(
  //         errorLog: log.copyWith(
  //       createAt: DateTime.now(),
  //       errorMessage: ex.toString(),
  //     ));
  //     if (ex is AppException) rethrow;
  //     throw AppException(message: ex.toString());
  //   }
  // }

  @override
  Future<ApiResult<List<IpOrderModel>>> getPrinterBill(
    OrderModel order,
    List<int> printerCheck,
  ) async {
    final resultPrinter = await getIpPrinterOrder(order, printerCheck);
    if (!resultPrinter.isSuccess) {
      throw AppException(
        statusCode: resultPrinter.statusCode,
        message: resultPrinter.error,
      );
    }
    List<IpOrderModel> ipResult = resultPrinter.data ?? [];
    try {
      await LocalStorage.saveListPrinters(ipResult);
    } catch (ex) {
      //
    }
    var checkPrinterAvailable = await AppPrinterCommon.checkPrinters(ipResult);
    if (checkPrinterAvailable != null) {
      return ApiResult.failure(404, checkPrinterAvailable);
    }
    return ApiResult.success(200, ipResult);
  }

  @override
  Future<ApiResult<bool>> lockOrder({
    required int orderId,
    required int statusLock,
  }) async {
    final makeDeviceId = LocalStorage.getMakeDeviceId();
    var apiUrl = "${ApiConfig.apiUrl}/api/v1/lock-order";
    final body = jsonEncode(<String, dynamic>{
      "order_id": orderId,
      "status_lock": statusLock,
      "device_id": makeDeviceId,
    });
    return safeCallApi(
      () {
        final url = Uri.parse(apiUrl);
        return _client.post(url, body: body);
      },
      dataKey: 'data',
      log: ErrorLogModel(
        action: AppLogAction.lockOrder,
        api: apiUrl,
        request: body,
      ),
    );
  }

  @override
  Future<ApiResult<bool>> checkStatusLockOrder(int orderId) async {
    var apiUrl = "${ApiConfig.apiUrl}/api/v1/status-lock-order?order_id=$orderId";
    return safeCallApi(
      () {
        final url = Uri.parse(apiUrl);
        return _client.get(url);
      },
      log: ErrorLogModel(
        action: AppLogAction.getDataBill,
        api: apiUrl,
        order: OrderModel(id: orderId),
      ),
    );
    // final apiUrl = "${ApiConfig.statusLockOrder}?order_id=$orderId";
    // var log = ErrorLogModel(
    //   action: AppLogAction.checkStatusLockOrder,
    //   api: apiUrl,
    //   modelInterface: 'bool',
    //   order: OrderModel(id: orderId),
    // );
    // try {
    //   final response = await restClient.get(Uri.parse(apiUrl));
    //   log = log.copyWith(
    //     response: [response.statusCode, response.body],
    //   );
    //   if (response.statusCode == 200) {
    //     return false;
    //   } else if (response.statusCode == 423) {
    //     return true;
    //   }
    //   throw AppException.fromHttpResponse(response);
    // } catch (ex) {
    //   LogService.sendLogs(
    //       log.copyWith(errorMessage: ex.toString(), createAt: DateTime.now()));

    //   if (ex is AppException) rethrow;
    //   throw AppException(message: ex.toString());
    // }
  }

  @override
  Future<ApiResult<void>> completeBill({
    required OrderModel order,
    String description = '',
    // // cấu trúc: keyPaymentMethod--priceFinal,
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
  }) async {
    final apiUrl = '${ApiConfig.apiUrl}/api/v2/in-bill-completed/${order.id}';
    final body = jsonEncode(<String, dynamic>{
      "description": description,
      "arrMethod": arrMethod,
      "amount_people": (amountChildren + amountAdult).toString(),
      "amount_children": amountChildren.toString(),
      "amount_adult": amountAdult.toString(),
      "e_sale_code": eSaleCode,
      "e_sale_name": eSaleName,
      "portrait": portrait,
      "total_price": totalPrice.toString(),
      "total_price_voucher": totalPriceVoucher.toString(),
      "total_price_tax": totalPriceTax.toString(),
      "total_price_final": totalPriceFinal.toString(),
      "isPrintPeople": isPrintPeople.toString(),
    });
    return safeCallApi(
      () async {
        final url = Uri.parse(apiUrl);
        return _client.post(url, body: body);
      },
      log: ErrorLogModel(
        action: AppLogAction.completeBill,
        api: apiUrl,
        request: body,
        order: order,
      ),
    );
  }

  @override
  Future<ApiResult<List<ProductCheckoutUpdateTaxModel>>> updateTax(
      {required OrderModel order,
      required List<ProductCheckoutModel> pc,
      required PaymentMethod paymentMethod}) async {
    final apiUrl = '${ApiConfig.apiUrl}/api/v2/update-tax-waiter';
    var body = jsonEncode({
      "order_id": order.id,
      "method": paymentMethod.key,
      "data": pc
          .map((e) => {
                'menu_item_id': e.id,
                // vì tax đang là dạng 0.08
                'tax': e.tax * 100,
              })
          .toList(),
    });
    return safeCallApiList(
      () async {
        final url = Uri.parse(apiUrl);
        return _client.post(url, body: body);
      },
      dataKey: 'data',
      parser: (json) => ProductCheckoutUpdateTaxModel.fromJson(json),
      log: ErrorLogModel(
        action: AppLogAction.updateReservation,
        api: apiUrl,
        request: body,
      ),
    );
    // var api = ApiConfig.updateTax;
    // var bodyRequest = jsonEncode({
    //   "order_id": order.id,
    //   "method": paymentMethod.key,
    //   "data": pc
    //       .map((e) => {
    //             'menu_item_id': e.id,
    //             // vì tax đang là dạng 0.08
    //             'tax': e.tax * 100,
    //           })
    //       .toList(),
    // });
    // var log = ErrorLogModel(
    //   action: AppLogAction.updateTax,
    //   api: api,
    //   request: bodyRequest,
    // );
    // try {
    //   final response = await restClient.post(Uri.parse(api), body: bodyRequest);
    //   log = log.copyWith(response: [response.statusCode, response.body]);
    //   if (response.statusCode == NetworkCodeConfig.ok) {
    //     var body = jsonDecode(response.body);
    //     if (body['status'] != NetworkCodeConfig.ok) {
    //       throw body['message'] != null
    //           ? AppException.fromMessage(body['message'])
    //           : AppException.fromStatusCode(body['status']);
    //     }

    //     return (body['data'] as List)
    //         .map((e) => ProductCheckoutUpdateTaxModel.fromJson(e))
    //         .toList();
    //   } else {
    //     throw AppException.fromStatusCode(response.statusCode);
    //   }
    // } catch (ex) {
    //   LogService.sendLogs(log.copyWith(errorMessage: ex.toString(), createAt: DateTime.now()));

    //   if (ex is AppException) rethrow;
    //   throw AppException(message: ex.toString());
    // }
  }
}
