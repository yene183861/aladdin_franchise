// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'order_offline.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

OrderOffline _$OrderOfflineFromJson(Map<String, dynamic> json) {
  return _OrderOffline.fromJson(json);
}

/// @nodoc
mixin _$OrderOffline {
  OrderModel get order => throw _privateConstructorUsedError;
  DateTime get lastUpdate => throw _privateConstructorUsedError;
  List<CustomerPolicyModel>? get coupons => throw _privateConstructorUsedError;
  CustomerModel? get customer => throw _privateConstructorUsedError;
  List<ProductCheckoutModel> get orderItem =>
      throw _privateConstructorUsedError;
  List<ProductCancelModel> get itemCancels =>
      throw _privateConstructorUsedError;
  List<OrderHistory> get orderHistory => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $OrderOfflineCopyWith<OrderOffline> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OrderOfflineCopyWith<$Res> {
  factory $OrderOfflineCopyWith(
          OrderOffline value, $Res Function(OrderOffline) then) =
      _$OrderOfflineCopyWithImpl<$Res, OrderOffline>;
  @useResult
  $Res call(
      {OrderModel order,
      DateTime lastUpdate,
      List<CustomerPolicyModel>? coupons,
      CustomerModel? customer,
      List<ProductCheckoutModel> orderItem,
      List<ProductCancelModel> itemCancels,
      List<OrderHistory> orderHistory});

  $OrderModelCopyWith<$Res> get order;
  $CustomerModelCopyWith<$Res>? get customer;
}

/// @nodoc
class _$OrderOfflineCopyWithImpl<$Res, $Val extends OrderOffline>
    implements $OrderOfflineCopyWith<$Res> {
  _$OrderOfflineCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? order = null,
    Object? lastUpdate = null,
    Object? coupons = freezed,
    Object? customer = freezed,
    Object? orderItem = null,
    Object? itemCancels = null,
    Object? orderHistory = null,
  }) {
    return _then(_value.copyWith(
      order: null == order
          ? _value.order
          : order // ignore: cast_nullable_to_non_nullable
              as OrderModel,
      lastUpdate: null == lastUpdate
          ? _value.lastUpdate
          : lastUpdate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      coupons: freezed == coupons
          ? _value.coupons
          : coupons // ignore: cast_nullable_to_non_nullable
              as List<CustomerPolicyModel>?,
      customer: freezed == customer
          ? _value.customer
          : customer // ignore: cast_nullable_to_non_nullable
              as CustomerModel?,
      orderItem: null == orderItem
          ? _value.orderItem
          : orderItem // ignore: cast_nullable_to_non_nullable
              as List<ProductCheckoutModel>,
      itemCancels: null == itemCancels
          ? _value.itemCancels
          : itemCancels // ignore: cast_nullable_to_non_nullable
              as List<ProductCancelModel>,
      orderHistory: null == orderHistory
          ? _value.orderHistory
          : orderHistory // ignore: cast_nullable_to_non_nullable
              as List<OrderHistory>,
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
abstract class _$$OrderOfflineImplCopyWith<$Res>
    implements $OrderOfflineCopyWith<$Res> {
  factory _$$OrderOfflineImplCopyWith(
          _$OrderOfflineImpl value, $Res Function(_$OrderOfflineImpl) then) =
      __$$OrderOfflineImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {OrderModel order,
      DateTime lastUpdate,
      List<CustomerPolicyModel>? coupons,
      CustomerModel? customer,
      List<ProductCheckoutModel> orderItem,
      List<ProductCancelModel> itemCancels,
      List<OrderHistory> orderHistory});

  @override
  $OrderModelCopyWith<$Res> get order;
  @override
  $CustomerModelCopyWith<$Res>? get customer;
}

/// @nodoc
class __$$OrderOfflineImplCopyWithImpl<$Res>
    extends _$OrderOfflineCopyWithImpl<$Res, _$OrderOfflineImpl>
    implements _$$OrderOfflineImplCopyWith<$Res> {
  __$$OrderOfflineImplCopyWithImpl(
      _$OrderOfflineImpl _value, $Res Function(_$OrderOfflineImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? order = null,
    Object? lastUpdate = null,
    Object? coupons = freezed,
    Object? customer = freezed,
    Object? orderItem = null,
    Object? itemCancels = null,
    Object? orderHistory = null,
  }) {
    return _then(_$OrderOfflineImpl(
      order: null == order
          ? _value.order
          : order // ignore: cast_nullable_to_non_nullable
              as OrderModel,
      lastUpdate: null == lastUpdate
          ? _value.lastUpdate
          : lastUpdate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      coupons: freezed == coupons
          ? _value._coupons
          : coupons // ignore: cast_nullable_to_non_nullable
              as List<CustomerPolicyModel>?,
      customer: freezed == customer
          ? _value.customer
          : customer // ignore: cast_nullable_to_non_nullable
              as CustomerModel?,
      orderItem: null == orderItem
          ? _value._orderItem
          : orderItem // ignore: cast_nullable_to_non_nullable
              as List<ProductCheckoutModel>,
      itemCancels: null == itemCancels
          ? _value._itemCancels
          : itemCancels // ignore: cast_nullable_to_non_nullable
              as List<ProductCancelModel>,
      orderHistory: null == orderHistory
          ? _value._orderHistory
          : orderHistory // ignore: cast_nullable_to_non_nullable
              as List<OrderHistory>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$OrderOfflineImpl extends _OrderOffline with DiagnosticableTreeMixin {
  const _$OrderOfflineImpl(
      {required this.order,
      required this.lastUpdate,
      final List<CustomerPolicyModel>? coupons,
      this.customer,
      final List<ProductCheckoutModel> orderItem = const [],
      final List<ProductCancelModel> itemCancels = const [],
      final List<OrderHistory> orderHistory = const []})
      : _coupons = coupons,
        _orderItem = orderItem,
        _itemCancels = itemCancels,
        _orderHistory = orderHistory,
        super._();

  factory _$OrderOfflineImpl.fromJson(Map<String, dynamic> json) =>
      _$$OrderOfflineImplFromJson(json);

  @override
  final OrderModel order;
  @override
  final DateTime lastUpdate;
  final List<CustomerPolicyModel>? _coupons;
  @override
  List<CustomerPolicyModel>? get coupons {
    final value = _coupons;
    if (value == null) return null;
    if (_coupons is EqualUnmodifiableListView) return _coupons;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final CustomerModel? customer;
  final List<ProductCheckoutModel> _orderItem;
  @override
  @JsonKey()
  List<ProductCheckoutModel> get orderItem {
    if (_orderItem is EqualUnmodifiableListView) return _orderItem;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_orderItem);
  }

  final List<ProductCancelModel> _itemCancels;
  @override
  @JsonKey()
  List<ProductCancelModel> get itemCancels {
    if (_itemCancels is EqualUnmodifiableListView) return _itemCancels;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_itemCancels);
  }

  final List<OrderHistory> _orderHistory;
  @override
  @JsonKey()
  List<OrderHistory> get orderHistory {
    if (_orderHistory is EqualUnmodifiableListView) return _orderHistory;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_orderHistory);
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'OrderOffline(order: $order, lastUpdate: $lastUpdate, coupons: $coupons, customer: $customer, orderItem: $orderItem, itemCancels: $itemCancels, orderHistory: $orderHistory)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'OrderOffline'))
      ..add(DiagnosticsProperty('order', order))
      ..add(DiagnosticsProperty('lastUpdate', lastUpdate))
      ..add(DiagnosticsProperty('coupons', coupons))
      ..add(DiagnosticsProperty('customer', customer))
      ..add(DiagnosticsProperty('orderItem', orderItem))
      ..add(DiagnosticsProperty('itemCancels', itemCancels))
      ..add(DiagnosticsProperty('orderHistory', orderHistory));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OrderOfflineImpl &&
            (identical(other.order, order) || other.order == order) &&
            (identical(other.lastUpdate, lastUpdate) ||
                other.lastUpdate == lastUpdate) &&
            const DeepCollectionEquality().equals(other._coupons, _coupons) &&
            (identical(other.customer, customer) ||
                other.customer == customer) &&
            const DeepCollectionEquality()
                .equals(other._orderItem, _orderItem) &&
            const DeepCollectionEquality()
                .equals(other._itemCancels, _itemCancels) &&
            const DeepCollectionEquality()
                .equals(other._orderHistory, _orderHistory));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      order,
      lastUpdate,
      const DeepCollectionEquality().hash(_coupons),
      customer,
      const DeepCollectionEquality().hash(_orderItem),
      const DeepCollectionEquality().hash(_itemCancels),
      const DeepCollectionEquality().hash(_orderHistory));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$OrderOfflineImplCopyWith<_$OrderOfflineImpl> get copyWith =>
      __$$OrderOfflineImplCopyWithImpl<_$OrderOfflineImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OrderOfflineImplToJson(
      this,
    );
  }
}

abstract class _OrderOffline extends OrderOffline {
  const factory _OrderOffline(
      {required final OrderModel order,
      required final DateTime lastUpdate,
      final List<CustomerPolicyModel>? coupons,
      final CustomerModel? customer,
      final List<ProductCheckoutModel> orderItem,
      final List<ProductCancelModel> itemCancels,
      final List<OrderHistory> orderHistory}) = _$OrderOfflineImpl;
  const _OrderOffline._() : super._();

  factory _OrderOffline.fromJson(Map<String, dynamic> json) =
      _$OrderOfflineImpl.fromJson;

  @override
  OrderModel get order;
  @override
  DateTime get lastUpdate;
  @override
  List<CustomerPolicyModel>? get coupons;
  @override
  CustomerModel? get customer;
  @override
  List<ProductCheckoutModel> get orderItem;
  @override
  List<ProductCancelModel> get itemCancels;
  @override
  List<OrderHistory> get orderHistory;
  @override
  @JsonKey(ignore: true)
  _$$OrderOfflineImplCopyWith<_$OrderOfflineImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
