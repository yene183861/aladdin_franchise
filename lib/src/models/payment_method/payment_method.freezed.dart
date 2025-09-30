// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'payment_method.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

PaymentMethod _$PaymentMethodFromJson(Map<String, dynamic> json) {
  return _PaymentMethod.fromJson(json);
}

/// @nodoc
mixin _$PaymentMethod {
  int get key => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get nameEn => throw _privateConstructorUsedError;
  bool? get isVat => throw _privateConstructorUsedError;
  bool get isBank =>
      throw _privateConstructorUsedError; // Sử dụng tài khoản ngân hàng
  bool get isGateway =>
      throw _privateConstructorUsedError; // Sử dụng cổng thanh toán
  bool get isCash => throw _privateConstructorUsedError; // Tiền mặt
  bool get isAtm => throw _privateConstructorUsedError; // Cà thẻ
// bắt buộc chỉnh sửa thuế trước khi hoàn thành đơn
// đơn MV + Grab, Shopee, ...
  bool get requireEditTax => throw _privateConstructorUsedError;

  /// api get data bill
  dynamic get paymentAmount => throw _privateConstructorUsedError;
  int get keyMethod => throw _privateConstructorUsedError;
  String get method => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PaymentMethodCopyWith<PaymentMethod> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PaymentMethodCopyWith<$Res> {
  factory $PaymentMethodCopyWith(
          PaymentMethod value, $Res Function(PaymentMethod) then) =
      _$PaymentMethodCopyWithImpl<$Res, PaymentMethod>;
  @useResult
  $Res call(
      {int key,
      String name,
      String nameEn,
      bool? isVat,
      bool isBank,
      bool isGateway,
      bool isCash,
      bool isAtm,
      bool requireEditTax,
      dynamic paymentAmount,
      int keyMethod,
      String method});
}

/// @nodoc
class _$PaymentMethodCopyWithImpl<$Res, $Val extends PaymentMethod>
    implements $PaymentMethodCopyWith<$Res> {
  _$PaymentMethodCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? key = null,
    Object? name = null,
    Object? nameEn = null,
    Object? isVat = freezed,
    Object? isBank = null,
    Object? isGateway = null,
    Object? isCash = null,
    Object? isAtm = null,
    Object? requireEditTax = null,
    Object? paymentAmount = freezed,
    Object? keyMethod = null,
    Object? method = null,
  }) {
    return _then(_value.copyWith(
      key: null == key
          ? _value.key
          : key // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      nameEn: null == nameEn
          ? _value.nameEn
          : nameEn // ignore: cast_nullable_to_non_nullable
              as String,
      isVat: freezed == isVat
          ? _value.isVat
          : isVat // ignore: cast_nullable_to_non_nullable
              as bool?,
      isBank: null == isBank
          ? _value.isBank
          : isBank // ignore: cast_nullable_to_non_nullable
              as bool,
      isGateway: null == isGateway
          ? _value.isGateway
          : isGateway // ignore: cast_nullable_to_non_nullable
              as bool,
      isCash: null == isCash
          ? _value.isCash
          : isCash // ignore: cast_nullable_to_non_nullable
              as bool,
      isAtm: null == isAtm
          ? _value.isAtm
          : isAtm // ignore: cast_nullable_to_non_nullable
              as bool,
      requireEditTax: null == requireEditTax
          ? _value.requireEditTax
          : requireEditTax // ignore: cast_nullable_to_non_nullable
              as bool,
      paymentAmount: freezed == paymentAmount
          ? _value.paymentAmount
          : paymentAmount // ignore: cast_nullable_to_non_nullable
              as dynamic,
      keyMethod: null == keyMethod
          ? _value.keyMethod
          : keyMethod // ignore: cast_nullable_to_non_nullable
              as int,
      method: null == method
          ? _value.method
          : method // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PaymentMethodImplCopyWith<$Res>
    implements $PaymentMethodCopyWith<$Res> {
  factory _$$PaymentMethodImplCopyWith(
          _$PaymentMethodImpl value, $Res Function(_$PaymentMethodImpl) then) =
      __$$PaymentMethodImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int key,
      String name,
      String nameEn,
      bool? isVat,
      bool isBank,
      bool isGateway,
      bool isCash,
      bool isAtm,
      bool requireEditTax,
      dynamic paymentAmount,
      int keyMethod,
      String method});
}

/// @nodoc
class __$$PaymentMethodImplCopyWithImpl<$Res>
    extends _$PaymentMethodCopyWithImpl<$Res, _$PaymentMethodImpl>
    implements _$$PaymentMethodImplCopyWith<$Res> {
  __$$PaymentMethodImplCopyWithImpl(
      _$PaymentMethodImpl _value, $Res Function(_$PaymentMethodImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? key = null,
    Object? name = null,
    Object? nameEn = null,
    Object? isVat = freezed,
    Object? isBank = null,
    Object? isGateway = null,
    Object? isCash = null,
    Object? isAtm = null,
    Object? requireEditTax = null,
    Object? paymentAmount = freezed,
    Object? keyMethod = null,
    Object? method = null,
  }) {
    return _then(_$PaymentMethodImpl(
      key: null == key
          ? _value.key
          : key // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      nameEn: null == nameEn
          ? _value.nameEn
          : nameEn // ignore: cast_nullable_to_non_nullable
              as String,
      isVat: freezed == isVat
          ? _value.isVat
          : isVat // ignore: cast_nullable_to_non_nullable
              as bool?,
      isBank: null == isBank
          ? _value.isBank
          : isBank // ignore: cast_nullable_to_non_nullable
              as bool,
      isGateway: null == isGateway
          ? _value.isGateway
          : isGateway // ignore: cast_nullable_to_non_nullable
              as bool,
      isCash: null == isCash
          ? _value.isCash
          : isCash // ignore: cast_nullable_to_non_nullable
              as bool,
      isAtm: null == isAtm
          ? _value.isAtm
          : isAtm // ignore: cast_nullable_to_non_nullable
              as bool,
      requireEditTax: null == requireEditTax
          ? _value.requireEditTax
          : requireEditTax // ignore: cast_nullable_to_non_nullable
              as bool,
      paymentAmount: freezed == paymentAmount
          ? _value.paymentAmount
          : paymentAmount // ignore: cast_nullable_to_non_nullable
              as dynamic,
      keyMethod: null == keyMethod
          ? _value.keyMethod
          : keyMethod // ignore: cast_nullable_to_non_nullable
              as int,
      method: null == method
          ? _value.method
          : method // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class _$PaymentMethodImpl extends _PaymentMethod with DiagnosticableTreeMixin {
  const _$PaymentMethodImpl(
      {this.key = -1,
      this.name = 'Phương thức thanh toán',
      this.nameEn = 'Payment method',
      this.isVat,
      this.isBank = false,
      this.isGateway = false,
      this.isCash = false,
      this.isAtm = false,
      this.requireEditTax = false,
      this.paymentAmount,
      this.keyMethod = -1,
      this.method = 'Phương thức thanh toán'})
      : super._();

  factory _$PaymentMethodImpl.fromJson(Map<String, dynamic> json) =>
      _$$PaymentMethodImplFromJson(json);

  @override
  @JsonKey()
  final int key;
  @override
  @JsonKey()
  final String name;
  @override
  @JsonKey()
  final String nameEn;
  @override
  final bool? isVat;
  @override
  @JsonKey()
  final bool isBank;
// Sử dụng tài khoản ngân hàng
  @override
  @JsonKey()
  final bool isGateway;
// Sử dụng cổng thanh toán
  @override
  @JsonKey()
  final bool isCash;
// Tiền mặt
  @override
  @JsonKey()
  final bool isAtm;
// Cà thẻ
// bắt buộc chỉnh sửa thuế trước khi hoàn thành đơn
// đơn MV + Grab, Shopee, ...
  @override
  @JsonKey()
  final bool requireEditTax;

  /// api get data bill
  @override
  final dynamic paymentAmount;
  @override
  @JsonKey()
  final int keyMethod;
  @override
  @JsonKey()
  final String method;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'PaymentMethod(key: $key, name: $name, nameEn: $nameEn, isVat: $isVat, isBank: $isBank, isGateway: $isGateway, isCash: $isCash, isAtm: $isAtm, requireEditTax: $requireEditTax, paymentAmount: $paymentAmount, keyMethod: $keyMethod, method: $method)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'PaymentMethod'))
      ..add(DiagnosticsProperty('key', key))
      ..add(DiagnosticsProperty('name', name))
      ..add(DiagnosticsProperty('nameEn', nameEn))
      ..add(DiagnosticsProperty('isVat', isVat))
      ..add(DiagnosticsProperty('isBank', isBank))
      ..add(DiagnosticsProperty('isGateway', isGateway))
      ..add(DiagnosticsProperty('isCash', isCash))
      ..add(DiagnosticsProperty('isAtm', isAtm))
      ..add(DiagnosticsProperty('requireEditTax', requireEditTax))
      ..add(DiagnosticsProperty('paymentAmount', paymentAmount))
      ..add(DiagnosticsProperty('keyMethod', keyMethod))
      ..add(DiagnosticsProperty('method', method));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PaymentMethodImpl &&
            (identical(other.key, key) || other.key == key) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.nameEn, nameEn) || other.nameEn == nameEn) &&
            (identical(other.isVat, isVat) || other.isVat == isVat) &&
            (identical(other.isBank, isBank) || other.isBank == isBank) &&
            (identical(other.isGateway, isGateway) ||
                other.isGateway == isGateway) &&
            (identical(other.isCash, isCash) || other.isCash == isCash) &&
            (identical(other.isAtm, isAtm) || other.isAtm == isAtm) &&
            (identical(other.requireEditTax, requireEditTax) ||
                other.requireEditTax == requireEditTax) &&
            const DeepCollectionEquality()
                .equals(other.paymentAmount, paymentAmount) &&
            (identical(other.keyMethod, keyMethod) ||
                other.keyMethod == keyMethod) &&
            (identical(other.method, method) || other.method == method));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      key,
      name,
      nameEn,
      isVat,
      isBank,
      isGateway,
      isCash,
      isAtm,
      requireEditTax,
      const DeepCollectionEquality().hash(paymentAmount),
      keyMethod,
      method);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PaymentMethodImplCopyWith<_$PaymentMethodImpl> get copyWith =>
      __$$PaymentMethodImplCopyWithImpl<_$PaymentMethodImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PaymentMethodImplToJson(
      this,
    );
  }
}

