import 'dart:async';
import 'dart:math';

import 'package:aladdin_franchise/src/configs/const.dart';
import 'package:aladdin_franchise/src/core/network/provider.dart';
import 'package:aladdin_franchise/src/core/network/repository/order/order_repository.dart';
import 'package:aladdin_franchise/src/data/enum/print_type.dart';
import 'package:aladdin_franchise/src/data/model/restaurant/printer.dart';
import 'package:aladdin_franchise/src/features/pages/checkout/provider.dart';
import 'package:aladdin_franchise/src/features/pages/home/provider.dart';
import 'package:aladdin_franchise/src/features/pages/home/state.dart';
import 'package:aladdin_franchise/src/models/order.dart';
import 'package:aladdin_franchise/src/models/product.dart';
import 'package:aladdin_franchise/src/utils/app_printer/app_printer_common.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'state.dart';

final cartPageProvider = StateNotifierProvider.autoDispose<CartPageNotifier, CartPageState>((ref) {
  return CartPageNotifier(ref, ref.read(orderRepositoryProvider));
});

class CartPageNotifier extends StateNotifier<CartPageState> {
  CartPageNotifier(this.ref, this._orderRepository) : super(const CartPageState());
  final Ref ref;
  final OrderRepository _orderRepository;
  OrderModel? getOrderSelect() {
    return ref.read(homeProvider).orderSelect;
  }

  void resetInfo() {
    state = state.copyWith(
      productsSelecting: [],
      productIdSelect: {},
    );
  }

  void addProductToCart(ProductModel product) async {
    var order = getOrderSelect();
    if (order == null) return;
    var productsSelecting = List<ProductModel>.from(state.productsSelecting);

    var index = productsSelecting.indexWhere((e) => e.id == product.id);
    if (index != -1) {
      var count = max(0, product.numberSelecting);
      if (count == 0) {
        productsSelecting.removeAt(index);
        onChangeProductIdSelect(product.id, false);
      } else {
        productsSelecting[index] = product.copyWith(numberSelecting: count);
      }
    } else {
      productsSelecting.add(product);
      onChangeProductIdSelect(product.id, true);
    }
    state = state.copyWith(productsSelecting: productsSelecting);
    return null;
  }

  void onChangeNoteProduct(int id, String note) async {
    var productsSelecting = List<ProductModel>.from(state.productsSelecting);
    var index = productsSelecting.indexWhere((e) => e.id == id);
    if (index != -1) {
      var item = productsSelecting[index].copyWith(note: note);
      productsSelecting[index] = item;
    }
    state = state.copyWith(productsSelecting: productsSelecting);
  }

