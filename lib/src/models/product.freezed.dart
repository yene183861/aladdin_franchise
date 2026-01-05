// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'product.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ProductModel _$ProductModelFromJson(Map<String, dynamic> json) {
  return _ProductModel.fromJson(json);
}

/// @nodoc
mixin _$ProductModel {
  int get id => throw _privateConstructorUsedError;
  int get categoryId => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  Map<String, dynamic> get language => throw _privateConstructorUsedError;
  int? get printerType => throw _privateConstructorUsedError;
  String? get slug => throw _privateConstructorUsedError;
  int? get menuNumber => throw _privateConstructorUsedError;
  String get unitPrice => throw _privateConstructorUsedError;
  bool get outOfStock => throw _privateConstructorUsedError;
  bool get internalUse => throw _privateConstructorUsedError;
  String? get discountPrice => throw _privateConstructorUsedError;
  String get unit => throw _privateConstructorUsedError;
  double get tax => throw _privateConstructorUsedError;
  String? get currencyCode => throw _privateConstructorUsedError;
  String? get image => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;

  /// chỉ dùng dưới app
  int get numberSelecting => throw _privateConstructorUsedError;
  String? get note => throw _privateConstructorUsedError;
  List<int>? get tags => throw _privateConstructorUsedError;
  int get quantityPromotion => throw _privateConstructorUsedError;
  int get unitPriceDiscount => throw _privateConstructorUsedError;
  int get quantityDiscount => throw _privateConstructorUsedError;
  int get withComboDiscount => throw _privateConstructorUsedError;
  String? get codeProduct => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ProductModelCopyWith<ProductModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProductModelCopyWith<$Res> {
  factory $ProductModelCopyWith(
          ProductModel value, $Res Function(ProductModel) then) =
      _$ProductModelCopyWithImpl<$Res, ProductModel>;
  @useResult
  $Res call(
      {int id,
      int categoryId,
      String name,
      Map<String, dynamic> language,
      int? printerType,
      String? slug,
      int? menuNumber,
      String unitPrice,
      bool outOfStock,
      bool internalUse,
      String? discountPrice,
      String unit,
      double tax,
      String? currencyCode,
      String? image,
      String? description,
      int numberSelecting,
      String? note,
      List<int>? tags,
      int quantityPromotion,
      int unitPriceDiscount,
      int quantityDiscount,
      int withComboDiscount,
      String? codeProduct});
}

/// @nodoc
class _$ProductModelCopyWithImpl<$Res, $Val extends ProductModel>
    implements $ProductModelCopyWith<$Res> {
  _$ProductModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? categoryId = null,
    Object? name = null,
    Object? language = null,
    Object? printerType = freezed,
    Object? slug = freezed,
    Object? menuNumber = freezed,
    Object? unitPrice = null,
    Object? outOfStock = null,
    Object? internalUse = null,
    Object? discountPrice = freezed,
    Object? unit = null,
    Object? tax = null,
    Object? currencyCode = freezed,
    Object? image = freezed,
    Object? description = freezed,
    Object? numberSelecting = null,
    Object? note = freezed,
    Object? tags = freezed,
    Object? quantityPromotion = null,
    Object? unitPriceDiscount = null,
    Object? quantityDiscount = null,
    Object? withComboDiscount = null,
    Object? codeProduct = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      categoryId: null == categoryId
          ? _value.categoryId
          : categoryId // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      language: null == language
          ? _value.language
          : language // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      printerType: freezed == printerType
          ? _value.printerType
          : printerType // ignore: cast_nullable_to_non_nullable
              as int?,
      slug: freezed == slug
          ? _value.slug
          : slug // ignore: cast_nullable_to_non_nullable
              as String?,
      menuNumber: freezed == menuNumber
          ? _value.menuNumber
          : menuNumber // ignore: cast_nullable_to_non_nullable
              as int?,
      unitPrice: null == unitPrice
          ? _value.unitPrice
          : unitPrice // ignore: cast_nullable_to_non_nullable
              as String,
      outOfStock: null == outOfStock
          ? _value.outOfStock
          : outOfStock // ignore: cast_nullable_to_non_nullable
              as bool,
      internalUse: null == internalUse
          ? _value.internalUse
          : internalUse // ignore: cast_nullable_to_non_nullable
              as bool,
      discountPrice: freezed == discountPrice
          ? _value.discountPrice
          : discountPrice // ignore: cast_nullable_to_non_nullable
              as String?,
      unit: null == unit
          ? _value.unit
          : unit // ignore: cast_nullable_to_non_nullable
              as String,
      tax: null == tax
          ? _value.tax
          : tax // ignore: cast_nullable_to_non_nullable
              as double,
      currencyCode: freezed == currencyCode
          ? _value.currencyCode
          : currencyCode // ignore: cast_nullable_to_non_nullable
              as String?,
      image: freezed == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      numberSelecting: null == numberSelecting
          ? _value.numberSelecting
          : numberSelecting // ignore: cast_nullable_to_non_nullable
              as int,
      note: freezed == note
          ? _value.note
          : note // ignore: cast_nullable_to_non_nullable
              as String?,
      tags: freezed == tags
          ? _value.tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<int>?,
      quantityPromotion: null == quantityPromotion
          ? _value.quantityPromotion
          : quantityPromotion // ignore: cast_nullable_to_non_nullable
              as int,
      unitPriceDiscount: null == unitPriceDiscount
          ? _value.unitPriceDiscount
          : unitPriceDiscount // ignore: cast_nullable_to_non_nullable
              as int,
      quantityDiscount: null == quantityDiscount
          ? _value.quantityDiscount
          : quantityDiscount // ignore: cast_nullable_to_non_nullable
              as int,
      withComboDiscount: null == withComboDiscount
          ? _value.withComboDiscount
          : withComboDiscount // ignore: cast_nullable_to_non_nullable
              as int,
      codeProduct: freezed == codeProduct
          ? _value.codeProduct
          : codeProduct // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ProductModelImplCopyWith<$Res>
    implements $ProductModelCopyWith<$Res> {
  factory _$$ProductModelImplCopyWith(
          _$ProductModelImpl value, $Res Function(_$ProductModelImpl) then) =
      __$$ProductModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      int categoryId,
      String name,
      Map<String, dynamic> language,
      int? printerType,
      String? slug,
      int? menuNumber,
      String unitPrice,
      bool outOfStock,
      bool internalUse,
      String? discountPrice,
      String unit,
      double tax,
      String? currencyCode,
      String? image,
      String? description,
      int numberSelecting,
      String? note,
      List<int>? tags,
      int quantityPromotion,
      int unitPriceDiscount,
      int quantityDiscount,
      int withComboDiscount,
      String? codeProduct});
}

