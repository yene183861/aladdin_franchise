import 'dart:async';
import 'dart:convert';

import 'package:aladdin_franchise/src/configs/app.dart';
import 'package:aladdin_franchise/src/configs/enums/bill_setting.dart';
import 'package:aladdin_franchise/src/configs/enums/type_order.dart';
import 'package:aladdin_franchise/src/core/network/repository/menu/menu_repository.dart';
import 'package:aladdin_franchise/src/core/network/provider.dart';
import 'package:aladdin_franchise/src/core/services/print_queue.dart';
import 'package:aladdin_franchise/src/core/storages/local.dart';
import 'package:aladdin_franchise/src/core/storages/provider.dart';
import 'package:aladdin_franchise/src/data/enum/status.dart';
import 'package:aladdin_franchise/src/data/model/o2o/request_order.dart';
import 'package:aladdin_franchise/src/features/common/process_state.dart';
import 'package:aladdin_franchise/src/features/dialogs/message.dart';
import 'package:aladdin_franchise/src/models/category.dart';
import 'package:aladdin_franchise/src/models/combo_item.dart';
import 'package:aladdin_franchise/src/models/ip_order.dart';
import 'package:aladdin_franchise/src/models/order.dart';
import 'package:aladdin_franchise/src/models/product.dart';
import 'package:aladdin_franchise/src/models/tag_product.dart';
import 'package:aladdin_franchise/src/utils/app_log.dart';
import 'package:aladdin_franchise/src/utils/app_printer/app_printer_html.dart';
import 'package:aladdin_franchise/src/utils/app_printer/app_printer_normal.dart';
import 'package:aladdin_franchise/src/utils/date_time.dart';
import 'package:aladdin_franchise/src/utils/product_helper.dart';
import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import 'state.dart';

final menuProvider = StateNotifierProvider.autoDispose<MenuNotifier, MenuState>((ref) {
  return MenuNotifier(
    ref,
    ref.read(menuRepositoryProvider),
  );
});

class MenuNotifier extends StateNotifier<MenuState> {
  MenuNotifier(
    this.ref,
    this._menuRepository,
  ) : super(const MenuState()) {
    ctrlSearch = TextEditingController();
    fetchAllProducts();
  }

  final Ref ref;
  final MenuRepository _menuRepository;

  Map<dynamic, GlobalKey> categoryKeys = {};

  late TextEditingController ctrlSearch;

  final ItemScrollController categoryScrollController = ItemScrollController();
  final ItemPositionsListener categoryPositionsListener = ItemPositionsListener.create();

  @override
  void dispose() {
    ctrlSearch.dispose();
    super.dispose();
  }

  Future<void> init({bool fetchProducts = true}) async {
    ctrlSearch.text = '';
    state = state.copyWith(
      categorySelect: null,
      subCategorySelect: null,
      tagSelect: null,
      search: '',
    );
    if (fetchProducts) {
      await getProducts();
    }
  }

  void changeCategorySelect(CategoryModel? categoryModel) {
    state = state.copyWith(categorySelect: categoryModel);

    if ((categoryModel?.children ?? []).isEmpty) {
      changeSubCategorySelect(null);
    } else {
      var subCategorySelect = state.subCategorySelect;
      var checkSubCategorySelect =
          categoryModel?.children?.firstWhereOrNull((e) => e == subCategorySelect);
      if (subCategorySelect == null || checkSubCategorySelect == null) {
        changeSubCategorySelect(
            (categoryModel?.children?.isEmpty ?? true) ? null : categoryModel!.children!.first);
      }
    }
  }

  void changeSubCategorySelect(SubCategoryModel? subCategoryModel) {
    state = state.copyWith(subCategorySelect: subCategoryModel);
  }

  void checkReloadMenu() {
    final lastTime = LocalStorage.getLastReloadMenu();
    final now = DateTime.now();
    if ((now.compareToWithoutTime(lastTime) == false) && now.hour >= 9 && now.minute >= 5) {
      getProducts();
    }
  }

