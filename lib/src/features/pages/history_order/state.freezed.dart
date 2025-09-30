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
mixin _$HistoryOrderState {
  HistoryOrderEvent get event => throw _privateConstructorUsedError;
  HistoryOrderModel? get historyOrderSelect =>
      throw _privateConstructorUsedError;
  String get messageError => throw _privateConstructorUsedError;
  PageState get getOrderDetailState => throw _privateConstructorUsedError;
  CustomerModel? get customer =>
      throw _privateConstructorUsedError; // PriceDataBill? billInfo,
  List<CustomerPolicyModel> get coupons => throw _privateConstructorUsedError;
  List<ProductCheckoutModel> get productCheckout =>
      throw _privateConstructorUsedError; // @Default([]) List<HistoryPolicyResultModel> vouchers,
// @Default([]) List<PaymentMethodDataBill> paymentMethods,
// String? portrait,
// int? amountChildren,
// int? amountAdult,
// String? description,
// @Default([]) List<String> imageConfirms,
  DataBillResponseData? get dataBill => throw _privateConstructorUsedError;
  DateTime get startDate => throw _privateConstructorUsedError;
  DateTime get endDate => throw _privateConstructorUsedError;
  String get textSearch => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $HistoryOrderStateCopyWith<HistoryOrderState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HistoryOrderStateCopyWith<$Res> {
  factory $HistoryOrderStateCopyWith(
          HistoryOrderState value, $Res Function(HistoryOrderState) then) =
      _$HistoryOrderStateCopyWithImpl<$Res, HistoryOrderState>;
  @useResult
  $Res call(
      {HistoryOrderEvent event,
      HistoryOrderModel? historyOrderSelect,
      String messageError,
      PageState getOrderDetailState,
      CustomerModel? customer,
      List<CustomerPolicyModel> coupons,
      List<ProductCheckoutModel> productCheckout,
      DataBillResponseData? dataBill,
      DateTime startDate,
      DateTime endDate,
      String textSearch});

  $HistoryOrderModelCopyWith<$Res>? get historyOrderSelect;
  $PageStateCopyWith<$Res> get getOrderDetailState;
  $CustomerModelCopyWith<$Res>? get customer;
  $DataBillResponseDataCopyWith<$Res>? get dataBill;
}

/// @nodoc
class _$HistoryOrderStateCopyWithImpl<$Res, $Val extends HistoryOrderState>
    implements $HistoryOrderStateCopyWith<$Res> {
  _$HistoryOrderStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? event = null,
    Object? historyOrderSelect = freezed,
    Object? messageError = null,
    Object? getOrderDetailState = null,
    Object? customer = freezed,
    Object? coupons = null,
    Object? productCheckout = null,
    Object? dataBill = freezed,
    Object? startDate = null,
    Object? endDate = null,
    Object? textSearch = null,
  }) {
    return _then(_value.copyWith(
      event: null == event
          ? _value.event
          : event // ignore: cast_nullable_to_non_nullable
              as HistoryOrderEvent,
      historyOrderSelect: freezed == historyOrderSelect
          ? _value.historyOrderSelect
          : historyOrderSelect // ignore: cast_nullable_to_non_nullable
              as HistoryOrderModel?,
      messageError: null == messageError
          ? _value.messageError
          : messageError // ignore: cast_nullable_to_non_nullable
              as String,
      getOrderDetailState: null == getOrderDetailState
          ? _value.getOrderDetailState
          : getOrderDetailState // ignore: cast_nullable_to_non_nullable
              as PageState,
      customer: freezed == customer
          ? _value.customer
          : customer // ignore: cast_nullable_to_non_nullable
              as CustomerModel?,
      coupons: null == coupons
          ? _value.coupons
          : coupons // ignore: cast_nullable_to_non_nullable
              as List<CustomerPolicyModel>,
      productCheckout: null == productCheckout
          ? _value.productCheckout
          : productCheckout // ignore: cast_nullable_to_non_nullable
              as List<ProductCheckoutModel>,
      dataBill: freezed == dataBill
          ? _value.dataBill
          : dataBill // ignore: cast_nullable_to_non_nullable
              as DataBillResponseData?,
      startDate: null == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endDate: null == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      textSearch: null == textSearch
          ? _value.textSearch
          : textSearch // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $HistoryOrderModelCopyWith<$Res>? get historyOrderSelect {
    if (_value.historyOrderSelect == null) {
      return null;
    }

    return $HistoryOrderModelCopyWith<$Res>(_value.historyOrderSelect!,
        (value) {
      return _then(_value.copyWith(historyOrderSelect: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $PageStateCopyWith<$Res> get getOrderDetailState {
    return $PageStateCopyWith<$Res>(_value.getOrderDetailState, (value) {
      return _then(_value.copyWith(getOrderDetailState: value) as $Val);
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
  $DataBillResponseDataCopyWith<$Res>? get dataBill {
    if (_value.dataBill == null) {
      return null;
    }

    return $DataBillResponseDataCopyWith<$Res>(_value.dataBill!, (value) {
      return _then(_value.copyWith(dataBill: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$HistoryOrderStateImplCopyWith<$Res>
    implements $HistoryOrderStateCopyWith<$Res> {
  factory _$$HistoryOrderStateImplCopyWith(_$HistoryOrderStateImpl value,
          $Res Function(_$HistoryOrderStateImpl) then) =
      __$$HistoryOrderStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {HistoryOrderEvent event,
      HistoryOrderModel? historyOrderSelect,
      String messageError,
      PageState getOrderDetailState,
      CustomerModel? customer,
      List<CustomerPolicyModel> coupons,
      List<ProductCheckoutModel> productCheckout,
      DataBillResponseData? dataBill,
      DateTime startDate,
      DateTime endDate,
      String textSearch});

  @override
  $HistoryOrderModelCopyWith<$Res>? get historyOrderSelect;
  @override
  $PageStateCopyWith<$Res> get getOrderDetailState;
  @override
  $CustomerModelCopyWith<$Res>? get customer;
  @override
  $DataBillResponseDataCopyWith<$Res>? get dataBill;
}

/// @nodoc
class __$$HistoryOrderStateImplCopyWithImpl<$Res>
    extends _$HistoryOrderStateCopyWithImpl<$Res, _$HistoryOrderStateImpl>
    implements _$$HistoryOrderStateImplCopyWith<$Res> {
  __$$HistoryOrderStateImplCopyWithImpl(_$HistoryOrderStateImpl _value,
      $Res Function(_$HistoryOrderStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? event = null,
    Object? historyOrderSelect = freezed,
    Object? messageError = null,
    Object? getOrderDetailState = null,
    Object? customer = freezed,
    Object? coupons = null,
    Object? productCheckout = null,
    Object? dataBill = freezed,
    Object? startDate = null,
    Object? endDate = null,
    Object? textSearch = null,
  }) {
    return _then(_$HistoryOrderStateImpl(
      event: null == event
          ? _value.event
          : event // ignore: cast_nullable_to_non_nullable
              as HistoryOrderEvent,
      historyOrderSelect: freezed == historyOrderSelect
          ? _value.historyOrderSelect
          : historyOrderSelect // ignore: cast_nullable_to_non_nullable
              as HistoryOrderModel?,
      messageError: null == messageError
          ? _value.messageError
          : messageError // ignore: cast_nullable_to_non_nullable
              as String,
      getOrderDetailState: null == getOrderDetailState
          ? _value.getOrderDetailState
          : getOrderDetailState // ignore: cast_nullable_to_non_nullable
              as PageState,
      customer: freezed == customer
          ? _value.customer
          : customer // ignore: cast_nullable_to_non_nullable
              as CustomerModel?,
      coupons: null == coupons
          ? _value._coupons
          : coupons // ignore: cast_nullable_to_non_nullable
              as List<CustomerPolicyModel>,
      productCheckout: null == productCheckout
          ? _value._productCheckout
          : productCheckout // ignore: cast_nullable_to_non_nullable
              as List<ProductCheckoutModel>,
      dataBill: freezed == dataBill
          ? _value.dataBill
          : dataBill // ignore: cast_nullable_to_non_nullable
              as DataBillResponseData?,
      startDate: null == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endDate: null == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      textSearch: null == textSearch
          ? _value.textSearch
          : textSearch // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$HistoryOrderStateImpl implements _HistoryOrderState {
  const _$HistoryOrderStateImpl(
      {this.event = HistoryOrderEvent.normal,
      this.historyOrderSelect,
      this.messageError = '',
      this.getOrderDetailState =
          const PageState(status: PageCommonState.loading),
      this.customer,
      final List<CustomerPolicyModel> coupons = const [],
      final List<ProductCheckoutModel> productCheckout = const [],
      this.dataBill,
      required this.startDate,
      required this.endDate,
      this.textSearch = ''})
      : _coupons = coupons,
        _productCheckout = productCheckout;

  @override
  @JsonKey()
  final HistoryOrderEvent event;
  @override
  final HistoryOrderModel? historyOrderSelect;
  @override
  @JsonKey()
  final String messageError;
  @override
  @JsonKey()
  final PageState getOrderDetailState;
  @override
  final CustomerModel? customer;
// PriceDataBill? billInfo,
  final List<CustomerPolicyModel> _coupons;
// PriceDataBill? billInfo,
  @override
  @JsonKey()
  List<CustomerPolicyModel> get coupons {
    if (_coupons is EqualUnmodifiableListView) return _coupons;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_coupons);
  }

  final List<ProductCheckoutModel> _productCheckout;
  @override
  @JsonKey()
  List<ProductCheckoutModel> get productCheckout {
    if (_productCheckout is EqualUnmodifiableListView) return _productCheckout;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_productCheckout);
  }

// @Default([]) List<HistoryPolicyResultModel> vouchers,
// @Default([]) List<PaymentMethodDataBill> paymentMethods,
// String? portrait,
// int? amountChildren,
// int? amountAdult,
// String? description,
// @Default([]) List<String> imageConfirms,
  @override
  final DataBillResponseData? dataBill;
  @override
  final DateTime startDate;
  @override
  final DateTime endDate;
  @override
  @JsonKey()
  final String textSearch;

  @override
  String toString() {
    return 'HistoryOrderState(event: $event, historyOrderSelect: $historyOrderSelect, messageError: $messageError, getOrderDetailState: $getOrderDetailState, customer: $customer, coupons: $coupons, productCheckout: $productCheckout, dataBill: $dataBill, startDate: $startDate, endDate: $endDate, textSearch: $textSearch)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HistoryOrderStateImpl &&
            (identical(other.event, event) || other.event == event) &&
            (identical(other.historyOrderSelect, historyOrderSelect) ||
                other.historyOrderSelect == historyOrderSelect) &&
            (identical(other.messageError, messageError) ||
                other.messageError == messageError) &&
            (identical(other.getOrderDetailState, getOrderDetailState) ||
                other.getOrderDetailState == getOrderDetailState) &&
            (identical(other.customer, customer) ||
                other.customer == customer) &&
            const DeepCollectionEquality().equals(other._coupons, _coupons) &&
            const DeepCollectionEquality()
                .equals(other._productCheckout, _productCheckout) &&
            (identical(other.dataBill, dataBill) ||
                other.dataBill == dataBill) &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.endDate, endDate) || other.endDate == endDate) &&
            (identical(other.textSearch, textSearch) ||
                other.textSearch == textSearch));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      event,
      historyOrderSelect,
      messageError,
      getOrderDetailState,
      customer,
      const DeepCollectionEquality().hash(_coupons),
      const DeepCollectionEquality().hash(_productCheckout),
      dataBill,
      startDate,
      endDate,
      textSearch);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$HistoryOrderStateImplCopyWith<_$HistoryOrderStateImpl> get copyWith =>
      __$$HistoryOrderStateImplCopyWithImpl<_$HistoryOrderStateImpl>(
          this, _$identity);
}

abstract class _HistoryOrderState implements HistoryOrderState {
  const factory _HistoryOrderState(
      {final HistoryOrderEvent event,
      final HistoryOrderModel? historyOrderSelect,
      final String messageError,
      final PageState getOrderDetailState,
      final CustomerModel? customer,
      final List<CustomerPolicyModel> coupons,
      final List<ProductCheckoutModel> productCheckout,
      final DataBillResponseData? dataBill,
      required final DateTime startDate,
      required final DateTime endDate,
      final String textSearch}) = _$HistoryOrderStateImpl;

  @override
  HistoryOrderEvent get event;
  @override
  HistoryOrderModel? get historyOrderSelect;
  @override
  String get messageError;
  @override
  PageState get getOrderDetailState;
  @override
  CustomerModel? get customer;
  @override // PriceDataBill? billInfo,
  List<CustomerPolicyModel> get coupons;
  @override
  List<ProductCheckoutModel> get productCheckout;
  @override // @Default([]) List<HistoryPolicyResultModel> vouchers,
// @Default([]) List<PaymentMethodDataBill> paymentMethods,
// String? portrait,
// int? amountChildren,
// int? amountAdult,
// String? description,
// @Default([]) List<String> imageConfirms,
  DataBillResponseData? get dataBill;
  @override
  DateTime get startDate;
  @override
  DateTime get endDate;
  @override
  String get textSearch;
  @override
  @JsonKey(ignore: true)
  _$$HistoryOrderStateImplCopyWith<_$HistoryOrderStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