  Future<({String? checkPrinters, String? error, String? resultSendPrintData, int? timesOrders})>
      addItemToOrder({
    String note = '',
    Set<PrinterModel> printerSelect = const {},
    bool useDefaultPrinter = true,
    bool processOrder = true,
    bool ignorePrint = false,
    int? turn,
  }) async {
    String? checkPrinters;
    String? resultSendPrintData;
    var order = getOrderSelect();
    if (order == null) {
      return (
        checkPrinters: null,
        error: null,
        resultSendPrintData: null,
        timesOrders: null,
      );
    }
    var productSelecting = List<ProductModel>.from(state.productsSelecting);
    var productIdSelect = Set<int>.from(state.productIdSelect);
    var products = productSelecting.where((e) => productIdSelect.contains(e.id)).toList();
    var kitchenNote = note;
    bool showLoading = processOrder || !ignorePrint;
    Set<PrinterModel> printers = <PrinterModel>{};
    Set<ProductModel> foods = <ProductModel>{}, drinks = <ProductModel>{};
    Set<PrinterModel> foodPrinterDefault = <PrinterModel>{}, barPrinterDefault = <PrinterModel>{};

    int? timesOrders = turn;
    try {
      if (showLoading) {
        state = state.copyWith(event: processOrder ? CartEvent.addItems : CartEvent.sendPrintData);
        // ref
        //     .read(homeProvider.notifier)
        //     .updateEvent(processOrder ? HomeEvent.processOrder : HomeEvent.sendPrintData);
      }
      if (!ignorePrint) {
        if (useDefaultPrinter) {
          for (var item in products) {
            switch (item.printerType) {
              case ProductPrinterType.drink:
                drinks.add(item);
                break;
              case ProductPrinterType.food:
                foods.add(item);
                break;
            }
          }

          for (var item in printerSelect) {
            switch (item.type) {
              case ProductPrinterType.drink:
                barPrinterDefault.add(item);
                break;
              case ProductPrinterType.food:
                foodPrinterDefault.add(item);
                break;
            }
          }

          if (drinks.isNotEmpty) {
            printers.addAll(barPrinterDefault);
          }
          if (foods.isNotEmpty) {
            printers.addAll(foodPrinterDefault);
          }
        } else {
          printers = Set<PrinterModel>.from(printerSelect);
        }
        checkPrinters = await AppPrinterCommon.checkListPrintersStatus(printers.toList());
        if (checkPrinters != null) throw checkPrinters;
      }

      if (processOrder) {
        var res = await _orderRepository.processOrderItem(
          order: order,
          total: products.fold(
              0.0, (previousValue, p) => previousValue + p.getUnitPriceNum() * p.numberSelecting),
          products: products,
          note: kitchenNote,
          cancel: false,
        );
        productSelecting.removeWhere((e) => productIdSelect.contains(e.id));
        state = state.copyWith(
          productsSelecting: productSelecting,
          productIdSelect: <int>{},
        );
        timesOrders = res.timesOrder;
        var checkoutNotifier = ref.read(checkoutProvider.notifier);
        try {
          checkoutNotifier.getProductCheckout();
          checkoutNotifier.getDataBill();
        } catch (ex) {
          //
        }
      }
      if (!ignorePrint) {
        if (useDefaultPrinter) {
          /// check here
          if (drinks.isNotEmpty) {
            resultSendPrintData = await ref.read(homeProvider.notifier).sendPrintData(
                  type: PrintTypeEnum.order,
                  note: kitchenNote,
                  products: drinks.toList(),
                  printers: barPrinterDefault.toList(),
                  timeOrder: timesOrders,
                  printDirectly: !processOrder,
                  useDefaultPrinters: true,
                  totalBill: true,
                );
          }
          if (foods.isNotEmpty) {
            resultSendPrintData = await ref.read(homeProvider.notifier).sendPrintData(
                  type: PrintTypeEnum.order,
                  note: kitchenNote,
                  products: foods.toList(),
                  printers: foodPrinterDefault.toList(),
                  timeOrder: timesOrders,
                  printDirectly: !processOrder,
                  useDefaultPrinters: true,
                  totalBill: true,
                );
          }
        } else {
          resultSendPrintData = await ref.read(homeProvider.notifier).sendPrintData(
                type: PrintTypeEnum.order,
                note: kitchenNote,
                products: products,
                printers: printers.toList(),
                timeOrder: timesOrders,
                printDirectly: !processOrder,
                useDefaultPrinters: false,
                totalBill: true,
              );
        }
      }

      if (showLoading) state = state.copyWith(event: CartEvent.normal);
      //  ref.read(homeProvider.notifier).updateEvent(HomeEvent.normal);

      return (
        checkPrinters: checkPrinters,
        error: null,
        resultSendPrintData: resultSendPrintData,
        timesOrders: timesOrders,
      );
    } catch (ex) {
      if (showLoading) state = state.copyWith(event: CartEvent.normal);
      // ref.read(homeProvider.notifier).updateEvent(HomeEvent.normal);

      return (
        checkPrinters: checkPrinters,
        error: ex.toString(),
        resultSendPrintData: resultSendPrintData,
        timesOrders: timesOrders
      );
    }
  }

  void onChangeProductIdSelect(int id, bool selected) {
    var data = Set<int>.from(state.productIdSelect);
    if (selected) {
      data.add(id);
    } else {
      data.remove(id);
    }
    state = state.copyWith(productIdSelect: data);
  }
}
