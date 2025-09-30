// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'info_policy_checkout.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

InfoPolicyCheckoutModel _$InfoPolicyCheckoutModelFromJson(
    Map<String, dynamic> json) {
  return _InfoPolicyCheckoutModel.fromJson(json);
}

/// @nodoc
mixin _$InfoPolicyCheckoutModel {
  int get orderId => throw _privateConstructorUsedError;
  CustomerModel? get customer => throw _privateConstructorUsedError;
  List<CustomerPolicyModel>? get customerPolicies =>
      throw _privateConstructorUsedError;
  List<CustomerPolicyModel>? get customerPolicySelects =>
      throw _privateConstructorUsedError;
  List<CustomerPolicyModel>? get coupons => throw _privateConstructorUsedError;
  List<PolicyResultModel>? get vouchers => throw _privateConstructorUsedError;
  dynamic get createVouchers => throw _privateConstructorUsedError;
  double? get totalDiscount => throw _privateConstructorUsedError;
  int? get pointUse => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $InfoPolicyCheckoutModelCopyWith<InfoPolicyCheckoutModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InfoPolicyCheckoutModelCopyWith<$Res> {
  factory $InfoPolicyCheckoutModelCopyWith(InfoPolicyCheckoutModel value,
          $Res Function(InfoPolicyCheckoutModel) then) =
      _$InfoPolicyCheckoutModelCopyWithImpl<$Res, InfoPolicyCheckoutModel>;
  @useResult
  $Res call(
      {int orderId,
      CustomerModel? customer,
      List<CustomerPolicyModel>? customerPolicies,
      List<CustomerPolicyModel>? customerPolicySelects,
      List<CustomerPolicyModel>? coupons,
      List<PolicyResultModel>? vouchers,
      dynamic createVouchers,
      double? totalDiscount,
      int? pointUse});

  $CustomerModelCopyWith<$Res>? get customer;
}

/// @nodoc
class _$InfoPolicyCheckoutModelCopyWithImpl<$Res,
        $Val extends InfoPolicyCheckoutModel>
    implements $InfoPolicyCheckoutModelCopyWith<$Res> {
  _$InfoPolicyCheckoutModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? orderId = null,
    Object? customer = freezed,
    Object? customerPolicies = freezed,
    Object? customerPolicySelects = freezed,
    Object? coupons = freezed,
    Object? vouchers = freezed,
    Object? createVouchers = freezed,
    Object? totalDiscount = freezed,
    Object? pointUse = freezed,
  }) {
    return _then(_value.copyWith(
      orderId: null == orderId
          ? _value.orderId
          : orderId // ignore: cast_nullable_to_non_nullable
              as int,
      customer: freezed == customer
          ? _value.customer
          : customer // ignore: cast_nullable_to_non_nullable
              as CustomerModel?,
      customerPolicies: freezed == customerPolicies
          ? _value.customerPolicies
          : customerPolicies // ignore: cast_nullable_to_non_nullable
              as List<CustomerPolicyModel>?,
      customerPolicySelects: freezed == customerPolicySelects
          ? _value.customerPolicySelects
          : customerPolicySelects // ignore: cast_nullable_to_non_nullable
              as List<CustomerPolicyModel>?,
      coupons: freezed == coupons
          ? _value.coupons
          : coupons // ignore: cast_nullable_to_non_nullable
              as List<CustomerPolicyModel>?,
      vouchers: freezed == vouchers
          ? _value.vouchers
          : vouchers // ignore: cast_nullable_to_non_nullable
              as List<PolicyResultModel>?,
      createVouchers: freezed == createVouchers
          ? _value.createVouchers
          : createVouchers // ignore: cast_nullable_to_non_nullable
              as dynamic,
      totalDiscount: freezed == totalDiscount
          ? _value.totalDiscount
          : totalDiscount // ignore: cast_nullable_to_non_nullable
              as double?,
      pointUse: freezed == pointUse
          ? _value.pointUse
          : pointUse // ignore: cast_nullable_to_non_nullable
              as int?,
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
}

/// @nodoc
abstract class _$$InfoPolicyCheckoutModelImplCopyWith<$Res>
    implements $InfoPolicyCheckoutModelCopyWith<$Res> {
  factory _$$InfoPolicyCheckoutModelImplCopyWith(
          _$InfoPolicyCheckoutModelImpl value,
          $Res Function(_$InfoPolicyCheckoutModelImpl) then) =
      __$$InfoPolicyCheckoutModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int orderId,
      CustomerModel? customer,
      List<CustomerPolicyModel>? customerPolicies,
      List<CustomerPolicyModel>? customerPolicySelects,
      List<CustomerPolicyModel>? coupons,
      List<PolicyResultModel>? vouchers,
      dynamic createVouchers,
      double? totalDiscount,
      int? pointUse});

  @override
  $CustomerModelCopyWith<$Res>? get customer;
}

