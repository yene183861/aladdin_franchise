import 'dart:convert';
import 'dart:io';

import 'package:aladdin_franchise/generated/l10n.dart';
import 'package:aladdin_franchise/src/configs/api.dart';
import 'package:aladdin_franchise/src/configs/app.dart';
import 'package:aladdin_franchise/src/configs/data_fake.dart';
import 'package:aladdin_franchise/src/configs/enums/app_log_action.dart';
import 'package:aladdin_franchise/src/core/network/app_exception.dart';
import 'package:aladdin_franchise/src/core/network/order/order_repository.dart';
import 'package:aladdin_franchise/src/core/network/responses/create_order.dart';
import 'package:aladdin_franchise/src/core/network/responses/data_bill.dart';
import 'package:aladdin_franchise/src/core/network/responses/order.dart';
import 'package:aladdin_franchise/src/core/network/responses/process_order.dart';
import 'package:aladdin_franchise/src/core/network/responses/product_checkout.dart';
import 'package:aladdin_franchise/src/core/network/rest_client.dart';
import 'package:aladdin_franchise/src/core/services/send_log/log_service.dart';
import 'package:aladdin_franchise/src/core/storages/local.dart';
import 'package:aladdin_franchise/src/core/storages/order_offine.dart';
import 'package:aladdin_franchise/src/models/comment.dart';
import 'package:aladdin_franchise/src/models/customer/cusomter_portrait.dart';
import 'package:aladdin_franchise/src/models/customer/customer_rating.dart';
import 'package:aladdin_franchise/src/models/data_bill.dart';
import 'package:aladdin_franchise/src/models/error_log.dart';
import 'package:aladdin_franchise/src/models/ip_order.dart';
import 'package:aladdin_franchise/src/models/order.dart';
import 'package:aladdin_franchise/src/models/order_offline/order_offline.dart';
import 'package:aladdin_franchise/src/models/payment_method/payment_method.dart';
import 'package:aladdin_franchise/src/models/policy_result.dart';
import 'package:aladdin_franchise/src/models/product.dart';
import 'package:aladdin_franchise/src/models/product_checkout.dart';
import 'package:aladdin_franchise/src/models/reservation/reservation.dart';
import 'package:aladdin_franchise/src/models/table.dart';
import 'package:aladdin_franchise/src/models/waiter.dart';
import 'package:aladdin_franchise/src/utils/app_log.dart';
import 'package:aladdin_franchise/src/utils/app_printer/app_printer_common.dart';

class OrderRepositoryImpl extends OrderRepository {
  @override
  Future<OrdersResponse> getOrders({int? typeOrder}) async {
    var apiUrl = ApiConfig.getOrders;
    var log = ErrorLogModel(
      action: AppLogAction.getOrders,
      api: apiUrl,
      modelInterface: OrdersResponse.getModelInterface(),
    );
    try {
      if (useDataFake) {
        await delayFunc();
        bool isOnline = (typeOrder ?? kTypeOrder) == 1;
        return OrdersResponse(
          status: 200,
          data: OrdersResponseData(
            notUse: isOnline ? kNotUseOnTables : kNotUseOffTables,
            using: isOnline ? kUsingOnTables : kUsingOffTables,
            userUsing: isOnline ? kOnOrders : kOffOrders,
            waiters: kWaiters,
          ),
        );
      }
      var response = await restClient.get(Uri.parse(apiUrl), typeOrder: typeOrder);
      log = log.copyWith(response: [response.statusCode, response.body]);
      if (response.statusCode == NetworkCodeConfig.ok) {
        var jsonRes = jsonDecode(response.body);
        var result = OrdersResponse.fromJson(jsonRes);
        var data = result.data;
        var notUse = List<TableModel>.from(data.notUse)
            .map((e) => e.copyWith(typeOrder: typeOrder ?? kTypeOrder))
            .toList();
        var using = List<TableModel>.from(data.using)
            .map((e) => e.copyWith(typeOrder: typeOrder ?? kTypeOrder))
            .toList();
        var orders = List<OrderModel>.from(data.userUsing)
            .map((e) => e.copyWith(typeOrder: typeOrder ?? kTypeOrder))
            .toList();
        return result.copyWith(
            data: data.copyWith(notUse: notUse, userUsing: orders, using: using));
      } else {
        throw AppException.fromStatusCode(response.statusCode);
      }
    } catch (ex) {
      showLog(ex, flags: "error getOrders");
      LogService.sendLogs(log.copyWith(errorMessage: ex.toString(), createAt: DateTime.now()));

      if (ex is AppException) rethrow;
      throw AppException(message: ex.toString());
    }
  }

