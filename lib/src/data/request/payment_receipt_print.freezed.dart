// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'payment_receipt_print.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

PaymentReceiptPrintRequest _$PaymentReceiptPrintRequestFromJson(
    Map<String, dynamic> json) {
  return _PaymentReceiptPrintRequest.fromJson(json);
}

/// @nodoc
mixin _$PaymentReceiptPrintRequest {
  OrderModel get order => throw _privateConstructorUsedError;
  PriceDataBill get price => throw _privateConstructorUsedError;
  ReceiptTypeEnum get receiptType => throw _privateConstructorUsedError;
  PaymentMethod? get paymentMethod => throw _privateConstructorUsedError;
  double get paymentAmount => throw _privateConstructorUsedError;
  int get numberPrintCompleted => throw _privateConstructorUsedError;
  int get numberPrintTemporary => throw _privateConstructorUsedError;
  List<LineItemDataBill> get orderLineItems =>
      throw _privateConstructorUsedError;
  List<HistoryPolicyResultModel> get vouchers =>
      throw _privateConstructorUsedError;
  String get note => throw _privateConstructorUsedError;
  bool get printNumberOfPeople => throw _privateConstructorUsedError;
  String get customerPhone => throw _privateConstructorUsedError;
  int get numberOfPeople => throw _privateConstructorUsedError;
  String get cashierCompleted => throw _privateConstructorUsedError;
  String get cashierPrint => throw _privateConstructorUsedError;
  DateTime? get timeCompleted => throw _privateConstructorUsedError;
  DateTime? get timeCreatedAt => throw _privateConstructorUsedError;
  String get invoiceQr => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PaymentReceiptPrintRequestCopyWith<PaymentReceiptPrintRequest>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PaymentReceiptPrintRequestCopyWith<$Res> {
  factory $PaymentReceiptPrintRequestCopyWith(PaymentReceiptPrintRequest value,
          $Res Function(PaymentReceiptPrintRequest) then) =
      _$PaymentReceiptPrintRequestCopyWithImpl<$Res,
          PaymentReceiptPrintRequest>;
  @useResult
  $Res call(
      {OrderModel order,
      PriceDataBill price,
      ReceiptTypeEnum receiptType,
      PaymentMethod? paymentMethod,
      double paymentAmount,
      int numberPrintCompleted,
      int numberPrintTemporary,
      List<LineItemDataBill> orderLineItems,
      List<HistoryPolicyResultModel> vouchers,
      String note,
      bool printNumberOfPeople,
      String customerPhone,
      int numberOfPeople,
      String cashierCompleted,
      String cashierPrint,
      DateTime? timeCompleted,
      DateTime? timeCreatedAt,
      String invoiceQr});

  $OrderModelCopyWith<$Res> get order;
  $PriceDataBillCopyWith<$Res> get price;
  $PaymentMethodCopyWith<$Res>? get paymentMethod;
}

/// @nodoc
class _$PaymentReceiptPrintRequestCopyWithImpl<$Res,
        $Val extends PaymentReceiptPrintRequest>
    implements $PaymentReceiptPrintRequestCopyWith<$Res> {
  _$PaymentReceiptPrintRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? order = null,
    Object? price = null,
    Object? receiptType = null,
    Object? paymentMethod = freezed,
    Object? paymentAmount = null,
    Object? numberPrintCompleted = null,
    Object? numberPrintTemporary = null,
    Object? orderLineItems = null,
    Object? vouchers = null,
    Object? note = null,
    Object? printNumberOfPeople = null,
    Object? customerPhone = null,
    Object? numberOfPeople = null,
    Object? cashierCompleted = null,
    Object? cashierPrint = null,
    Object? timeCompleted = freezed,
    Object? timeCreatedAt = freezed,
    Object? invoiceQr = null,
  }) {
    return _then(_value.copyWith(
      order: null == order
          ? _value.order
          : order // ignore: cast_nullable_to_non_nullable
              as OrderModel,
      price: null == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as PriceDataBill,
      receiptType: null == receiptType
          ? _value.receiptType
          : receiptType // ignore: cast_nullable_to_non_nullable
              as ReceiptTypeEnum,
      paymentMethod: freezed == paymentMethod
          ? _value.paymentMethod
          : paymentMethod // ignore: cast_nullable_to_non_nullable
              as PaymentMethod?,
      paymentAmount: null == paymentAmount
          ? _value.paymentAmount
          : paymentAmount // ignore: cast_nullable_to_non_nullable
              as double,
      numberPrintCompleted: null == numberPrintCompleted
          ? _value.numberPrintCompleted
          : numberPrintCompleted // ignore: cast_nullable_to_non_nullable
              as int,
      numberPrintTemporary: null == numberPrintTemporary
          ? _value.numberPrintTemporary
          : numberPrintTemporary // ignore: cast_nullable_to_non_nullable
              as int,
      orderLineItems: null == orderLineItems
          ? _value.orderLineItems
          : orderLineItems // ignore: cast_nullable_to_non_nullable
              as List<LineItemDataBill>,
      vouchers: null == vouchers
          ? _value.vouchers
          : vouchers // ignore: cast_nullable_to_non_nullable
              as List<HistoryPolicyResultModel>,
      note: null == note
          ? _value.note
          : note // ignore: cast_nullable_to_non_nullable
              as String,
      printNumberOfPeople: null == printNumberOfPeople
          ? _value.printNumberOfPeople
          : printNumberOfPeople // ignore: cast_nullable_to_non_nullable
              as bool,
      customerPhone: null == customerPhone
          ? _value.customerPhone
          : customerPhone // ignore: cast_nullable_to_non_nullable
              as String,
      numberOfPeople: null == numberOfPeople
          ? _value.numberOfPeople
          : numberOfPeople // ignore: cast_nullable_to_non_nullable
              as int,
      cashierCompleted: null == cashierCompleted
          ? _value.cashierCompleted
          : cashierCompleted // ignore: cast_nullable_to_non_nullable
              as String,
      cashierPrint: null == cashierPrint
          ? _value.cashierPrint
          : cashierPrint // ignore: cast_nullable_to_non_nullable
              as String,
      timeCompleted: freezed == timeCompleted
          ? _value.timeCompleted
          : timeCompleted // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      timeCreatedAt: freezed == timeCreatedAt
          ? _value.timeCreatedAt
          : timeCreatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      invoiceQr: null == invoiceQr
          ? _value.invoiceQr
          : invoiceQr // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $OrderModelCopyWith<$Res> get order {
    return $OrderModelCopyWith<$Res>(_value.order, (value) {
      return _then(_value.copyWith(order: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $PriceDataBillCopyWith<$Res> get price {
    return $PriceDataBillCopyWith<$Res>(_value.price, (value) {
      return _then(_value.copyWith(price: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $PaymentMethodCopyWith<$Res>? get paymentMethod {
    if (_value.paymentMethod == null) {
      return null;
    }

    return $PaymentMethodCopyWith<$Res>(_value.paymentMethod!, (value) {
      return _then(_value.copyWith(paymentMethod: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$PaymentReceiptPrintRequestImplCopyWith<$Res>
    implements $PaymentReceiptPrintRequestCopyWith<$Res> {
  factory _$$PaymentReceiptPrintRequestImplCopyWith(
          _$PaymentReceiptPrintRequestImpl value,
          $Res Function(_$PaymentReceiptPrintRequestImpl) then) =
      __$$PaymentReceiptPrintRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {OrderModel order,
      PriceDataBill price,
      ReceiptTypeEnum receiptType,
      PaymentMethod? paymentMethod,
      double paymentAmount,
      int numberPrintCompleted,
      int numberPrintTemporary,
      List<LineItemDataBill> orderLineItems,
      List<HistoryPolicyResultModel> vouchers,
      String note,
      bool printNumberOfPeople,
      String customerPhone,
      int numberOfPeople,
      String cashierCompleted,
      String cashierPrint,
      DateTime? timeCompleted,
      DateTime? timeCreatedAt,
      String invoiceQr});

  @override
  $OrderModelCopyWith<$Res> get order;
  @override
  $PriceDataBillCopyWith<$Res> get price;
  @override
  $PaymentMethodCopyWith<$Res>? get paymentMethod;
}

/// @nodoc
class __$$PaymentReceiptPrintRequestImplCopyWithImpl<$Res>
    extends _$PaymentReceiptPrintRequestCopyWithImpl<$Res,
        _$PaymentReceiptPrintRequestImpl>
    implements _$$PaymentReceiptPrintRequestImplCopyWith<$Res> {
  __$$PaymentReceiptPrintRequestImplCopyWithImpl(
      _$PaymentReceiptPrintRequestImpl _value,
      $Res Function(_$PaymentReceiptPrintRequestImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? order = null,
    Object? price = null,
    Object? receiptType = null,
    Object? paymentMethod = freezed,
    Object? paymentAmount = null,
    Object? numberPrintCompleted = null,
    Object? numberPrintTemporary = null,
    Object? orderLineItems = null,
    Object? vouchers = null,
    Object? note = null,
    Object? printNumberOfPeople = null,
    Object? customerPhone = null,
    Object? numberOfPeople = null,
    Object? cashierCompleted = null,
    Object? cashierPrint = null,
    Object? timeCompleted = freezed,
    Object? timeCreatedAt = freezed,
    Object? invoiceQr = null,
  }) {
    return _then(_$PaymentReceiptPrintRequestImpl(
      order: null == order
          ? _value.order
          : order // ignore: cast_nullable_to_non_nullable
              as OrderModel,
      price: null == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as PriceDataBill,
      receiptType: null == receiptType
          ? _value.receiptType
          : receiptType // ignore: cast_nullable_to_non_nullable
              as ReceiptTypeEnum,
      paymentMethod: freezed == paymentMethod
          ? _value.paymentMethod
          : paymentMethod // ignore: cast_nullable_to_non_nullable
              as PaymentMethod?,
      paymentAmount: null == paymentAmount
          ? _value.paymentAmount
          : paymentAmount // ignore: cast_nullable_to_non_nullable
              as double,
      numberPrintCompleted: null == numberPrintCompleted
          ? _value.numberPrintCompleted
          : numberPrintCompleted // ignore: cast_nullable_to_non_nullable
              as int,
      numberPrintTemporary: null == numberPrintTemporary
          ? _value.numberPrintTemporary
          : numberPrintTemporary // ignore: cast_nullable_to_non_nullable
              as int,
      orderLineItems: null == orderLineItems
          ? _value._orderLineItems
          : orderLineItems // ignore: cast_nullable_to_non_nullable
              as List<LineItemDataBill>,
      vouchers: null == vouchers
          ? _value._vouchers
          : vouchers // ignore: cast_nullable_to_non_nullable
              as List<HistoryPolicyResultModel>,
      note: null == note
          ? _value.note
          : note // ignore: cast_nullable_to_non_nullable
              as String,
      printNumberOfPeople: null == printNumberOfPeople
          ? _value.printNumberOfPeople
          : printNumberOfPeople // ignore: cast_nullable_to_non_nullable
              as bool,
      customerPhone: null == customerPhone
          ? _value.customerPhone
          : customerPhone // ignore: cast_nullable_to_non_nullable
              as String,
      numberOfPeople: null == numberOfPeople
          ? _value.numberOfPeople
          : numberOfPeople // ignore: cast_nullable_to_non_nullable
              as int,
      cashierCompleted: null == cashierCompleted
          ? _value.cashierCompleted
          : cashierCompleted // ignore: cast_nullable_to_non_nullable
              as String,
      cashierPrint: null == cashierPrint
          ? _value.cashierPrint
          : cashierPrint // ignore: cast_nullable_to_non_nullable
              as String,
      timeCompleted: freezed == timeCompleted
          ? _value.timeCompleted
          : timeCompleted // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      timeCreatedAt: freezed == timeCreatedAt
          ? _value.timeCreatedAt
          : timeCreatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      invoiceQr: null == invoiceQr
          ? _value.invoiceQr
          : invoiceQr // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class _$PaymentReceiptPrintRequestImpl extends _PaymentReceiptPrintRequest {
  _$PaymentReceiptPrintRequestImpl(
      {required this.order,
      this.price = const PriceDataBill(),
      this.receiptType = ReceiptTypeEnum.paymentReceipt,
      this.paymentMethod,
      this.paymentAmount = 0.0,
      this.numberPrintCompleted = 1,
      this.numberPrintTemporary = 0,
      final List<LineItemDataBill> orderLineItems = const [],
      final List<HistoryPolicyResultModel> vouchers = const [],
      this.note = '',
      this.printNumberOfPeople = false,
      this.customerPhone = '',
      this.numberOfPeople = 1,
      this.cashierCompleted = '',
      this.cashierPrint = '',
      this.timeCompleted,
      this.timeCreatedAt,
      this.invoiceQr = ''})
      : _orderLineItems = orderLineItems,
        _vouchers = vouchers,
        super._();

  factory _$PaymentReceiptPrintRequestImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$PaymentReceiptPrintRequestImplFromJson(json);

  @override
  final OrderModel order;
  @override
  @JsonKey()
  final PriceDataBill price;
  @override
  @JsonKey()
  final ReceiptTypeEnum receiptType;
  @override
  final PaymentMethod? paymentMethod;
  @override
  @JsonKey()
  final double paymentAmount;
  @override
  @JsonKey()
  final int numberPrintCompleted;
  @override
  @JsonKey()
  final int numberPrintTemporary;
  final List<LineItemDataBill> _orderLineItems;
  @override
  @JsonKey()
  List<LineItemDataBill> get orderLineItems {
    if (_orderLineItems is EqualUnmodifiableListView) return _orderLineItems;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_orderLineItems);
  }

  final List<HistoryPolicyResultModel> _vouchers;
  @override
  @JsonKey()
  List<HistoryPolicyResultModel> get vouchers {
    if (_vouchers is EqualUnmodifiableListView) return _vouchers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_vouchers);
  }

  @override
  @JsonKey()
  final String note;
  @override
  @JsonKey()
  final bool printNumberOfPeople;
  @override
  @JsonKey()
  final String customerPhone;
  @override
  @JsonKey()
  final int numberOfPeople;
  @override
  @JsonKey()
  final String cashierCompleted;
  @override
  @JsonKey()
  final String cashierPrint;
  @override
  final DateTime? timeCompleted;
  @override
  final DateTime? timeCreatedAt;
  @override
  @JsonKey()
  final String invoiceQr;

  @override
  String toString() {
    return 'PaymentReceiptPrintRequest(order: $order, price: $price, receiptType: $receiptType, paymentMethod: $paymentMethod, paymentAmount: $paymentAmount, numberPrintCompleted: $numberPrintCompleted, numberPrintTemporary: $numberPrintTemporary, orderLineItems: $orderLineItems, vouchers: $vouchers, note: $note, printNumberOfPeople: $printNumberOfPeople, customerPhone: $customerPhone, numberOfPeople: $numberOfPeople, cashierCompleted: $cashierCompleted, cashierPrint: $cashierPrint, timeCompleted: $timeCompleted, timeCreatedAt: $timeCreatedAt, invoiceQr: $invoiceQr)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PaymentReceiptPrintRequestImpl &&
            (identical(other.order, order) || other.order == order) &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.receiptType, receiptType) ||
                other.receiptType == receiptType) &&
            (identical(other.paymentMethod, paymentMethod) ||
                other.paymentMethod == paymentMethod) &&
            (identical(other.paymentAmount, paymentAmount) ||
                other.paymentAmount == paymentAmount) &&
            (identical(other.numberPrintCompleted, numberPrintCompleted) ||
                other.numberPrintCompleted == numberPrintCompleted) &&
            (identical(other.numberPrintTemporary, numberPrintTemporary) ||
                other.numberPrintTemporary == numberPrintTemporary) &&
            const DeepCollectionEquality()
                .equals(other._orderLineItems, _orderLineItems) &&
            const DeepCollectionEquality().equals(other._vouchers, _vouchers) &&
            (identical(other.note, note) || other.note == note) &&
            (identical(other.printNumberOfPeople, printNumberOfPeople) ||
                other.printNumberOfPeople == printNumberOfPeople) &&
            (identical(other.customerPhone, customerPhone) ||
                other.customerPhone == customerPhone) &&
            (identical(other.numberOfPeople, numberOfPeople) ||
                other.numberOfPeople == numberOfPeople) &&
            (identical(other.cashierCompleted, cashierCompleted) ||
                other.cashierCompleted == cashierCompleted) &&
            (identical(other.cashierPrint, cashierPrint) ||
                other.cashierPrint == cashierPrint) &&
            (identical(other.timeCompleted, timeCompleted) ||
                other.timeCompleted == timeCompleted) &&
            (identical(other.timeCreatedAt, timeCreatedAt) ||
                other.timeCreatedAt == timeCreatedAt) &&
            (identical(other.invoiceQr, invoiceQr) ||
                other.invoiceQr == invoiceQr));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      order,
      price,
      receiptType,
      paymentMethod,
      paymentAmount,
      numberPrintCompleted,
      numberPrintTemporary,
      const DeepCollectionEquality().hash(_orderLineItems),
      const DeepCollectionEquality().hash(_vouchers),
      note,
      printNumberOfPeople,
      customerPhone,
      numberOfPeople,
      cashierCompleted,
      cashierPrint,
      timeCompleted,
      timeCreatedAt,
      invoiceQr);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PaymentReceiptPrintRequestImplCopyWith<_$PaymentReceiptPrintRequestImpl>
      get copyWith => __$$PaymentReceiptPrintRequestImplCopyWithImpl<
          _$PaymentReceiptPrintRequestImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PaymentReceiptPrintRequestImplToJson(
      this,
    );
  }
}

abstract class _PaymentReceiptPrintRequest extends PaymentReceiptPrintRequest {
  factory _PaymentReceiptPrintRequest(
      {required final OrderModel order,
      final PriceDataBill price,
      final ReceiptTypeEnum receiptType,
      final PaymentMethod? paymentMethod,
      final double paymentAmount,
      final int numberPrintCompleted,
      final int numberPrintTemporary,
      final List<LineItemDataBill> orderLineItems,
      final List<HistoryPolicyResultModel> vouchers,
      final String note,
      final bool printNumberOfPeople,
      final String customerPhone,
      final int numberOfPeople,
      final String cashierCompleted,
      final String cashierPrint,
      final DateTime? timeCompleted,
      final DateTime? timeCreatedAt,
      final String invoiceQr}) = _$PaymentReceiptPrintRequestImpl;
  _PaymentReceiptPrintRequest._() : super._();

  factory _PaymentReceiptPrintRequest.fromJson(Map<String, dynamic> json) =
      _$PaymentReceiptPrintRequestImpl.fromJson;

  @override
  OrderModel get order;
  @override
  PriceDataBill get price;
  @override
  ReceiptTypeEnum get receiptType;
  @override
  PaymentMethod? get paymentMethod;
  @override
  double get paymentAmount;
  @override
  int get numberPrintCompleted;
  @override
  int get numberPrintTemporary;
  @override
  List<LineItemDataBill> get orderLineItems;
  @override
  List<HistoryPolicyResultModel> get vouchers;
  @override
  String get note;
  @override
  bool get printNumberOfPeople;
  @override
  String get customerPhone;
  @override
  int get numberOfPeople;
  @override
  String get cashierCompleted;
  @override
  String get cashierPrint;
  @override
  DateTime? get timeCompleted;
  @override
  DateTime? get timeCreatedAt;
  @override
  String get invoiceQr;
  @override
  @JsonKey(ignore: true)
  _$$PaymentReceiptPrintRequestImplCopyWith<_$PaymentReceiptPrintRequestImpl>
      get copyWith => throw _privateConstructorUsedError;
}
