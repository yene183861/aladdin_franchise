import 'dart:async';

import 'package:aladdin_franchise/src/core/network/repository/order/order_repository.dart';
import 'package:aladdin_franchise/src/core/network/provider.dart';
import 'package:aladdin_franchise/src/core/network/repository/responses/data_bill.dart';
import 'package:aladdin_franchise/src/data/enum/print_type.dart';
import 'package:aladdin_franchise/src/data/enum/receipt_type.dart';
import 'package:aladdin_franchise/src/data/model/restaurant/printer.dart';
import 'package:aladdin_franchise/src/data/request/payment_receipt_print.dart';
import 'package:aladdin_franchise/src/features/pages/home/provider.dart';
import 'package:aladdin_franchise/src/features/pages/home/state.dart';
import 'package:aladdin_franchise/src/models/data_bill.dart';
import 'package:aladdin_franchise/src/models/ip_order.dart';
import 'package:aladdin_franchise/src/models/order.dart';
import 'package:aladdin_franchise/src/models/payment_method/payment_method.dart';
import 'package:aladdin_franchise/src/utils/app_printer/app_printer_common.dart';
import 'package:aladdin_franchise/src/utils/date_time.dart';
import 'package:collection/collection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'state.dart';

final historyOrderPageProvider =
    StateNotifierProvider.autoDispose<HistoryOrderNotifier, HistoryOrderState>((ref) {
  return HistoryOrderNotifier(ref, ref.read(orderRepositoryProvider));
});

class HistoryOrderNotifier extends StateNotifier<HistoryOrderState> {
  HistoryOrderNotifier(this.ref, this._orderRepository)
      : super(HistoryOrderState(
          startDate: DateTime.now().onlyDate(),
          endDate: DateTime.now().onlyDate(),
        ));
  final Ref ref;
  final OrderRepository _orderRepository;

  void onChangeDate({
    required DateTime startDate,
    required DateTime endDate,
  }) {
    state = state.copyWith(startDate: startDate, endDate: endDate);
    ref.refresh(historyOrderProvider);
  }

  void onChangeTextSearch(String value) {
    state = state.copyWith(textSearch: value.trim());
  }

  Future<String?> getDetailOrder(OrderModel order) async {
    var map = Map<int, DetailHistoryOrderModel?>.from(state.detail);
    var data = map[order.id] ?? const DetailHistoryOrderModel();
    try {
      map[order.id] = data.copyWith(state: const PageState(status: PageCommonState.loading));
      state = state.copyWith(detail: Map.from(map));
      final result = await _orderRepository.getProductCheckout(order);
      DataBillResponseData? billInfo = await _orderRepository.getDataBill(orderId: order.id);
      map[order.id] = data.copyWith(
        coupons: result.coupons ?? [],
        customer: result.customer,
        dataBill: billInfo,
        productCheckout: result.data?.first.orderItem ?? [],
        state: const PageState(status: PageCommonState.success),
      );
      state = state.copyWith(detail: Map.from(map));
      return null;
    } catch (ex) {
      map[order.id] = data.copyWith(
          state: PageState(status: PageCommonState.error, messageError: ex.toString()));
      state = state.copyWith(detail: Map.from(map));
      return ex.toString();
    }
  }