  @override
  Future<CreateOrderResponse> createAndUpdateOrder(
    List<int> tableIds,
    OrderModel order, {
    WaiterModel? waiterTransfer,
    int? typeOrder,
    ReservationModel? reservation,
  }) async {
    var log = ErrorLogModel(
      action: AppLogAction.createAndUpdateOrder,
      api: ApiConfig.createAndUpdateOrder,
      modelInterface: CreateOrderResponse.getModelInterface(),
      order: order,
    );
    try {
      var loginData = LocalStorage.getDataLogin();
      bool useReservation = loginData?.restaurant?.reservationStatus ?? false;
      Map<String, dynamic> bodyRequest = {
        "lat": "0",
        "long": "0",
        "order_id": order.id,
        "payment_type": 25,
        "restaurant_id": loginData?.restaurant?.id,
        "table_id": tableIds.toString(),
        "total": 0,
        // check ?
        "waiter_id": loginData?.waiterId,
        "waiter_id_transfer": waiterTransfer?.id,
      };

      if (useReservation) {
        bodyRequest['reservation_crm_id'] = reservation?.id;
        bodyRequest['sale_name'] = reservation?.saleName ?? '';
        bodyRequest['sale_code'] = reservation?.saleCode ?? '';
      }

      var body = jsonEncode(bodyRequest);
      log = log.copyWith(
        request: body,
      );
      var response = await restClient.post(
        Uri.parse(ApiConfig.createAndUpdateOrder),
        body: body,
        typeOrder: typeOrder,
      );
      log = log.copyWith(
        response: [response.statusCode, response.body],
      );
      if (response.statusCode == NetworkCodeConfig.ok) {
        var json = jsonDecode(response.body);
        var result = CreateOrderResponse.fromJson(json);
        return result;
      } else {
        checkLockedOrder(response);
        throw AppException.fromStatusCode(response.statusCode);
      }
    } catch (ex) {
      showLog(ex, flags: 'createAndUpdateOrder ex');
      LogService.sendLogs(log.copyWith(errorMessage: ex.toString(), createAt: DateTime.now()));

      if (ex is AppException) rethrow;
      throw AppException(message: ex.toString());
    }
  }

  @override
  Future<ProcessOrderResponse> processOrder({
    required OrderModel order,
    required List<ProductModel> products,
    required double total,
    String? orderNote,
  }) async {
    var log = ErrorLogModel(
      action: AppLogAction.processOrder,
      api: ApiConfig.processOrder,
      modelInterface: ProcessOrderResponse.getModelInterface(),
      order: order,
    );
    try {
      final loginData = LocalStorage.getDataLogin();
      final body = jsonEncode(<String, dynamic>{
        "order_id": order.id,
        "total": total,
        "restaurant_id": loginData?.restaurant?.id,
        "description": orderNote,
        "items": jsonEncode(products
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
                "note": e.noteForProcessOrder ?? "",
              },
            )
            .toList()),
      });
      final response = await restClient.post(
        Uri.parse(ApiConfig.processOrder),
        body: body,
      );
      log = log.copyWith(
        response: [response.statusCode, response.body],
        request: body,
      );

