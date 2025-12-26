// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$MenuState {
  ProcessState get productState => throw _privateConstructorUsedError;
  List<CategoryModel> get categories => throw _privateConstructorUsedError;
  List<ProductModel> get products => throw _privateConstructorUsedError;
  List<TagProductModel> get tags => throw _privateConstructorUsedError;
  List<dynamic> get menuCategoryItem => throw _privateConstructorUsedError;
  CategoryModel? get categorySelect => throw _privateConstructorUsedError;
  SubCategoryModel? get subCategorySelect => throw _privateConstructorUsedError;
  TagProductModel? get tagSelect => throw _privateConstructorUsedError;
  String get search => throw _privateConstructorUsedError;
  bool get checkReloadWhenHiddenApp => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $MenuStateCopyWith<MenuState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MenuStateCopyWith<$Res> {
  factory $MenuStateCopyWith(MenuState value, $Res Function(MenuState) then) =
      _$MenuStateCopyWithImpl<$Res, MenuState>;
  @useResult
  $Res call(
      {ProcessState productState,
      List<CategoryModel> categories,
      List<ProductModel> products,
      List<TagProductModel> tags,
      List<dynamic> menuCategoryItem,
      CategoryModel? categorySelect,
      SubCategoryModel? subCategorySelect,
      TagProductModel? tagSelect,
      String search,
      bool checkReloadWhenHiddenApp});

  $ProcessStateCopyWith<$Res> get productState;
  $CategoryModelCopyWith<$Res>? get categorySelect;
  $SubCategoryModelCopyWith<$Res>? get subCategorySelect;
  $TagProductModelCopyWith<$Res>? get tagSelect;
}

