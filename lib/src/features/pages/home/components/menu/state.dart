import 'package:aladdin_franchise/src/data/enum/status.dart';
import 'package:aladdin_franchise/src/features/common/process_state.dart';
import 'package:aladdin_franchise/src/models/category.dart';
import 'package:aladdin_franchise/src/models/product.dart';
import 'package:aladdin_franchise/src/models/tag_product.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'state.freezed.dart';

@freezed
class MenuState with _$MenuState {
  const factory MenuState({
    @Default(ProcessState(status: StatusEnum.loading)) ProcessState productState,
    // @Default([]) List<CategoryModel> categories,
    @Default([]) List<ProductModel> products,
    @Default([]) List<TagProductModel> tags,
    CategoryModel? categorySelect,
    TagProductModel? tagSelect,
    @Default('') String search,
    @Default(false) bool checkReloadWhenHiddenApp,
    @Default({}) Map<int, Map<String, dynamic>> allProduct,
    @Default({}) Map<dynamic, MenuDataView> menuDataView,
    CategoryModel? subCategorySelect,
  }) = _HomeState;
}

@freezed
class MenuDataView with _$MenuDataView {
  const factory MenuDataView({
    CategoryModel? item,
    @Default(false) bool symbol,
    @Default({}) Set<ProductModel> products,
  }) = _MenuDataView;
}