/// @nodoc
class __$$ProductModelImplCopyWithImpl<$Res>
    extends _$ProductModelCopyWithImpl<$Res, _$ProductModelImpl>
    implements _$$ProductModelImplCopyWith<$Res> {
  __$$ProductModelImplCopyWithImpl(
      _$ProductModelImpl _value, $Res Function(_$ProductModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? categoryId = null,
    Object? name = null,
    Object? language = null,
    Object? printerType = freezed,
    Object? slug = freezed,
    Object? menuNumber = freezed,
    Object? unitPrice = null,
    Object? outOfStock = null,
    Object? internalUse = null,
    Object? discountPrice = freezed,
    Object? unit = null,
    Object? tax = null,
    Object? currencyCode = freezed,
    Object? image = freezed,
    Object? description = freezed,
    Object? numberSelecting = null,
    Object? note = freezed,
    Object? tags = freezed,
    Object? quantityPromotion = null,
    Object? unitPriceDiscount = null,
    Object? quantityDiscount = null,
    Object? withComboDiscount = null,
    Object? codeProduct = freezed,
  }) {
    return _then(_$ProductModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      categoryId: null == categoryId
          ? _value.categoryId
          : categoryId // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      language: null == language
          ? _value._language
          : language // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      printerType: freezed == printerType
          ? _value.printerType
          : printerType // ignore: cast_nullable_to_non_nullable
              as int?,
      slug: freezed == slug
          ? _value.slug
          : slug // ignore: cast_nullable_to_non_nullable
              as String?,
      menuNumber: freezed == menuNumber
          ? _value.menuNumber
          : menuNumber // ignore: cast_nullable_to_non_nullable
              as int?,
      unitPrice: null == unitPrice
          ? _value.unitPrice
          : unitPrice // ignore: cast_nullable_to_non_nullable
              as String,
      outOfStock: null == outOfStock
          ? _value.outOfStock
          : outOfStock // ignore: cast_nullable_to_non_nullable
              as bool,
      internalUse: null == internalUse
          ? _value.internalUse
          : internalUse // ignore: cast_nullable_to_non_nullable
              as bool,
      discountPrice: freezed == discountPrice
          ? _value.discountPrice
          : discountPrice // ignore: cast_nullable_to_non_nullable
              as String?,
      unit: null == unit
          ? _value.unit
          : unit // ignore: cast_nullable_to_non_nullable
              as String,
      tax: null == tax
          ? _value.tax
          : tax // ignore: cast_nullable_to_non_nullable
              as double,
      currencyCode: freezed == currencyCode
          ? _value.currencyCode
          : currencyCode // ignore: cast_nullable_to_non_nullable
              as String?,
      image: freezed == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      numberSelecting: null == numberSelecting
          ? _value.numberSelecting
          : numberSelecting // ignore: cast_nullable_to_non_nullable
              as int,
      note: freezed == note
          ? _value.note
          : note // ignore: cast_nullable_to_non_nullable
              as String?,
      tags: freezed == tags
          ? _value._tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<int>?,
      quantityPromotion: null == quantityPromotion
          ? _value.quantityPromotion
          : quantityPromotion // ignore: cast_nullable_to_non_nullable
              as int,
      unitPriceDiscount: null == unitPriceDiscount
          ? _value.unitPriceDiscount
          : unitPriceDiscount // ignore: cast_nullable_to_non_nullable
              as int,
      quantityDiscount: null == quantityDiscount
          ? _value.quantityDiscount
          : quantityDiscount // ignore: cast_nullable_to_non_nullable
              as int,
      withComboDiscount: null == withComboDiscount
          ? _value.withComboDiscount
          : withComboDiscount // ignore: cast_nullable_to_non_nullable
              as int,
      codeProduct: freezed == codeProduct
          ? _value.codeProduct
          : codeProduct // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class _$ProductModelImpl extends _ProductModel with DiagnosticableTreeMixin {
  const _$ProductModelImpl(
      {required this.id,
      this.categoryId = -1,
      this.name = '',
      final Map<String, dynamic> language = const {},
      this.printerType,
      this.slug,
      this.menuNumber,
      this.unitPrice = "0",
      this.outOfStock = false,
      this.internalUse = false,
      this.discountPrice,
      this.unit = '',
      this.tax = 0.0,
      this.currencyCode,
      this.image,
      this.description,
      this.numberSelecting = 0,
      this.note,
      final List<int>? tags,
      this.quantityPromotion = 0,
      this.unitPriceDiscount = 0,
      this.quantityDiscount = 0,
      this.withComboDiscount = 0,
      this.codeProduct})
      : _language = language,
        _tags = tags,
        super._();

  factory _$ProductModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProductModelImplFromJson(json);

  @override
  final int id;
  @override
  @JsonKey()
  final int categoryId;
  @override
  @JsonKey()
  final String name;
  final Map<String, dynamic> _language;
  @override
  @JsonKey()
  Map<String, dynamic> get language {
    if (_language is EqualUnmodifiableMapView) return _language;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_language);
  }

  @override
  final int? printerType;
  @override
  final String? slug;
  @override
  final int? menuNumber;
  @override
  @JsonKey()
  final String unitPrice;
  @override
  @JsonKey()
  final bool outOfStock;
  @override
  @JsonKey()
  final bool internalUse;
  @override
  final String? discountPrice;
  @override
  @JsonKey()
  final String unit;
  @override
  @JsonKey()
  final double tax;
  @override
  final String? currencyCode;
  @override
  final String? image;
  @override
  final String? description;

  /// chỉ dùng dưới app
  @override
  @JsonKey()
  final int numberSelecting;
  @override
  final String? note;
  final List<int>? _tags;
  @override
  List<int>? get tags {
    final value = _tags;
    if (value == null) return null;
    if (_tags is EqualUnmodifiableListView) return _tags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  @JsonKey()
  final int quantityPromotion;
  @override
  @JsonKey()
  final int unitPriceDiscount;
  @override
  @JsonKey()
  final int quantityDiscount;
  @override
  @JsonKey()
  final int withComboDiscount;
  @override
  final String? codeProduct;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ProductModel(id: $id, categoryId: $categoryId, name: $name, language: $language, printerType: $printerType, slug: $slug, menuNumber: $menuNumber, unitPrice: $unitPrice, outOfStock: $outOfStock, internalUse: $internalUse, discountPrice: $discountPrice, unit: $unit, tax: $tax, currencyCode: $currencyCode, image: $image, description: $description, numberSelecting: $numberSelecting, note: $note, tags: $tags, quantityPromotion: $quantityPromotion, unitPriceDiscount: $unitPriceDiscount, quantityDiscount: $quantityDiscount, withComboDiscount: $withComboDiscount, codeProduct: $codeProduct)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'ProductModel'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('categoryId', categoryId))
      ..add(DiagnosticsProperty('name', name))
      ..add(DiagnosticsProperty('language', language))
      ..add(DiagnosticsProperty('printerType', printerType))
      ..add(DiagnosticsProperty('slug', slug))
      ..add(DiagnosticsProperty('menuNumber', menuNumber))
      ..add(DiagnosticsProperty('unitPrice', unitPrice))
      ..add(DiagnosticsProperty('outOfStock', outOfStock))
      ..add(DiagnosticsProperty('internalUse', internalUse))
      ..add(DiagnosticsProperty('discountPrice', discountPrice))
      ..add(DiagnosticsProperty('unit', unit))
      ..add(DiagnosticsProperty('tax', tax))
      ..add(DiagnosticsProperty('currencyCode', currencyCode))
      ..add(DiagnosticsProperty('image', image))
      ..add(DiagnosticsProperty('description', description))
      ..add(DiagnosticsProperty('numberSelecting', numberSelecting))
      ..add(DiagnosticsProperty('note', note))
      ..add(DiagnosticsProperty('tags', tags))
      ..add(DiagnosticsProperty('quantityPromotion', quantityPromotion))
      ..add(DiagnosticsProperty('unitPriceDiscount', unitPriceDiscount))
      ..add(DiagnosticsProperty('quantityDiscount', quantityDiscount))
      ..add(DiagnosticsProperty('withComboDiscount', withComboDiscount))
      ..add(DiagnosticsProperty('codeProduct', codeProduct));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProductModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.categoryId, categoryId) ||
                other.categoryId == categoryId) &&
            (identical(other.name, name) || other.name == name) &&
            const DeepCollectionEquality().equals(other._language, _language) &&
            (identical(other.printerType, printerType) ||
                other.printerType == printerType) &&
            (identical(other.slug, slug) || other.slug == slug) &&
            (identical(other.menuNumber, menuNumber) ||
                other.menuNumber == menuNumber) &&
            (identical(other.unitPrice, unitPrice) ||
                other.unitPrice == unitPrice) &&
            (identical(other.outOfStock, outOfStock) ||
                other.outOfStock == outOfStock) &&
            (identical(other.internalUse, internalUse) ||
                other.internalUse == internalUse) &&
            (identical(other.discountPrice, discountPrice) ||
                other.discountPrice == discountPrice) &&
            (identical(other.unit, unit) || other.unit == unit) &&
            (identical(other.tax, tax) || other.tax == tax) &&
            (identical(other.currencyCode, currencyCode) ||
                other.currencyCode == currencyCode) &&
            (identical(other.image, image) || other.image == image) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.numberSelecting, numberSelecting) ||
                other.numberSelecting == numberSelecting) &&
            (identical(other.note, note) || other.note == note) &&
            const DeepCollectionEquality().equals(other._tags, _tags) &&
            (identical(other.quantityPromotion, quantityPromotion) ||
                other.quantityPromotion == quantityPromotion) &&
            (identical(other.unitPriceDiscount, unitPriceDiscount) ||
                other.unitPriceDiscount == unitPriceDiscount) &&
            (identical(other.quantityDiscount, quantityDiscount) ||
                other.quantityDiscount == quantityDiscount) &&
            (identical(other.withComboDiscount, withComboDiscount) ||
                other.withComboDiscount == withComboDiscount) &&
            (identical(other.codeProduct, codeProduct) ||
                other.codeProduct == codeProduct));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        categoryId,
        name,
        const DeepCollectionEquality().hash(_language),
        printerType,
        slug,
        menuNumber,
        unitPrice,
        outOfStock,
        internalUse,
        discountPrice,
        unit,
        tax,
        currencyCode,
        image,
        description,
        numberSelecting,
        note,
        const DeepCollectionEquality().hash(_tags),
        quantityPromotion,
        unitPriceDiscount,
        quantityDiscount,
        withComboDiscount,
        codeProduct
      ]);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ProductModelImplCopyWith<_$ProductModelImpl> get copyWith =>
      __$$ProductModelImplCopyWithImpl<_$ProductModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ProductModelImplToJson(
      this,
    );
  }
}

