import 'dart:async';

import 'package:aladdin_franchise/src/configs/const.dart';
import 'package:aladdin_franchise/src/core/network/provider.dart';
import 'package:aladdin_franchise/src/core/network/repository/order/order_repository.dart';
import 'package:aladdin_franchise/src/data/enum/print_type.dart';
import 'package:aladdin_franchise/src/data/enum/printer_type.dart';
import 'package:aladdin_franchise/src/data/model/restaurant/printer.dart';
import 'package:aladdin_franchise/src/features/pages/home/components/menu/provider.dart';
import 'package:aladdin_franchise/src/features/pages/home/provider.dart';
import 'package:aladdin_franchise/src/models/product.dart';
import 'package:aladdin_franchise/src/models/product_checkout.dart';
import 'package:collection/collection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'state.dart';

final checkoutPageProvider =
    StateNotifierProvider.autoDispose<CheckoutPageNotifier, CheckoutPageState>((ref) {
  return CheckoutPageNotifier(ref, ref.read(orderRepositoryProvider));
});

class CheckoutPageNotifier extends StateNotifier<CheckoutPageState> {
  CheckoutPageNotifier(this.ref, this._orderRepository) : super(const CheckoutPageState());
  final Ref ref;
  final OrderRepository _orderRepository;
  void init(List<ProductCheckoutModel> products) async {
    state = CheckoutPageState(productsCheckout: products);
    await getPrinterDefault();
  }

  Future<void> getPrinterDefault() async {
    var order = ref.read(homeProvider).orderSelect;
    if (order == null) return;
    try {
      var printers = await _orderRepository.getIpPrinterOrder(
        order,
        [
          PrinterTypeEnum.total,
          PrinterTypeEnum.receipt,
          PrinterTypeEnum.tmp,
          PrinterTypeEnum.kitchen,
          PrinterTypeEnum.bar,
        ].map((e) => e.key).toList(),
      );
      var defaultPrinters = printers
          .map(
            (e) => PrinterModel(
                ip: e.ip,
                port: e.port,
                name: e.name,
                defaultPrinter: true,
                pingStatus: true,
                type: e.type,
                typeAreaLocation: e.typeAreaLocation),
          )
          .toSet();
      state = state.copyWith(defaultPrinters: defaultPrinters);
      checkPrinterStatus();
    } catch (ex) {
      //
    }
  }

  void checkPrinterStatus([List<PrinterModel>? printers]) {}

  void reset() {
    state = const CheckoutPageState();
  }

  void changeCancelQuantity(ProductCheckoutModel item) {
    var productsCheckout = List<ProductCheckoutModel>.from(state.productsCheckout);

    var index = productsCheckout.indexWhere((e) => e.id == item.id);
    if (index != -1) {
      productsCheckout[index] = item;
    }
    state = state.copyWith(productsCheckout: productsCheckout);
  }

  Future<String?> cancelProductCheckout({
    List<ProductCheckoutModel> productCheckout = const [],
    String reason = '',
    Set<PrinterModel> printerSelect = const <PrinterModel>{},
    bool useDefaultPrinter = true,
  }) async {
    var order = ref.read(homeProvider).orderSelect;
    if (order == null) return null;
    try {
      var result = await ref.read(homeProvider.notifier).cancelProductOrder1(
            productCheckout: productCheckout,
            reason: reason,
            printerSelect: printerSelect,
            useDefaultPrinter: useDefaultPrinter,
          );
      var menu = ref.read(menuProvider);

      Set<PrinterModel> foodPrinterDefault = <PrinterModel>{}, barPrinterDefault = <PrinterModel>{};
      for (var item in state.defaultPrinters) {
        switch (item.type) {
          case ProductPrinterType.drink:
            barPrinterDefault.add(item);
            break;
          case ProductPrinterType.food:
            foodPrinterDefault.add(item);
            break;
        }
      }

      Set<ProductModel> foods = <ProductModel>{}, drinks = <ProductModel>{};
      Set<ProductModel> productPrint = {};
      for (var item in productCheckout) {
        var p = menu.products.firstWhereOrNull((e) => e.id == item.id);
        if (p != null) {
          var _product = p.copyWith(
            numberSelecting: item.quantityCancel,
            unitPrice: item.unitPrice,
          );
          productPrint.add(_product);
          switch (p.printerType) {
            case ProductPrinterType.drink:
              drinks.add(_product);
              break;
            case ProductPrinterType.food:
              foods.add(_product);
              break;
          }
        } else {
          var pChange = ProductModel(
            id: item.id,
            printerType: item.printerType,
            name: item.name,
            unit: item.unit,
            unitPrice: item.unitPrice,
            numberSelecting: item.quantityCancel,
          );
          productPrint.add(pChange);
          switch (item.printerType) {
            case ProductPrinterType.drink:
              drinks.add(pChange);
              break;
            case ProductPrinterType.food:
              foods.add(pChange);
              break;
          }
        }
      }
      if (useDefaultPrinter) {
        if (drinks.isNotEmpty) {
          ref.read(homeProvider.notifier).sendPrintData(
                type: PrintTypeEnum.cancel,
                note: reason,
                products: drinks.toList(),
                printers: barPrinterDefault.toList(),
                timeOrder: 1,
              );
        }
        if (foods.isNotEmpty) {
          ref.read(homeProvider.notifier).sendPrintData(
                type: PrintTypeEnum.cancel,
                note: reason,
                products: foods.toList(),
                printers: foodPrinterDefault.toList(),
                timeOrder: 1,
              );
        }
      } else {
        ref.read(homeProvider.notifier).sendPrintData(
              type: PrintTypeEnum.cancel,
              note: reason,
              products: productPrint.toList(),
              printers: printerSelect.toList(),
              timeOrder: 1,
            );
      }
      return result.error;
    } catch (ex) {
      return ex.toString();
    }
  }
}

  // void onChangePrinterSelect(PrinterModel item, bool selected) {
  //   var data = Set<PrinterModel>.from(state.printerSelect);
  //   if (selected) {
  //     data.add(item);
  //   } else {
  //     data.remove(item);
  //   }

  //   state = state.copyWith(printerSelect: data);
  // }

  // void onResetPrinterSelect() {
  //   state = state.copyWith(printerSelect: {});
  // }
// }
