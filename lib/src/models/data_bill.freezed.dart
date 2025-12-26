// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'data_bill.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

PriceDataBill _$PriceDataBillFromJson(Map<String, dynamic> json) {
  return _PriceDataBill.fromJson(json);
}

/// @nodoc
mixin _$PriceDataBill {
  dynamic get totalPrice => throw _privateConstructorUsedError;
  dynamic get totalPriceVoucher => throw _privateConstructorUsedError;
  dynamic get totalPriceTax => throw _privateConstructorUsedError;
  dynamic get totalPriceFinal =>
      throw _privateConstructorUsedError; // số tiền mặt thu ngân nhận của khách
  double? get receivedAmount => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PriceDataBillCopyWith<PriceDataBill> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PriceDataBillCopyWith<$Res> {
  factory $PriceDataBillCopyWith(
          PriceDataBill value, $Res Function(PriceDataBill) then) =
      _$PriceDataBillCopyWithImpl<$Res, PriceDataBill>;
  @useResult
  $Res call(
      {dynamic totalPrice,
      dynamic totalPriceVoucher,
      dynamic totalPriceTax,
      dynamic totalPriceFinal,
      double? receivedAmount});
}

/// @nodoc
class _$PriceDataBillCopyWithImpl<$Res, $Val extends PriceDataBill>
    implements $PriceDataBillCopyWith<$Res> {
  _$PriceDataBillCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalPrice = freezed,
    Object? totalPriceVoucher = freezed,
    Object? totalPriceTax = freezed,
    Object? totalPriceFinal = freezed,
    Object? receivedAmount = freezed,
  }) {
    return _then(_value.copyWith(
      totalPrice: freezed == totalPrice
          ? _value.totalPrice
          : totalPrice // ignore: cast_nullable_to_non_nullable
              as dynamic,
      totalPriceVoucher: freezed == totalPriceVoucher
          ? _value.totalPriceVoucher
          : totalPriceVoucher // ignore: cast_nullable_to_non_nullable
              as dynamic,
      totalPriceTax: freezed == totalPriceTax
          ? _value.totalPriceTax
          : totalPriceTax // ignore: cast_nullable_to_non_nullable
              as dynamic,
      totalPriceFinal: freezed == totalPriceFinal
          ? _value.totalPriceFinal
          : totalPriceFinal // ignore: cast_nullable_to_non_nullable
              as dynamic,
      receivedAmount: freezed == receivedAmount
          ? _value.receivedAmount
          : receivedAmount // ignore: cast_nullable_to_non_nullable
              as double?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PriceDataBillImplCopyWith<$Res>
    implements $PriceDataBillCopyWith<$Res> {
  factory _$$PriceDataBillImplCopyWith(
          _$PriceDataBillImpl value, $Res Function(_$PriceDataBillImpl) then) =
      __$$PriceDataBillImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {dynamic totalPrice,
      dynamic totalPriceVoucher,
      dynamic totalPriceTax,
      dynamic totalPriceFinal,
      double? receivedAmount});
}

/// @nodoc
class __$$PriceDataBillImplCopyWithImpl<$Res>
    extends _$PriceDataBillCopyWithImpl<$Res, _$PriceDataBillImpl>
    implements _$$PriceDataBillImplCopyWith<$Res> {
  __$$PriceDataBillImplCopyWithImpl(
      _$PriceDataBillImpl _value, $Res Function(_$PriceDataBillImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalPrice = freezed,
    Object? totalPriceVoucher = freezed,
    Object? totalPriceTax = freezed,
    Object? totalPriceFinal = freezed,
    Object? receivedAmount = freezed,
  }) {
    return _then(_$PriceDataBillImpl(
      totalPrice: freezed == totalPrice
          ? _value.totalPrice
          : totalPrice // ignore: cast_nullable_to_non_nullable
              as dynamic,
      totalPriceVoucher: freezed == totalPriceVoucher
          ? _value.totalPriceVoucher
          : totalPriceVoucher // ignore: cast_nullable_to_non_nullable
              as dynamic,
      totalPriceTax: freezed == totalPriceTax
          ? _value.totalPriceTax
          : totalPriceTax // ignore: cast_nullable_to_non_nullable
              as dynamic,
      totalPriceFinal: freezed == totalPriceFinal
          ? _value.totalPriceFinal
          : totalPriceFinal // ignore: cast_nullable_to_non_nullable
              as dynamic,
      receivedAmount: freezed == receivedAmount
          ? _value.receivedAmount
          : receivedAmount // ignore: cast_nullable_to_non_nullable
              as double?,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class _$PriceDataBillImpl extends _PriceDataBill with DiagnosticableTreeMixin {
  const _$PriceDataBillImpl(
      {this.totalPrice = 0,
      this.totalPriceVoucher = 0,
      this.totalPriceTax = 0,
      this.totalPriceFinal = 0,
      this.receivedAmount = 0})
      : super._();

  factory _$PriceDataBillImpl.fromJson(Map<String, dynamic> json) =>
      _$$PriceDataBillImplFromJson(json);

  @override
  @JsonKey()
  final dynamic totalPrice;
  @override
  @JsonKey()
  final dynamic totalPriceVoucher;
  @override
  @JsonKey()
  final dynamic totalPriceTax;
  @override
  @JsonKey()
  final dynamic totalPriceFinal;
// số tiền mặt thu ngân nhận của khách
  @override
  @JsonKey()
  final double? receivedAmount;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'PriceDataBill(totalPrice: $totalPrice, totalPriceVoucher: $totalPriceVoucher, totalPriceTax: $totalPriceTax, totalPriceFinal: $totalPriceFinal, receivedAmount: $receivedAmount)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'PriceDataBill'))
      ..add(DiagnosticsProperty('totalPrice', totalPrice))
      ..add(DiagnosticsProperty('totalPriceVoucher', totalPriceVoucher))
      ..add(DiagnosticsProperty('totalPriceTax', totalPriceTax))
      ..add(DiagnosticsProperty('totalPriceFinal', totalPriceFinal))
      ..add(DiagnosticsProperty('receivedAmount', receivedAmount));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PriceDataBillImpl &&
            const DeepCollectionEquality()
                .equals(other.totalPrice, totalPrice) &&
            const DeepCollectionEquality()
                .equals(other.totalPriceVoucher, totalPriceVoucher) &&
            const DeepCollectionEquality()
                .equals(other.totalPriceTax, totalPriceTax) &&
            const DeepCollectionEquality()
                .equals(other.totalPriceFinal, totalPriceFinal) &&
            (identical(other.receivedAmount, receivedAmount) ||
                other.receivedAmount == receivedAmount));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(totalPrice),
      const DeepCollectionEquality().hash(totalPriceVoucher),
      const DeepCollectionEquality().hash(totalPriceTax),
      const DeepCollectionEquality().hash(totalPriceFinal),
      receivedAmount);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PriceDataBillImplCopyWith<_$PriceDataBillImpl> get copyWith =>
      __$$PriceDataBillImplCopyWithImpl<_$PriceDataBillImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PriceDataBillImplToJson(
      this,
    );
  }
}

abstract class _PriceDataBill extends PriceDataBill {
  const factory _PriceDataBill(
      {final dynamic totalPrice,
      final dynamic totalPriceVoucher,
      final dynamic totalPriceTax,
      final dynamic totalPriceFinal,
      final double? receivedAmount}) = _$PriceDataBillImpl;
  const _PriceDataBill._() : super._();

  factory _PriceDataBill.fromJson(Map<String, dynamic> json) =
      _$PriceDataBillImpl.fromJson;

  @override
  dynamic get totalPrice;
  @override
  dynamic get totalPriceVoucher;
  @override
  dynamic get totalPriceTax;
  @override
  dynamic get totalPriceFinal;
  @override // số tiền mặt thu ngân nhận của khách
  double? get receivedAmount;
  @override
  @JsonKey(ignore: true)
  _$$PriceDataBillImplCopyWith<_$PriceDataBillImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

OrderDataBill _$OrderDataBillFromJson(Map<String, dynamic> json) {
  return _OrderDataBill.fromJson(json);
}

/// @nodoc
mixin _$OrderDataBill {
  int get id => throw _privateConstructorUsedError;
  String get code => throw _privateConstructorUsedError;
  String get tableName => throw _privateConstructorUsedError;

  /// payment_method: 50
  int? get paymentMethod => throw _privateConstructorUsedError;
  int get amountChildren => throw _privateConstructorUsedError;
  int get amountAdult => throw _privateConstructorUsedError;
  String? get portrait => throw _privateConstructorUsedError;
  int get numberPrintCompleted => throw _privateConstructorUsedError;
  int get numberPrintTemporary => throw _privateConstructorUsedError;
  List<String> get imageConfirms => throw _privateConstructorUsedError;
  List<dynamic> get customerRatings => throw _privateConstructorUsedError;
  List<PaymentMethodDataBill> get listPaymentMethod =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $OrderDataBillCopyWith<OrderDataBill> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OrderDataBillCopyWith<$Res> {
  factory $OrderDataBillCopyWith(
          OrderDataBill value, $Res Function(OrderDataBill) then) =
      _$OrderDataBillCopyWithImpl<$Res, OrderDataBill>;
  @useResult
  $Res call(
      {int id,
      String code,
      String tableName,
      int? paymentMethod,
      int amountChildren,
      int amountAdult,
      String? portrait,
      int numberPrintCompleted,
      int numberPrintTemporary,
      List<String> imageConfirms,
      List<dynamic> customerRatings,
      List<PaymentMethodDataBill> listPaymentMethod});
}

/// @nodoc
class _$OrderDataBillCopyWithImpl<$Res, $Val extends OrderDataBill>
    implements $OrderDataBillCopyWith<$Res> {
  _$OrderDataBillCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? code = null,
    Object? tableName = null,
    Object? paymentMethod = freezed,
    Object? amountChildren = null,
    Object? amountAdult = null,
    Object? portrait = freezed,
    Object? numberPrintCompleted = null,
    Object? numberPrintTemporary = null,
    Object? imageConfirms = null,
    Object? customerRatings = null,
    Object? listPaymentMethod = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      code: null == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String,
      tableName: null == tableName
          ? _value.tableName
          : tableName // ignore: cast_nullable_to_non_nullable
              as String,
      paymentMethod: freezed == paymentMethod
          ? _value.paymentMethod
          : paymentMethod // ignore: cast_nullable_to_non_nullable
              as int?,
      amountChildren: null == amountChildren
          ? _value.amountChildren
          : amountChildren // ignore: cast_nullable_to_non_nullable
              as int,
      amountAdult: null == amountAdult
          ? _value.amountAdult
          : amountAdult // ignore: cast_nullable_to_non_nullable
              as int,
      portrait: freezed == portrait
          ? _value.portrait
          : portrait // ignore: cast_nullable_to_non_nullable
              as String?,
      numberPrintCompleted: null == numberPrintCompleted
          ? _value.numberPrintCompleted
          : numberPrintCompleted // ignore: cast_nullable_to_non_nullable
              as int,
      numberPrintTemporary: null == numberPrintTemporary
          ? _value.numberPrintTemporary
          : numberPrintTemporary // ignore: cast_nullable_to_non_nullable
              as int,
      imageConfirms: null == imageConfirms
          ? _value.imageConfirms
          : imageConfirms // ignore: cast_nullable_to_non_nullable
              as List<String>,
      customerRatings: null == customerRatings
          ? _value.customerRatings
          : customerRatings // ignore: cast_nullable_to_non_nullable
              as List<dynamic>,
      listPaymentMethod: null == listPaymentMethod
          ? _value.listPaymentMethod
          : listPaymentMethod // ignore: cast_nullable_to_non_nullable
              as List<PaymentMethodDataBill>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$OrderDataBillImplCopyWith<$Res>
    implements $OrderDataBillCopyWith<$Res> {
  factory _$$OrderDataBillImplCopyWith(
          _$OrderDataBillImpl value, $Res Function(_$OrderDataBillImpl) then) =
      __$$OrderDataBillImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String code,
      String tableName,
      int? paymentMethod,
      int amountChildren,
      int amountAdult,
      String? portrait,
      int numberPrintCompleted,
      int numberPrintTemporary,
      List<String> imageConfirms,
      List<dynamic> customerRatings,
      List<PaymentMethodDataBill> listPaymentMethod});
}

/// @nodoc
class __$$OrderDataBillImplCopyWithImpl<$Res>
    extends _$OrderDataBillCopyWithImpl<$Res, _$OrderDataBillImpl>
    implements _$$OrderDataBillImplCopyWith<$Res> {
  __$$OrderDataBillImplCopyWithImpl(
      _$OrderDataBillImpl _value, $Res Function(_$OrderDataBillImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? code = null,
    Object? tableName = null,
    Object? paymentMethod = freezed,
    Object? amountChildren = null,
    Object? amountAdult = null,
    Object? portrait = freezed,
    Object? numberPrintCompleted = null,
    Object? numberPrintTemporary = null,
    Object? imageConfirms = null,
    Object? customerRatings = null,
    Object? listPaymentMethod = null,
  }) {
    return _then(_$OrderDataBillImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      code: null == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String,
      tableName: null == tableName
          ? _value.tableName
          : tableName // ignore: cast_nullable_to_non_nullable
              as String,
      paymentMethod: freezed == paymentMethod
          ? _value.paymentMethod
          : paymentMethod // ignore: cast_nullable_to_non_nullable
              as int?,
      amountChildren: null == amountChildren
          ? _value.amountChildren
          : amountChildren // ignore: cast_nullable_to_non_nullable
              as int,
      amountAdult: null == amountAdult
          ? _value.amountAdult
          : amountAdult // ignore: cast_nullable_to_non_nullable
              as int,
      portrait: freezed == portrait
          ? _value.portrait
          : portrait // ignore: cast_nullable_to_non_nullable
              as String?,
      numberPrintCompleted: null == numberPrintCompleted
          ? _value.numberPrintCompleted
          : numberPrintCompleted // ignore: cast_nullable_to_non_nullable
              as int,
      numberPrintTemporary: null == numberPrintTemporary
          ? _value.numberPrintTemporary
          : numberPrintTemporary // ignore: cast_nullable_to_non_nullable
              as int,
      imageConfirms: null == imageConfirms
          ? _value._imageConfirms
          : imageConfirms // ignore: cast_nullable_to_non_nullable
              as List<String>,
      customerRatings: null == customerRatings
          ? _value._customerRatings
          : customerRatings // ignore: cast_nullable_to_non_nullable
              as List<dynamic>,
      listPaymentMethod: null == listPaymentMethod
          ? _value._listPaymentMethod
          : listPaymentMethod // ignore: cast_nullable_to_non_nullable
              as List<PaymentMethodDataBill>,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class _$OrderDataBillImpl extends _OrderDataBill with DiagnosticableTreeMixin {
  const _$OrderDataBillImpl(
      {this.id = -1,
      this.code = '',
      this.tableName = '',
      this.paymentMethod,
      this.amountChildren = 0,
      this.amountAdult = 0,
      this.portrait,
      this.numberPrintCompleted = 0,
      this.numberPrintTemporary = 0,
      final List<String> imageConfirms = const [],
      final List<dynamic> customerRatings = const [],
      final List<PaymentMethodDataBill> listPaymentMethod = const []})
      : _imageConfirms = imageConfirms,
        _customerRatings = customerRatings,
        _listPaymentMethod = listPaymentMethod,
        super._();

  factory _$OrderDataBillImpl.fromJson(Map<String, dynamic> json) =>
      _$$OrderDataBillImplFromJson(json);

  @override
  @JsonKey()
  final int id;
  @override
  @JsonKey()
  final String code;
  @override
  @JsonKey()
  final String tableName;

  /// payment_method: 50
  @override
  final int? paymentMethod;
  @override
  @JsonKey()
  final int amountChildren;
  @override
  @JsonKey()
  final int amountAdult;
  @override
  final String? portrait;
  @override
  @JsonKey()
  final int numberPrintCompleted;
  @override
  @JsonKey()
  final int numberPrintTemporary;
  final List<String> _imageConfirms;
  @override
  @JsonKey()
  List<String> get imageConfirms {
    if (_imageConfirms is EqualUnmodifiableListView) return _imageConfirms;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_imageConfirms);
  }

  final List<dynamic> _customerRatings;
  @override
  @JsonKey()
  List<dynamic> get customerRatings {
    if (_customerRatings is EqualUnmodifiableListView) return _customerRatings;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_customerRatings);
  }

  final List<PaymentMethodDataBill> _listPaymentMethod;
  @override
  @JsonKey()
  List<PaymentMethodDataBill> get listPaymentMethod {
    if (_listPaymentMethod is EqualUnmodifiableListView)
      return _listPaymentMethod;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_listPaymentMethod);
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'OrderDataBill(id: $id, code: $code, tableName: $tableName, paymentMethod: $paymentMethod, amountChildren: $amountChildren, amountAdult: $amountAdult, portrait: $portrait, numberPrintCompleted: $numberPrintCompleted, numberPrintTemporary: $numberPrintTemporary, imageConfirms: $imageConfirms, customerRatings: $customerRatings, listPaymentMethod: $listPaymentMethod)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'OrderDataBill'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('code', code))
      ..add(DiagnosticsProperty('tableName', tableName))
      ..add(DiagnosticsProperty('paymentMethod', paymentMethod))
      ..add(DiagnosticsProperty('amountChildren', amountChildren))
      ..add(DiagnosticsProperty('amountAdult', amountAdult))
      ..add(DiagnosticsProperty('portrait', portrait))
      ..add(DiagnosticsProperty('numberPrintCompleted', numberPrintCompleted))
      ..add(DiagnosticsProperty('numberPrintTemporary', numberPrintTemporary))
      ..add(DiagnosticsProperty('imageConfirms', imageConfirms))
      ..add(DiagnosticsProperty('customerRatings', customerRatings))
      ..add(DiagnosticsProperty('listPaymentMethod', listPaymentMethod));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OrderDataBillImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.tableName, tableName) ||
                other.tableName == tableName) &&
            (identical(other.paymentMethod, paymentMethod) ||
                other.paymentMethod == paymentMethod) &&
            (identical(other.amountChildren, amountChildren) ||
                other.amountChildren == amountChildren) &&
            (identical(other.amountAdult, amountAdult) ||
                other.amountAdult == amountAdult) &&
            (identical(other.portrait, portrait) ||
                other.portrait == portrait) &&
            (identical(other.numberPrintCompleted, numberPrintCompleted) ||
                other.numberPrintCompleted == numberPrintCompleted) &&
            (identical(other.numberPrintTemporary, numberPrintTemporary) ||
                other.numberPrintTemporary == numberPrintTemporary) &&
            const DeepCollectionEquality()
                .equals(other._imageConfirms, _imageConfirms) &&
            const DeepCollectionEquality()
                .equals(other._customerRatings, _customerRatings) &&
            const DeepCollectionEquality()
                .equals(other._listPaymentMethod, _listPaymentMethod));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      code,
      tableName,
      paymentMethod,
      amountChildren,
      amountAdult,
      portrait,
      numberPrintCompleted,
      numberPrintTemporary,
      const DeepCollectionEquality().hash(_imageConfirms),
      const DeepCollectionEquality().hash(_customerRatings),
      const DeepCollectionEquality().hash(_listPaymentMethod));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$OrderDataBillImplCopyWith<_$OrderDataBillImpl> get copyWith =>
      __$$OrderDataBillImplCopyWithImpl<_$OrderDataBillImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OrderDataBillImplToJson(
      this,
    );
  }
}