  void printReceipt({bool requireCompleteBill = false, required OrderModel order}) async {
    var detail = state.detail[order.id];

    try {
      state = state.copyWith(event: HistoryOrderEvent.printBill);
      if (detail == null || detail.state.status != PageCommonState.success) {
        var error = await getDetailOrder(order);
        if (error != null) throw error;
        detail = state.detail[order.id];
      }
      if (detail == null) throw 'Không có dữ liệu thanh toán';
      var dataBill = detail.dataBill;
      var paymentMethod = dataBill?.order.listPaymentMethod.firstOrNull;
      if (paymentMethod == null) {
        throw 'Không thể tìm thấy phương thức đã thanh toán với đơn bàn này';
      }
      var price = dataBill?.price ?? const PriceDataBill();
      var invoiceQr = await _orderRepository.completeBill(
          order: order,
          description: dataBill?.description ?? '',
          isPrintPeople: (dataBill?.print?.order?.isPrintPeople ?? false) ? 1 : 0,
          amountAdult: dataBill?.order.amountAdult ?? 1,
          amountChildren: dataBill?.order.amountChildren ?? 0,
          portrait: dataBill?.order.portrait ?? '',
          totalPrice: price.totalPrice,
          totalPriceTax: price.totalPriceTax,
          totalPriceVoucher: price.totalPriceVoucher,
          totalPriceFinal: price.totalPriceFinal,
          eSaleName: dataBill?.sale?.eSaleName ?? '',
          eSaleCode: dataBill?.sale?.eSaleCode ?? '',
          arrMethod: ['${paymentMethod.keyMethod}--${paymentMethod.paymentAmount}']);
      if (requireCompleteBill) {
        ref.refresh(historyOrderProvider);
        getDetailOrder(order);
      }
      var infoPrint = dataBill?.print?.infoPrint;
      if (infoPrint == null) throw 'Không có thông tin máy in phiếu thanh toán';
      var check = await AppPrinterCommon.checkPrinter(
          IpOrderModel(ip: infoPrint.ip, port: infoPrint.port, type: 1));
      if (check != null) throw check;
      List<LineItemDataBill> _itemsPrint = [];
      for (var e in (dataBill?.orderLineItems ?? [])) {
        _itemsPrint.add(LineItemDataBill(
          name: e.name,
          price: e.price,
          tax: e.tax,
          unit: e.unit,
          count: e.count,
        ));
        if (e.listItem.isNotEmpty) {
          for (var item in e.listItem) {
            _itemsPrint.add(LineItemDataBill(
              name: ' - ${item.name}',
              price: '0',
              tax: '0',
              unit: '',
              count: 0,
            ));
          }
        }
      }
      var data = PaymentReceiptPrintRequest(
        order: order,
        price: price,
        receiptType: ReceiptTypeEnum.paymentReceipt,
        paymentMethod: PaymentMethod(
          key: paymentMethod.keyMethod,
          name: paymentMethod.method,
        ),
        paymentAmount: paymentMethod.paymentAmount,
        numberPrintCompleted: 1,
        numberPrintTemporary: 1,
        orderLineItems: _itemsPrint,
        vouchers: dataBill?.vouchers ?? [],
        note: dataBill?.description ?? '',
        printNumberOfPeople: dataBill?.print?.order?.isPrintPeople ?? false,
        customerPhone: detail.customer?.phoneNumber ?? '',
        numberOfPeople: dataBill?.order.amountAdult ?? 0,
        cashierCompleted: dataBill?.print?.order?.cashierCompleted ?? '',
        cashierPrint: dataBill?.print?.order?.cashierPrint ?? '',
        timeCompleted: dataBill?.print?.order?.timeCompleted,
        timeCreatedAt: dataBill?.print?.order?.createdAt,
        invoiceQr: invoiceQr ?? '',
      );
      var resultSend = await ref.read(homeProvider.notifier).sendPrintData(
        type: PrintTypeEnum.payment,
        paymentData: data,
        printers: [
          PrinterModel(
            ip: infoPrint.ip,
            port: infoPrint.port,
          ),
        ],
      );
      if (resultSend != null) throw resultSend;
      state = state.copyWith(event: HistoryOrderEvent.normal);
    } catch (ex) {
      state = state.copyWith(
        event: HistoryOrderEvent.error,
        messageError: ex.toString(),
      );
    }
  }

  OrderModel convertToOrderModel({
    required int id,
    required String tableName,
    required String code,
    required int typeOrder,
  }) {
    return OrderModel(
      id: id,
      name: tableName,
      misc: '{"order_code":"$code","remarks":""}',
      typeOrder: typeOrder,
    );
  }
}
