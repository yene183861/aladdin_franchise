// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'close_shift.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

CloseShiftResponseModel _$CloseShiftResponseModelFromJson(
    Map<String, dynamic> json) {
  return _CloseShiftResponseModel.fromJson(json);
}

/// @nodoc
mixin _$CloseShiftResponseModel {
  @JsonKey(name: 'infoPrint')
  IpOrderModel? get infoPrint => throw _privateConstructorUsedError;
  DateTime? get openShift => throw _privateConstructorUsedError;
  DateTime? get lockShift => throw _privateConstructorUsedError;
  String get shiftName => throw _privateConstructorUsedError;
  double get openingBalances => throw _privateConstructorUsedError;
  double get totalAmount => throw _privateConstructorUsedError;
  double get discountMoney => throw _privateConstructorUsedError;
  double get percentBill => throw _privateConstructorUsedError;
  int get countInvoice => throw _privateConstructorUsedError;
  double get endofshiftBalance => throw _privateConstructorUsedError;
  String get cashierName => throw _privateConstructorUsedError;
  dynamic get totalPayment => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CloseShiftResponseModelCopyWith<CloseShiftResponseModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CloseShiftResponseModelCopyWith<$Res> {
  factory $CloseShiftResponseModelCopyWith(CloseShiftResponseModel value,
          $Res Function(CloseShiftResponseModel) then) =
      _$CloseShiftResponseModelCopyWithImpl<$Res, CloseShiftResponseModel>;
  @useResult
  $Res call(
      {@JsonKey(name: 'infoPrint') IpOrderModel? infoPrint,
      DateTime? openShift,
      DateTime? lockShift,
      String shiftName,
      double openingBalances,
      double totalAmount,
      double discountMoney,
      double percentBill,
      int countInvoice,
      double endofshiftBalance,
      String cashierName,
      dynamic totalPayment});

  $IpOrderModelCopyWith<$Res>? get infoPrint;
}

/// @nodoc
class _$CloseShiftResponseModelCopyWithImpl<$Res,
        $Val extends CloseShiftResponseModel>
    implements $CloseShiftResponseModelCopyWith<$Res> {
  _$CloseShiftResponseModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? infoPrint = freezed,
    Object? openShift = freezed,
    Object? lockShift = freezed,
    Object? shiftName = null,
    Object? openingBalances = null,
    Object? totalAmount = null,
    Object? discountMoney = null,
    Object? percentBill = null,
    Object? countInvoice = null,
    Object? endofshiftBalance = null,
    Object? cashierName = null,
    Object? totalPayment = freezed,
  }) {
    return _then(_value.copyWith(
      infoPrint: freezed == infoPrint
          ? _value.infoPrint
          : infoPrint // ignore: cast_nullable_to_non_nullable
              as IpOrderModel?,
      openShift: freezed == openShift
          ? _value.openShift
          : openShift // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      lockShift: freezed == lockShift
          ? _value.lockShift
          : lockShift // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      shiftName: null == shiftName
          ? _value.shiftName
          : shiftName // ignore: cast_nullable_to_non_nullable
              as String,
      openingBalances: null == openingBalances
          ? _value.openingBalances
          : openingBalances // ignore: cast_nullable_to_non_nullable
              as double,
      totalAmount: null == totalAmount
          ? _value.totalAmount
          : totalAmount // ignore: cast_nullable_to_non_nullable
              as double,
      discountMoney: null == discountMoney
          ? _value.discountMoney
          : discountMoney // ignore: cast_nullable_to_non_nullable
              as double,
      percentBill: null == percentBill
          ? _value.percentBill
          : percentBill // ignore: cast_nullable_to_non_nullable
              as double,
      countInvoice: null == countInvoice
          ? _value.countInvoice
          : countInvoice // ignore: cast_nullable_to_non_nullable
              as int,
      endofshiftBalance: null == endofshiftBalance
          ? _value.endofshiftBalance
          : endofshiftBalance // ignore: cast_nullable_to_non_nullable
              as double,
      cashierName: null == cashierName
          ? _value.cashierName
          : cashierName // ignore: cast_nullable_to_non_nullable
              as String,
      totalPayment: freezed == totalPayment
          ? _value.totalPayment
          : totalPayment // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $IpOrderModelCopyWith<$Res>? get infoPrint {
    if (_value.infoPrint == null) {
      return null;
    }

    return $IpOrderModelCopyWith<$Res>(_value.infoPrint!, (value) {
      return _then(_value.copyWith(infoPrint: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$CloseShiftResponseModelImplCopyWith<$Res>
    implements $CloseShiftResponseModelCopyWith<$Res> {
  factory _$$CloseShiftResponseModelImplCopyWith(
          _$CloseShiftResponseModelImpl value,
          $Res Function(_$CloseShiftResponseModelImpl) then) =
      __$$CloseShiftResponseModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'infoPrint') IpOrderModel? infoPrint,
      DateTime? openShift,
      DateTime? lockShift,
      String shiftName,
      double openingBalances,
      double totalAmount,
      double discountMoney,
      double percentBill,
      int countInvoice,
      double endofshiftBalance,
      String cashierName,
      dynamic totalPayment});

  @override
  $IpOrderModelCopyWith<$Res>? get infoPrint;
}

/// @nodoc
class __$$CloseShiftResponseModelImplCopyWithImpl<$Res>
    extends _$CloseShiftResponseModelCopyWithImpl<$Res,
        _$CloseShiftResponseModelImpl>
    implements _$$CloseShiftResponseModelImplCopyWith<$Res> {
  __$$CloseShiftResponseModelImplCopyWithImpl(
      _$CloseShiftResponseModelImpl _value,
      $Res Function(_$CloseShiftResponseModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? infoPrint = freezed,
    Object? openShift = freezed,
    Object? lockShift = freezed,
    Object? shiftName = null,
    Object? openingBalances = null,
    Object? totalAmount = null,
    Object? discountMoney = null,
    Object? percentBill = null,
    Object? countInvoice = null,
    Object? endofshiftBalance = null,
    Object? cashierName = null,
    Object? totalPayment = freezed,
  }) {
    return _then(_$CloseShiftResponseModelImpl(
      infoPrint: freezed == infoPrint
          ? _value.infoPrint
          : infoPrint // ignore: cast_nullable_to_non_nullable
              as IpOrderModel?,
      openShift: freezed == openShift
          ? _value.openShift
          : openShift // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      lockShift: freezed == lockShift
          ? _value.lockShift
          : lockShift // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      shiftName: null == shiftName
          ? _value.shiftName
          : shiftName // ignore: cast_nullable_to_non_nullable
              as String,
      openingBalances: null == openingBalances
          ? _value.openingBalances
          : openingBalances // ignore: cast_nullable_to_non_nullable
              as double,
      totalAmount: null == totalAmount
          ? _value.totalAmount
          : totalAmount // ignore: cast_nullable_to_non_nullable
              as double,
      discountMoney: null == discountMoney
          ? _value.discountMoney
          : discountMoney // ignore: cast_nullable_to_non_nullable
              as double,
      percentBill: null == percentBill
          ? _value.percentBill
          : percentBill // ignore: cast_nullable_to_non_nullable
              as double,
      countInvoice: null == countInvoice
          ? _value.countInvoice
          : countInvoice // ignore: cast_nullable_to_non_nullable
              as int,
      endofshiftBalance: null == endofshiftBalance
          ? _value.endofshiftBalance
          : endofshiftBalance // ignore: cast_nullable_to_non_nullable
              as double,
      cashierName: null == cashierName
          ? _value.cashierName
          : cashierName // ignore: cast_nullable_to_non_nullable
              as String,
      totalPayment: freezed == totalPayment
          ? _value.totalPayment
          : totalPayment // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class _$CloseShiftResponseModelImpl implements _CloseShiftResponseModel {
  const _$CloseShiftResponseModelImpl(
      {@JsonKey(name: 'infoPrint') this.infoPrint,
      this.openShift,
      this.lockShift,
      this.shiftName = '',
      this.openingBalances = 0,
      this.totalAmount = 0,
      this.discountMoney = 0,
      this.percentBill = 0,
      this.countInvoice = 0,
      this.endofshiftBalance = 0,
      this.cashierName = '',
      this.totalPayment});

  factory _$CloseShiftResponseModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$CloseShiftResponseModelImplFromJson(json);

  @override
  @JsonKey(name: 'infoPrint')
  final IpOrderModel? infoPrint;
  @override
  final DateTime? openShift;
  @override
  final DateTime? lockShift;
  @override
  @JsonKey()
  final String shiftName;
  @override
  @JsonKey()
  final double openingBalances;
  @override
  @JsonKey()
  final double totalAmount;
  @override
  @JsonKey()
  final double discountMoney;
  @override
  @JsonKey()
  final double percentBill;
  @override
  @JsonKey()
  final int countInvoice;
  @override
  @JsonKey()
  final double endofshiftBalance;
  @override
  @JsonKey()
  final String cashierName;
  @override
  final dynamic totalPayment;

  @override
  String toString() {
    return 'CloseShiftResponseModel(infoPrint: $infoPrint, openShift: $openShift, lockShift: $lockShift, shiftName: $shiftName, openingBalances: $openingBalances, totalAmount: $totalAmount, discountMoney: $discountMoney, percentBill: $percentBill, countInvoice: $countInvoice, endofshiftBalance: $endofshiftBalance, cashierName: $cashierName, totalPayment: $totalPayment)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CloseShiftResponseModelImpl &&
            (identical(other.infoPrint, infoPrint) ||
                other.infoPrint == infoPrint) &&
            (identical(other.openShift, openShift) ||
                other.openShift == openShift) &&
            (identical(other.lockShift, lockShift) ||
                other.lockShift == lockShift) &&
            (identical(other.shiftName, shiftName) ||
                other.shiftName == shiftName) &&
            (identical(other.openingBalances, openingBalances) ||
                other.openingBalances == openingBalances) &&
            (identical(other.totalAmount, totalAmount) ||
                other.totalAmount == totalAmount) &&
            (identical(other.discountMoney, discountMoney) ||
                other.discountMoney == discountMoney) &&
            (identical(other.percentBill, percentBill) ||
                other.percentBill == percentBill) &&
            (identical(other.countInvoice, countInvoice) ||
                other.countInvoice == countInvoice) &&
            (identical(other.endofshiftBalance, endofshiftBalance) ||
                other.endofshiftBalance == endofshiftBalance) &&
            (identical(other.cashierName, cashierName) ||
                other.cashierName == cashierName) &&
            const DeepCollectionEquality()
                .equals(other.totalPayment, totalPayment));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      infoPrint,
      openShift,
      lockShift,
      shiftName,
      openingBalances,
      totalAmount,
      discountMoney,
      percentBill,
      countInvoice,
      endofshiftBalance,
      cashierName,
      const DeepCollectionEquality().hash(totalPayment));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CloseShiftResponseModelImplCopyWith<_$CloseShiftResponseModelImpl>
      get copyWith => __$$CloseShiftResponseModelImplCopyWithImpl<
          _$CloseShiftResponseModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CloseShiftResponseModelImplToJson(
      this,
    );
  }
}

abstract class _CloseShiftResponseModel implements CloseShiftResponseModel {
  const factory _CloseShiftResponseModel(
      {@JsonKey(name: 'infoPrint') final IpOrderModel? infoPrint,
      final DateTime? openShift,
      final DateTime? lockShift,
      final String shiftName,
      final double openingBalances,
      final double totalAmount,
      final double discountMoney,
      final double percentBill,
      final int countInvoice,
      final double endofshiftBalance,
      final String cashierName,
      final dynamic totalPayment}) = _$CloseShiftResponseModelImpl;

  factory _CloseShiftResponseModel.fromJson(Map<String, dynamic> json) =
      _$CloseShiftResponseModelImpl.fromJson;

  @override
  @JsonKey(name: 'infoPrint')
  IpOrderModel? get infoPrint;
  @override
  DateTime? get openShift;
  @override
  DateTime? get lockShift;
  @override
  String get shiftName;
  @override
  double get openingBalances;
  @override
  double get totalAmount;
  @override
  double get discountMoney;
  @override
  double get percentBill;
  @override
  int get countInvoice;
  @override
  double get endofshiftBalance;
  @override
  String get cashierName;
  @override
  dynamic get totalPayment;
  @override
  @JsonKey(ignore: true)
  _$$CloseShiftResponseModelImplCopyWith<_$CloseShiftResponseModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}