abstract class _PaymentMethod extends PaymentMethod {
  const factory _PaymentMethod(
      {final int key,
      final String name,
      final String nameEn,
      final bool? isVat,
      final bool isBank,
      final bool isGateway,
      final bool isCash,
      final bool isAtm,
      final bool requireEditTax,
      final dynamic paymentAmount,
      final int keyMethod,
      final String method}) = _$PaymentMethodImpl;
  const _PaymentMethod._() : super._();

  factory _PaymentMethod.fromJson(Map<String, dynamic> json) =
      _$PaymentMethodImpl.fromJson;

  @override
  int get key;
  @override
  String get name;
  @override
  String get nameEn;
  @override
  bool? get isVat;
  @override
  bool get isBank;
  @override // Sử dụng tài khoản ngân hàng
  bool get isGateway;
  @override // Sử dụng cổng thanh toán
  bool get isCash;
  @override // Tiền mặt
  bool get isAtm;
  @override // Cà thẻ
// bắt buộc chỉnh sửa thuế trước khi hoàn thành đơn
// đơn MV + Grab, Shopee, ...
  bool get requireEditTax;
  @override

  /// api get data bill
  dynamic get paymentAmount;
  @override
  int get keyMethod;
  @override
  String get method;
  @override
  @JsonKey(ignore: true)
  _$$PaymentMethodImplCopyWith<_$PaymentMethodImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
