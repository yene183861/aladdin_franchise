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
mixin _$CustomerPageState {
  PaymentMethod? get paymentMethodSelect => throw _privateConstructorUsedError;
  String get gatewayUrl => throw _privateConstructorUsedError;
  bool get autoScrollProducts => throw _privateConstructorUsedError;

  /// id của sản phẩm được thay đổi gần nhất
  int? get changedProductId => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $CustomerPageStateCopyWith<CustomerPageState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CustomerPageStateCopyWith<$Res> {
  factory $CustomerPageStateCopyWith(
          CustomerPageState value, $Res Function(CustomerPageState) then) =
      _$CustomerPageStateCopyWithImpl<$Res, CustomerPageState>;
  @useResult
  $Res call(
      {PaymentMethod? paymentMethodSelect,
      String gatewayUrl,
      bool autoScrollProducts,
      int? changedProductId});

  $PaymentMethodCopyWith<$Res>? get paymentMethodSelect;
}

/// @nodoc
class _$CustomerPageStateCopyWithImpl<$Res, $Val extends CustomerPageState>
    implements $CustomerPageStateCopyWith<$Res> {
  _$CustomerPageStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? paymentMethodSelect = freezed,
    Object? gatewayUrl = null,
    Object? autoScrollProducts = null,
    Object? changedProductId = freezed,
  }) {
    return _then(_value.copyWith(
      paymentMethodSelect: freezed == paymentMethodSelect
          ? _value.paymentMethodSelect
          : paymentMethodSelect // ignore: cast_nullable_to_non_nullable
              as PaymentMethod?,
      gatewayUrl: null == gatewayUrl
          ? _value.gatewayUrl
          : gatewayUrl // ignore: cast_nullable_to_non_nullable
              as String,
      autoScrollProducts: null == autoScrollProducts
          ? _value.autoScrollProducts
          : autoScrollProducts // ignore: cast_nullable_to_non_nullable
              as bool,
      changedProductId: freezed == changedProductId
          ? _value.changedProductId
          : changedProductId // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $PaymentMethodCopyWith<$Res>? get paymentMethodSelect {
    if (_value.paymentMethodSelect == null) {
      return null;
    }

    return $PaymentMethodCopyWith<$Res>(_value.paymentMethodSelect!, (value) {
      return _then(_value.copyWith(paymentMethodSelect: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$CustomerPageStateImplCopyWith<$Res>
    implements $CustomerPageStateCopyWith<$Res> {
  factory _$$CustomerPageStateImplCopyWith(_$CustomerPageStateImpl value,
          $Res Function(_$CustomerPageStateImpl) then) =
      __$$CustomerPageStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {PaymentMethod? paymentMethodSelect,
      String gatewayUrl,
      bool autoScrollProducts,
      int? changedProductId});

  @override
  $PaymentMethodCopyWith<$Res>? get paymentMethodSelect;
}

/// @nodoc
class __$$CustomerPageStateImplCopyWithImpl<$Res>
    extends _$CustomerPageStateCopyWithImpl<$Res, _$CustomerPageStateImpl>
    implements _$$CustomerPageStateImplCopyWith<$Res> {
  __$$CustomerPageStateImplCopyWithImpl(_$CustomerPageStateImpl _value,
      $Res Function(_$CustomerPageStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? paymentMethodSelect = freezed,
    Object? gatewayUrl = null,
    Object? autoScrollProducts = null,
    Object? changedProductId = freezed,
  }) {
    return _then(_$CustomerPageStateImpl(
      paymentMethodSelect: freezed == paymentMethodSelect
          ? _value.paymentMethodSelect
          : paymentMethodSelect // ignore: cast_nullable_to_non_nullable
              as PaymentMethod?,
      gatewayUrl: null == gatewayUrl
          ? _value.gatewayUrl
          : gatewayUrl // ignore: cast_nullable_to_non_nullable
              as String,
      autoScrollProducts: null == autoScrollProducts
          ? _value.autoScrollProducts
          : autoScrollProducts // ignore: cast_nullable_to_non_nullable
              as bool,
      changedProductId: freezed == changedProductId
          ? _value.changedProductId
          : changedProductId // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc

class _$CustomerPageStateImpl implements _CustomerPageState {
  const _$CustomerPageStateImpl(
      {this.paymentMethodSelect,
      this.gatewayUrl = '',
      this.autoScrollProducts = true,
      this.changedProductId});

  @override
  final PaymentMethod? paymentMethodSelect;
  @override
  @JsonKey()
  final String gatewayUrl;
  @override
  @JsonKey()
  final bool autoScrollProducts;

  /// id của sản phẩm được thay đổi gần nhất
  @override
  final int? changedProductId;

  @override
  String toString() {
    return 'CustomerPageState(paymentMethodSelect: $paymentMethodSelect, gatewayUrl: $gatewayUrl, autoScrollProducts: $autoScrollProducts, changedProductId: $changedProductId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CustomerPageStateImpl &&
            (identical(other.paymentMethodSelect, paymentMethodSelect) ||
                other.paymentMethodSelect == paymentMethodSelect) &&
            (identical(other.gatewayUrl, gatewayUrl) ||
                other.gatewayUrl == gatewayUrl) &&
            (identical(other.autoScrollProducts, autoScrollProducts) ||
                other.autoScrollProducts == autoScrollProducts) &&
            (identical(other.changedProductId, changedProductId) ||
                other.changedProductId == changedProductId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, paymentMethodSelect, gatewayUrl,
      autoScrollProducts, changedProductId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CustomerPageStateImplCopyWith<_$CustomerPageStateImpl> get copyWith =>
      __$$CustomerPageStateImplCopyWithImpl<_$CustomerPageStateImpl>(
          this, _$identity);
}

abstract class _CustomerPageState implements CustomerPageState {
  const factory _CustomerPageState(
      {final PaymentMethod? paymentMethodSelect,
      final String gatewayUrl,
      final bool autoScrollProducts,
      final int? changedProductId}) = _$CustomerPageStateImpl;

  @override
  PaymentMethod? get paymentMethodSelect;
  @override
  String get gatewayUrl;
  @override
  bool get autoScrollProducts;
  @override

  /// id của sản phẩm được thay đổi gần nhất
  int? get changedProductId;
  @override
  @JsonKey(ignore: true)
  _$$CustomerPageStateImplCopyWith<_$CustomerPageStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