/// @nodoc
class __$$InfoPolicyCheckoutModelImplCopyWithImpl<$Res>
    extends _$InfoPolicyCheckoutModelCopyWithImpl<$Res,
        _$InfoPolicyCheckoutModelImpl>
    implements _$$InfoPolicyCheckoutModelImplCopyWith<$Res> {
  __$$InfoPolicyCheckoutModelImplCopyWithImpl(
      _$InfoPolicyCheckoutModelImpl _value,
      $Res Function(_$InfoPolicyCheckoutModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? orderId = null,
    Object? customer = freezed,
    Object? customerPolicies = freezed,
    Object? customerPolicySelects = freezed,
    Object? coupons = freezed,
    Object? vouchers = freezed,
    Object? createVouchers = freezed,
    Object? totalDiscount = freezed,
    Object? pointUse = freezed,
  }) {
    return _then(_$InfoPolicyCheckoutModelImpl(
      orderId: null == orderId
          ? _value.orderId
          : orderId // ignore: cast_nullable_to_non_nullable
              as int,
      customer: freezed == customer
          ? _value.customer
          : customer // ignore: cast_nullable_to_non_nullable
              as CustomerModel?,
      customerPolicies: freezed == customerPolicies
          ? _value._customerPolicies
          : customerPolicies // ignore: cast_nullable_to_non_nullable
              as List<CustomerPolicyModel>?,
      customerPolicySelects: freezed == customerPolicySelects
          ? _value._customerPolicySelects
          : customerPolicySelects // ignore: cast_nullable_to_non_nullable
              as List<CustomerPolicyModel>?,
      coupons: freezed == coupons
          ? _value._coupons
          : coupons // ignore: cast_nullable_to_non_nullable
              as List<CustomerPolicyModel>?,
      vouchers: freezed == vouchers
          ? _value._vouchers
          : vouchers // ignore: cast_nullable_to_non_nullable
              as List<PolicyResultModel>?,
      createVouchers: freezed == createVouchers
          ? _value.createVouchers
          : createVouchers // ignore: cast_nullable_to_non_nullable
              as dynamic,
      totalDiscount: freezed == totalDiscount
          ? _value.totalDiscount
          : totalDiscount // ignore: cast_nullable_to_non_nullable
              as double?,
      pointUse: freezed == pointUse
          ? _value.pointUse
          : pointUse // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class _$InfoPolicyCheckoutModelImpl extends _InfoPolicyCheckoutModel
    with DiagnosticableTreeMixin {
  const _$InfoPolicyCheckoutModelImpl(
      {required this.orderId,
      this.customer,
      final List<CustomerPolicyModel>? customerPolicies,
      final List<CustomerPolicyModel>? customerPolicySelects,
      final List<CustomerPolicyModel>? coupons,
      final List<PolicyResultModel>? vouchers,
      this.createVouchers,
      this.totalDiscount,
      this.pointUse})
      : _customerPolicies = customerPolicies,
        _customerPolicySelects = customerPolicySelects,
        _coupons = coupons,
        _vouchers = vouchers,
        super._();

  factory _$InfoPolicyCheckoutModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$InfoPolicyCheckoutModelImplFromJson(json);

  @override
  final int orderId;
  @override
  final CustomerModel? customer;
  final List<CustomerPolicyModel>? _customerPolicies;
  @override
  List<CustomerPolicyModel>? get customerPolicies {
    final value = _customerPolicies;
    if (value == null) return null;
    if (_customerPolicies is EqualUnmodifiableListView)
      return _customerPolicies;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<CustomerPolicyModel>? _customerPolicySelects;
  @override
  List<CustomerPolicyModel>? get customerPolicySelects {
    final value = _customerPolicySelects;
    if (value == null) return null;
    if (_customerPolicySelects is EqualUnmodifiableListView)
      return _customerPolicySelects;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<CustomerPolicyModel>? _coupons;
  @override
  List<CustomerPolicyModel>? get coupons {
    final value = _coupons;
    if (value == null) return null;
    if (_coupons is EqualUnmodifiableListView) return _coupons;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<PolicyResultModel>? _vouchers;
  @override
  List<PolicyResultModel>? get vouchers {
    final value = _vouchers;
    if (value == null) return null;
    if (_vouchers is EqualUnmodifiableListView) return _vouchers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final dynamic createVouchers;
  @override
  final double? totalDiscount;
  @override
  final int? pointUse;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'InfoPolicyCheckoutModel(orderId: $orderId, customer: $customer, customerPolicies: $customerPolicies, customerPolicySelects: $customerPolicySelects, coupons: $coupons, vouchers: $vouchers, createVouchers: $createVouchers, totalDiscount: $totalDiscount, pointUse: $pointUse)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'InfoPolicyCheckoutModel'))
      ..add(DiagnosticsProperty('orderId', orderId))
      ..add(DiagnosticsProperty('customer', customer))
      ..add(DiagnosticsProperty('customerPolicies', customerPolicies))
      ..add(DiagnosticsProperty('customerPolicySelects', customerPolicySelects))
      ..add(DiagnosticsProperty('coupons', coupons))
      ..add(DiagnosticsProperty('vouchers', vouchers))
      ..add(DiagnosticsProperty('createVouchers', createVouchers))
      ..add(DiagnosticsProperty('totalDiscount', totalDiscount))
      ..add(DiagnosticsProperty('pointUse', pointUse));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InfoPolicyCheckoutModelImpl &&
            (identical(other.orderId, orderId) || other.orderId == orderId) &&
            (identical(other.customer, customer) ||
                other.customer == customer) &&
            const DeepCollectionEquality()
                .equals(other._customerPolicies, _customerPolicies) &&
            const DeepCollectionEquality()
                .equals(other._customerPolicySelects, _customerPolicySelects) &&
            const DeepCollectionEquality().equals(other._coupons, _coupons) &&
            const DeepCollectionEquality().equals(other._vouchers, _vouchers) &&
            const DeepCollectionEquality()
                .equals(other.createVouchers, createVouchers) &&
            (identical(other.totalDiscount, totalDiscount) ||
                other.totalDiscount == totalDiscount) &&
            (identical(other.pointUse, pointUse) ||
                other.pointUse == pointUse));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      orderId,
      customer,
      const DeepCollectionEquality().hash(_customerPolicies),
      const DeepCollectionEquality().hash(_customerPolicySelects),
      const DeepCollectionEquality().hash(_coupons),
      const DeepCollectionEquality().hash(_vouchers),
      const DeepCollectionEquality().hash(createVouchers),
      totalDiscount,
      pointUse);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$InfoPolicyCheckoutModelImplCopyWith<_$InfoPolicyCheckoutModelImpl>
      get copyWith => __$$InfoPolicyCheckoutModelImplCopyWithImpl<
          _$InfoPolicyCheckoutModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$InfoPolicyCheckoutModelImplToJson(
      this,
    );
  }
}

abstract class _InfoPolicyCheckoutModel extends InfoPolicyCheckoutModel {
  const factory _InfoPolicyCheckoutModel(
      {required final int orderId,
      final CustomerModel? customer,
      final List<CustomerPolicyModel>? customerPolicies,
      final List<CustomerPolicyModel>? customerPolicySelects,
      final List<CustomerPolicyModel>? coupons,
      final List<PolicyResultModel>? vouchers,
      final dynamic createVouchers,
      final double? totalDiscount,
      final int? pointUse}) = _$InfoPolicyCheckoutModelImpl;
  const _InfoPolicyCheckoutModel._() : super._();

  factory _InfoPolicyCheckoutModel.fromJson(Map<String, dynamic> json) =
      _$InfoPolicyCheckoutModelImpl.fromJson;

  @override
  int get orderId;
  @override
  CustomerModel? get customer;
  @override
  List<CustomerPolicyModel>? get customerPolicies;
  @override
  List<CustomerPolicyModel>? get customerPolicySelects;
  @override
  List<CustomerPolicyModel>? get coupons;
  @override
  List<PolicyResultModel>? get vouchers;
  @override
  dynamic get createVouchers;
  @override
  double? get totalDiscount;
  @override
  int? get pointUse;
  @override
  @JsonKey(ignore: true)
  _$$InfoPolicyCheckoutModelImplCopyWith<_$InfoPolicyCheckoutModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}