/// @nodoc
class _$MenuStateCopyWithImpl<$Res, $Val extends MenuState>
    implements $MenuStateCopyWith<$Res> {
  _$MenuStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? productState = null,
    Object? categories = null,
    Object? products = null,
    Object? tags = null,
    Object? menuCategoryItem = null,
    Object? categorySelect = freezed,
    Object? subCategorySelect = freezed,
    Object? tagSelect = freezed,
    Object? search = null,
    Object? checkReloadWhenHiddenApp = null,
  }) {
    return _then(_value.copyWith(
      productState: null == productState
          ? _value.productState
          : productState // ignore: cast_nullable_to_non_nullable
              as ProcessState,
      categories: null == categories
          ? _value.categories
          : categories // ignore: cast_nullable_to_non_nullable
              as List<CategoryModel>,
      products: null == products
          ? _value.products
          : products // ignore: cast_nullable_to_non_nullable
              as List<ProductModel>,
      tags: null == tags
          ? _value.tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<TagProductModel>,
      menuCategoryItem: null == menuCategoryItem
          ? _value.menuCategoryItem
          : menuCategoryItem // ignore: cast_nullable_to_non_nullable
              as List<dynamic>,
      categorySelect: freezed == categorySelect
          ? _value.categorySelect
          : categorySelect // ignore: cast_nullable_to_non_nullable
              as CategoryModel?,
      subCategorySelect: freezed == subCategorySelect
          ? _value.subCategorySelect
          : subCategorySelect // ignore: cast_nullable_to_non_nullable
              as SubCategoryModel?,
      tagSelect: freezed == tagSelect
          ? _value.tagSelect
          : tagSelect // ignore: cast_nullable_to_non_nullable
              as TagProductModel?,
      search: null == search
          ? _value.search
          : search // ignore: cast_nullable_to_non_nullable
              as String,
      checkReloadWhenHiddenApp: null == checkReloadWhenHiddenApp
          ? _value.checkReloadWhenHiddenApp
          : checkReloadWhenHiddenApp // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $ProcessStateCopyWith<$Res> get productState {
    return $ProcessStateCopyWith<$Res>(_value.productState, (value) {
      return _then(_value.copyWith(productState: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $CategoryModelCopyWith<$Res>? get categorySelect {
    if (_value.categorySelect == null) {
      return null;
    }

    return $CategoryModelCopyWith<$Res>(_value.categorySelect!, (value) {
      return _then(_value.copyWith(categorySelect: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $SubCategoryModelCopyWith<$Res>? get subCategorySelect {
    if (_value.subCategorySelect == null) {
      return null;
    }

    return $SubCategoryModelCopyWith<$Res>(_value.subCategorySelect!, (value) {
      return _then(_value.copyWith(subCategorySelect: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $TagProductModelCopyWith<$Res>? get tagSelect {
    if (_value.tagSelect == null) {
      return null;
    }

    return $TagProductModelCopyWith<$Res>(_value.tagSelect!, (value) {
      return _then(_value.copyWith(tagSelect: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$HomeStateImplCopyWith<$Res>
    implements $MenuStateCopyWith<$Res> {
  factory _$$HomeStateImplCopyWith(
          _$HomeStateImpl value, $Res Function(_$HomeStateImpl) then) =
      __$$HomeStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {ProcessState productState,
      List<CategoryModel> categories,
      List<ProductModel> products,
      List<TagProductModel> tags,
      List<dynamic> menuCategoryItem,
      CategoryModel? categorySelect,
      SubCategoryModel? subCategorySelect,
      TagProductModel? tagSelect,
      String search,
      bool checkReloadWhenHiddenApp});

  @override
  $ProcessStateCopyWith<$Res> get productState;
  @override
  $CategoryModelCopyWith<$Res>? get categorySelect;
  @override
  $SubCategoryModelCopyWith<$Res>? get subCategorySelect;
  @override
  $TagProductModelCopyWith<$Res>? get tagSelect;
}

/// @nodoc
class __$$HomeStateImplCopyWithImpl<$Res>
    extends _$MenuStateCopyWithImpl<$Res, _$HomeStateImpl>
    implements _$$HomeStateImplCopyWith<$Res> {
  __$$HomeStateImplCopyWithImpl(
      _$HomeStateImpl _value, $Res Function(_$HomeStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? productState = null,
    Object? categories = null,
    Object? products = null,
    Object? tags = null,
    Object? menuCategoryItem = null,
    Object? categorySelect = freezed,
    Object? subCategorySelect = freezed,
    Object? tagSelect = freezed,
    Object? search = null,
    Object? checkReloadWhenHiddenApp = null,
  }) {
    return _then(_$HomeStateImpl(
      productState: null == productState
          ? _value.productState
          : productState // ignore: cast_nullable_to_non_nullable
              as ProcessState,
      categories: null == categories
          ? _value._categories
          : categories // ignore: cast_nullable_to_non_nullable
              as List<CategoryModel>,
      products: null == products
          ? _value._products
          : products // ignore: cast_nullable_to_non_nullable
              as List<ProductModel>,
      tags: null == tags
          ? _value._tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<TagProductModel>,
      menuCategoryItem: null == menuCategoryItem
          ? _value._menuCategoryItem
          : menuCategoryItem // ignore: cast_nullable_to_non_nullable
              as List<dynamic>,
      categorySelect: freezed == categorySelect
          ? _value.categorySelect
          : categorySelect // ignore: cast_nullable_to_non_nullable
              as CategoryModel?,
      subCategorySelect: freezed == subCategorySelect
          ? _value.subCategorySelect
          : subCategorySelect // ignore: cast_nullable_to_non_nullable
              as SubCategoryModel?,
      tagSelect: freezed == tagSelect
          ? _value.tagSelect
          : tagSelect // ignore: cast_nullable_to_non_nullable
              as TagProductModel?,
      search: null == search
          ? _value.search
          : search // ignore: cast_nullable_to_non_nullable
              as String,
      checkReloadWhenHiddenApp: null == checkReloadWhenHiddenApp
          ? _value.checkReloadWhenHiddenApp
          : checkReloadWhenHiddenApp // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$HomeStateImpl with DiagnosticableTreeMixin implements _HomeState {
  const _$HomeStateImpl(
      {this.productState = const ProcessState(status: StatusEnum.loading),
      final List<CategoryModel> categories = const [],
      final List<ProductModel> products = const [],
      final List<TagProductModel> tags = const [],
      final List<dynamic> menuCategoryItem = const [],
      this.categorySelect,
      this.subCategorySelect,
      this.tagSelect,
      this.search = '',
      this.checkReloadWhenHiddenApp = false})
      : _categories = categories,
        _products = products,
        _tags = tags,
        _menuCategoryItem = menuCategoryItem;

  @override
  @JsonKey()
  final ProcessState productState;
  final List<CategoryModel> _categories;
  @override
  @JsonKey()
  List<CategoryModel> get categories {
    if (_categories is EqualUnmodifiableListView) return _categories;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_categories);
  }

  final List<ProductModel> _products;
  @override
  @JsonKey()
  List<ProductModel> get products {
    if (_products is EqualUnmodifiableListView) return _products;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_products);
  }

  final List<TagProductModel> _tags;
  @override
  @JsonKey()
  List<TagProductModel> get tags {
    if (_tags is EqualUnmodifiableListView) return _tags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tags);
  }

  final List<dynamic> _menuCategoryItem;
  @override
  @JsonKey()
  List<dynamic> get menuCategoryItem {
    if (_menuCategoryItem is EqualUnmodifiableListView)
      return _menuCategoryItem;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_menuCategoryItem);
  }

  @override
  final CategoryModel? categorySelect;
  @override
  final SubCategoryModel? subCategorySelect;
  @override
  final TagProductModel? tagSelect;
  @override
  @JsonKey()
  final String search;
  @override
  @JsonKey()
  final bool checkReloadWhenHiddenApp;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'MenuState(productState: $productState, categories: $categories, products: $products, tags: $tags, menuCategoryItem: $menuCategoryItem, categorySelect: $categorySelect, subCategorySelect: $subCategorySelect, tagSelect: $tagSelect, search: $search, checkReloadWhenHiddenApp: $checkReloadWhenHiddenApp)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'MenuState'))
      ..add(DiagnosticsProperty('productState', productState))
      ..add(DiagnosticsProperty('categories', categories))
      ..add(DiagnosticsProperty('products', products))
      ..add(DiagnosticsProperty('tags', tags))
      ..add(DiagnosticsProperty('menuCategoryItem', menuCategoryItem))
      ..add(DiagnosticsProperty('categorySelect', categorySelect))
      ..add(DiagnosticsProperty('subCategorySelect', subCategorySelect))
      ..add(DiagnosticsProperty('tagSelect', tagSelect))
      ..add(DiagnosticsProperty('search', search))
      ..add(DiagnosticsProperty(
          'checkReloadWhenHiddenApp', checkReloadWhenHiddenApp));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HomeStateImpl &&
            (identical(other.productState, productState) ||
                other.productState == productState) &&
            const DeepCollectionEquality()
                .equals(other._categories, _categories) &&
            const DeepCollectionEquality().equals(other._products, _products) &&
            const DeepCollectionEquality().equals(other._tags, _tags) &&
            const DeepCollectionEquality()
                .equals(other._menuCategoryItem, _menuCategoryItem) &&
            (identical(other.categorySelect, categorySelect) ||
                other.categorySelect == categorySelect) &&
            (identical(other.subCategorySelect, subCategorySelect) ||
                other.subCategorySelect == subCategorySelect) &&
            (identical(other.tagSelect, tagSelect) ||
                other.tagSelect == tagSelect) &&
            (identical(other.search, search) || other.search == search) &&
            (identical(
                    other.checkReloadWhenHiddenApp, checkReloadWhenHiddenApp) ||
                other.checkReloadWhenHiddenApp == checkReloadWhenHiddenApp));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      productState,
      const DeepCollectionEquality().hash(_categories),
      const DeepCollectionEquality().hash(_products),
      const DeepCollectionEquality().hash(_tags),
      const DeepCollectionEquality().hash(_menuCategoryItem),
      categorySelect,
      subCategorySelect,
      tagSelect,
      search,
      checkReloadWhenHiddenApp);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$HomeStateImplCopyWith<_$HomeStateImpl> get copyWith =>
      __$$HomeStateImplCopyWithImpl<_$HomeStateImpl>(this, _$identity);
}

abstract class _HomeState implements MenuState {
  const factory _HomeState(
      {final ProcessState productState,
      final List<CategoryModel> categories,
      final List<ProductModel> products,
      final List<TagProductModel> tags,
      final List<dynamic> menuCategoryItem,
      final CategoryModel? categorySelect,
      final SubCategoryModel? subCategorySelect,
      final TagProductModel? tagSelect,
      final String search,
      final bool checkReloadWhenHiddenApp}) = _$HomeStateImpl;

  @override
  ProcessState get productState;
  @override
  List<CategoryModel> get categories;
  @override
  List<ProductModel> get products;
  @override
  List<TagProductModel> get tags;
  @override
  List<dynamic> get menuCategoryItem;
  @override
  CategoryModel? get categorySelect;
  @override
  SubCategoryModel? get subCategorySelect;
  @override
  TagProductModel? get tagSelect;
  @override
  String get search;
  @override
  bool get checkReloadWhenHiddenApp;
  @override
  @JsonKey(ignore: true)
  _$$HomeStateImplCopyWith<_$HomeStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
