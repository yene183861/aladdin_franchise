import 'dart:async';
import 'dart:math';

import 'package:aladdin_franchise/generated/l10n.dart';
import 'package:aladdin_franchise/src/configs/api.dart';
import 'package:aladdin_franchise/src/configs/app.dart';
import 'package:aladdin_franchise/src/configs/const.dart';
import 'package:aladdin_franchise/src/core/network/api/app_exception.dart';
import 'package:aladdin_franchise/src/core/network/provider.dart';
import 'package:aladdin_franchise/src/core/network/repository/order/order_repository.dart';
import 'package:aladdin_franchise/src/core/network/repository/responses/login.dart';
import 'package:aladdin_franchise/src/core/network/repository/user/user_repository.dart';
import 'package:aladdin_franchise/src/core/storages/local.dart';
import 'package:aladdin_franchise/src/data/enum/printer_type.dart';
import 'package:aladdin_franchise/src/data/model/restaurant/printer.dart';
import 'package:aladdin_franchise/src/features/pages/home/provider.dart';
import 'package:aladdin_franchise/src/features/pages/login/state.dart';
import 'package:aladdin_franchise/src/models/product.dart';
import 'package:aladdin_franchise/src/utils/app_helper.dart';
import 'package:aladdin_franchise/src/utils/app_log.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'state.dart';

final cartPageProvider =
    StateNotifierProvider.autoDispose<CartPageNotifier, CartPageState>((ref) {
  return CartPageNotifier(ref, ref.read(orderRepositoryProvider));
});

class CartPageNotifier extends StateNotifier<CartPageState> {
  CartPageNotifier(this.ref, this._orderRepository)
      : super(const CartPageState());
  final Ref ref;
  final OrderRepository _orderRepository;
  void init(List<ProductModel> products) async {
    await getPrinterDefault();
    mapProductWithPrinter();
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
    state = const CartPageState();
  }

  void updateEvent([CartPageEvent? event]) {
    state = state.copyWith(event: event ?? CartPageEvent.normal);
  }

  void mapProductWithPrinter([
    ProductModel? product,
    bool saveConfigPrinter = false,
  ]) {
    var productsSelecting = state.productsSelecting;
    var defaultPrinters = state.defaultPrinters;

    Set<PrinterModel> defaultKitchenPrinter = <PrinterModel>{},
        defaultBarPrinter = <PrinterModel>{};
    for (var item in defaultPrinters) {
      switch (item.type) {
        case ProductPrinterType.drink:
          defaultBarPrinter.add(item);
          break;
        case ProductPrinterType.food:
          defaultKitchenPrinter.add(item);
          break;
      }
    }
    Set<int> productIdSelect = Set<int>.from(state.productIdSelect);
    Map<int, Map<String, dynamic>> map =
        Map<int, Map<String, dynamic>>.from(state.productMap);

    if (saveConfigPrinter) {
      // Set<int> productIdSelectChange = {};
      for (var id in productIdSelect) {
        var product = map[id]?['product'] as ProductModel?;
        // if (product == null) {
        //   map.remove(id);
        // } else {
        // productIdSelectChange.add(value)
        map[id] = {
          'printers': state.printerSelect,
          'product': product,
        };
        // }
      }
      // var values = state.productMap.values.where((e) => e['selected'] == true);
      // for (var item in state.)
    } else if (product != null) {
      var printDefault = switch (product.printerType) {
        null => <PrinterModel>{},
        ProductPrinterType.drink => defaultBarPrinter,
        ProductPrinterType.food => defaultKitchenPrinter,
        _ => <PrinterModel>{},
      };
      var printers =
          (map[product.id]?['printers'] ?? printDefault) as Set<PrinterModel>;
      if (product.numberSelecting == 0) {
        map.remove(product.id);
        productIdSelect.remove(product.id);
      } else {
        map[product.id] = {
          'printers': printers,
          'product': product,
        };
        productIdSelect.add(product.id);
      }
    } else {
      for (var item in productsSelecting) {
        var print = switch (item.printerType) {
          null => <PrinterModel>{},
          ProductPrinterType.drink => defaultBarPrinter,
          ProductPrinterType.food => defaultKitchenPrinter,
          _ => <PrinterModel>{},
        };
        productIdSelect.add(item.id);
        map[item.id] = {
          'printers': print,
          'product': item,
        };
      }
    }
    // // Map<int, Set<PrinterModel>> map = {};
    // Map<int, Map<String, dynamic>> map1 = {};
    // if (product == null) {
    //   // cấu hình máy in mặc định cho các món
    //   for (var item in productsSelecting) {
    //     var print = switch (item.printerType) {
    //       null => <PrinterModel>{},
    //       ProductPrinterType.drink => defaultBarPrinter,
    //       ProductPrinterType.food => defaultKitchenPrinter,
    //       _ => <PrinterModel>{},
    //     };
    //     // map[item.id] = print;
    //     map1[item.id] = {
    //       'selected': map1[item.id]?['selected'] ?? true,
    //       'printers': print,
    //       'product': item,
    //     };
    //   }
    // } else {
    //   var printDefault = switch (product.printerType) {
    //     null => <PrinterModel>{},
    //     ProductPrinterType.drink => defaultBarPrinter,
    //     ProductPrinterType.food => defaultKitchenPrinter,
    //     _ => <PrinterModel>{},
    //   };
    //   var printers =
    //       (map1[product.id]?['printers'] ?? printDefault) as Set<PrinterModel>;
    //   if (product.numberSelecting == 0) {
    //     map1[product.id] = {
    //       'selected': false,
    //       'printers': printers,
    //       'product': null,
    //     };
    showLogs(productIdSelect, flags: 'productIdSelect');
    showLogs(map, flags: 'map');
    state = state.copyWith(
      productMap: map,
      productIdSelect: productIdSelect,
    );
  }