  Future<void> getProducts() async {
    try {
      state = state.copyWith(productState: const ProcessState(status: StatusEnum.loading));

      await fetchAllProducts();
      var data = getMenuByType(kTypeOrder);
      if (data.status.status == StatusEnum.error) {
        throw data.status.message;
      }
      await LocalStorage.setLastReloadMenu();
      List<ProductModel> products = data.products;
      List<CategoryModel> categories = data.categories;
      List<TagProductModel> tags = data.tags;
      List<dynamic> menuCategoryItem = [];

      if (categories.isNotEmpty) {
        var categorySelect = state.categorySelect;

        var checkCategorySelect = categories.firstWhereOrNull((e) => e.id == categorySelect?.id);
        if (categorySelect == null || checkCategorySelect == null) {
          changeCategorySelect(categories.first);
          checkCategorySelect = categories.first;
        } else {
          changeCategorySelect(checkCategorySelect);
        }
      } else {
        state = state.copyWith(
          categorySelect: null,
          subCategorySelect: null,
        );
      }

      for (var element in categories) {
        menuCategoryItem.add(element);
        categoryKeys[element] = categoryKeys[element] ?? GlobalKey();
        if ((element.children ?? []).isNotEmpty) {
          menuCategoryItem.add(-1);
        }
        for (var sub in (element.children ?? [])) {
          menuCategoryItem.add(sub);
          categoryKeys[sub] = categoryKeys[sub] ?? GlobalKey();
        }
      }

      state = state.copyWith(
        categories: categories,
        products: products,
        tags: tags,
        menuCategoryItem: menuCategoryItem,
        productState: const ProcessState(status: StatusEnum.success),
        tagSelect: tags.firstWhereOrNull((e) => e == state.tagSelect),
      );
    } catch (ex) {
      if (mounted) {
        state = state.copyWith(
          productState: ProcessState(
            status: StatusEnum.error,
            message: ex.toString(),
          ),
        );
      }
    }
  }

  void changeSearch(String text) {
    state = state.copyWith(search: text);
    if (ctrlSearch.text != text) {
      ctrlSearch.text = text;
    }
  }

  void changeTagSelect(TagProductModel? tag) {
    state = state.copyWith(tagSelect: tag);
  }

  void updateReloadWhenHiddenApp(bool value) {
    state = state.copyWith(checkReloadWhenHiddenApp: value);
  }

  bool getCheckReloadWhenHiddenApp() => state.checkReloadWhenHiddenApp;

  ({
    List<ProductModel> products,
    List<CategoryModel> categories,
    List<TagProductModel> tags,
    ProcessState status
  }) getMenuByType(int? typeOrder) {
    var allProduct = Map<int, Map<String, dynamic>>.from(state.allProduct);
    var data = allProduct[typeOrder ?? kTypeOrder] ?? {};
    return (
      products: (data['product'] ?? []) as List<ProductModel>,
      categories: (data['category'] ?? []) as List<CategoryModel>,
      tags: (data['tag'] ?? []) as List<TagProductModel>,
      status: (data['status'] ?? const ProcessState(status: StatusEnum.normal)) as ProcessState,
    );
  }

  Future<void> fetchAllProducts() async {
    await _fetchProductByType(TypeOrderEnum.offline.type);
    if (ref.read(enableOrderOnlineProvider)) {
      await _fetchProductByType(TypeOrderEnum.online.type);
    }
  }

  Future<void> _fetchProductByType(int typeOrder) async {
    Map<String, dynamic> result = {
      "status": const ProcessState(status: StatusEnum.loading),
      "category": [],
      "tag": [],
      "product": [],
    };
    int retry = 0;
    while (retry < 3) {
      try {
        final categoryResult = await _menuRepository.getCategory(typeOrder);
        List<CategoryModel> categories = categoryResult.data;
        List<TagProductModel> tags = categoryResult.tags ?? [];
        final products = await _menuRepository.getProduct(null, typeOrder: typeOrder);

        result = {
          "status": const ProcessState(status: StatusEnum.success),
          "category": categories,
          "tag": tags,
          "product": products,
        };
        break;
      } catch (ex) {
        retry++;
        result[typeOrder]?["status"] = ProcessState(
          status: StatusEnum.error,
          message: ex.toString(),
        );
      }
    }
    var allProduct = Map<int, Map<String, dynamic>>.from(state.allProduct);
    allProduct[typeOrder] = result;
    state = state.copyWith(allProduct: allProduct);
  }