abstract class _OrderDataBill extends OrderDataBill {
  const factory _OrderDataBill(
          {final int id,
          final String code,
          final String tableName,
          final int? paymentMethod,
          final int amountChildren,
          final int amountAdult,
          final String? portrait,
          final int numberPrintCompleted,
          final int numberPrintTemporary,
          final List<String> imageConfirms,
          final List<dynamic> customerRatings,
          final List<PaymentMethodDataBill> listPaymentMethod}) =
      _$OrderDataBillImpl;
  const _OrderDataBill._() : super._();

  factory _OrderDataBill.fromJson(Map<String, dynamic> json) =
      _$OrderDataBillImpl.fromJson;

  @override
  int get id;
  @override
  String get code;
  @override
  String get tableName;
  @override

  /// payment_method: 50
  int? get paymentMethod;
  @override
  int get amountChildren;
  @override
  int get amountAdult;
  @override
  String? get portrait;
  @override
  int get numberPrintCompleted;
  @override
  int get numberPrintTemporary;
  @override
  List<String> get imageConfirms;
  @override
  List<dynamic> get customerRatings;
  @override
  List<PaymentMethodDataBill> get listPaymentMethod;
  @override
  @JsonKey(ignore: true)
  _$$OrderDataBillImplCopyWith<_$OrderDataBillImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PaymentMethodDataBill _$PaymentMethodDataBillFromJson(
    Map<String, dynamic> json) {
  return _PaymentMethodDataBill.fromJson(json);
}

/// @nodoc
mixin _$PaymentMethodDataBill {
  int get keyMethod => throw _privateConstructorUsedError;
  String get method => throw _privateConstructorUsedError;
  double get paymentAmount => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PaymentMethodDataBillCopyWith<PaymentMethodDataBill> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PaymentMethodDataBillCopyWith<$Res> {
  factory $PaymentMethodDataBillCopyWith(PaymentMethodDataBill value,
          $Res Function(PaymentMethodDataBill) then) =
      _$PaymentMethodDataBillCopyWithImpl<$Res, PaymentMethodDataBill>;
  @useResult
  $Res call({int keyMethod, String method, double paymentAmount});
}

/// @nodoc
class _$PaymentMethodDataBillCopyWithImpl<$Res,
        $Val extends PaymentMethodDataBill>
    implements $PaymentMethodDataBillCopyWith<$Res> {
  _$PaymentMethodDataBillCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? keyMethod = null,
    Object? method = null,
    Object? paymentAmount = null,
  }) {
    return _then(_value.copyWith(
      keyMethod: null == keyMethod
          ? _value.keyMethod
          : keyMethod // ignore: cast_nullable_to_non_nullable
              as int,
      method: null == method
          ? _value.method
          : method // ignore: cast_nullable_to_non_nullable
              as String,
      paymentAmount: null == paymentAmount
          ? _value.paymentAmount
          : paymentAmount // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PaymentMethodDataBillImplCopyWith<$Res>
    implements $PaymentMethodDataBillCopyWith<$Res> {
  factory _$$PaymentMethodDataBillImplCopyWith(
          _$PaymentMethodDataBillImpl value,
          $Res Function(_$PaymentMethodDataBillImpl) then) =
      __$$PaymentMethodDataBillImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int keyMethod, String method, double paymentAmount});
}

/// @nodoc
class __$$PaymentMethodDataBillImplCopyWithImpl<$Res>
    extends _$PaymentMethodDataBillCopyWithImpl<$Res,
        _$PaymentMethodDataBillImpl>
    implements _$$PaymentMethodDataBillImplCopyWith<$Res> {
  __$$PaymentMethodDataBillImplCopyWithImpl(_$PaymentMethodDataBillImpl _value,
      $Res Function(_$PaymentMethodDataBillImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? keyMethod = null,
    Object? method = null,
    Object? paymentAmount = null,
  }) {
    return _then(_$PaymentMethodDataBillImpl(
      keyMethod: null == keyMethod
          ? _value.keyMethod
          : keyMethod // ignore: cast_nullable_to_non_nullable
              as int,
      method: null == method
          ? _value.method
          : method // ignore: cast_nullable_to_non_nullable
              as String,
      paymentAmount: null == paymentAmount
          ? _value.paymentAmount
          : paymentAmount // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class _$PaymentMethodDataBillImpl
    with DiagnosticableTreeMixin
    implements _PaymentMethodDataBill {
  const _$PaymentMethodDataBillImpl(
      {this.keyMethod = 0, this.method = '', this.paymentAmount = 0.0});

  factory _$PaymentMethodDataBillImpl.fromJson(Map<String, dynamic> json) =>
      _$$PaymentMethodDataBillImplFromJson(json);

  @override
  @JsonKey()
  final int keyMethod;
  @override
  @JsonKey()
  final String method;
  @override
  @JsonKey()
  final double paymentAmount;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'PaymentMethodDataBill(keyMethod: $keyMethod, method: $method, paymentAmount: $paymentAmount)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'PaymentMethodDataBill'))
      ..add(DiagnosticsProperty('keyMethod', keyMethod))
      ..add(DiagnosticsProperty('method', method))
      ..add(DiagnosticsProperty('paymentAmount', paymentAmount));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PaymentMethodDataBillImpl &&
            (identical(other.keyMethod, keyMethod) ||
                other.keyMethod == keyMethod) &&
            (identical(other.method, method) || other.method == method) &&
            (identical(other.paymentAmount, paymentAmount) ||
                other.paymentAmount == paymentAmount));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, keyMethod, method, paymentAmount);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PaymentMethodDataBillImplCopyWith<_$PaymentMethodDataBillImpl>
      get copyWith => __$$PaymentMethodDataBillImplCopyWithImpl<
          _$PaymentMethodDataBillImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PaymentMethodDataBillImplToJson(
      this,
    );
  }
}

abstract class _PaymentMethodDataBill implements PaymentMethodDataBill {
  const factory _PaymentMethodDataBill(
      {final int keyMethod,
      final String method,
      final double paymentAmount}) = _$PaymentMethodDataBillImpl;

  factory _PaymentMethodDataBill.fromJson(Map<String, dynamic> json) =
      _$PaymentMethodDataBillImpl.fromJson;

  @override
  int get keyMethod;
  @override
  String get method;
  @override
  double get paymentAmount;
  @override
  @JsonKey(ignore: true)
  _$$PaymentMethodDataBillImplCopyWith<_$PaymentMethodDataBillImpl>
      get copyWith => throw _privateConstructorUsedError;
}

LineItemDataBill _$LineItemDataBillFromJson(Map<String, dynamic> json) {
  return _LineItemDataBill.fromJson(json);
}

/// @nodoc
mixin _$LineItemDataBill {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  dynamic get price => throw _privateConstructorUsedError;
  int get count => throw _privateConstructorUsedError;
  String get unit => throw _privateConstructorUsedError;
  dynamic get tax => throw _privateConstructorUsedError;
  String get nameEn => throw _privateConstructorUsedError;
  String get codeProduct => throw _privateConstructorUsedError;
  List<SubLineItemDataBill> get listItem => throw _privateConstructorUsedError;
  int get isChangeTax => throw _privateConstructorUsedError;
  Map<String, dynamic> get language => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $LineItemDataBillCopyWith<LineItemDataBill> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LineItemDataBillCopyWith<$Res> {
  factory $LineItemDataBillCopyWith(
          LineItemDataBill value, $Res Function(LineItemDataBill) then) =
      _$LineItemDataBillCopyWithImpl<$Res, LineItemDataBill>;
  @useResult
  $Res call(
      {int id,
      String name,
      dynamic price,
      int count,
      String unit,
      dynamic tax,
      String nameEn,
      String codeProduct,
      List<SubLineItemDataBill> listItem,
      int isChangeTax,
      Map<String, dynamic> language});
}

/// @nodoc
class _$LineItemDataBillCopyWithImpl<$Res, $Val extends LineItemDataBill>
    implements $LineItemDataBillCopyWith<$Res> {
  _$LineItemDataBillCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? price = freezed,
    Object? count = null,
    Object? unit = null,
    Object? tax = freezed,
    Object? nameEn = null,
    Object? codeProduct = null,
    Object? listItem = null,
    Object? isChangeTax = null,
    Object? language = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      price: freezed == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as dynamic,
      count: null == count
          ? _value.count
          : count // ignore: cast_nullable_to_non_nullable
              as int,
      unit: null == unit
          ? _value.unit
          : unit // ignore: cast_nullable_to_non_nullable
              as String,
      tax: freezed == tax
          ? _value.tax
          : tax // ignore: cast_nullable_to_non_nullable
              as dynamic,
      nameEn: null == nameEn
          ? _value.nameEn
          : nameEn // ignore: cast_nullable_to_non_nullable
              as String,
      codeProduct: null == codeProduct
          ? _value.codeProduct
          : codeProduct // ignore: cast_nullable_to_non_nullable
              as String,
      listItem: null == listItem
          ? _value.listItem
          : listItem // ignore: cast_nullable_to_non_nullable
              as List<SubLineItemDataBill>,
      isChangeTax: null == isChangeTax
          ? _value.isChangeTax
          : isChangeTax // ignore: cast_nullable_to_non_nullable
              as int,
      language: null == language
          ? _value.language
          : language // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LineItemDataBillImplCopyWith<$Res>
    implements $LineItemDataBillCopyWith<$Res> {
  factory _$$LineItemDataBillImplCopyWith(_$LineItemDataBillImpl value,
          $Res Function(_$LineItemDataBillImpl) then) =
      __$$LineItemDataBillImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String name,
      dynamic price,
      int count,
      String unit,
      dynamic tax,
      String nameEn,
      String codeProduct,
      List<SubLineItemDataBill> listItem,
      int isChangeTax,
      Map<String, dynamic> language});
}

/// @nodoc
class __$$LineItemDataBillImplCopyWithImpl<$Res>
    extends _$LineItemDataBillCopyWithImpl<$Res, _$LineItemDataBillImpl>
    implements _$$LineItemDataBillImplCopyWith<$Res> {
  __$$LineItemDataBillImplCopyWithImpl(_$LineItemDataBillImpl _value,
      $Res Function(_$LineItemDataBillImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? price = freezed,
    Object? count = null,
    Object? unit = null,
    Object? tax = freezed,
    Object? nameEn = null,
    Object? codeProduct = null,
    Object? listItem = null,
    Object? isChangeTax = null,
    Object? language = null,
  }) {
    return _then(_$LineItemDataBillImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      price: freezed == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as dynamic,
      count: null == count
          ? _value.count
          : count // ignore: cast_nullable_to_non_nullable
              as int,
      unit: null == unit
          ? _value.unit
          : unit // ignore: cast_nullable_to_non_nullable
              as String,
      tax: freezed == tax
          ? _value.tax
          : tax // ignore: cast_nullable_to_non_nullable
              as dynamic,
      nameEn: null == nameEn
          ? _value.nameEn
          : nameEn // ignore: cast_nullable_to_non_nullable
              as String,
      codeProduct: null == codeProduct
          ? _value.codeProduct
          : codeProduct // ignore: cast_nullable_to_non_nullable
              as String,
      listItem: null == listItem
          ? _value._listItem
          : listItem // ignore: cast_nullable_to_non_nullable
              as List<SubLineItemDataBill>,
      isChangeTax: null == isChangeTax
          ? _value.isChangeTax
          : isChangeTax // ignore: cast_nullable_to_non_nullable
              as int,
      language: null == language
          ? _value._language
          : language // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class _$LineItemDataBillImpl extends _LineItemDataBill
    with DiagnosticableTreeMixin {
  const _$LineItemDataBillImpl(
      {this.id = -1,
      this.name = '',
      this.price,
      this.count = 0,
      this.unit = '_',
      this.tax,
      this.nameEn = '',
      this.codeProduct = '',
      final List<SubLineItemDataBill> listItem = const [],
      this.isChangeTax = 0,
      final Map<String, dynamic> language = const {}})
      : _listItem = listItem,
        _language = language,
        super._();

  factory _$LineItemDataBillImpl.fromJson(Map<String, dynamic> json) =>
      _$$LineItemDataBillImplFromJson(json);

  @override
  @JsonKey()
  final int id;
  @override
  @JsonKey()
  final String name;
  @override
  final dynamic price;
  @override
  @JsonKey()
  final int count;
  @override
  @JsonKey()
  final String unit;
  @override
  final dynamic tax;
  @override
  @JsonKey()
  final String nameEn;
  @override
  @JsonKey()
  final String codeProduct;
  final List<SubLineItemDataBill> _listItem;
  @override
  @JsonKey()
  List<SubLineItemDataBill> get listItem {
    if (_listItem is EqualUnmodifiableListView) return _listItem;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_listItem);
  }

  @override
  @JsonKey()
  final int isChangeTax;
  final Map<String, dynamic> _language;
  @override
  @JsonKey()
  Map<String, dynamic> get language {
    if (_language is EqualUnmodifiableMapView) return _language;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_language);
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'LineItemDataBill(id: $id, name: $name, price: $price, count: $count, unit: $unit, tax: $tax, nameEn: $nameEn, codeProduct: $codeProduct, listItem: $listItem, isChangeTax: $isChangeTax, language: $language)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'LineItemDataBill'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('name', name))
      ..add(DiagnosticsProperty('price', price))
      ..add(DiagnosticsProperty('count', count))
      ..add(DiagnosticsProperty('unit', unit))
      ..add(DiagnosticsProperty('tax', tax))
      ..add(DiagnosticsProperty('nameEn', nameEn))
      ..add(DiagnosticsProperty('codeProduct', codeProduct))
      ..add(DiagnosticsProperty('listItem', listItem))
      ..add(DiagnosticsProperty('isChangeTax', isChangeTax))
      ..add(DiagnosticsProperty('language', language));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LineItemDataBillImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            const DeepCollectionEquality().equals(other.price, price) &&
            (identical(other.count, count) || other.count == count) &&
            (identical(other.unit, unit) || other.unit == unit) &&
            const DeepCollectionEquality().equals(other.tax, tax) &&
            (identical(other.nameEn, nameEn) || other.nameEn == nameEn) &&
            (identical(other.codeProduct, codeProduct) ||
                other.codeProduct == codeProduct) &&
            const DeepCollectionEquality().equals(other._listItem, _listItem) &&
            (identical(other.isChangeTax, isChangeTax) ||
                other.isChangeTax == isChangeTax) &&
            const DeepCollectionEquality().equals(other._language, _language));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      const DeepCollectionEquality().hash(price),
      count,
      unit,
      const DeepCollectionEquality().hash(tax),
      nameEn,
      codeProduct,
      const DeepCollectionEquality().hash(_listItem),
      isChangeTax,
      const DeepCollectionEquality().hash(_language));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LineItemDataBillImplCopyWith<_$LineItemDataBillImpl> get copyWith =>
      __$$LineItemDataBillImplCopyWithImpl<_$LineItemDataBillImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LineItemDataBillImplToJson(
      this,
    );
  }
}

abstract class _LineItemDataBill extends LineItemDataBill {
  const factory _LineItemDataBill(
      {final int id,
      final String name,
      final dynamic price,
      final int count,
      final String unit,
      final dynamic tax,
      final String nameEn,
      final String codeProduct,
      final List<SubLineItemDataBill> listItem,
      final int isChangeTax,
      final Map<String, dynamic> language}) = _$LineItemDataBillImpl;
  const _LineItemDataBill._() : super._();

  factory _LineItemDataBill.fromJson(Map<String, dynamic> json) =
      _$LineItemDataBillImpl.fromJson;

  @override
  int get id;
  @override
  String get name;
  @override
  dynamic get price;
  @override
  int get count;
  @override
  String get unit;
  @override
  dynamic get tax;
  @override
  String get nameEn;
  @override
  String get codeProduct;
  @override
  List<SubLineItemDataBill> get listItem;
  @override
  int get isChangeTax;
  @override
  Map<String, dynamic> get language;
  @override
  @JsonKey(ignore: true)
  _$$LineItemDataBillImplCopyWith<_$LineItemDataBillImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SubLineItemDataBill _$SubLineItemDataBillFromJson(Map<String, dynamic> json) {
  return _SubLineItemDataBill.fromJson(json);
}

/// @nodoc
mixin _$SubLineItemDataBill {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  dynamic get price => throw _privateConstructorUsedError;
  int get count => throw _privateConstructorUsedError;
  String get unit => throw _privateConstructorUsedError;
  dynamic get tax => throw _privateConstructorUsedError;
  int? get type => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SubLineItemDataBillCopyWith<SubLineItemDataBill> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SubLineItemDataBillCopyWith<$Res> {
  factory $SubLineItemDataBillCopyWith(
          SubLineItemDataBill value, $Res Function(SubLineItemDataBill) then) =
      _$SubLineItemDataBillCopyWithImpl<$Res, SubLineItemDataBill>;
  @useResult
  $Res call(
      {int id,
      String name,
      dynamic price,
      int count,
      String unit,
      dynamic tax,
      int? type});
}

/// @nodoc
class _$SubLineItemDataBillCopyWithImpl<$Res, $Val extends SubLineItemDataBill>
    implements $SubLineItemDataBillCopyWith<$Res> {
  _$SubLineItemDataBillCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? price = freezed,
    Object? count = null,
    Object? unit = null,
    Object? tax = freezed,
    Object? type = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      price: freezed == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as dynamic,
      count: null == count
          ? _value.count
          : count // ignore: cast_nullable_to_non_nullable
              as int,
      unit: null == unit
          ? _value.unit
          : unit // ignore: cast_nullable_to_non_nullable
              as String,
      tax: freezed == tax
          ? _value.tax
          : tax // ignore: cast_nullable_to_non_nullable
              as dynamic,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SubLineItemDataBillImplCopyWith<$Res>
    implements $SubLineItemDataBillCopyWith<$Res> {
  factory _$$SubLineItemDataBillImplCopyWith(_$SubLineItemDataBillImpl value,
          $Res Function(_$SubLineItemDataBillImpl) then) =
      __$$SubLineItemDataBillImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String name,
      dynamic price,
      int count,
      String unit,
      dynamic tax,
      int? type});
}

/// @nodoc
class __$$SubLineItemDataBillImplCopyWithImpl<$Res>
    extends _$SubLineItemDataBillCopyWithImpl<$Res, _$SubLineItemDataBillImpl>
    implements _$$SubLineItemDataBillImplCopyWith<$Res> {
  __$$SubLineItemDataBillImplCopyWithImpl(_$SubLineItemDataBillImpl _value,
      $Res Function(_$SubLineItemDataBillImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? price = freezed,
    Object? count = null,
    Object? unit = null,
    Object? tax = freezed,
    Object? type = freezed,
  }) {
    return _then(_$SubLineItemDataBillImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      price: freezed == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as dynamic,
      count: null == count
          ? _value.count
          : count // ignore: cast_nullable_to_non_nullable
              as int,
      unit: null == unit
          ? _value.unit
          : unit // ignore: cast_nullable_to_non_nullable
              as String,
      tax: freezed == tax
          ? _value.tax
          : tax // ignore: cast_nullable_to_non_nullable
              as dynamic,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class _$SubLineItemDataBillImpl extends _SubLineItemDataBill
    with DiagnosticableTreeMixin {
  const _$SubLineItemDataBillImpl(
      {this.id = -1,
      this.name = '',
      this.price,
      this.count = 0,
      this.unit = '_',
      this.tax,
      this.type})
      : super._();

  factory _$SubLineItemDataBillImpl.fromJson(Map<String, dynamic> json) =>
      _$$SubLineItemDataBillImplFromJson(json);

  @override
  @JsonKey()
  final int id;
  @override
  @JsonKey()
  final String name;
  @override
  final dynamic price;
  @override
  @JsonKey()
  final int count;
  @override
  @JsonKey()
  final String unit;
  @override
  final dynamic tax;
  @override
  final int? type;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'SubLineItemDataBill(id: $id, name: $name, price: $price, count: $count, unit: $unit, tax: $tax, type: $type)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'SubLineItemDataBill'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('name', name))
      ..add(DiagnosticsProperty('price', price))
      ..add(DiagnosticsProperty('count', count))
      ..add(DiagnosticsProperty('unit', unit))
      ..add(DiagnosticsProperty('tax', tax))
      ..add(DiagnosticsProperty('type', type));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SubLineItemDataBillImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            const DeepCollectionEquality().equals(other.price, price) &&
            (identical(other.count, count) || other.count == count) &&
            (identical(other.unit, unit) || other.unit == unit) &&
            const DeepCollectionEquality().equals(other.tax, tax) &&
            (identical(other.type, type) || other.type == type));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      const DeepCollectionEquality().hash(price),
      count,
      unit,
      const DeepCollectionEquality().hash(tax),
      type);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SubLineItemDataBillImplCopyWith<_$SubLineItemDataBillImpl> get copyWith =>
      __$$SubLineItemDataBillImplCopyWithImpl<_$SubLineItemDataBillImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SubLineItemDataBillImplToJson(
      this,
    );
  }
}

abstract class _SubLineItemDataBill extends SubLineItemDataBill {
  const factory _SubLineItemDataBill(
      {final int id,
      final String name,
      final dynamic price,
      final int count,
      final String unit,
      final dynamic tax,
      final int? type}) = _$SubLineItemDataBillImpl;
  const _SubLineItemDataBill._() : super._();

  factory _SubLineItemDataBill.fromJson(Map<String, dynamic> json) =
      _$SubLineItemDataBillImpl.fromJson;

  @override
  int get id;
  @override
  String get name;
  @override
  dynamic get price;
  @override
  int get count;
  @override
  String get unit;
  @override
  dynamic get tax;
  @override
  int? get type;
  @override
  @JsonKey(ignore: true)
  _$$SubLineItemDataBillImplCopyWith<_$SubLineItemDataBillImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PaymentDataBillCheck _$PaymentDataBillCheckFromJson(Map<String, dynamic> json) {
  return _PaymentDataBillCheck.fromJson(json);
}

/// @nodoc
mixin _$PaymentDataBillCheck {
  String get notes => throw _privateConstructorUsedError;
  double get totalPayment => throw _privateConstructorUsedError;
  double get paymentQrCode => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PaymentDataBillCheckCopyWith<PaymentDataBillCheck> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PaymentDataBillCheckCopyWith<$Res> {
  factory $PaymentDataBillCheckCopyWith(PaymentDataBillCheck value,
          $Res Function(PaymentDataBillCheck) then) =
      _$PaymentDataBillCheckCopyWithImpl<$Res, PaymentDataBillCheck>;
  @useResult
  $Res call({String notes, double totalPayment, double paymentQrCode});
}

/// @nodoc
class _$PaymentDataBillCheckCopyWithImpl<$Res,
        $Val extends PaymentDataBillCheck>
    implements $PaymentDataBillCheckCopyWith<$Res> {
  _$PaymentDataBillCheckCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? notes = null,
    Object? totalPayment = null,
    Object? paymentQrCode = null,
  }) {
    return _then(_value.copyWith(
      notes: null == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String,
      totalPayment: null == totalPayment
          ? _value.totalPayment
          : totalPayment // ignore: cast_nullable_to_non_nullable
              as double,
      paymentQrCode: null == paymentQrCode
          ? _value.paymentQrCode
          : paymentQrCode // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PaymentDataBillCheckImplCopyWith<$Res>
    implements $PaymentDataBillCheckCopyWith<$Res> {
  factory _$$PaymentDataBillCheckImplCopyWith(_$PaymentDataBillCheckImpl value,
          $Res Function(_$PaymentDataBillCheckImpl) then) =
      __$$PaymentDataBillCheckImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String notes, double totalPayment, double paymentQrCode});
}

/// @nodoc
class __$$PaymentDataBillCheckImplCopyWithImpl<$Res>
    extends _$PaymentDataBillCheckCopyWithImpl<$Res, _$PaymentDataBillCheckImpl>
    implements _$$PaymentDataBillCheckImplCopyWith<$Res> {
  __$$PaymentDataBillCheckImplCopyWithImpl(_$PaymentDataBillCheckImpl _value,
      $Res Function(_$PaymentDataBillCheckImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? notes = null,
    Object? totalPayment = null,
    Object? paymentQrCode = null,
  }) {
    return _then(_$PaymentDataBillCheckImpl(
      notes: null == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String,
      totalPayment: null == totalPayment
          ? _value.totalPayment
          : totalPayment // ignore: cast_nullable_to_non_nullable
              as double,
      paymentQrCode: null == paymentQrCode
          ? _value.paymentQrCode
          : paymentQrCode // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class _$PaymentDataBillCheckImpl extends _PaymentDataBillCheck
    with DiagnosticableTreeMixin {
  const _$PaymentDataBillCheckImpl(
      {this.notes = '', this.totalPayment = 0, this.paymentQrCode = 0})
      : super._();

  factory _$PaymentDataBillCheckImpl.fromJson(Map<String, dynamic> json) =>
      _$$PaymentDataBillCheckImplFromJson(json);

  @override
  @JsonKey()
  final String notes;
  @override
  @JsonKey()
  final double totalPayment;
  @override
  @JsonKey()
  final double paymentQrCode;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'PaymentDataBillCheck(notes: $notes, totalPayment: $totalPayment, paymentQrCode: $paymentQrCode)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'PaymentDataBillCheck'))
      ..add(DiagnosticsProperty('notes', notes))
      ..add(DiagnosticsProperty('totalPayment', totalPayment))
      ..add(DiagnosticsProperty('paymentQrCode', paymentQrCode));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PaymentDataBillCheckImpl &&
            (identical(other.notes, notes) || other.notes == notes) &&
            (identical(other.totalPayment, totalPayment) ||
                other.totalPayment == totalPayment) &&
            (identical(other.paymentQrCode, paymentQrCode) ||
                other.paymentQrCode == paymentQrCode));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, notes, totalPayment, paymentQrCode);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PaymentDataBillCheckImplCopyWith<_$PaymentDataBillCheckImpl>
      get copyWith =>
          __$$PaymentDataBillCheckImplCopyWithImpl<_$PaymentDataBillCheckImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PaymentDataBillCheckImplToJson(
      this,
    );
  }
}

abstract class _PaymentDataBillCheck extends PaymentDataBillCheck {
  const factory _PaymentDataBillCheck(
      {final String notes,
      final double totalPayment,
      final double paymentQrCode}) = _$PaymentDataBillCheckImpl;
  const _PaymentDataBillCheck._() : super._();

  factory _PaymentDataBillCheck.fromJson(Map<String, dynamic> json) =
      _$PaymentDataBillCheckImpl.fromJson;

  @override
  String get notes;
  @override
  double get totalPayment;
  @override
  double get paymentQrCode;
  @override
  @JsonKey(ignore: true)
  _$$PaymentDataBillCheckImplCopyWith<_$PaymentDataBillCheckImpl>
      get copyWith => throw _privateConstructorUsedError;
}

ProductCheckoutUpdateTaxModel _$ProductCheckoutUpdateTaxModelFromJson(
    Map<String, dynamic> json) {
  return _ProductCheckoutUpdateTaxModel.fromJson(json);
}

/// @nodoc
mixin _$ProductCheckoutUpdateTaxModel {
  int get menuItemId => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get unit => throw _privateConstructorUsedError;
  String get codeProduct => throw _privateConstructorUsedError;
  double get tax => throw _privateConstructorUsedError;
  String get unitPrice => throw _privateConstructorUsedError;
  double get priceAfterDiscount => throw _privateConstructorUsedError;
  String get quantity => throw _privateConstructorUsedError;
  double get priceNew => throw _privateConstructorUsedError;
  double get priceTax => throw _privateConstructorUsedError;
  double get total => throw _privateConstructorUsedError;
  double get discount => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ProductCheckoutUpdateTaxModelCopyWith<ProductCheckoutUpdateTaxModel>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProductCheckoutUpdateTaxModelCopyWith<$Res> {
  factory $ProductCheckoutUpdateTaxModelCopyWith(
          ProductCheckoutUpdateTaxModel value,
          $Res Function(ProductCheckoutUpdateTaxModel) then) =
      _$ProductCheckoutUpdateTaxModelCopyWithImpl<$Res,
          ProductCheckoutUpdateTaxModel>;
  @useResult
  $Res call(
      {int menuItemId,
      String name,
      String unit,
      String codeProduct,
      double tax,
      String unitPrice,
      double priceAfterDiscount,
      String quantity,
      double priceNew,
      double priceTax,
      double total,
      double discount});
}

/// @nodoc
class _$ProductCheckoutUpdateTaxModelCopyWithImpl<$Res,
        $Val extends ProductCheckoutUpdateTaxModel>
    implements $ProductCheckoutUpdateTaxModelCopyWith<$Res> {
  _$ProductCheckoutUpdateTaxModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? menuItemId = null,
    Object? name = null,
    Object? unit = null,
    Object? codeProduct = null,
    Object? tax = null,
    Object? unitPrice = null,
    Object? priceAfterDiscount = null,
    Object? quantity = null,
    Object? priceNew = null,
    Object? priceTax = null,
    Object? total = null,
    Object? discount = null,
  }) {
    return _then(_value.copyWith(
      menuItemId: null == menuItemId
          ? _value.menuItemId
          : menuItemId // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      unit: null == unit
          ? _value.unit
          : unit // ignore: cast_nullable_to_non_nullable
              as String,
      codeProduct: null == codeProduct
          ? _value.codeProduct
          : codeProduct // ignore: cast_nullable_to_non_nullable
              as String,
      tax: null == tax
          ? _value.tax
          : tax // ignore: cast_nullable_to_non_nullable
              as double,
      unitPrice: null == unitPrice
          ? _value.unitPrice
          : unitPrice // ignore: cast_nullable_to_non_nullable
              as String,
      priceAfterDiscount: null == priceAfterDiscount
          ? _value.priceAfterDiscount
          : priceAfterDiscount // ignore: cast_nullable_to_non_nullable
              as double,
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as String,
      priceNew: null == priceNew
          ? _value.priceNew
          : priceNew // ignore: cast_nullable_to_non_nullable
              as double,
      priceTax: null == priceTax
          ? _value.priceTax
          : priceTax // ignore: cast_nullable_to_non_nullable
              as double,
      total: null == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as double,
      discount: null == discount
          ? _value.discount
          : discount // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ProductCheckoutUpdateTaxModelImplCopyWith<$Res>
    implements $ProductCheckoutUpdateTaxModelCopyWith<$Res> {
  factory _$$ProductCheckoutUpdateTaxModelImplCopyWith(
          _$ProductCheckoutUpdateTaxModelImpl value,
          $Res Function(_$ProductCheckoutUpdateTaxModelImpl) then) =
      __$$ProductCheckoutUpdateTaxModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int menuItemId,
      String name,
      String unit,
      String codeProduct,
      double tax,
      String unitPrice,
      double priceAfterDiscount,
      String quantity,
      double priceNew,
      double priceTax,
      double total,
      double discount});
}

/// @nodoc
class __$$ProductCheckoutUpdateTaxModelImplCopyWithImpl<$Res>
    extends _$ProductCheckoutUpdateTaxModelCopyWithImpl<$Res,
        _$ProductCheckoutUpdateTaxModelImpl>
    implements _$$ProductCheckoutUpdateTaxModelImplCopyWith<$Res> {
  __$$ProductCheckoutUpdateTaxModelImplCopyWithImpl(
      _$ProductCheckoutUpdateTaxModelImpl _value,
      $Res Function(_$ProductCheckoutUpdateTaxModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? menuItemId = null,
    Object? name = null,
    Object? unit = null,
    Object? codeProduct = null,
    Object? tax = null,
    Object? unitPrice = null,
    Object? priceAfterDiscount = null,
    Object? quantity = null,
    Object? priceNew = null,
    Object? priceTax = null,
    Object? total = null,
    Object? discount = null,
  }) {
    return _then(_$ProductCheckoutUpdateTaxModelImpl(
      menuItemId: null == menuItemId
          ? _value.menuItemId
          : menuItemId // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      unit: null == unit
          ? _value.unit
          : unit // ignore: cast_nullable_to_non_nullable
              as String,
      codeProduct: null == codeProduct
          ? _value.codeProduct
          : codeProduct // ignore: cast_nullable_to_non_nullable
              as String,
      tax: null == tax
          ? _value.tax
          : tax // ignore: cast_nullable_to_non_nullable
              as double,
      unitPrice: null == unitPrice
          ? _value.unitPrice
          : unitPrice // ignore: cast_nullable_to_non_nullable
              as String,
      priceAfterDiscount: null == priceAfterDiscount
          ? _value.priceAfterDiscount
          : priceAfterDiscount // ignore: cast_nullable_to_non_nullable
              as double,
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as String,
      priceNew: null == priceNew
          ? _value.priceNew
          : priceNew // ignore: cast_nullable_to_non_nullable
              as double,
      priceTax: null == priceTax
          ? _value.priceTax
          : priceTax // ignore: cast_nullable_to_non_nullable
              as double,
      total: null == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as double,
      discount: null == discount
          ? _value.discount
          : discount // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class _$ProductCheckoutUpdateTaxModelImpl extends _ProductCheckoutUpdateTaxModel
    with DiagnosticableTreeMixin {
  const _$ProductCheckoutUpdateTaxModelImpl(
      {this.menuItemId = 0,
      this.name = '',
      this.unit = '',
      this.codeProduct = '',
      this.tax = 0,
      this.unitPrice = '',
      this.priceAfterDiscount = 0,
      this.quantity = '0',
      this.priceNew = 0,
      this.priceTax = 0,
      this.total = 0,
      this.discount = 0})
      : super._();

  factory _$ProductCheckoutUpdateTaxModelImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$ProductCheckoutUpdateTaxModelImplFromJson(json);

  @override
  @JsonKey()
  final int menuItemId;
  @override
  @JsonKey()
  final String name;
  @override
  @JsonKey()
  final String unit;
  @override
  @JsonKey()
  final String codeProduct;
  @override
  @JsonKey()
  final double tax;
  @override
  @JsonKey()
  final String unitPrice;
  @override
  @JsonKey()
  final double priceAfterDiscount;
  @override
  @JsonKey()
  final String quantity;
  @override
  @JsonKey()
  final double priceNew;
  @override
  @JsonKey()
  final double priceTax;
  @override
  @JsonKey()
  final double total;
  @override
  @JsonKey()
  final double discount;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ProductCheckoutUpdateTaxModel(menuItemId: $menuItemId, name: $name, unit: $unit, codeProduct: $codeProduct, tax: $tax, unitPrice: $unitPrice, priceAfterDiscount: $priceAfterDiscount, quantity: $quantity, priceNew: $priceNew, priceTax: $priceTax, total: $total, discount: $discount)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'ProductCheckoutUpdateTaxModel'))
      ..add(DiagnosticsProperty('menuItemId', menuItemId))
      ..add(DiagnosticsProperty('name', name))
      ..add(DiagnosticsProperty('unit', unit))
      ..add(DiagnosticsProperty('codeProduct', codeProduct))
      ..add(DiagnosticsProperty('tax', tax))
      ..add(DiagnosticsProperty('unitPrice', unitPrice))
      ..add(DiagnosticsProperty('priceAfterDiscount', priceAfterDiscount))
      ..add(DiagnosticsProperty('quantity', quantity))
      ..add(DiagnosticsProperty('priceNew', priceNew))
      ..add(DiagnosticsProperty('priceTax', priceTax))
      ..add(DiagnosticsProperty('total', total))
      ..add(DiagnosticsProperty('discount', discount));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProductCheckoutUpdateTaxModelImpl &&
            (identical(other.menuItemId, menuItemId) ||
                other.menuItemId == menuItemId) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.unit, unit) || other.unit == unit) &&
            (identical(other.codeProduct, codeProduct) ||
                other.codeProduct == codeProduct) &&
            (identical(other.tax, tax) || other.tax == tax) &&
            (identical(other.unitPrice, unitPrice) ||
                other.unitPrice == unitPrice) &&
            (identical(other.priceAfterDiscount, priceAfterDiscount) ||
                other.priceAfterDiscount == priceAfterDiscount) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity) &&
            (identical(other.priceNew, priceNew) ||
                other.priceNew == priceNew) &&
            (identical(other.priceTax, priceTax) ||
                other.priceTax == priceTax) &&
            (identical(other.total, total) || other.total == total) &&
            (identical(other.discount, discount) ||
                other.discount == discount));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      menuItemId,
      name,
      unit,
      codeProduct,
      tax,
      unitPrice,
      priceAfterDiscount,
      quantity,
      priceNew,
      priceTax,
      total,
      discount);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ProductCheckoutUpdateTaxModelImplCopyWith<
          _$ProductCheckoutUpdateTaxModelImpl>
      get copyWith => __$$ProductCheckoutUpdateTaxModelImplCopyWithImpl<
          _$ProductCheckoutUpdateTaxModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ProductCheckoutUpdateTaxModelImplToJson(
      this,
    );
  }
}

abstract class _ProductCheckoutUpdateTaxModel
    extends ProductCheckoutUpdateTaxModel {
  const factory _ProductCheckoutUpdateTaxModel(
      {final int menuItemId,
      final String name,
      final String unit,
      final String codeProduct,
      final double tax,
      final String unitPrice,
      final double priceAfterDiscount,
      final String quantity,
      final double priceNew,
      final double priceTax,
      final double total,
      final double discount}) = _$ProductCheckoutUpdateTaxModelImpl;
  const _ProductCheckoutUpdateTaxModel._() : super._();

  factory _ProductCheckoutUpdateTaxModel.fromJson(Map<String, dynamic> json) =
      _$ProductCheckoutUpdateTaxModelImpl.fromJson;

  @override
  int get menuItemId;
  @override
  String get name;
  @override
  String get unit;
  @override
  String get codeProduct;
  @override
  double get tax;
  @override
  String get unitPrice;
  @override
  double get priceAfterDiscount;
  @override
  String get quantity;
  @override
  double get priceNew;
  @override
  double get priceTax;
  @override
  double get total;
  @override
  double get discount;
  @override
  @JsonKey(ignore: true)
  _$$ProductCheckoutUpdateTaxModelImplCopyWith<
          _$ProductCheckoutUpdateTaxModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}
