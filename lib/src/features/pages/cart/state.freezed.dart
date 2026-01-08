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
      throw _privateConstructorUsedError;
  CartPageEvent get event => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  Map<PrinterModel?, List<ProductModel>> get productWithPrinter =>
      throw _privateConstructorUsedError;

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
      CartPageEvent event,
      String message,
      Map<PrinterModel?, List<ProductModel>> productWithPrinter});
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
    Object? event = null,
    Object? message = null,
    Object? productWithPrinter = null,
  }) {
    return _then(_value.copyWith(
      productsSelecting: null == productsSelecting
          ? _value.productsSelecting
          : productsSelecting // ignore: cast_nullable_to_non_nullable
              as List<ProductModel>,
      event: null == event
          ? _value.event
          : event // ignore: cast_nullable_to_non_nullable
              as CartPageEvent,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      productWithPrinter: null == productWithPrinter
          ? _value.productWithPrinter
          : productWithPrinter // ignore: cast_nullable_to_non_nullable
              as Map<PrinterModel?, List<ProductModel>>,
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
      CartPageEvent event,
      String message,
      Map<PrinterModel?, List<ProductModel>> productWithPrinter});
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
    Object? event = null,
    Object? message = null,
    Object? productWithPrinter = null,
  }) {
    return _then(_$CartPageStateImpl(
      productsSelecting: null == productsSelecting
          ? _value._productsSelecting
          : productsSelecting // ignore: cast_nullable_to_non_nullable
              as List<ProductModel>,
      event: null == event
          ? _value.event
          : event // ignore: cast_nullable_to_non_nullable
              as CartPageEvent,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      productWithPrinter: null == productWithPrinter
          ? _value._productWithPrinter
          : productWithPrinter // ignore: cast_nullable_to_non_nullable
              as Map<PrinterModel?, List<ProductModel>>,
    ));
  }
}

/// @nodoc

class _$CartPageStateImpl implements _CartPageState {
  const _$CartPageStateImpl(
      {final List<ProductModel> productsSelecting = const [],
      this.event = CartPageEvent.normal,
      this.message = '',
      final Map<PrinterModel?, List<ProductModel>> productWithPrinter =
          const {}})
      : _productsSelecting = productsSelecting,
        _productWithPrinter = productWithPrinter;

  final List<ProductModel> _productsSelecting;
  @override
  @JsonKey()
  List<ProductModel> get productsSelecting {
    if (_productsSelecting is EqualUnmodifiableListView)
      return _productsSelecting;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_productsSelecting);
  }

  @override
  @JsonKey()
  final CartPageEvent event;
  @override
  @JsonKey()
  final String message;
  final Map<PrinterModel?, List<ProductModel>> _productWithPrinter;
  @override
  @JsonKey()
  Map<PrinterModel?, List<ProductModel>> get productWithPrinter {
    if (_productWithPrinter is EqualUnmodifiableMapView)
      return _productWithPrinter;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_productWithPrinter);
  }

  @override
  String toString() {
    return 'CartPageState(productsSelecting: $productsSelecting, event: $event, message: $message, productWithPrinter: $productWithPrinter)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CartPageStateImpl &&
            const DeepCollectionEquality()
                .equals(other._productsSelecting, _productsSelecting) &&
            (identical(other.event, event) || other.event == event) &&
            (identical(other.message, message) || other.message == message) &&
            const DeepCollectionEquality()
                .equals(other._productWithPrinter, _productWithPrinter));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_productsSelecting),
      event,
      message,
      const DeepCollectionEquality().hash(_productWithPrinter));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CartPageStateImplCopyWith<_$CartPageStateImpl> get copyWith =>
      __$$CartPageStateImplCopyWithImpl<_$CartPageStateImpl>(this, _$identity);
}

abstract class _CartPageState implements CartPageState {
  const factory _CartPageState(
          {final List<ProductModel> productsSelecting,
          final CartPageEvent event,
          final String message,
          final Map<PrinterModel?, List<ProductModel>> productWithPrinter}) =
      _$CartPageStateImpl;

  @override
  List<ProductModel> get productsSelecting;
  @override
  CartPageEvent get event;
  @override
  String get message;
  @override
  Map<PrinterModel?, List<ProductModel>> get productWithPrinter;
  @override
  @JsonKey(ignore: true)
  _$$CartPageStateImplCopyWith<_$CartPageStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