  Map<int, List<ProductModel>> mapO2oItemWithPrintType(List<RequestOrderItemModel> items) {
    Map<int, List<ProductModel>> productPrint = {};
    var data = state.allProduct[TypeOrderEnum.offline.type] ?? {};

    var status = (data['status'] ?? const ProcessState(status: StatusEnum.normal)) as ProcessState;
    List<ProductModel> products = data['product'] ?? [];

    for (var element in items) {
      showLogs(element, flags: 'element');
      var p = products.firstWhereOrNull((e) => e.codeProduct == element.codeProduct);
      showLogs(p, flags: 'p');
      if (p != null) {
        var comboItems = ProductHelper().getComboDescription(p);
        // coi combo k có thành phần như là món thường để in
        if (comboItems == null || comboItems.isEmpty) {
          if (p.printerType != null) {
            var items = List<ProductModel>.from(productPrint[p.printerType] ?? []);
            items.add(p.copyWith(
                note: element.note, description: null, numberSelecting: element.quantity));
            productPrint[p.printerType!] = items;
          }
        } else {
          Map<int, List<ComboItemModel>> printComboItem = {};
          for (var ci in comboItems) {
            var printerType = ci.printerType;
            if (printerType != null) {
              var items = List<ComboItemModel>.from(printComboItem[printerType] ?? []);
              items.add(ci);
              printComboItem[printerType] = items;
            }
          }

          printComboItem.forEach(
            (key, value) {
              var items = List<ProductModel>.from(productPrint[key] ?? []);
              items.add(p.copyWith(
                  description: jsonEncode(value),
                  numberSelecting: element.quantity,
                  note: element.note));
              productPrint[key] = items;
            },
          );
        }
      }
    }

    return productPrint;
  }

  void printO2oRequest({
    List<IpOrderModel> printers = const [],
    Map<int, List<ProductModel>> data = const {},
    required OrderModel order,
    BuildContext? context,
    String? note,
  }) async {
    var appSeting = LocalStorage.getPrintSetting();
    for (var printer in printers) {
      var products = data[printer.type] ?? [];
      if (products.isEmpty) continue;
      var bytes = LocalStorage.getPrintSetting().appPrinterType == AppPrinterSettingTypeEnum.normal
          ? await AppPrinterNormalUtils.instance.generateBill(
              order: order,
              billSingle: false,
              cancel: false,
              timeOrder: 1,
              totalNote: note,
              products: products,
              title: '',
            )
          : await AppPrinterHtmlUtils.instance
              .generateImageBill(AppPrinterHtmlUtils.instance.kitchenBillContent(
              order: order,
              product: products,
              note: note ?? '',
              timeOrders: 1,
              cancel: false,
              totalBill: true,
            ));

      showLogs(printer, flags: 'printer');
      showLogs(products.length, flags: 'products');
      PrintQueue.instance.addTask(
        ip: printer.ip,
        port: printer.port,
        buildReceipt: (generator) async {
          return bytes;
        },
        onComplete: (success, error) async {
          if (success) {
            // showLogs("✅ In thành công", flags: 'in món thành công');
            // chỉ in bill lẻ với bếp
            if (printer.type == 2 && appSeting.billReturnSetting.useOddBill) {
              for (var p in products) {
                List<int> byteDatas;
                var oddHtmlBill = AppPrinterHtmlUtils.instance.kitchenBillContent(
                  product: [p],
                  totalBill: false,
                  order: order,
                  note: note ?? '',
                  timeOrders: 1,
                );
                byteDatas = appSeting.appPrinterType == AppPrinterSettingTypeEnum.normal
                    ? await AppPrinterNormalUtils.instance.generateBill(
                        order: order,
                        billSingle: true,
                        cancel: false,
                        timeOrder: 1,
                        totalNote: note,
                        products: [p],
                        title: '',
                      )
                    : await AppPrinterHtmlUtils.instance.generateImageBill(oddHtmlBill);
                PrintQueue.instance.addTask(
                  ip: printer.ip,
                  port: printer.port,
                  buildReceipt: (generator) async {
                    // var byteDatas = await AppPrinterHtmlUtils.instance
                    //     .generateImageBill(oddHtmlBill);
                    return byteDatas;
                  },
                  onComplete: (success, error) {
                    if (success) {
                      // showLogs("✅ In thành công", flags: 'in món lẻ thành công');
                    } else {
                      // showLogs("❌ In thất bại: $error", flags: 'in món lẻ thất bại');
                    }
                  },
                );
              }
            }
          } else {
            // showLogs("❌ In thất bại: $error", flags: 'in món thất bại');
            if (error != null) {
              if (context != null) {
                showMessageDialog(context, message: error);
              }
            }
          }
        },
      );
    }
  }
}
