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
mixin _$CheckoutPageState {
// @Default({}) Map<int, Map<String, dynamic>> productMap,
  List<ProductCheckoutModel> get productsCheckout =>
      throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  Set<PrinterModel> get defaultPrinters => throw _privateConstructorUsedError;
  Set<PrinterModel> get printerSelect =>
      throw _privateConstructorUsedError; // @Default({}) Set<int> productIdSelect,
  bool get useDefaultPrinters => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $CheckoutPageStateCopyWith<CheckoutPageState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CheckoutPageStateCopyWith<$Res> {
  factory $CheckoutPageStateCopyWith(
          CheckoutPageState value, $Res Function(CheckoutPageState) then) =
      _$CheckoutPageStateCopyWithImpl<$Res, CheckoutPageState>;
  @useResult
  $Res call(
      {List<ProductCheckoutModel> productsCheckout,
      String message,
      Set<PrinterModel> defaultPrinters,
      Set<PrinterModel> printerSelect,
      bool useDefaultPrinters});
}

/// @nodoc
class _$CheckoutPageStateCopyWithImpl<$Res, $Val extends CheckoutPageState>
    implements $CheckoutPageStateCopyWith<$Res> {
  _$CheckoutPageStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? productsCheckout = null,
    Object? message = null,
    Object? defaultPrinters = null,
    Object? printerSelect = null,
    Object? useDefaultPrinters = null,
  }) {
    return _then(_value.copyWith(
      productsCheckout: null == productsCheckout
          ? _value.productsCheckout
          : productsCheckout // ignore: cast_nullable_to_non_nullable
              as List<ProductCheckoutModel>,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      defaultPrinters: null == defaultPrinters
          ? _value.defaultPrinters
          : defaultPrinters // ignore: cast_nullable_to_non_nullable
              as Set<PrinterModel>,
      printerSelect: null == printerSelect
          ? _value.printerSelect
          : printerSelect // ignore: cast_nullable_to_non_nullable
              as Set<PrinterModel>,
      useDefaultPrinters: null == useDefaultPrinters
          ? _value.useDefaultPrinters
          : useDefaultPrinters // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CheckoutPageStateImplCopyWith<$Res>
    implements $CheckoutPageStateCopyWith<$Res> {
  factory _$$CheckoutPageStateImplCopyWith(_$CheckoutPageStateImpl value,
          $Res Function(_$CheckoutPageStateImpl) then) =
      __$$CheckoutPageStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<ProductCheckoutModel> productsCheckout,
      String message,
      Set<PrinterModel> defaultPrinters,
      Set<PrinterModel> printerSelect,
      bool useDefaultPrinters});
}

/// @nodoc
class __$$CheckoutPageStateImplCopyWithImpl<$Res>
    extends _$CheckoutPageStateCopyWithImpl<$Res, _$CheckoutPageStateImpl>
    implements _$$CheckoutPageStateImplCopyWith<$Res> {
  __$$CheckoutPageStateImplCopyWithImpl(_$CheckoutPageStateImpl _value,
      $Res Function(_$CheckoutPageStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? productsCheckout = null,
    Object? message = null,
    Object? defaultPrinters = null,
    Object? printerSelect = null,
    Object? useDefaultPrinters = null,
  }) {
    return _then(_$CheckoutPageStateImpl(
      productsCheckout: null == productsCheckout
          ? _value._productsCheckout
          : productsCheckout // ignore: cast_nullable_to_non_nullable
              as List<ProductCheckoutModel>,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      defaultPrinters: null == defaultPrinters
          ? _value._defaultPrinters
          : defaultPrinters // ignore: cast_nullable_to_non_nullable
              as Set<PrinterModel>,
      printerSelect: null == printerSelect
          ? _value._printerSelect
          : printerSelect // ignore: cast_nullable_to_non_nullable
              as Set<PrinterModel>,
      useDefaultPrinters: null == useDefaultPrinters
          ? _value.useDefaultPrinters
          : useDefaultPrinters // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$CheckoutPageStateImpl implements _CheckoutPageState {
  const _$CheckoutPageStateImpl(
      {final List<ProductCheckoutModel> productsCheckout = const [],
      this.message = '',
      final Set<PrinterModel> defaultPrinters = const {},
      final Set<PrinterModel> printerSelect = const {},
      this.useDefaultPrinters = false})
      : _productsCheckout = productsCheckout,
        _defaultPrinters = defaultPrinters,
        _printerSelect = printerSelect;

// @Default({}) Map<int, Map<String, dynamic>> productMap,
  final List<ProductCheckoutModel> _productsCheckout;
// @Default({}) Map<int, Map<String, dynamic>> productMap,
  @override
  @JsonKey()
  List<ProductCheckoutModel> get productsCheckout {
    if (_productsCheckout is EqualUnmodifiableListView)
      return _productsCheckout;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_productsCheckout);
  }

  @override
  @JsonKey()
  final String message;
  final Set<PrinterModel> _defaultPrinters;
  @override
  @JsonKey()
  Set<PrinterModel> get defaultPrinters {
    if (_defaultPrinters is EqualUnmodifiableSetView) return _defaultPrinters;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableSetView(_defaultPrinters);
  }

  final Set<PrinterModel> _printerSelect;
  @override
  @JsonKey()
  Set<PrinterModel> get printerSelect {
    if (_printerSelect is EqualUnmodifiableSetView) return _printerSelect;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableSetView(_printerSelect);
  }

// @Default({}) Set<int> productIdSelect,
  @override
  @JsonKey()
  final bool useDefaultPrinters;

  @override
  String toString() {
    return 'CheckoutPageState(productsCheckout: $productsCheckout, message: $message, defaultPrinters: $defaultPrinters, printerSelect: $printerSelect, useDefaultPrinters: $useDefaultPrinters)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CheckoutPageStateImpl &&
            const DeepCollectionEquality()
                .equals(other._productsCheckout, _productsCheckout) &&
            (identical(other.message, message) || other.message == message) &&
            const DeepCollectionEquality()
                .equals(other._defaultPrinters, _defaultPrinters) &&
            const DeepCollectionEquality()
                .equals(other._printerSelect, _printerSelect) &&
            (identical(other.useDefaultPrinters, useDefaultPrinters) ||
                other.useDefaultPrinters == useDefaultPrinters));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_productsCheckout),
      message,
      const DeepCollectionEquality().hash(_defaultPrinters),
      const DeepCollectionEquality().hash(_printerSelect),
      useDefaultPrinters);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CheckoutPageStateImplCopyWith<_$CheckoutPageStateImpl> get copyWith =>
      __$$CheckoutPageStateImplCopyWithImpl<_$CheckoutPageStateImpl>(
          this, _$identity);
}

abstract class _CheckoutPageState implements CheckoutPageState {
  const factory _CheckoutPageState(
      {final List<ProductCheckoutModel> productsCheckout,
      final String message,
      final Set<PrinterModel> defaultPrinters,
      final Set<PrinterModel> printerSelect,
      final bool useDefaultPrinters}) = _$CheckoutPageStateImpl;

  @override // @Default({}) Map<int, Map<String, dynamic>> productMap,
  List<ProductCheckoutModel> get productsCheckout;
  @override
  String get message;
  @override
  Set<PrinterModel> get defaultPrinters;
  @override
  Set<PrinterModel> get printerSelect;
  @override // @Default({}) Set<int> productIdSelect,
  bool get useDefaultPrinters;
  @override
  @JsonKey(ignore: true)
  _$$CheckoutPageStateImplCopyWith<_$CheckoutPageStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
