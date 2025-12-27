import 'dart:async';

import 'package:aladdin_franchise/src/configs/app.dart';
import 'package:aladdin_franchise/src/core/network/api/app_exception.dart';
import 'package:aladdin_franchise/src/core/network/repository/menu/menu_repository.dart';
import 'package:aladdin_franchise/src/core/network/provider.dart';
import 'package:aladdin_franchise/src/core/storages/local.dart';
import 'package:aladdin_franchise/src/data/enum/status.dart';
import 'package:aladdin_franchise/src/features/common/process_state.dart';
import 'package:aladdin_franchise/src/models/category.dart';
import 'package:aladdin_franchise/src/models/product.dart';
import 'package:aladdin_franchise/src/models/tag_product.dart';
import 'package:aladdin_franchise/src/utils/date_time.dart';
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

  Future<void> init({bool loadProducts = true}) async {
    ctrlSearch.text = '';
    state = state.copyWith(
      categorySelect: null,
      subCategorySelect: null,
      tagSelect: null,
      search: '',
    );
    if (loadProducts) {
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
      final categoryResult = await _menuRepository.getCategory();

      List<CategoryModel> categories = categoryResult.data;
      List<TagProductModel> tags = categoryResult.tags ?? [];
      final productsRepo = await _menuRepository.getProduct(null);

      await LocalStorage.setLastReloadMenu();
      List<ProductModel> products = List.from(productsRepo);
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

      // cập nhật ngôn ngữ local khi load menu
      kAppLanguageLocal = LocalStorage.getLanguageLocal();
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
}
