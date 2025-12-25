import 'package:aladdin_franchise/src/features/pages/home/state.dart';
import 'package:aladdin_franchise/src/models/category.dart';
import 'package:aladdin_franchise/src/models/product.dart';
import 'package:aladdin_franchise/src/models/tag_product.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'state.freezed.dart';

@freezed
class MenuState with _$MenuState {
  const factory MenuState({
    /// danh mục, món
    @Default(PageState(status: PageCommonState.loading)) PageState productsState,
    @Default([]) List<CategoryModel> categories,
    @Default([]) List<ProductModel> products,
    @Default([]) List<TagProductModel> tags,

    /// chứa category, subcategory, dấu >
    @Default([]) List<dynamic> menuCategoryItem,
    CategoryModel? categorySelect,
    SubCategoryModel? subCategorySelect,
    TagProductModel? tagSelect,

    ///
    @Default('') String search,
    @Default(false) bool checkReloadWhenHiddenApp,
  }) = _HomeState;
}
