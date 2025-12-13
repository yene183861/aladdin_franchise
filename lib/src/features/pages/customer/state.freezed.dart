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
  CustomerModel? get customer => throw _privateConstructorUsedError;
  List<ProductModel> get products => throw _privateConstructorUsedError;
  PriceDataBill? get price => throw _privateConstructorUsedError;
  OrderModel? get order => throw _privateConstructorUsedError;
  String get completeNote => throw _privateConstructorUsedError;
  String get kitchenNote => throw _privateConstructorUsedError;
  UserBankModel? get bankSelect => throw _privateConstructorUsedError;
  String get payooGatewayUrl => throw _privateConstructorUsedError;

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
      int? changedProductId,
      CustomerModel? customer,
      List<ProductModel> products,
      PriceDataBill? price,
      OrderModel? order,
      String completeNote,
      String kitchenNote,
      UserBankModel? bankSelect,
      String payooGatewayUrl});

  $PaymentMethodCopyWith<$Res>? get paymentMethodSelect;
  $CustomerModelCopyWith<$Res>? get customer;
  $PriceDataBillCopyWith<$Res>? get price;
  $OrderModelCopyWith<$Res>? get order;
  $UserBankModelCopyWith<$Res>? get bankSelect;
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
    Object? customer = freezed,
    Object? products = null,
    Object? price = freezed,
    Object? order = freezed,
    Object? completeNote = null,
    Object? kitchenNote = null,
    Object? bankSelect = freezed,
    Object? payooGatewayUrl = null,
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
      customer: freezed == customer
          ? _value.customer
          : customer // ignore: cast_nullable_to_non_nullable
              as CustomerModel?,
      products: null == products
          ? _value.products
          : products // ignore: cast_nullable_to_non_nullable
              as List<ProductModel>,
      price: freezed == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as PriceDataBill?,
      order: freezed == order
          ? _value.order
          : order // ignore: cast_nullable_to_non_nullable
              as OrderModel?,
      completeNote: null == completeNote
          ? _value.completeNote
          : completeNote // ignore: cast_nullable_to_non_nullable
              as String,
      kitchenNote: null == kitchenNote
          ? _value.kitchenNote
          : kitchenNote // ignore: cast_nullable_to_non_nullable
              as String,
      bankSelect: freezed == bankSelect
          ? _value.bankSelect
          : bankSelect // ignore: cast_nullable_to_non_nullable
              as UserBankModel?,
      payooGatewayUrl: null == payooGatewayUrl
          ? _value.payooGatewayUrl
          : payooGatewayUrl // ignore: cast_nullable_to_non_nullable
              as String,
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
  $PriceDataBillCopyWith<$Res>? get price {
    if (_value.price == null) {
      return null;
    }

    return $PriceDataBillCopyWith<$Res>(_value.price!, (value) {
      return _then(_value.copyWith(price: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $OrderModelCopyWith<$Res>? get order {
    if (_value.order == null) {
      return null;
    }

    return $OrderModelCopyWith<$Res>(_value.order!, (value) {
      return _then(_value.copyWith(order: value) as $Val);
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
      int? changedProductId,
      CustomerModel? customer,
      List<ProductModel> products,
      PriceDataBill? price,
      OrderModel? order,
      String completeNote,
      String kitchenNote,
      UserBankModel? bankSelect,
      String payooGatewayUrl});

  @override
  $PaymentMethodCopyWith<$Res>? get paymentMethodSelect;
  @override
  $CustomerModelCopyWith<$Res>? get customer;
  @override
  $PriceDataBillCopyWith<$Res>? get price;
  @override
  $OrderModelCopyWith<$Res>? get order;
  @override
  $UserBankModelCopyWith<$Res>? get bankSelect;
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
    Object? customer = freezed,
    Object? products = null,
    Object? price = freezed,
    Object? order = freezed,
    Object? completeNote = null,
    Object? kitchenNote = null,
    Object? bankSelect = freezed,
    Object? payooGatewayUrl = null,
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
      customer: freezed == customer
          ? _value.customer
          : customer // ignore: cast_nullable_to_non_nullable
              as CustomerModel?,
      products: null == products
          ? _value._products
          : products // ignore: cast_nullable_to_non_nullable
              as List<ProductModel>,
      price: freezed == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as PriceDataBill?,
      order: freezed == order
          ? _value.order
          : order // ignore: cast_nullable_to_non_nullable
              as OrderModel?,
      completeNote: null == completeNote
          ? _value.completeNote
          : completeNote // ignore: cast_nullable_to_non_nullable
              as String,
      kitchenNote: null == kitchenNote
          ? _value.kitchenNote
          : kitchenNote // ignore: cast_nullable_to_non_nullable
              as String,
      bankSelect: freezed == bankSelect
          ? _value.bankSelect
          : bankSelect // ignore: cast_nullable_to_non_nullable
              as UserBankModel?,
      payooGatewayUrl: null == payooGatewayUrl
          ? _value.payooGatewayUrl
          : payooGatewayUrl // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$CustomerPageStateImpl implements _CustomerPageState {
  const _$CustomerPageStateImpl(
      {this.paymentMethodSelect,
      this.gatewayUrl = '',
      this.autoScrollProducts = true,
      this.changedProductId,
      this.customer,
      final List<ProductModel> products = const [],
      this.price,
      this.order,
      this.completeNote = '',
      this.kitchenNote = '',
      this.bankSelect,
      this.payooGatewayUrl = ''})
      : _products = products;

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
  final CustomerModel? customer;
  final List<ProductModel> _products;
  @override
  @JsonKey()
  List<ProductModel> get products {
    if (_products is EqualUnmodifiableListView) return _products;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_products);
  }

  @override
  final PriceDataBill? price;
  @override
  final OrderModel? order;
  @override
  @JsonKey()
  final String completeNote;
  @override
  @JsonKey()
  final String kitchenNote;
  @override
  final UserBankModel? bankSelect;
  @override
  @JsonKey()
  final String payooGatewayUrl;

  @override
  String toString() {
    return 'CustomerPageState(paymentMethodSelect: $paymentMethodSelect, gatewayUrl: $gatewayUrl, autoScrollProducts: $autoScrollProducts, changedProductId: $changedProductId, customer: $customer, products: $products, price: $price, order: $order, completeNote: $completeNote, kitchenNote: $kitchenNote, bankSelect: $bankSelect, payooGatewayUrl: $payooGatewayUrl)';
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
                other.changedProductId == changedProductId) &&
            (identical(other.customer, customer) ||
                other.customer == customer) &&
            const DeepCollectionEquality().equals(other._products, _products) &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.order, order) || other.order == order) &&
            (identical(other.completeNote, completeNote) ||
                other.completeNote == completeNote) &&
            (identical(other.kitchenNote, kitchenNote) ||
                other.kitchenNote == kitchenNote) &&
            (identical(other.bankSelect, bankSelect) ||
                other.bankSelect == bankSelect) &&
            (identical(other.payooGatewayUrl, payooGatewayUrl) ||
                other.payooGatewayUrl == payooGatewayUrl));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      paymentMethodSelect,
      gatewayUrl,
      autoScrollProducts,
      changedProductId,
      customer,
      const DeepCollectionEquality().hash(_products),
      price,
      order,
      completeNote,
      kitchenNote,
      bankSelect,
      payooGatewayUrl);

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
      final int? changedProductId,
      final CustomerModel? customer,
      final List<ProductModel> products,
      final PriceDataBill? price,
      final OrderModel? order,
      final String completeNote,
      final String kitchenNote,
      final UserBankModel? bankSelect,
      final String payooGatewayUrl}) = _$CustomerPageStateImpl;

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
  CustomerModel? get customer;
  @override
  List<ProductModel> get products;
  @override
  PriceDataBill? get price;
  @override
  OrderModel? get order;
  @override
  String get completeNote;
  @override
  String get kitchenNote;
  @override
  UserBankModel? get bankSelect;
  @override
  String get payooGatewayUrl;
  @override
  @JsonKey(ignore: true)
  _$$CustomerPageStateImplCopyWith<_$CustomerPageStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
