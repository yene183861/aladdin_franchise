// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'detail_history_order_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$DetailHistoryOrderModel {
  CustomerModel? get customer => throw _privateConstructorUsedError;
  List<CustomerPolicyModel> get coupons => throw _privateConstructorUsedError;
  List<ProductCheckoutModel> get productCheckout =>
      throw _privateConstructorUsedError;
  DataBillResponseData? get dataBill => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $DetailHistoryOrderModelCopyWith<DetailHistoryOrderModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DetailHistoryOrderModelCopyWith<$Res> {
  factory $DetailHistoryOrderModelCopyWith(DetailHistoryOrderModel value,
          $Res Function(DetailHistoryOrderModel) then) =
      _$DetailHistoryOrderModelCopyWithImpl<$Res, DetailHistoryOrderModel>;
  @useResult
  $Res call(
      {CustomerModel? customer,
      List<CustomerPolicyModel> coupons,
      List<ProductCheckoutModel> productCheckout,
      DataBillResponseData? dataBill});

  $CustomerModelCopyWith<$Res>? get customer;
  $DataBillResponseDataCopyWith<$Res>? get dataBill;
}

/// @nodoc
class _$DetailHistoryOrderModelCopyWithImpl<$Res,
        $Val extends DetailHistoryOrderModel>
    implements $DetailHistoryOrderModelCopyWith<$Res> {
  _$DetailHistoryOrderModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? customer = freezed,
    Object? coupons = null,
    Object? productCheckout = null,
    Object? dataBill = freezed,
  }) {
    return _then(_value.copyWith(
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
    ) as $Val);
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
abstract class _$$DetailHistoryOrderModelImplCopyWith<$Res>
    implements $DetailHistoryOrderModelCopyWith<$Res> {
  factory _$$DetailHistoryOrderModelImplCopyWith(
          _$DetailHistoryOrderModelImpl value,
          $Res Function(_$DetailHistoryOrderModelImpl) then) =
      __$$DetailHistoryOrderModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {CustomerModel? customer,
      List<CustomerPolicyModel> coupons,
      List<ProductCheckoutModel> productCheckout,
      DataBillResponseData? dataBill});

  @override
  $CustomerModelCopyWith<$Res>? get customer;
  @override
  $DataBillResponseDataCopyWith<$Res>? get dataBill;
}

/// @nodoc
class __$$DetailHistoryOrderModelImplCopyWithImpl<$Res>
    extends _$DetailHistoryOrderModelCopyWithImpl<$Res,
        _$DetailHistoryOrderModelImpl>
    implements _$$DetailHistoryOrderModelImplCopyWith<$Res> {
  __$$DetailHistoryOrderModelImplCopyWithImpl(
      _$DetailHistoryOrderModelImpl _value,
      $Res Function(_$DetailHistoryOrderModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? customer = freezed,
    Object? coupons = null,
    Object? productCheckout = null,
    Object? dataBill = freezed,
  }) {
    return _then(_$DetailHistoryOrderModelImpl(
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
    ));
  }
}

/// @nodoc

class _$DetailHistoryOrderModelImpl implements _DetailHistoryOrderModel {
  const _$DetailHistoryOrderModelImpl(
      {this.customer,
      final List<CustomerPolicyModel> coupons = const [],
      final List<ProductCheckoutModel> productCheckout = const [],
      this.dataBill})
      : _coupons = coupons,
        _productCheckout = productCheckout;

  @override
  final CustomerModel? customer;
  final List<CustomerPolicyModel> _coupons;
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

  @override
  final DataBillResponseData? dataBill;

  @override
  String toString() {
    return 'DetailHistoryOrderModel(customer: $customer, coupons: $coupons, productCheckout: $productCheckout, dataBill: $dataBill)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DetailHistoryOrderModelImpl &&
            (identical(other.customer, customer) ||
                other.customer == customer) &&
            const DeepCollectionEquality().equals(other._coupons, _coupons) &&
            const DeepCollectionEquality()
                .equals(other._productCheckout, _productCheckout) &&
            (identical(other.dataBill, dataBill) ||
                other.dataBill == dataBill));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      customer,
      const DeepCollectionEquality().hash(_coupons),
      const DeepCollectionEquality().hash(_productCheckout),
      dataBill);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DetailHistoryOrderModelImplCopyWith<_$DetailHistoryOrderModelImpl>
      get copyWith => __$$DetailHistoryOrderModelImplCopyWithImpl<
          _$DetailHistoryOrderModelImpl>(this, _$identity);
}

abstract class _DetailHistoryOrderModel implements DetailHistoryOrderModel {
  const factory _DetailHistoryOrderModel(
      {final CustomerModel? customer,
      final List<CustomerPolicyModel> coupons,
      final List<ProductCheckoutModel> productCheckout,
      final DataBillResponseData? dataBill}) = _$DetailHistoryOrderModelImpl;

  @override
  CustomerModel? get customer;
  @override
  List<CustomerPolicyModel> get coupons;
  @override
  List<ProductCheckoutModel> get productCheckout;
  @override
  DataBillResponseData? get dataBill;
  @override
  @JsonKey(ignore: true)
  _$$DetailHistoryOrderModelImplCopyWith<_$DetailHistoryOrderModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}
