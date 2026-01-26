import 'dart:async';
import 'dart:math';

import 'package:aladdin_franchise/generated/l10n.dart';
import 'package:aladdin_franchise/src/configs/api.dart';
import 'package:aladdin_franchise/src/configs/app.dart';
import 'package:aladdin_franchise/src/configs/const.dart';
import 'package:aladdin_franchise/src/configs/enums/bill_setting.dart';
import 'package:aladdin_franchise/src/core/network/api/app_exception.dart';
import 'package:aladdin_franchise/src/core/network/provider.dart';
import 'package:aladdin_franchise/src/core/network/repository/order/order_repository.dart';
import 'package:aladdin_franchise/src/core/network/repository/responses/login.dart';
import 'package:aladdin_franchise/src/core/network/repository/user/user_repository.dart';
import 'package:aladdin_franchise/src/core/services/print_queue.dart';
import 'package:aladdin_franchise/src/core/storages/local.dart';
import 'package:aladdin_franchise/src/data/enum/print_type.dart';
import 'package:aladdin_franchise/src/data/enum/printer_type.dart';
import 'package:aladdin_franchise/src/data/model/restaurant/printer.dart';
import 'package:aladdin_franchise/src/features/pages/home/provider.dart';
import 'package:aladdin_franchise/src/features/pages/home/state.dart';
import 'package:aladdin_franchise/src/features/pages/login/state.dart';
import 'package:aladdin_franchise/src/models/ip_order.dart';
import 'package:aladdin_franchise/src/models/product.dart';
import 'package:aladdin_franchise/src/utils/app_helper.dart';
import 'package:aladdin_franchise/src/utils/app_log.dart';
import 'package:aladdin_franchise/src/utils/app_printer/app_printer_common.dart';
import 'package:aladdin_franchise/src/utils/app_printer/app_printer_html.dart';
import 'package:aladdin_franchise/src/utils/app_printer/app_printer_normal.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'state.dart';

final cartPageProvider = StateNotifierProvider.autoDispose<CartPageNotifier, CartPageState>((ref) {
  return CartPageNotifier(ref, ref.read(orderRepositoryProvider));
});

class CartPageNotifier extends StateNotifier<CartPageState> {
  CartPageNotifier(this.ref, this._orderRepository) : super(const CartPageState());
  final Ref ref;
  final OrderRepository _orderRepository;

  void initialize() {
    var order = ref.read(homeProvider).orderSelect;
    if (order == null) {
      showLogs(null, flags: 'cartPageProvider init NO ACTION');
      state = const CartPageState();
    } else {
      showLogs(null, flags: 'cartPageProvider load product selecting');
    }
  }

  void init(List<ProductModel> products) async {
    state = state.copyWith(productsSelecting: products);
    // await getPrinterDefault();
    // mapProductWithPrinter();
  }

  // Future<void> getPrinterDefault() async {
  //   var order = ref.read(homeProvider).orderSelect;
  //   if (order == null) return;
  //   try {
  //     var printers = await _orderRepository.getIpPrinterOrder(
  //       order,
  //       [
  //         PrinterTypeEnum.total,
  //         PrinterTypeEnum.receipt,
  //         PrinterTypeEnum.tmp,
  //         PrinterTypeEnum.kitchen,
  //         PrinterTypeEnum.bar,
  //       ].map((e) => e.key).toList(),
  //     );
  //     var defaultPrinters = printers
  //         .map(
  //           (e) => PrinterModel(
  //               ip: e.ip,
  //               port: e.port,
  //               name: e.name,
  //               // defaultPrinter: true,
  //               // pingStatus: true,
  //               type: e.type,
  //               typeAreaLocation: e.typeAreaLocation),
  //         )
  //         .toSet();
  //     state = state.copyWith(defaultPrinters: defaultPrinters);
  //     checkPrinterStatus();
  //   } catch (ex) {
  //     //
  //   }
  // }

  // void checkPrinterStatus([List<PrinterModel>? printers]) {}

  // void reset() {
  //   state = const CartPageState();
  // }

  // void updateEvent([CartPageEvent? event]) {
  //   state = state.copyWith(event: event ?? CartPageEvent.normal);
  // }

  // void mapProductWithPrinter({
  //   ProductModel? product,
  //   bool saveConfigPrinter = false,
  //   List<ProductModel>? productsConfig,
  // }) {
  //   var productsSelecting = state.productsSelecting;
  //   var defaultPrinters = state.defaultPrinters;

  //   Set<PrinterModel> defaultKitchenPrinter = <PrinterModel>{},
  //       defaultBarPrinter = <PrinterModel>{};
  //   for (var item in defaultPrinters) {
  //     switch (item.type) {
  //       case ProductPrinterType.drink:
  //         defaultBarPrinter.add(item);
  //         break;
  //       case ProductPrinterType.food:
  //         defaultKitchenPrinter.add(item);
  //         break;
  //     }
  //   }
  //   Set<int> productIdSelect = Set<int>.from(state.productIdSelect);
  //   Map<int, Map<String, dynamic>> map =
  //       Map<int, Map<String, dynamic>>.from(state.productMap);