  void addProductToCart({required ProductModel product}) async {
    var order = ref.read(homeProvider).orderSelect;
    if (order == null) return;
    var productsSelecting = List<ProductModel>.from(state.productsSelecting);

    var index = productsSelecting.indexWhere((e) => e.id == product.id);
    if (index != -1) {
      var item = productsSelecting[index];
      productsSelecting[index] =
          product.copyWith(numberSelecting: max(0, item.numberSelecting));
    } else {
      productsSelecting.add(product.copyWith(numberSelecting: 1));
    }
    state = state.copyWith(productsSelecting: productsSelecting);

    Map<String, int> data = {};
    for (var e in productsSelecting) {
      data[e.id.toString()] = e.numberSelecting;
    }
    try {
      await LocalStorage.setOrderItemSelectingForOrder(
          orderId: order.id, data: data);
    } catch (ex) {
      showLogs(ex, flags: 'addProductToCart - K lưu được món đang chọn');
    }

    // mapProductIdWithPrinter(product);
    // onChangeProductIdSelect(product.id, true);
    mapProductWithPrinter(product);
    return null;
  }

  void addItems() async {
    var order = ref.read(homeProvider).orderSelect;
    if (order == null) return;
    var note = LocalStorage.getNotePerOrderItem(order: order);

    Set<int> printerCheck = {};

    // Map<int, List<ProductModel>> printerMapProducts = {};
    // double total = 0.0;
    // List<ProductModel> productPrintBill = (state.productsSelecting).map((e) {
    //   total += (double.tryParse(e.unitPrice) ?? 0.0) * max(0, e.numberSelecting);

    //   var product = e.copyWith(note: note?[e.id.toString()] ?? '');
    //   var comboItems = ProductHelper().getComboDescription(product);
    //   if (comboItems == null || comboItems.isEmpty) {
    //     if (product.printerType != null) {
    //       var items = List<ProductModel>.from(printerMapProducts[product.printerType] ?? []);
    //       // coi combo k có thành phần như là món thường để in
    //       items.add(product.copyWith(description: null));
    //       printerMapProducts[product.printerType!] = items;
    //     }
    //   } else {
    //     Map<int, List<ComboItemModel>> printComboItem = {};
    //     for (var ci in comboItems) {
    //       var printerType = ci.printerType;
    //       if (printerType != null) {
    //         var items = List<ComboItemModel>.from(printComboItem[printerType] ?? []);
    //         items.add(ci);
    //         printComboItem[printerType] = items;
    //       }
    //     }

    //     printComboItem.forEach(
    //       (key, value) {
    //         var items = List<ProductModel>.from(printerMapProducts[key] ?? []);
    //         items.add(product.copyWith(description: jsonEncode(value)));
    //         printerMapProducts[key] = items;
    //       },
    //     );
    //   }

    //   if (product.printerType != null) {
    //     printerCheck.add(product.printerType!);
    //   }
    //   return product;
    // }).toList();

    // try {
    //   updateEvent(CartPageEvent.addItems);
    //   showLogs(printerCheck, flags: 'ds printerType gọi món');
    //   var listPrinters = await _orderRepository.getPrinterBill(
    //     order,
    //     printerCheck.toList(),
    //   );

    //   showLogs(listPrinters, flags: 'danh sách máy in - gọi món');
    //   var kitchenNote = state.kitchenNote;
    //   await _checkOrderSelect();
    //   var result = await _orderRepository.processOrderItem(
    //     order: state.orderSelect!,
    //     total: total,
    //     // orderNote: kitchenNote,
    //     products: productPrintBill,
    //     note: kitchenNote,
    //     cancel: false,
    //   );

    //   try {
    //     await LocalStorage.deleteNotePerOrderItem(order: state.orderSelect!);
    //   } catch (ex) {
    //     //
    //   }
    //   state = state.copyWith(
    //     productsSelecting: [],
    //     orderTabSelect: OrderTabEnum.ordered,
    //   );

    //   try {
    //     await LocalStorage.setOrderItemSelectingForOrder(orderId: state.orderSelect!.id, data: {});
    //   } catch (ex) {
    //     //
    //   }
    //   getOrderProductCheckout(applyPolicy: true);

    //   state = state.copyWith(kitchenNote: '');
    //   // sử dụng kds thì k cần in
    //   if (AppConfig.useKds) {
    //     updateEvent(HomeEvent.normal);
    //     return null;
    //   }

    //   try {
    //     var setting = LocalStorage.getPrintSetting();
    //     bool printNormal = setting.appPrinterType == AppPrinterSettingTypeEnum.normal;

    //     for (var printer in (listPrinters ?? <IpOrderModel>[])) {
    //       List<ProductModel> productPrinter =
    //           List<ProductModel>.from(printerMapProducts[printer.type] ?? []);

    //       if (productPrinter.isEmpty) {
    //         continue;
    //       }
    //       if (kitchenNote.trim().isEmpty && productPrinter.length == 1) {
    //         kitchenNote = productPrinter.firstOrNull?.note ?? '';
    //       }
    //       showLogs(productPrinter.length, flags: 'check só lượng món in');
    //       var bytes = printNormal
    //           ? await AppPrinterNormalUtils.instance.generateBill(
    //               order: state.orderSelect!,
    //               billSingle: false,
    //               cancel: false,
    //               timeOrder: 1,
    //               totalNote: kitchenNote,
    //               products: productPrinter,
    //               title: '',
    //             )
    //           : await AppPrinterHtmlUtils.instance
    //               .generateImageBill(AppPrinterHtmlUtils.instance.kitchenBillContent(
    //               order: state.orderSelect!,
    //               product: productPrinter,
    //               note: kitchenNote,
    //               timeOrders: 1,
    //               cancel: false,
    //               totalBill: true,
    //             ));
    //       List<ProductModel> errors = [];
    //       PrintQueue.instance.addTask(
    //         ip: printer.ip,
    //         port: printer.port,
    //         buildReceipt: (generator) async {
    //           return bytes;
    //         },
    //         onComplete: (success, error) async {
    //           if (success) {
    //             showLogs("✅ In thành công", flags: 'BILL TỔNG');
    //             // chỉ in bill lẻ với bếp
    //             String? errorPrintOdd;
    //             if (printer.type == 2 && setting.billReturnSetting.useOddBill) {
    //               for (var item in productPrinter) {
    //                 List<int> byteDatas;

    //                 var listComboItemPrint = ProductHelper().getComboDescription(item);

    //                 if (listComboItemPrint == null || listComboItemPrint.isEmpty) {
    //                   // món thường
    //                   byteDatas = printNormal
    //                       ? await AppPrinterNormalUtils.instance.generateBill(
    //                           order: state.orderSelect!,
    //                           billSingle: true,
    //                           cancel: false,
    //                           timeOrder: 1,
    //                           totalNote: kitchenNote,
    //                           products: [item],
    //                           title: '',
    //                         )
    //                       : await AppPrinterHtmlUtils.instance
    //                           .generateImageBill(AppPrinterHtmlUtils.instance.kitchenBillContent(
    //                           product: [item],
    //                           totalBill: false,
    //                           order: state.orderSelect!,
    //                           note: kitchenNote,
    //                           timeOrders: 1,
    //                         ));
    //                   PrintQueue.instance.addTask(
    //                     ip: printer.ip,
    //                     port: printer.port,
    //                     buildReceipt: (generator) async {
    //                       return byteDatas;
    //                     },
    //                     onComplete: (success, error) {
    //                       if (success) {
    //                         showLogs("✅ In thành công\n$item", flags: 'BILL LẺ');
    //                       } else {
    //                         errorPrintOdd = error;
    //                         errors.add(item);
    //                         showLogs("❌ In thất bại\n$item", flags: 'BILL LẺ');
    //                       }
    //                     },
    //                   );
    //                 } else {
    //                   // in từng món trong combo
    //                   for (var ci in listComboItemPrint) {
    //                     byteDatas = printNormal
    //                         ? await AppPrinterNormalUtils.instance.generateBill(
    //                             order: state.orderSelect!,
    //                             billSingle: true,
    //                             cancel: false,
    //                             timeOrder: 1,
    //                             totalNote: kitchenNote,
    //                             products: [
    //                               item.copyWith(description: jsonEncode([ci]))
    //                             ],
    //                             title: '',
    //                           )
    //                         : await AppPrinterHtmlUtils.instance.generateImageBill(
    //                             AppPrinterHtmlUtils.instance.kitchenBillContent(
    //                               product: [
    //                                 item.copyWith(description: jsonEncode([ci]))
    //                               ],
    //                               totalBill: false,
    //                               order: state.orderSelect!,
    //                               note: kitchenNote,
    //                               timeOrders: 1,
    //                             ),
    //                           );
    //                     PrintQueue.instance.addTask(
    //                       ip: printer.ip,
    //                       port: printer.port,
    //                       buildReceipt: (generator) async {
    //                         return byteDatas;
    //                       },
    //                       onComplete: (success, error) {
    //                         if (success) {
    //                           showLogs(
    //                               "✅ In thành công\n${item.copyWith(description: jsonEncode(ci))}",
    //                               flags: 'BILL LẺ');
    //                         } else {
    //                           errorPrintOdd = error;
    //                           errors.add(
    //                             item.copyWith(
    //                               description: jsonEncode([ci]),
    //                             ),
    //                           );
    //                           showLogs(
    //                               "❌ In thất bại\n${item.copyWith(description: jsonEncode(ci))}",
    //                               flags: 'BILL LẺ');
    //                         }
    //                       },
    //                     );
    //                   }
    //                 }
    //               }
    //               if (errors.isNotEmpty && context.mounted) {
    //                 showMessageDialog(
    //                   context,
    //                   message: "Không thể in bill lẻ xuống bếp\n"
    //                       '$errorPrintOdd\n'
    //                       'Danh sách các món không thể ra bill lẻ:\n${errors.map((e) => e.name).join(', ')}',
    //                 );
    //               }
    //             }
    //           } else {
    //             showLogs("❌ In thất bại", flags: 'BILL TỔNG');
    //             if (error != null && context.mounted) {
    //               showMessageDialog(
    //                 context,
    //                 message: "Món đã được thêm vào hóa đơn nhưng không thể in bill xuống bếp\n"
    //                     'Lỗi:\n$error',
    //               );
    //             }
    //           }
    //         },
    //       );
    //     }

    //     updateEvent(HomeEvent.normal);
    //     return null;
    //   } catch (ex) {
    //     updateEvent(HomeEvent.normal);
    //     if (context.mounted) {
    //       showMessageDialog(
    //         context,
    //         message: 'Món đã được thêm vào hóa đơn nhưng không thể in bill xuống bếp\n'
    //             'Lỗi:\n${ex.toString()}',
    //       );
    //     }
    //     return null;
    //   }
    // } catch (ex) {
    //   updateEvent(HomeEvent.normal);
    //   _lockOrder(ex);
    //   return ex.toString();
    // }
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

  void onChangeDisplayPrinterSetupPanel(bool? value) {
    state = state.copyWith(
        showPrinterSetupPanel: value ?? !state.showPrinterSetupPanel);
  }
}
