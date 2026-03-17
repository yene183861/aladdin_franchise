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
  List<ProductCheckoutModel> get productsCheckout =>
      throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  Set<PrinterModel> get printerSelect => throw _privateConstructorUsedError;
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
      final Set<PrinterModel> printerSelect = const {},
      this.useDefaultPrinters = false})
      : _productsCheckout = productsCheckout,
        _printerSelect = printerSelect;

  final List<ProductCheckoutModel> _productsCheckout;
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
  final Set<PrinterModel> _printerSelect;
  @override
  @JsonKey()
  Set<PrinterModel> get printerSelect {
    if (_printerSelect is EqualUnmodifiableSetView) return _printerSelect;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableSetView(_printerSelect);
  }

  @override
  @JsonKey()
  final bool useDefaultPrinters;

  @override
  String toString() {
    return 'CheckoutPageState(productsCheckout: $productsCheckout, message: $message, printerSelect: $printerSelect, useDefaultPrinters: $useDefaultPrinters)';
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
                .equals(other._printerSelect, _printerSelect) &&
            (identical(other.useDefaultPrinters, useDefaultPrinters) ||
                other.useDefaultPrinters == useDefaultPrinters));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_productsCheckout),
      message,
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
      final Set<PrinterModel> printerSelect,
      final bool useDefaultPrinters}) = _$CheckoutPageStateImpl;

  @override
  List<ProductCheckoutModel> get productsCheckout;
  @override
  String get message;
  @override
  Set<PrinterModel> get printerSelect;
  @override
  bool get useDefaultPrinters;
  @override
  @JsonKey(ignore: true)
  _$$CheckoutPageStateImplCopyWith<_$CheckoutPageStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$CheckoutState {
  CheckoutEvent get event => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError; //
  List<ProductCheckoutModel> get productCheckout =>
      throw _privateConstructorUsedError;
  PageState get productCheckoutState => throw _privateConstructorUsedError;
  CustomerModel? get customer => throw _privateConstructorUsedError;
  List<OrderHistory> get orderHistory =>
      throw _privateConstructorUsedError; // invoice
  PageState get invoiceState => throw _privateConstructorUsedError;
  OrderInvoice? get invoice => throw _privateConstructorUsedError; // data bill
  PageState get dataBillState => throw _privateConstructorUsedError;
  DataBillResponseData get dataBill =>
      throw _privateConstructorUsedError; // coupons + voucher
  List<CustomerPolicyModel> get coupons => throw _privateConstructorUsedError;
  List<PolicyResultModel> get vouchers => throw _privateConstructorUsedError;
  dynamic get createVouchers => throw _privateConstructorUsedError;
  DiscountTypeEnum get discountTypeSelect => throw _privateConstructorUsedError;
  PageState get applyPolicyState => throw _privateConstructorUsedError;

  /// guest
  int get numberOfAdults => throw _privateConstructorUsedError;
  int get numberOfChildren => throw _privateConstructorUsedError;

  /// payment
// payment method
  List<PaymentMethod> get paymentMethods => throw _privateConstructorUsedError;
  PageState get paymentMethodState => throw _privateConstructorUsedError;
  PaymentMethod? get paymentMethodSelect =>
      throw _privateConstructorUsedError; // banks
  List<UserBankModel> get banks => throw _privateConstructorUsedError;
  PageState get banksState => throw _privateConstructorUsedError;
  UserBankModel? get bankSelect => throw _privateConstructorUsedError; // atm
  PageState get listAtmPosState => throw _privateConstructorUsedError;
  List<AtmPosModel> get listAtmPos => throw _privateConstructorUsedError;
  AtmPosModel? get atmPosSelect =>
      throw _privateConstructorUsedError; // gateway
  bool get statusPaymentGateway => throw _privateConstructorUsedError;
  dynamic get totalPaymentGateway =>
      throw _privateConstructorUsedError; // cash payment
  double get cashReceivedAmount =>
      throw _privateConstructorUsedError; // other payment info
  List<File> get imageBills => throw _privateConstructorUsedError;
  CustomerPortrait? get customerPortraitSelect =>
      throw _privateConstructorUsedError;
  String get completeNote => throw _privateConstructorUsedError;
  bool get printNumberOfPeople => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $CheckoutStateCopyWith<CheckoutState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CheckoutStateCopyWith<$Res> {
  factory $CheckoutStateCopyWith(
          CheckoutState value, $Res Function(CheckoutState) then) =
      _$CheckoutStateCopyWithImpl<$Res, CheckoutState>;
  @useResult
  $Res call(
      {CheckoutEvent event,
      String message,
      List<ProductCheckoutModel> productCheckout,
      PageState productCheckoutState,
      CustomerModel? customer,
      List<OrderHistory> orderHistory,
      PageState invoiceState,
      OrderInvoice? invoice,
      PageState dataBillState,
      DataBillResponseData dataBill,
      List<CustomerPolicyModel> coupons,
      List<PolicyResultModel> vouchers,
      dynamic createVouchers,
      DiscountTypeEnum discountTypeSelect,
      PageState applyPolicyState,
      int numberOfAdults,
      int numberOfChildren,
      List<PaymentMethod> paymentMethods,
      PageState paymentMethodState,
      PaymentMethod? paymentMethodSelect,
      List<UserBankModel> banks,
      PageState banksState,
      UserBankModel? bankSelect,
      PageState listAtmPosState,
      List<AtmPosModel> listAtmPos,
      AtmPosModel? atmPosSelect,
      bool statusPaymentGateway,
      dynamic totalPaymentGateway,
      double cashReceivedAmount,
      List<File> imageBills,
      CustomerPortrait? customerPortraitSelect,
      String completeNote,
      bool printNumberOfPeople});

  $PageStateCopyWith<$Res> get productCheckoutState;
  $CustomerModelCopyWith<$Res>? get customer;
  $PageStateCopyWith<$Res> get invoiceState;
  $OrderInvoiceCopyWith<$Res>? get invoice;
  $PageStateCopyWith<$Res> get dataBillState;
  $DataBillResponseDataCopyWith<$Res> get dataBill;
  $PageStateCopyWith<$Res> get applyPolicyState;
  $PageStateCopyWith<$Res> get paymentMethodState;
  $PaymentMethodCopyWith<$Res>? get paymentMethodSelect;
  $PageStateCopyWith<$Res> get banksState;
  $UserBankModelCopyWith<$Res>? get bankSelect;
  $PageStateCopyWith<$Res> get listAtmPosState;
  $AtmPosModelCopyWith<$Res>? get atmPosSelect;
  $CustomerPortraitCopyWith<$Res>? get customerPortraitSelect;
}

/// @nodoc
class _$CheckoutStateCopyWithImpl<$Res, $Val extends CheckoutState>
    implements $CheckoutStateCopyWith<$Res> {
  _$CheckoutStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? event = null,
    Object? message = null,
    Object? productCheckout = null,
    Object? productCheckoutState = null,
    Object? customer = freezed,
    Object? orderHistory = null,
    Object? invoiceState = null,
    Object? invoice = freezed,
    Object? dataBillState = null,
    Object? dataBill = null,
    Object? coupons = null,
    Object? vouchers = null,
    Object? createVouchers = freezed,
    Object? discountTypeSelect = null,
    Object? applyPolicyState = null,
    Object? numberOfAdults = null,
    Object? numberOfChildren = null,
    Object? paymentMethods = null,
    Object? paymentMethodState = null,
    Object? paymentMethodSelect = freezed,
    Object? banks = null,
    Object? banksState = null,
    Object? bankSelect = freezed,
    Object? listAtmPosState = null,
    Object? listAtmPos = null,
    Object? atmPosSelect = freezed,
    Object? statusPaymentGateway = null,
    Object? totalPaymentGateway = freezed,
    Object? cashReceivedAmount = null,
    Object? imageBills = null,
    Object? customerPortraitSelect = freezed,
    Object? completeNote = null,
    Object? printNumberOfPeople = null,
  }) {
    return _then(_value.copyWith(
      event: null == event
          ? _value.event
          : event // ignore: cast_nullable_to_non_nullable
              as CheckoutEvent,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      productCheckout: null == productCheckout
          ? _value.productCheckout
          : productCheckout // ignore: cast_nullable_to_non_nullable
              as List<ProductCheckoutModel>,
      productCheckoutState: null == productCheckoutState
          ? _value.productCheckoutState
          : productCheckoutState // ignore: cast_nullable_to_non_nullable
              as PageState,
      customer: freezed == customer
          ? _value.customer
          : customer // ignore: cast_nullable_to_non_nullable
              as CustomerModel?,
      orderHistory: null == orderHistory
          ? _value.orderHistory
          : orderHistory // ignore: cast_nullable_to_non_nullable
              as List<OrderHistory>,
      invoiceState: null == invoiceState
          ? _value.invoiceState
          : invoiceState // ignore: cast_nullable_to_non_nullable
              as PageState,
      invoice: freezed == invoice
          ? _value.invoice
          : invoice // ignore: cast_nullable_to_non_nullable
              as OrderInvoice?,
      dataBillState: null == dataBillState
          ? _value.dataBillState
          : dataBillState // ignore: cast_nullable_to_non_nullable
              as PageState,
      dataBill: null == dataBill
          ? _value.dataBill
          : dataBill // ignore: cast_nullable_to_non_nullable
              as DataBillResponseData,
      coupons: null == coupons
          ? _value.coupons
          : coupons // ignore: cast_nullable_to_non_nullable
              as List<CustomerPolicyModel>,
      vouchers: null == vouchers
          ? _value.vouchers
          : vouchers // ignore: cast_nullable_to_non_nullable
              as List<PolicyResultModel>,
      createVouchers: freezed == createVouchers
          ? _value.createVouchers
          : createVouchers // ignore: cast_nullable_to_non_nullable
              as dynamic,
      discountTypeSelect: null == discountTypeSelect
          ? _value.discountTypeSelect
          : discountTypeSelect // ignore: cast_nullable_to_non_nullable
              as DiscountTypeEnum,
      applyPolicyState: null == applyPolicyState
          ? _value.applyPolicyState
          : applyPolicyState // ignore: cast_nullable_to_non_nullable
              as PageState,
      numberOfAdults: null == numberOfAdults
          ? _value.numberOfAdults
          : numberOfAdults // ignore: cast_nullable_to_non_nullable
              as int,
      numberOfChildren: null == numberOfChildren
          ? _value.numberOfChildren
          : numberOfChildren // ignore: cast_nullable_to_non_nullable
              as int,
      paymentMethods: null == paymentMethods
          ? _value.paymentMethods
          : paymentMethods // ignore: cast_nullable_to_non_nullable
              as List<PaymentMethod>,
      paymentMethodState: null == paymentMethodState
          ? _value.paymentMethodState
          : paymentMethodState // ignore: cast_nullable_to_non_nullable
              as PageState,
      paymentMethodSelect: freezed == paymentMethodSelect
          ? _value.paymentMethodSelect
          : paymentMethodSelect // ignore: cast_nullable_to_non_nullable
              as PaymentMethod?,
      banks: null == banks
          ? _value.banks
          : banks // ignore: cast_nullable_to_non_nullable
              as List<UserBankModel>,
      banksState: null == banksState
          ? _value.banksState
          : banksState // ignore: cast_nullable_to_non_nullable
              as PageState,
      bankSelect: freezed == bankSelect
          ? _value.bankSelect
          : bankSelect // ignore: cast_nullable_to_non_nullable
              as UserBankModel?,
      listAtmPosState: null == listAtmPosState
          ? _value.listAtmPosState
          : listAtmPosState // ignore: cast_nullable_to_non_nullable
              as PageState,
      listAtmPos: null == listAtmPos
          ? _value.listAtmPos
          : listAtmPos // ignore: cast_nullable_to_non_nullable
              as List<AtmPosModel>,
      atmPosSelect: freezed == atmPosSelect
          ? _value.atmPosSelect
          : atmPosSelect // ignore: cast_nullable_to_non_nullable
              as AtmPosModel?,
      statusPaymentGateway: null == statusPaymentGateway
          ? _value.statusPaymentGateway
          : statusPaymentGateway // ignore: cast_nullable_to_non_nullable
              as bool,
      totalPaymentGateway: freezed == totalPaymentGateway
          ? _value.totalPaymentGateway
          : totalPaymentGateway // ignore: cast_nullable_to_non_nullable
              as dynamic,
      cashReceivedAmount: null == cashReceivedAmount
          ? _value.cashReceivedAmount
          : cashReceivedAmount // ignore: cast_nullable_to_non_nullable
              as double,
      imageBills: null == imageBills
          ? _value.imageBills
          : imageBills // ignore: cast_nullable_to_non_nullable
              as List<File>,
      customerPortraitSelect: freezed == customerPortraitSelect
          ? _value.customerPortraitSelect
          : customerPortraitSelect // ignore: cast_nullable_to_non_nullable
              as CustomerPortrait?,
      completeNote: null == completeNote
          ? _value.completeNote
          : completeNote // ignore: cast_nullable_to_non_nullable
              as String,
      printNumberOfPeople: null == printNumberOfPeople
          ? _value.printNumberOfPeople
          : printNumberOfPeople // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $PageStateCopyWith<$Res> get productCheckoutState {
    return $PageStateCopyWith<$Res>(_value.productCheckoutState, (value) {
      return _then(_value.copyWith(productCheckoutState: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $CustomerModelCopyWith<$Res>? get customer {
    if (_value.customer == null) {
      return null;
    }

    return $CustomerModelCopyWith<$Res>(_value.customer!, (value) {
      return _then(_value.copyWith(customer: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $PageStateCopyWith<$Res> get invoiceState {
    return $PageStateCopyWith<$Res>(_value.invoiceState, (value) {
      return _then(_value.copyWith(invoiceState: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $OrderInvoiceCopyWith<$Res>? get invoice {
    if (_value.invoice == null) {
      return null;
    }

    return $OrderInvoiceCopyWith<$Res>(_value.invoice!, (value) {
      return _then(_value.copyWith(invoice: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $PageStateCopyWith<$Res> get dataBillState {
    return $PageStateCopyWith<$Res>(_value.dataBillState, (value) {
      return _then(_value.copyWith(dataBillState: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $DataBillResponseDataCopyWith<$Res> get dataBill {
    return $DataBillResponseDataCopyWith<$Res>(_value.dataBill, (value) {
      return _then(_value.copyWith(dataBill: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $PageStateCopyWith<$Res> get applyPolicyState {
    return $PageStateCopyWith<$Res>(_value.applyPolicyState, (value) {
      return _then(_value.copyWith(applyPolicyState: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $PageStateCopyWith<$Res> get paymentMethodState {
    return $PageStateCopyWith<$Res>(_value.paymentMethodState, (value) {
      return _then(_value.copyWith(paymentMethodState: value) as $Val);
    });
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

  @override
  @pragma('vm:prefer-inline')
  $PageStateCopyWith<$Res> get banksState {
    return $PageStateCopyWith<$Res>(_value.banksState, (value) {
      return _then(_value.copyWith(banksState: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $UserBankModelCopyWith<$Res>? get bankSelect {
    if (_value.bankSelect == null) {
      return null;
    }

    return $UserBankModelCopyWith<$Res>(_value.bankSelect!, (value) {
      return _then(_value.copyWith(bankSelect: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $PageStateCopyWith<$Res> get listAtmPosState {
    return $PageStateCopyWith<$Res>(_value.listAtmPosState, (value) {
      return _then(_value.copyWith(listAtmPosState: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $AtmPosModelCopyWith<$Res>? get atmPosSelect {
    if (_value.atmPosSelect == null) {
      return null;
    }

    return $AtmPosModelCopyWith<$Res>(_value.atmPosSelect!, (value) {
      return _then(_value.copyWith(atmPosSelect: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $CustomerPortraitCopyWith<$Res>? get customerPortraitSelect {
    if (_value.customerPortraitSelect == null) {
      return null;
    }

    return $CustomerPortraitCopyWith<$Res>(_value.customerPortraitSelect!,
        (value) {
      return _then(_value.copyWith(customerPortraitSelect: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$CheckoutStateImplCopyWith<$Res>
    implements $CheckoutStateCopyWith<$Res> {
  factory _$$CheckoutStateImplCopyWith(
          _$CheckoutStateImpl value, $Res Function(_$CheckoutStateImpl) then) =
      __$$CheckoutStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {CheckoutEvent event,
      String message,
      List<ProductCheckoutModel> productCheckout,
      PageState productCheckoutState,
      CustomerModel? customer,
      List<OrderHistory> orderHistory,
      PageState invoiceState,
      OrderInvoice? invoice,
      PageState dataBillState,
      DataBillResponseData dataBill,
      List<CustomerPolicyModel> coupons,
      List<PolicyResultModel> vouchers,
      dynamic createVouchers,
      DiscountTypeEnum discountTypeSelect,
      PageState applyPolicyState,
      int numberOfAdults,
      int numberOfChildren,
      List<PaymentMethod> paymentMethods,
      PageState paymentMethodState,
      PaymentMethod? paymentMethodSelect,
      List<UserBankModel> banks,
      PageState banksState,
      UserBankModel? bankSelect,
      PageState listAtmPosState,
      List<AtmPosModel> listAtmPos,
      AtmPosModel? atmPosSelect,
      bool statusPaymentGateway,
      dynamic totalPaymentGateway,
      double cashReceivedAmount,
      List<File> imageBills,
      CustomerPortrait? customerPortraitSelect,
      String completeNote,
      bool printNumberOfPeople});

  @override
  $PageStateCopyWith<$Res> get productCheckoutState;
  @override
  $CustomerModelCopyWith<$Res>? get customer;
  @override
  $PageStateCopyWith<$Res> get invoiceState;
  @override
  $OrderInvoiceCopyWith<$Res>? get invoice;
  @override
  $PageStateCopyWith<$Res> get dataBillState;
  @override
  $DataBillResponseDataCopyWith<$Res> get dataBill;
  @override
  $PageStateCopyWith<$Res> get applyPolicyState;
  @override
  $PageStateCopyWith<$Res> get paymentMethodState;
  @override
  $PaymentMethodCopyWith<$Res>? get paymentMethodSelect;
  @override
  $PageStateCopyWith<$Res> get banksState;
  @override
  $UserBankModelCopyWith<$Res>? get bankSelect;
  @override
  $PageStateCopyWith<$Res> get listAtmPosState;
  @override
  $AtmPosModelCopyWith<$Res>? get atmPosSelect;
  @override
  $CustomerPortraitCopyWith<$Res>? get customerPortraitSelect;
}

/// @nodoc
class __$$CheckoutStateImplCopyWithImpl<$Res>
    extends _$CheckoutStateCopyWithImpl<$Res, _$CheckoutStateImpl>
    implements _$$CheckoutStateImplCopyWith<$Res> {
  __$$CheckoutStateImplCopyWithImpl(
      _$CheckoutStateImpl _value, $Res Function(_$CheckoutStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? event = null,
    Object? message = null,
    Object? productCheckout = null,
    Object? productCheckoutState = null,
    Object? customer = freezed,
    Object? orderHistory = null,
    Object? invoiceState = null,
    Object? invoice = freezed,
    Object? dataBillState = null,
    Object? dataBill = null,
    Object? coupons = null,
    Object? vouchers = null,
    Object? createVouchers = freezed,
    Object? discountTypeSelect = null,
    Object? applyPolicyState = null,
    Object? numberOfAdults = null,
    Object? numberOfChildren = null,
    Object? paymentMethods = null,
    Object? paymentMethodState = null,
    Object? paymentMethodSelect = freezed,
    Object? banks = null,
    Object? banksState = null,
    Object? bankSelect = freezed,
    Object? listAtmPosState = null,
    Object? listAtmPos = null,
    Object? atmPosSelect = freezed,
    Object? statusPaymentGateway = null,
    Object? totalPaymentGateway = freezed,
    Object? cashReceivedAmount = null,
    Object? imageBills = null,
    Object? customerPortraitSelect = freezed,
    Object? completeNote = null,
    Object? printNumberOfPeople = null,
  }) {
    return _then(_$CheckoutStateImpl(
      event: null == event
          ? _value.event
          : event // ignore: cast_nullable_to_non_nullable
              as CheckoutEvent,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      productCheckout: null == productCheckout
          ? _value._productCheckout
          : productCheckout // ignore: cast_nullable_to_non_nullable
              as List<ProductCheckoutModel>,
      productCheckoutState: null == productCheckoutState
          ? _value.productCheckoutState
          : productCheckoutState // ignore: cast_nullable_to_non_nullable
              as PageState,
      customer: freezed == customer
          ? _value.customer
          : customer // ignore: cast_nullable_to_non_nullable
              as CustomerModel?,
      orderHistory: null == orderHistory
          ? _value._orderHistory
          : orderHistory // ignore: cast_nullable_to_non_nullable
              as List<OrderHistory>,
      invoiceState: null == invoiceState
          ? _value.invoiceState
          : invoiceState // ignore: cast_nullable_to_non_nullable
              as PageState,
      invoice: freezed == invoice
          ? _value.invoice
          : invoice // ignore: cast_nullable_to_non_nullable
              as OrderInvoice?,
      dataBillState: null == dataBillState
          ? _value.dataBillState
          : dataBillState // ignore: cast_nullable_to_non_nullable
              as PageState,
      dataBill: null == dataBill
          ? _value.dataBill
          : dataBill // ignore: cast_nullable_to_non_nullable
              as DataBillResponseData,
      coupons: null == coupons
          ? _value._coupons
          : coupons // ignore: cast_nullable_to_non_nullable
              as List<CustomerPolicyModel>,
      vouchers: null == vouchers
          ? _value._vouchers
          : vouchers // ignore: cast_nullable_to_non_nullable
              as List<PolicyResultModel>,
      createVouchers: freezed == createVouchers
          ? _value.createVouchers
          : createVouchers // ignore: cast_nullable_to_non_nullable
              as dynamic,
      discountTypeSelect: null == discountTypeSelect
          ? _value.discountTypeSelect
          : discountTypeSelect // ignore: cast_nullable_to_non_nullable
              as DiscountTypeEnum,
      applyPolicyState: null == applyPolicyState
          ? _value.applyPolicyState
          : applyPolicyState // ignore: cast_nullable_to_non_nullable
              as PageState,
      numberOfAdults: null == numberOfAdults
          ? _value.numberOfAdults
          : numberOfAdults // ignore: cast_nullable_to_non_nullable
              as int,
      numberOfChildren: null == numberOfChildren
          ? _value.numberOfChildren
          : numberOfChildren // ignore: cast_nullable_to_non_nullable
              as int,
      paymentMethods: null == paymentMethods
          ? _value._paymentMethods
          : paymentMethods // ignore: cast_nullable_to_non_nullable
              as List<PaymentMethod>,
      paymentMethodState: null == paymentMethodState
          ? _value.paymentMethodState
          : paymentMethodState // ignore: cast_nullable_to_non_nullable
              as PageState,
      paymentMethodSelect: freezed == paymentMethodSelect
          ? _value.paymentMethodSelect
          : paymentMethodSelect // ignore: cast_nullable_to_non_nullable
              as PaymentMethod?,
      banks: null == banks
          ? _value._banks
          : banks // ignore: cast_nullable_to_non_nullable
              as List<UserBankModel>,
      banksState: null == banksState
          ? _value.banksState
          : banksState // ignore: cast_nullable_to_non_nullable
              as PageState,
      bankSelect: freezed == bankSelect
          ? _value.bankSelect
          : bankSelect // ignore: cast_nullable_to_non_nullable
              as UserBankModel?,
      listAtmPosState: null == listAtmPosState
          ? _value.listAtmPosState
          : listAtmPosState // ignore: cast_nullable_to_non_nullable
              as PageState,
      listAtmPos: null == listAtmPos
          ? _value._listAtmPos
          : listAtmPos // ignore: cast_nullable_to_non_nullable
              as List<AtmPosModel>,
      atmPosSelect: freezed == atmPosSelect
          ? _value.atmPosSelect
          : atmPosSelect // ignore: cast_nullable_to_non_nullable
              as AtmPosModel?,
      statusPaymentGateway: null == statusPaymentGateway
          ? _value.statusPaymentGateway
          : statusPaymentGateway // ignore: cast_nullable_to_non_nullable
              as bool,
      totalPaymentGateway: freezed == totalPaymentGateway
          ? _value.totalPaymentGateway
          : totalPaymentGateway // ignore: cast_nullable_to_non_nullable
              as dynamic,
      cashReceivedAmount: null == cashReceivedAmount
          ? _value.cashReceivedAmount
          : cashReceivedAmount // ignore: cast_nullable_to_non_nullable
              as double,
      imageBills: null == imageBills
          ? _value._imageBills
          : imageBills // ignore: cast_nullable_to_non_nullable
              as List<File>,
      customerPortraitSelect: freezed == customerPortraitSelect
          ? _value.customerPortraitSelect
          : customerPortraitSelect // ignore: cast_nullable_to_non_nullable
              as CustomerPortrait?,
      completeNote: null == completeNote
          ? _value.completeNote
          : completeNote // ignore: cast_nullable_to_non_nullable
              as String,
      printNumberOfPeople: null == printNumberOfPeople
          ? _value.printNumberOfPeople
          : printNumberOfPeople // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$CheckoutStateImpl implements _CheckoutState {
  const _$CheckoutStateImpl(
      {this.event = CheckoutEvent.normal,
      this.message = '',
      final List<ProductCheckoutModel> productCheckout = const [],
      this.productCheckoutState = const PageState(),
      this.customer,
      final List<OrderHistory> orderHistory = const [],
      this.invoiceState = const PageState(),
      this.invoice,
      this.dataBillState = const PageState(),
      this.dataBill = const DataBillResponseData(),
      final List<CustomerPolicyModel> coupons = const [],
      final List<PolicyResultModel> vouchers = const [],
      this.createVouchers,
      this.discountTypeSelect = DiscountTypeEnum.vnd,
      this.applyPolicyState = const PageState(status: PageCommonState.success),
      this.numberOfAdults = 1,
      this.numberOfChildren = 0,
      final List<PaymentMethod> paymentMethods = const [],
      this.paymentMethodState = const PageState(),
      this.paymentMethodSelect,
      final List<UserBankModel> banks = const [],
      this.banksState = const PageState(),
      this.bankSelect,
      this.listAtmPosState = const PageState(),
      final List<AtmPosModel> listAtmPos = const [],
      this.atmPosSelect,
      this.statusPaymentGateway = false,
      this.totalPaymentGateway,
      this.cashReceivedAmount = 0,
      final List<File> imageBills = const [],
      this.customerPortraitSelect,
      this.completeNote = '',
      this.printNumberOfPeople = false})
      : _productCheckout = productCheckout,
        _orderHistory = orderHistory,
        _coupons = coupons,
        _vouchers = vouchers,
        _paymentMethods = paymentMethods,
        _banks = banks,
        _listAtmPos = listAtmPos,
        _imageBills = imageBills;

  @override
  @JsonKey()
  final CheckoutEvent event;
  @override
  @JsonKey()
  final String message;
//
  final List<ProductCheckoutModel> _productCheckout;
//
  @override
  @JsonKey()
  List<ProductCheckoutModel> get productCheckout {
    if (_productCheckout is EqualUnmodifiableListView) return _productCheckout;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_productCheckout);
  }

  @override
  @JsonKey()
  final PageState productCheckoutState;
  @override
  final CustomerModel? customer;
  final List<OrderHistory> _orderHistory;
  @override
  @JsonKey()
  List<OrderHistory> get orderHistory {
    if (_orderHistory is EqualUnmodifiableListView) return _orderHistory;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_orderHistory);
  }

// invoice
  @override
  @JsonKey()
  final PageState invoiceState;
  @override
  final OrderInvoice? invoice;
// data bill
  @override
  @JsonKey()
  final PageState dataBillState;
  @override
  @JsonKey()
  final DataBillResponseData dataBill;
// coupons + voucher
  final List<CustomerPolicyModel> _coupons;
// coupons + voucher
  @override
  @JsonKey()
  List<CustomerPolicyModel> get coupons {
    if (_coupons is EqualUnmodifiableListView) return _coupons;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_coupons);
  }

  final List<PolicyResultModel> _vouchers;
  @override
  @JsonKey()
  List<PolicyResultModel> get vouchers {
    if (_vouchers is EqualUnmodifiableListView) return _vouchers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_vouchers);
  }

  @override
  final dynamic createVouchers;
  @override
  @JsonKey()
  final DiscountTypeEnum discountTypeSelect;
  @override
  @JsonKey()
  final PageState applyPolicyState;

  /// guest
  @override
  @JsonKey()
  final int numberOfAdults;
  @override
  @JsonKey()
  final int numberOfChildren;

  /// payment
// payment method
  final List<PaymentMethod> _paymentMethods;

  /// payment
// payment method
  @override
  @JsonKey()
  List<PaymentMethod> get paymentMethods {
    if (_paymentMethods is EqualUnmodifiableListView) return _paymentMethods;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_paymentMethods);
  }

  @override
  @JsonKey()
  final PageState paymentMethodState;
  @override
  final PaymentMethod? paymentMethodSelect;
// banks
  final List<UserBankModel> _banks;
// banks
  @override
  @JsonKey()
  List<UserBankModel> get banks {
    if (_banks is EqualUnmodifiableListView) return _banks;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_banks);
  }

  @override
  @JsonKey()
  final PageState banksState;
  @override
  final UserBankModel? bankSelect;
// atm
  @override
  @JsonKey()
  final PageState listAtmPosState;
  final List<AtmPosModel> _listAtmPos;
  @override
  @JsonKey()
  List<AtmPosModel> get listAtmPos {
    if (_listAtmPos is EqualUnmodifiableListView) return _listAtmPos;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_listAtmPos);
  }

  @override
  final AtmPosModel? atmPosSelect;
// gateway
  @override
  @JsonKey()
  final bool statusPaymentGateway;
  @override
  final dynamic totalPaymentGateway;
// cash payment
  @override
  @JsonKey()
  final double cashReceivedAmount;
// other payment info
  final List<File> _imageBills;
// other payment info
  @override
  @JsonKey()
  List<File> get imageBills {
    if (_imageBills is EqualUnmodifiableListView) return _imageBills;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_imageBills);
  }

  @override
  final CustomerPortrait? customerPortraitSelect;
  @override
  @JsonKey()
  final String completeNote;
  @override
  @JsonKey()
  final bool printNumberOfPeople;

  @override
  String toString() {
    return 'CheckoutState(event: $event, message: $message, productCheckout: $productCheckout, productCheckoutState: $productCheckoutState, customer: $customer, orderHistory: $orderHistory, invoiceState: $invoiceState, invoice: $invoice, dataBillState: $dataBillState, dataBill: $dataBill, coupons: $coupons, vouchers: $vouchers, createVouchers: $createVouchers, discountTypeSelect: $discountTypeSelect, applyPolicyState: $applyPolicyState, numberOfAdults: $numberOfAdults, numberOfChildren: $numberOfChildren, paymentMethods: $paymentMethods, paymentMethodState: $paymentMethodState, paymentMethodSelect: $paymentMethodSelect, banks: $banks, banksState: $banksState, bankSelect: $bankSelect, listAtmPosState: $listAtmPosState, listAtmPos: $listAtmPos, atmPosSelect: $atmPosSelect, statusPaymentGateway: $statusPaymentGateway, totalPaymentGateway: $totalPaymentGateway, cashReceivedAmount: $cashReceivedAmount, imageBills: $imageBills, customerPortraitSelect: $customerPortraitSelect, completeNote: $completeNote, printNumberOfPeople: $printNumberOfPeople)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CheckoutStateImpl &&
            (identical(other.event, event) || other.event == event) &&
            (identical(other.message, message) || other.message == message) &&
            const DeepCollectionEquality()
                .equals(other._productCheckout, _productCheckout) &&
            (identical(other.productCheckoutState, productCheckoutState) ||
                other.productCheckoutState == productCheckoutState) &&
            (identical(other.customer, customer) ||
                other.customer == customer) &&
            const DeepCollectionEquality()
                .equals(other._orderHistory, _orderHistory) &&
            (identical(other.invoiceState, invoiceState) ||
                other.invoiceState == invoiceState) &&
            (identical(other.invoice, invoice) || other.invoice == invoice) &&
            (identical(other.dataBillState, dataBillState) ||
                other.dataBillState == dataBillState) &&
            (identical(other.dataBill, dataBill) ||
                other.dataBill == dataBill) &&
            const DeepCollectionEquality().equals(other._coupons, _coupons) &&
            const DeepCollectionEquality().equals(other._vouchers, _vouchers) &&
            const DeepCollectionEquality()
                .equals(other.createVouchers, createVouchers) &&
            (identical(other.discountTypeSelect, discountTypeSelect) ||
                other.discountTypeSelect == discountTypeSelect) &&
            (identical(other.applyPolicyState, applyPolicyState) ||
                other.applyPolicyState == applyPolicyState) &&
            (identical(other.numberOfAdults, numberOfAdults) ||
                other.numberOfAdults == numberOfAdults) &&
            (identical(other.numberOfChildren, numberOfChildren) ||
                other.numberOfChildren == numberOfChildren) &&
            const DeepCollectionEquality()
                .equals(other._paymentMethods, _paymentMethods) &&
            (identical(other.paymentMethodState, paymentMethodState) ||
                other.paymentMethodState == paymentMethodState) &&
            (identical(other.paymentMethodSelect, paymentMethodSelect) ||
                other.paymentMethodSelect == paymentMethodSelect) &&
            const DeepCollectionEquality().equals(other._banks, _banks) &&
            (identical(other.banksState, banksState) ||
                other.banksState == banksState) &&
            (identical(other.bankSelect, bankSelect) ||
                other.bankSelect == bankSelect) &&
            (identical(other.listAtmPosState, listAtmPosState) ||
                other.listAtmPosState == listAtmPosState) &&
            const DeepCollectionEquality()
                .equals(other._listAtmPos, _listAtmPos) &&
            (identical(other.atmPosSelect, atmPosSelect) ||
                other.atmPosSelect == atmPosSelect) &&
            (identical(other.statusPaymentGateway, statusPaymentGateway) ||
                other.statusPaymentGateway == statusPaymentGateway) &&
            const DeepCollectionEquality()
                .equals(other.totalPaymentGateway, totalPaymentGateway) &&
            (identical(other.cashReceivedAmount, cashReceivedAmount) ||
                other.cashReceivedAmount == cashReceivedAmount) &&
            const DeepCollectionEquality()
                .equals(other._imageBills, _imageBills) &&
            (identical(other.customerPortraitSelect, customerPortraitSelect) ||
                other.customerPortraitSelect == customerPortraitSelect) &&
            (identical(other.completeNote, completeNote) ||
                other.completeNote == completeNote) &&
            (identical(other.printNumberOfPeople, printNumberOfPeople) ||
                other.printNumberOfPeople == printNumberOfPeople));
  }

  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        event,
        message,
        const DeepCollectionEquality().hash(_productCheckout),
        productCheckoutState,
        customer,
        const DeepCollectionEquality().hash(_orderHistory),
        invoiceState,
        invoice,
        dataBillState,
        dataBill,
        const DeepCollectionEquality().hash(_coupons),
        const DeepCollectionEquality().hash(_vouchers),
        const DeepCollectionEquality().hash(createVouchers),
        discountTypeSelect,
        applyPolicyState,
        numberOfAdults,
        numberOfChildren,
        const DeepCollectionEquality().hash(_paymentMethods),
        paymentMethodState,
        paymentMethodSelect,
        const DeepCollectionEquality().hash(_banks),
        banksState,
        bankSelect,
        listAtmPosState,
        const DeepCollectionEquality().hash(_listAtmPos),
        atmPosSelect,
        statusPaymentGateway,
        const DeepCollectionEquality().hash(totalPaymentGateway),
        cashReceivedAmount,
        const DeepCollectionEquality().hash(_imageBills),
        customerPortraitSelect,
        completeNote,
        printNumberOfPeople
      ]);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CheckoutStateImplCopyWith<_$CheckoutStateImpl> get copyWith =>
      __$$CheckoutStateImplCopyWithImpl<_$CheckoutStateImpl>(this, _$identity);
}

abstract class _CheckoutState implements CheckoutState {
  const factory _CheckoutState(
      {final CheckoutEvent event,
      final String message,
      final List<ProductCheckoutModel> productCheckout,
      final PageState productCheckoutState,
      final CustomerModel? customer,
      final List<OrderHistory> orderHistory,
      final PageState invoiceState,
      final OrderInvoice? invoice,
      final PageState dataBillState,
      final DataBillResponseData dataBill,
      final List<CustomerPolicyModel> coupons,
      final List<PolicyResultModel> vouchers,
      final dynamic createVouchers,
      final DiscountTypeEnum discountTypeSelect,
      final PageState applyPolicyState,
      final int numberOfAdults,
      final int numberOfChildren,
      final List<PaymentMethod> paymentMethods,
      final PageState paymentMethodState,
      final PaymentMethod? paymentMethodSelect,
      final List<UserBankModel> banks,
      final PageState banksState,
      final UserBankModel? bankSelect,
      final PageState listAtmPosState,
      final List<AtmPosModel> listAtmPos,
      final AtmPosModel? atmPosSelect,
      final bool statusPaymentGateway,
      final dynamic totalPaymentGateway,
      final double cashReceivedAmount,
      final List<File> imageBills,
      final CustomerPortrait? customerPortraitSelect,
      final String completeNote,
      final bool printNumberOfPeople}) = _$CheckoutStateImpl;

  @override
  CheckoutEvent get event;
  @override
  String get message;
  @override //
  List<ProductCheckoutModel> get productCheckout;
  @override
  PageState get productCheckoutState;
  @override
  CustomerModel? get customer;
  @override
  List<OrderHistory> get orderHistory;
  @override // invoice
  PageState get invoiceState;
  @override
  OrderInvoice? get invoice;
  @override // data bill
  PageState get dataBillState;
  @override
  DataBillResponseData get dataBill;
  @override // coupons + voucher
  List<CustomerPolicyModel> get coupons;
  @override
  List<PolicyResultModel> get vouchers;
  @override
  dynamic get createVouchers;
  @override
  DiscountTypeEnum get discountTypeSelect;
  @override
  PageState get applyPolicyState;
  @override

  /// guest
  int get numberOfAdults;
  @override
  int get numberOfChildren;
  @override

  /// payment
// payment method
  List<PaymentMethod> get paymentMethods;
  @override
  PageState get paymentMethodState;
  @override
  PaymentMethod? get paymentMethodSelect;
  @override // banks
  List<UserBankModel> get banks;
  @override
  PageState get banksState;
  @override
  UserBankModel? get bankSelect;
  @override // atm
  PageState get listAtmPosState;
  @override
  List<AtmPosModel> get listAtmPos;
  @override
  AtmPosModel? get atmPosSelect;
  @override // gateway
  bool get statusPaymentGateway;
  @override
  dynamic get totalPaymentGateway;
  @override // cash payment
  double get cashReceivedAmount;
  @override // other payment info
  List<File> get imageBills;
  @override
  CustomerPortrait? get customerPortraitSelect;
  @override
  String get completeNote;
  @override
  bool get printNumberOfPeople;
  @override
  @JsonKey(ignore: true)
  _$$CheckoutStateImplCopyWith<_$CheckoutStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