  //   if (saveConfigPrinter) {
  //     // Set<int> productIdSelectChange = {};
  //     for (var id in productIdSelect) {
  //       var product = map[id]?['product'] as ProductModel?;
  //       // if (product == null) {
  //       //   map.remove(id);
  //       // } else {
  //       // productIdSelectChange.add(value)

  //       var printDefault = (map[id]?['default_printers'] ?? <PrinterModel>{})
  //           as Set<PrinterModel>;
  //       map[id] = {
  //         'printers': state.printerSelect,
  //         'product': product,
  //         'default_printers': printDefault,
  //       };
  //       // }
  //     }
  //     // var values = state.productMap.values.where((e) => e['selected'] == true);
  //     // for (var item in state.)
  //   } else if (product != null) {
  //     var printDefault = switch (product.printerType) {
  //       null => <PrinterModel>{},
  //       ProductPrinterType.drink => defaultBarPrinter,
  //       ProductPrinterType.food => defaultKitchenPrinter,
  //       _ => <PrinterModel>{},
  //     };
  //     var printers =
  //         (map[product.id]?['printers'] ?? printDefault) as Set<PrinterModel>;
  //     if (product.numberSelecting <= 0) {
  //       map.remove(product.id);
  //       productIdSelect.remove(product.id);
  //     } else {
  //       map[product.id] = {
  //         'printers': printers,
  //         'product': product,
  //         'default_printers': printDefault,
  //       };
  //       productIdSelect.add(product.id);
  //       state = state.copyWith(printerSelect: {
  //         ...state.printerSelect,
  //         ...printers,
  //       });
  //     }
  //   } else {
  //     state = state.copyWith(printerSelect: {});
  //     for (var item in (productsConfig ?? state.productsSelecting)) {
  //       var print = switch (item.printerType) {
  //         null => <PrinterModel>{},
  //         ProductPrinterType.drink => defaultBarPrinter,
  //         ProductPrinterType.food => defaultKitchenPrinter,
  //         _ => <PrinterModel>{},
  //       };
  //       productIdSelect.add(item.id);
  //       map[item.id] = {
  //         'printers': print,
  //         'product': item,
  //         'default_printers': print,
  //       };
  //       state = state.copyWith(printerSelect: {
  //         ...print,
  //         ...state.printerSelect,
  //       });
  //     }
  //   }
  //   // // Map<int, Set<PrinterModel>> map = {};
  //   // Map<int, Map<String, dynamic>> map1 = {};
  //   // if (product == null) {
  //   //   // cấu hình máy in mặc định cho các món
  //   //   for (var item in productsSelecting) {
  //   //     var print = switch (item.printerType) {
  //   //       null => <PrinterModel>{},
  //   //       ProductPrinterType.drink => defaultBarPrinter,
  //   //       ProductPrinterType.food => defaultKitchenPrinter,
  //   //       _ => <PrinterModel>{},
  //   //     };
  //   //     // map[item.id] = print;
  //   //     map1[item.id] = {
  //   //       'selected': map1[item.id]?['selected'] ?? true,
  //   //       'printers': print,
  //   //       'product': item,
  //   //     };
  //   //   }
  //   // } else {
  //   //   var printDefault = switch (product.printerType) {
  //   //     null => <PrinterModel>{},
  //   //     ProductPrinterType.drink => defaultBarPrinter,
  //   //     ProductPrinterType.food => defaultKitchenPrinter,
  //   //     _ => <PrinterModel>{},
  //   //   };
  //   //   var printers =
  //   //       (map1[product.id]?['printers'] ?? printDefault) as Set<PrinterModel>;
  //   //   if (product.numberSelecting == 0) {
  //   //     map1[product.id] = {
  //   //       'selected': false,
  //   //       'printers': printers,
  //   //       'product': null,
  //   //     };
  //   state = state.copyWith(
  //     productMap: map,
  //     productIdSelect: productIdSelect,
  //   );
  // }

  void onChangeNoteProduct(int id, String note) async {
    var productsSelecting = List<ProductModel>.from(state.productsSelecting);

    var index = productsSelecting.indexWhere((e) => e.id == id);
    if (index != -1) {
      var item = productsSelecting[index].copyWith(note: note);
      productsSelecting[index] = item;
    }
    state = state.copyWith(productsSelecting: productsSelecting);

    return null;
  }