abstract class _ProductModel extends ProductModel {
  const factory _ProductModel(
      {required final int id,
      final int categoryId,
      final String name,
      final Map<String, dynamic> language,
      final int? printerType,
      final String? slug,
      final int? menuNumber,
      final String unitPrice,
      final bool outOfStock,
      final bool internalUse,
      final String? discountPrice,
      final String unit,
      final double tax,
      final String? currencyCode,
      final String? image,
      final String? description,
      final int numberSelecting,
      final String? note,
      final List<int>? tags,
      final int quantityPromotion,
      final int unitPriceDiscount,
      final int quantityDiscount,
      final int withComboDiscount,
      final String? codeProduct}) = _$ProductModelImpl;
  const _ProductModel._() : super._();

  factory _ProductModel.fromJson(Map<String, dynamic> json) =
      _$ProductModelImpl.fromJson;

  @override
  int get id;
  @override
  int get categoryId;
  @override
  String get name;
  @override
  Map<String, dynamic> get language;
  @override
  int? get printerType;
  @override
  String? get slug;
  @override
  int? get menuNumber;
  @override
  String get unitPrice;
  @override
  bool get outOfStock;
  @override
  bool get internalUse;
  @override
  String? get discountPrice;
  @override
  String get unit;
  @override
  double get tax;
  @override
  String? get currencyCode;
  @override
  String? get image;
  @override
  String? get description;
  @override

  /// chỉ dùng dưới app
  int get numberSelecting;
  @override
  String? get note;
  @override
  List<int>? get tags;
  @override
  int get quantityPromotion;
  @override
  int get unitPriceDiscount;
  @override
  int get quantityDiscount;
  @override
  int get withComboDiscount;
  @override
  String? get codeProduct;
  @override
  @JsonKey(ignore: true)
  _$$ProductModelImplCopyWith<_$ProductModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