      if (response.statusCode == NetworkCodeConfig.ok) {
        final jsonRes = jsonDecode(response.body);
        final result = ProcessOrderResponse.fromJson(jsonRes);
        return result;
      } else {
        checkLockedOrder(response);
        throw AppException.fromStatusCode(response.statusCode);
      }
    } catch (ex) {
      LogService.sendLogs(log.copyWith(errorMessage: ex.toString(), createAt: DateTime.now()));

      if (ex is AppException) rethrow;
      throw AppException(message: ex.toString());
    }
  }

  @override
  Future<ProductCheckoutResponse> getProductCheckout(OrderModel? order) async {
    if (order == null) {
      return const ProductCheckoutResponse(status: 404);
    }
    final apiUrl = "${ApiConfig.productCheckout}?order_id=${order.id}";
    var log = ErrorLogModel(
      action: AppLogAction.getProductCheckout,
      api: apiUrl,
      order: order,
    );
    try {
      if (useDataFake) {
        await delayFunc();
        var res = await kGetProductCheckout(orderId);
        return ProductCheckoutResponse(
          status: 200,
          message: '',
          coupons: res.coupons,
          customer: res.customer,
          numberOfAdults: res.numberOfAdults,
          data: res.checkoutData,
        );
      }
      final response = await restClient.get(Uri.parse(apiUrl));
      log = log.copyWith(
        response: [response.statusCode, response.body],
      );
      if (response.statusCode == NetworkCodeConfig.ok) {
        final jsonRes = jsonDecode(response.body);
        final result = ProductCheckoutResponse.fromJson(jsonRes);
        final productCheckoutResponseData = result.data?.first;
        OrderOfflineService.instance.updateOrderOffline(OrderOffline(
          lastUpdate: DateTime.now(),
          order: order,
          coupons: result.coupons,
          customer: result.customer,
          orderItem: productCheckoutResponseData?.orderItem ?? [],
          itemCancels: productCheckoutResponseData?.itemCancels ?? [],
          orderHistory: productCheckoutResponseData?.orderHistory ?? [],
        ));
        return result;
      } else {
        throw AppException.fromStatusCode(response.statusCode);
      }
    } catch (ex) {
      LogService.sendLogs(log.copyWith(errorMessage: ex.toString(), createAt: DateTime.now()));

      if (ex is AppException) rethrow;
      throw AppException(message: ex.toString());
    }
  }

  @override
  Future<ProcessOrderResponse> cancelDishInOrder({
    required OrderModel order,
    required List<ProductCheckoutModel> products,
    required double total,
    required String contentCancelOrder,
  }) async {
    final apiUrl = ApiConfig.processOrder;
    var log = ErrorLogModel(
      action: AppLogAction.cancelDish,
      api: apiUrl,
      modelInterface: ProcessOrderResponse.getModelInterface(),
      order: order,
    );
    try {
      final loginData = LocalStorage.getDataLogin();
      final body = jsonEncode(<String, dynamic>{
        "order_id": order.id,
        "total": total,
        "restaurant_id": loginData?.restaurant?.id,
        "content_cancel_order": contentCancelOrder,
        "items": jsonEncode(products
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
            .toList()),
      });
      final response = await restClient.post(
        Uri.parse(apiUrl),
        body: body,
      );
      log = log.copyWith(
        response: [response.statusCode, response.body],
        request: body,
      );
      checkLockedOrder(response);
      if (response.statusCode == NetworkCodeConfig.ok) {
        final jsonRes = jsonDecode(response.body);
        final result = ProcessOrderResponse.fromJson(jsonRes);
        return result;
      } else {
        throw AppException.fromStatusCode(response.statusCode);
      }
    } catch (ex) {
      showLog(ex.toString(), flags: 'cancelDishInOrder ex');
      LogService.sendLogs(log.copyWith(errorMessage: ex.toString(), createAt: DateTime.now()));

      if (ex is AppException) rethrow;
      throw AppException(message: ex.toString());
    }
  }

  @override
  Future<({List<IpOrderModel> printers, String? error})> getIpPrinterOrder(
    OrderModel order,
    List<int> printerType,
  ) async {
    var apiUrl = "${ApiConfig.getOrders}?type_order=${order.id}&printer_type=$printerType";
    var log = ErrorLogModel(
        action: AppLogAction.getIpPrinterOrder,
        api: apiUrl,
        order: order,
        modelInterface: "[${IpOrderModel.getModelInterface()}]");
    try {
      final response = await restClient.get(
        Uri.parse(apiUrl),
      );
      log = log.copyWith(
        response: [response.statusCode, response.body],
      );
      if (response.statusCode == NetworkCodeConfig.ok) {
        final jsonData = jsonDecode(response.body);
        final result = OrdersResponse.fromJson(jsonData);
        List<IpOrderModel> printers = [];
        String? error;
        printers = result.data.ipOrder == null
            ? []
            : result.data.ipOrder.map<IpOrderModel>((e) => IpOrderModel.fromJson(e)).toList();
        if (printers.isEmpty) {
          error = S.current.error_ping_printer;
        }
        return (printers: printers, error: error);
      } else {
        throw AppException.fromStatusCode(response.statusCode);
      }
    } catch (ex) {
      LogService.sendLogs(log.copyWith(errorMessage: ex.toString(), createAt: DateTime.now()));

      if (ex is AppException) rethrow;
      throw AppException(message: ex.toString());
    }
  }

  @override
  Future<bool> payment({
    required OrderModel order,
    required List<IpOrderModel> infoPrint,
    required List<ProductCheckoutModel> products,
    required List<PolicyResultModel> vouchers,
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
    var apiUrl = ApiConfig.paymentAndPrinter;
    var log = ErrorLogModel(
      action: AppLogAction.payment,
      api: apiUrl,
      modelInterface: "bool",
      order: order,
    );
    ListCustomerRating customerRatingPush =
        customerRatings.where((element) => element.isEmptyOrError() == false).toList();

    try {
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
        "vouchers": vouchers,
        "createVouchers": createVouchers,
        "comment": comment,
        "order_id": order.id,
        "numberOfPeople": numberOfAdults + numberOfChildren,
        "numberOfAdults": numberOfAdults,
        "numberOfChildren": numberOfChildren,
        "note": note,
        "flag_invoice": flagInvoice,
        "customer_rating": customerRatingPush, //customerRating.getQuestionPush(),
        //"payment": paymentDataBillCheck.toJson(),
        "files": images,
        "payment_method": paymentMethod,
        "portrait": customerPortrait?.key,
        "status_payment_completed": statusPaymentCompleted ? 1 : 0,
        "total_payment_completed": totalPaymentCompleted,
      });
      final response = await restClient.post(
        Uri.parse(apiUrl),
        body: body,
      );
      log = log.copyWith(
        response: [response.statusCode, response.body],
      );
      if (response.statusCode == NetworkCodeConfig.ok) {
        showLogs(response.body, flags: "payment client result");
        // if (int.tryParse(response.body) != 1) {
        //   throw AppException.fromMessage("Thanh toán in bill lỗi");
        // }
        return true;
      } else {
        throw AppException.fromStatusCode(response.statusCode);
      }
    } catch (ex) {
      LogService.sendLogs(log.copyWith(errorMessage: ex.toString(), createAt: DateTime.now()));

      showLogs(ex, flags: "Call payment error");
      if (ex is AppException) rethrow;
      throw AppException(message: ex.toString());
    }
  }

  @override
  Future<({bool result, String? error})> processOrderPrintBill({
    required OrderModel order,
    required List<IpOrderModel> infoPrint,
    List<ProductModel>? products,
    List<ProductCheckoutModel>? productCheckout,
    required int status,
    int? timesOrder,
    String? contentCancelOrder,
    String? orderNote,
  }) async {
    var apiUrl = ApiConfig.processOrderAndPrinter;
    var log = ErrorLogModel(
      action: status == 2 ? AppLogAction.processOrderBill : AppLogAction.cancelDishBill,
      api: apiUrl,
      modelInterface: "bool",
      order: order,
    );
    try {
      var loginData = LocalStorage.getDataLogin();
      var body = jsonEncode(<String, dynamic>{
        "content_cancel_order": contentCancelOrder,
        "description": orderNote,
        "restaurant": loginData?.restaurant,
        "order": {
          "code": order.misc,
          "order_time": timesOrder,
          "table_name": order.name,
        },
        "order_id": order.id,
        "infoPrint": infoPrint,
        "orderLineItems": status == 2
            ? products
                ?.map((e) => {
                      "id": e.id,
                      "name": e.name,
                      "price": e.unitPrice,
                      "dollarSign": "vnđ",
                      "count": e.numberSelecting,
                      "unit": e.unit,
                      "printer_type": e.printerType,
                      "tax": e.tax,
                      "note": e.noteForProcessOrder ?? "",
                    })
                .toList()
            : productCheckout
                ?.map((e) => {
                      "id": e.id,
                      "name": e.name,
                      "price": e.unitPrice,
                      "dollarSign": "vnđ",
                      "count": e.quantityCancel,
                      "unit": e.unit,
                      "printer_type": e.printerType,
                      "tax": e.tax,
                    })
                .toList(),
        "status": status,
      });

      var response = await restClient.post(
        Uri.parse(apiUrl),
        body: body,
      );
      log = log.copyWith(
        response: [response.statusCode, response.body],
        request: body,
      );
      if (response.statusCode == NetworkCodeConfig.ok) {
        showLog(response.body, flags: "InBillOrder Result");
        if (int.tryParse(response.body) != 1) {
          throw AppException.fromMessage(S.current.error_print_bill_order);
        }
        return (result: true, error: null);
      } else {
        throw AppException.fromStatusCode(response.statusCode);
      }
    } catch (ex) {
      LogService.sendLogs(log.copyWith(errorMessage: ex.toString(), createAt: DateTime.now()));

      showLogs(ex, flags: "processOrderInBill");
      return (result: false, error: ex.toString());
    }
  }

  @override
  Future<DataBillResponse> getDataBill({required int orderId}) async {
    var apiUrl = ApiConfig.getDataBillOrder;
    var log = ErrorLogModel(
      action: AppLogAction.getDataBill,
      api: ApiConfig.getDataBillOrder,
    );
    try {
      if (useDataFake) {
        await delayFunc();
        var result = await kGetOrderDataBill(orderId);
        return DataBillResponse(data: result);
      }
      var response = await restClient.get(
        Uri.parse("$apiUrl?order_id=$orderId"),
      );
      log = log.copyWith(
        response: [response.statusCode, response.body],
      );

      if (response.statusCode == NetworkCodeConfig.ok) {
        if (response.body.trim().isEmpty) {
          throw S.current.error_get_invoice_info;
        }
        var jsonBody = jsonDecode(response.body);

        var sale = jsonBody['data']['sale'];
        if (sale is List && sale.isEmpty) {
          jsonBody['data']['sale'] = null;
        }

        var result = DataBillResponse.fromJson(jsonBody);
        return result;
      } else {
        throw AppException.fromStatusCode(response.statusCode);
      }
    } catch (ex) {
      showLogs(ex.toString(), flags: 'ex getDataBill');
      if (ex.toString() != S.current.error_get_invoice_info) {
        LogService.sendLogs(log.copyWith(errorMessage: ex.toString(), createAt: DateTime.now()));
      }

      if (ex is AppException) rethrow;
      throw AppException(message: ex.toString());
    }
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
  Future<({List<IpOrderModel> printers, String? error})> getPrinterBill(
    OrderModel order,
    List<int> printerCheck,
  ) async {
    List<IpOrderModel> ipResult = [];
    String? error;
    Set<IpOrderModel> printers = {};
    try {
      // Lấy thông tin máy in
      // final resultPrinter = await getIpPrinterOrder(order, [2, 4]);
      final resultPrinter = await getIpPrinterOrder(order, printerCheck);
      //showLogs(ipResult, flags: "Printer");
      if (resultPrinter.error != null) {
        error = resultPrinter.error;
      } else {
        ipResult = resultPrinter.printers;

        await LocalStorage.saveListPrinters(ipResult);

        // Kiểm tra tình trạng máy in
        for (var ipPrinter in ipResult) {
          if (printerCheck.contains(ipPrinter.type)) {
            printers.add(ipPrinter);
            var checkPrinterAvailable = await AppPrinterCommon.checkPrinter(
                // var checkPrinterAvailable = await LocalNetworkService.checkPrinter(ipPrinter.ip,
                // ipPrinter.port);
                ipPrinter);
            showLog(checkPrinterAvailable, flags: "checkPrinterAvailable[${ipPrinter.type}]");
            if (checkPrinterAvailable != null) {
              error = ipPrinter.messageConnectFail();
            }
          }
        }
      }
    } catch (ex) {
      error = "${S.current.error_retrieving_printer_info}\n${S.current.please_try_again}!"
          "\n${S.current.ex_problem}: ${ex.toString()}";
    }
    return (printers: printers.toList(), error: error);
  }

  @override
  Future<void> lockOrder({
    required int orderId,
    required int statusLock,
  }) async {
    final makeDeviceId = LocalStorage.getMakeDeviceId();
    final apiUrl = ApiConfig.lockOrder;
    var log = ErrorLogModel(
      action: AppLogAction.lockOrder,
      api: apiUrl,
    );
    try {
      final bodyRequest = jsonEncode(<String, dynamic>{
        "order_id": orderId,
        "status_lock": statusLock,
        "device_id": makeDeviceId,
      });
      final response = await restClient.post(
        Uri.parse(apiUrl),
        body: bodyRequest,
      );
      log = log.copyWith(
        request: bodyRequest,
        response: [response.statusCode, response.body],
      );
      if (response.statusCode != 200) {
        throw AppException.fromStatusCode(response.statusCode);
      }
    } catch (ex) {
      LogService.sendLogs(log.copyWith(errorMessage: ex.toString(), createAt: DateTime.now()));

      if (ex is AppException) rethrow;
      throw AppException(message: ex.toString());
    }
  }

  // @override
  // Future<bool> checkStatusLockOrder({required int orderId}) async {
  //   final apiUrl = "${ApiConfig.statusLockOrder}?order_id=$orderId";
  //   var log = ErrorLogModel(
  //     action: AppLogAction.checkStatusLockOrder,
  //     api: apiUrl,
  //     modelInterface: 'bool',
  //     order: OrderModel(id: orderId),
  //   );
  //   try {
  //     final response = await restClient.get(Uri.parse(apiUrl));
  //     log = log.copyWith(
  //       response: [response.statusCode, response.body],
  //     );
  //     if (response.statusCode == 200) {
  //       return false;
  //     } else if (response.statusCode == 423) {
  //       return true;
  //     }
  //     throw AppException.fromHttpResponse(response);
  //   } catch (ex) {
  //     LogService.sendLogs(
  //         log.copyWith(errorMessage: ex.toString(), createAt: DateTime.now()));

  //     if (ex is AppException) rethrow;
  //     throw AppException(message: ex.toString());
  //   }
  // }

  @override
  Future<ProcessOrderResponse> updateProductInOrder({
    required OrderModel order,
    required List<ProductModel> products,
    required double total,
    String noteCancel = '',
    String totalNote = '',
  }) async {
    var log = ErrorLogModel(
      action: AppLogAction.processOrder,
      api: ApiConfig.processOrder,
      modelInterface: ProcessOrderResponse.getModelInterface(),
      order: order,
    );
    try {
      final loginData = LocalStorage.getDataLogin();
      final body = jsonEncode(<String, dynamic>{
        "order_id": order.id,
        "total": total,
        "restaurant_id": loginData?.restaurant?.id,
        "description": totalNote,
        "content_cancel_order": noteCancel,
        "items": jsonEncode(products
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
                "note": e.noteForProcessOrder ?? "",
              },
            )
            .toList()),
      });
      final response = await restClient.post(
        Uri.parse(ApiConfig.processOrder),
        body: body,
      );
      log = log.copyWith(
        response: [response.statusCode, response.body],
        request: body,
      );
      if (response.statusCode == NetworkCodeConfig.locked) {
        throw AppException.fromMessage(S.current.msg_locked_order);
      }
      if (response.statusCode == NetworkCodeConfig.ok) {
        final jsonRes = jsonDecode(response.body);
        final result = ProcessOrderResponse.fromJson(jsonRes);
        return result;
      } else {
        throw AppException.fromStatusCode(response.statusCode);
      }
    } catch (ex) {
      LogService.sendLogs(log.copyWith(errorMessage: ex.toString(), createAt: DateTime.now()));

      if (ex is AppException) rethrow;
      throw AppException(message: ex.toString());
    }
  }

  @override
  Future<void> completeBill({
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
    var api = '${ApiConfig.completeBill}/${order.id}';
    var log = ErrorLogModel(
      action: AppLogAction.completeBill,
      api: api,
      modelInterface: ProcessOrderResponse.getModelInterface(),
      order: order,
    );
    try {
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
      final response = await restClient.post(Uri.parse(api), body: body);
      log = log.copyWith(
        response: [response.statusCode, response.body],
        request: body,
      );
      if (response.statusCode == NetworkCodeConfig.locked) {
        throw AppException.fromMessage(S.current.msg_locked_order);
      }
      if (response.statusCode == NetworkCodeConfig.ok) {
        return;
      } else {
        throw AppException.fromStatusCode(response.statusCode);
      }
    } catch (ex) {
      LogService.sendLogs(log.copyWith(errorMessage: ex.toString(), createAt: DateTime.now()));

      if (ex is AppException) rethrow;
      throw AppException(message: ex.toString());
    }
  }

  @override
  Future<List<ProductCheckoutUpdateTaxModel>> updateTax(
      {required OrderModel order,
      required List<ProductCheckoutModel> pc,
      required PaymentMethod paymentMethod}) async {
    var api = ApiConfig.updateTax;
    var bodyRequest = jsonEncode({
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
    var log = ErrorLogModel(
      action: AppLogAction.updateTax,
      api: api,
      request: bodyRequest,
    );
    try {
      final response = await restClient.post(Uri.parse(api), body: bodyRequest);
      log = log.copyWith(response: [response.statusCode, response.body]);
      if (response.statusCode == NetworkCodeConfig.ok) {
        var body = jsonDecode(response.body);
        if (body['status'] != NetworkCodeConfig.ok) {
          throw body['message'] != null
              ? AppException.fromMessage(body['message'])
              : AppException.fromStatusCode(body['status']);
        }

        return (body['data'] as List)
            .map((e) => ProductCheckoutUpdateTaxModel.fromJson(e))
            .toList();
      } else {
        throw AppException.fromStatusCode(response.statusCode);
      }
    } catch (ex) {
      LogService.sendLogs(log.copyWith(errorMessage: ex.toString(), createAt: DateTime.now()));

      if (ex is AppException) rethrow;
      throw AppException(message: ex.toString());
    }
  }

  @override
  Future<bool> checkStatusLockOrder({required int orderId}) async {
    final apiUrl = "${ApiConfig.statusLockOrder}?order_id=$orderId";
    var log = ErrorLogModel(
      action: AppLogAction.checkStatusLockOrder,
      api: apiUrl,
      modelInterface: 'bool',
      order: OrderModel(id: orderId),
    );
    try {
      final response = await restClient.get(Uri.parse(apiUrl));
      log = log.copyWith(
        response: [response.statusCode, response.body],
      );
      if (response.statusCode == 200) {
        return false;
      } else if (response.statusCode == 423) {
        return true;
      }
      throw AppException.fromHttpResponse(response);
    } catch (ex) {
      LogService.sendLogs(log.copyWith(errorMessage: ex.toString(), createAt: DateTime.now()));

      if (ex is AppException) rethrow;
      throw AppException(message: ex.toString());
    }
  }
}
