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
mixin _$CartPageState {
  List<ProductModel> get productsSelecting =>
      throw _privateConstructorUsedError; // @Default(CartPageEvent.normal) CartPageEvent event,
// @Default('') String message,
// @Default({}) Map<int, Set<PrinterModel>> productIdWithPrinter,
// @Default(false) bool showPrinterSetupPanel,
// @Default({}) Set<int> productIdSelect,
// @Default({}) Map<int, Map<String, dynamic>> productMap,
  Set<PrinterModel> get defaultPrinters =>
      throw _privateConstructorUsedError; // @Default({}) Set<PrinterModel> printerSelect,
  Set<int> get productIdSelect => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $CartPageStateCopyWith<CartPageState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CartPageStateCopyWith<$Res> {
  factory $CartPageStateCopyWith(
          CartPageState value, $Res Function(CartPageState) then) =
      _$CartPageStateCopyWithImpl<$Res, CartPageState>;
  @useResult
  $Res call(
      {List<ProductModel> productsSelecting,
      Set<PrinterModel> defaultPrinters,
      Set<int> productIdSelect});
}

/// @nodoc
class _$CartPageStateCopyWithImpl<$Res, $Val extends CartPageState>
    implements $CartPageStateCopyWith<$Res> {
  _$CartPageStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? productsSelecting = null,
    Object? defaultPrinters = null,
    Object? productIdSelect = null,
  }) {
    return _then(_value.copyWith(
      productsSelecting: null == productsSelecting
          ? _value.productsSelecting
          : productsSelecting // ignore: cast_nullable_to_non_nullable
              as List<ProductModel>,
      defaultPrinters: null == defaultPrinters
          ? _value.defaultPrinters
          : defaultPrinters // ignore: cast_nullable_to_non_nullable
              as Set<PrinterModel>,
      productIdSelect: null == productIdSelect
          ? _value.productIdSelect
          : productIdSelect // ignore: cast_nullable_to_non_nullable
              as Set<int>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CartPageStateImplCopyWith<$Res>
    implements $CartPageStateCopyWith<$Res> {
  factory _$$CartPageStateImplCopyWith(
          _$CartPageStateImpl value, $Res Function(_$CartPageStateImpl) then) =
      __$$CartPageStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<ProductModel> productsSelecting,
      Set<PrinterModel> defaultPrinters,
      Set<int> productIdSelect});
}

/// @nodoc
class __$$CartPageStateImplCopyWithImpl<$Res>
    extends _$CartPageStateCopyWithImpl<$Res, _$CartPageStateImpl>
    implements _$$CartPageStateImplCopyWith<$Res> {
  __$$CartPageStateImplCopyWithImpl(
      _$CartPageStateImpl _value, $Res Function(_$CartPageStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? productsSelecting = null,
    Object? defaultPrinters = null,
    Object? productIdSelect = null,
  }) {
    return _then(_$CartPageStateImpl(
      productsSelecting: null == productsSelecting
          ? _value._productsSelecting
          : productsSelecting // ignore: cast_nullable_to_non_nullable
              as List<ProductModel>,
      defaultPrinters: null == defaultPrinters
          ? _value._defaultPrinters
          : defaultPrinters // ignore: cast_nullable_to_non_nullable
              as Set<PrinterModel>,
      productIdSelect: null == productIdSelect
          ? _value._productIdSelect
          : productIdSelect // ignore: cast_nullable_to_non_nullable
              as Set<int>,
    ));
  }
}

/// @nodoc

class _$CartPageStateImpl implements _CartPageState {
  const _$CartPageStateImpl(
      {final List<ProductModel> productsSelecting = const [],
      final Set<PrinterModel> defaultPrinters = const {},
      final Set<int> productIdSelect = const {}})
      : _productsSelecting = productsSelecting,
        _defaultPrinters = defaultPrinters,
        _productIdSelect = productIdSelect;

  final List<ProductModel> _productsSelecting;
  @override
  @JsonKey()
  List<ProductModel> get productsSelecting {
    if (_productsSelecting is EqualUnmodifiableListView)
      return _productsSelecting;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_productsSelecting);
  }

// @Default(CartPageEvent.normal) CartPageEvent event,
// @Default('') String message,
// @Default({}) Map<int, Set<PrinterModel>> productIdWithPrinter,
// @Default(false) bool showPrinterSetupPanel,
// @Default({}) Set<int> productIdSelect,
// @Default({}) Map<int, Map<String, dynamic>> productMap,
  final Set<PrinterModel> _defaultPrinters;
// @Default(CartPageEvent.normal) CartPageEvent event,
// @Default('') String message,
// @Default({}) Map<int, Set<PrinterModel>> productIdWithPrinter,
// @Default(false) bool showPrinterSetupPanel,
// @Default({}) Set<int> productIdSelect,
// @Default({}) Map<int, Map<String, dynamic>> productMap,
  @override
  @JsonKey()
  Set<PrinterModel> get defaultPrinters {
    if (_defaultPrinters is EqualUnmodifiableSetView) return _defaultPrinters;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableSetView(_defaultPrinters);
  }

// @Default({}) Set<PrinterModel> printerSelect,
  final Set<int> _productIdSelect;
// @Default({}) Set<PrinterModel> printerSelect,
  @override
  @JsonKey()
  Set<int> get productIdSelect {
    if (_productIdSelect is EqualUnmodifiableSetView) return _productIdSelect;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableSetView(_productIdSelect);
  }

  @override
  String toString() {
    return 'CartPageState(productsSelecting: $productsSelecting, defaultPrinters: $defaultPrinters, productIdSelect: $productIdSelect)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CartPageStateImpl &&
            const DeepCollectionEquality()
                .equals(other._productsSelecting, _productsSelecting) &&
            const DeepCollectionEquality()
                .equals(other._defaultPrinters, _defaultPrinters) &&
            const DeepCollectionEquality()
                .equals(other._productIdSelect, _productIdSelect));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_productsSelecting),
      const DeepCollectionEquality().hash(_defaultPrinters),
      const DeepCollectionEquality().hash(_productIdSelect));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CartPageStateImplCopyWith<_$CartPageStateImpl> get copyWith =>
      __$$CartPageStateImplCopyWithImpl<_$CartPageStateImpl>(this, _$identity);
}

abstract class _CartPageState implements CartPageState {
  const factory _CartPageState(
      {final List<ProductModel> productsSelecting,
      final Set<PrinterModel> defaultPrinters,
      final Set<int> productIdSelect}) = _$CartPageStateImpl;

  @override
  List<ProductModel> get productsSelecting;
  @override // @Default(CartPageEvent.normal) CartPageEvent event,
// @Default('') String message,
// @Default({}) Map<int, Set<PrinterModel>> productIdWithPrinter,
// @Default(false) bool showPrinterSetupPanel,
// @Default({}) Set<int> productIdSelect,
// @Default({}) Map<int, Map<String, dynamic>> productMap,
  Set<PrinterModel> get defaultPrinters;
  @override // @Default({}) Set<PrinterModel> printerSelect,
  Set<int> get productIdSelect;
  @override
  @JsonKey(ignore: true)
  _$$CartPageStateImplCopyWith<_$CartPageStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