  void addProductToCart(ProductModel product) async {
    var order = ref.read(homeProvider).orderSelect;
    if (order == null) return;
    var productsSelecting = List<ProductModel>.from(state.productsSelecting);

    var index = productsSelecting.indexWhere((e) => e.id == product.id);
    if (index != -1) {
      var count = max(0, product.numberSelecting);
      if (count == 0) {
        productsSelecting.removeAt(index);
        onChangeProductIdSelect(product.id, false);
      } else {
        // mapProductWithPrinter(
        //     product: product.copyWith(numberSelecting: count));
        productsSelecting[index] = product.copyWith(numberSelecting: count);
        onChangeProductIdSelect(product.id, true);
      }
    } else {
      productsSelecting.add(product);
      onChangeProductIdSelect(product.id, true);
      // mapProductWithPrinter(product: product);
    }
    state = state.copyWith(productsSelecting: productsSelecting);

    // Map<String, int> data = {};
    // for (var e in productsSelecting) {
    //   data[e.id.toString()] = e.numberSelecting;
    // }
    // try {
    //   await LocalStorage.setOrderItemSelectingForOrder(orderId: order.id, data: data);
    // } catch (ex) {
    //   showLogs(ex, flags: 'addProductToCart - K lưu được món đang chọn');
    // }

    // mapProductIdWithPrinter(product);
    // onChangeProductIdSelect(product.id, true);
    return null;
  }

  Future<({String? pingPrinters, String? error, String? resultSendPrintData})> addItemToOrder({
    String note = '',
    Set<PrinterModel> printerSelect = const {},
    bool useDefaultPrinter = true,
    bool processOrder = true,
    bool ignorePrint = false,
  }) async {
    String? checkPrinters;
    String? resultSendPrintData;
    var order = ref.read(homeProvider).orderSelect;
    if (order == null) return (pingPrinters: null, error: null, resultSendPrintData: null);
    var productSelecting = List<ProductModel>.from(state.productsSelecting);
    var productIdSelect = Set<int>.from(state.productIdSelect);
    var products = productSelecting.where((e) => productIdSelect.contains(e.id)).toList();
    var kitchenNote = note;
    bool showLoading = processOrder || !ignorePrint;
    Set<PrinterModel> printers = <PrinterModel>{};
    Set<ProductModel> foods = <ProductModel>{}, drinks = <ProductModel>{};
    // for (var item in products) {
    //   switch (item.printerType) {
    //     case ProductPrinterType.drink:
    //       drinks.add(item);
    //       break;
    //     case ProductPrinterType.food:
    //       foods.add(item);
    //       break;
    //   }
    // }
    Set<PrinterModel> foodPrinterDefault = <PrinterModel>{}, barPrinterDefault = <PrinterModel>{};
    try {
      if (showLoading) {
        ref
            .read(homeProvider.notifier)
            .updateEvent(processOrder ? HomeEvent.processOrder : HomeEvent.sendPrintData);
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
        await _orderRepository.processOrderItem(
          order: order,
          total: products.fold(
              0.0, (previousValue, p) => previousValue + p.getUnitPriceNum() * p.numberSelecting),
          products: products,
          note: kitchenNote,
          cancel: false,
        );

        // ref.read(homeProvider.notifier).getOrderProductCheckout();
        // ref.read(homeProvider.notifier).getDataBill();
      }
      if (!ignorePrint) {
        if (useDefaultPrinter) {
          if (drinks.isNotEmpty) {
            resultSendPrintData = await ref.read(homeProvider.notifier).sendPrintData(
                  type: PrintTypeEnum.order,
                  note: kitchenNote,
                  products: drinks.toList(),
                  printers: barPrinterDefault.toList(),
                  timeOrder: 1,
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
                  timeOrder: 1,
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
                timeOrder: 1,
                printDirectly: !processOrder,
                useDefaultPrinters: false,
                totalBill: true,
              );
        }
      }
      if (processOrder) {
        productSelecting.removeWhere((e) => productIdSelect.contains(e.id));
        state = state.copyWith(
          productsSelecting: productSelecting,
          productIdSelect: <int>{},
        );
      }
      if (showLoading) ref.read(homeProvider.notifier).updateEvent(HomeEvent.normal);

      return (
        pingPrinters: checkPrinters,
        error: null,
        resultSendPrintData: resultSendPrintData,
      );
    } catch (ex) {
      if (showLoading) ref.read(homeProvider.notifier).updateEvent(HomeEvent.normal);

      return (
        pingPrinters: checkPrinters,
        error: ex.toString(),
        resultSendPrintData: resultSendPrintData,
      );
    }
  }

  void onChangeProductIdSelect(int id, bool selected) {
    var data = Set<int>.from(state.productIdSelect);
    if (selected) {
      // mapProductWithPrinter(product: product);
      data.add(id);
    } else {
      data.remove(id);
    }

    state = state.copyWith(productIdSelect: data);
  }
}
