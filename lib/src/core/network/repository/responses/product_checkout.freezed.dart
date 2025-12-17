// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'product_checkout.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ProductCheckoutResponse _$ProductCheckoutResponseFromJson(
    Map<String, dynamic> json) {
  return _ProductCheckoutResponse.fromJson(json);
}

/// @nodoc
mixin _$ProductCheckoutResponse {
  int? get status => throw _privateConstructorUsedError;
  List<ProductCheckoutResponseData>? get data =>
      throw _privateConstructorUsedError;
  dynamic get message => throw _privateConstructorUsedError;
  List<CustomerPolicyModel>? get coupons => throw _privateConstructorUsedError;
  CustomerModel? get customer => throw _privateConstructorUsedError;
  @JsonKey(name: "numberOfAdults")
  int get numberOfAdults => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ProductCheckoutResponseCopyWith<ProductCheckoutResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProductCheckoutResponseCopyWith<$Res> {
  factory $ProductCheckoutResponseCopyWith(ProductCheckoutResponse value,
          $Res Function(ProductCheckoutResponse) then) =
      _$ProductCheckoutResponseCopyWithImpl<$Res, ProductCheckoutResponse>;
  @useResult
  $Res call(
      {int? status,
      List<ProductCheckoutResponseData>? data,
      dynamic message,
      List<CustomerPolicyModel>? coupons,
      CustomerModel? customer,
      @JsonKey(name: "numberOfAdults") int numberOfAdults});

  $CustomerModelCopyWith<$Res>? get customer;
}

/// @nodoc
class _$ProductCheckoutResponseCopyWithImpl<$Res,
        $Val extends ProductCheckoutResponse>
    implements $ProductCheckoutResponseCopyWith<$Res> {
  _$ProductCheckoutResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = freezed,
    Object? data = freezed,
    Object? message = freezed,
    Object? coupons = freezed,
    Object? customer = freezed,
    Object? numberOfAdults = null,
  }) {
    return _then(_value.copyWith(
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as int?,
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as List<ProductCheckoutResponseData>?,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as dynamic,
      coupons: freezed == coupons
          ? _value.coupons
          : coupons // ignore: cast_nullable_to_non_nullable
              as List<CustomerPolicyModel>?,
      customer: freezed == customer
          ? _value.customer
          : customer // ignore: cast_nullable_to_non_nullable
              as CustomerModel?,
      numberOfAdults: null == numberOfAdults
          ? _value.numberOfAdults
          : numberOfAdults // ignore: cast_nullable_to_non_nullable
              as int,
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
abstract class _$$ProductCheckoutResponseImplCopyWith<$Res>
    implements $ProductCheckoutResponseCopyWith<$Res> {
  factory _$$ProductCheckoutResponseImplCopyWith(
          _$ProductCheckoutResponseImpl value,
          $Res Function(_$ProductCheckoutResponseImpl) then) =
      __$$ProductCheckoutResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? status,
      List<ProductCheckoutResponseData>? data,
      dynamic message,
      List<CustomerPolicyModel>? coupons,
      CustomerModel? customer,
      @JsonKey(name: "numberOfAdults") int numberOfAdults});

  @override
  $CustomerModelCopyWith<$Res>? get customer;
}

/// @nodoc
class __$$ProductCheckoutResponseImplCopyWithImpl<$Res>
    extends _$ProductCheckoutResponseCopyWithImpl<$Res,
        _$ProductCheckoutResponseImpl>
    implements _$$ProductCheckoutResponseImplCopyWith<$Res> {
  __$$ProductCheckoutResponseImplCopyWithImpl(
      _$ProductCheckoutResponseImpl _value,
      $Res Function(_$ProductCheckoutResponseImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = freezed,
    Object? data = freezed,
    Object? message = freezed,
    Object? coupons = freezed,
    Object? customer = freezed,
    Object? numberOfAdults = null,
  }) {
    return _then(_$ProductCheckoutResponseImpl(
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as int?,
      data: freezed == data
          ? _value._data
          : data // ignore: cast_nullable_to_non_nullable
              as List<ProductCheckoutResponseData>?,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as dynamic,
      coupons: freezed == coupons
          ? _value._coupons
          : coupons // ignore: cast_nullable_to_non_nullable
              as List<CustomerPolicyModel>?,
      customer: freezed == customer
          ? _value.customer
          : customer // ignore: cast_nullable_to_non_nullable
              as CustomerModel?,
      numberOfAdults: null == numberOfAdults
          ? _value.numberOfAdults
          : numberOfAdults // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class _$ProductCheckoutResponseImpl
    with DiagnosticableTreeMixin
    implements _ProductCheckoutResponse {
  const _$ProductCheckoutResponseImpl(
      {required this.status,
      final List<ProductCheckoutResponseData>? data,
      this.message,
      final List<CustomerPolicyModel>? coupons,
      this.customer,
      @JsonKey(name: "numberOfAdults") this.numberOfAdults = 1})
      : _data = data,
        _coupons = coupons;

  factory _$ProductCheckoutResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProductCheckoutResponseImplFromJson(json);

  @override
  final int? status;
  final List<ProductCheckoutResponseData>? _data;
  @override
  List<ProductCheckoutResponseData>? get data {
    final value = _data;
    if (value == null) return null;
    if (_data is EqualUnmodifiableListView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final dynamic message;
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
  @override
  @JsonKey(name: "numberOfAdults")
  final int numberOfAdults;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ProductCheckoutResponse(status: $status, data: $data, message: $message, coupons: $coupons, customer: $customer, numberOfAdults: $numberOfAdults)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'ProductCheckoutResponse'))
      ..add(DiagnosticsProperty('status', status))
      ..add(DiagnosticsProperty('data', data))
      ..add(DiagnosticsProperty('message', message))
      ..add(DiagnosticsProperty('coupons', coupons))
      ..add(DiagnosticsProperty('customer', customer))
      ..add(DiagnosticsProperty('numberOfAdults', numberOfAdults));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProductCheckoutResponseImpl &&
            (identical(other.status, status) || other.status == status) &&
            const DeepCollectionEquality().equals(other._data, _data) &&
            const DeepCollectionEquality().equals(other.message, message) &&
            const DeepCollectionEquality().equals(other._coupons, _coupons) &&
            (identical(other.customer, customer) ||
                other.customer == customer) &&
            (identical(other.numberOfAdults, numberOfAdults) ||
                other.numberOfAdults == numberOfAdults));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      status,
      const DeepCollectionEquality().hash(_data),
      const DeepCollectionEquality().hash(message),
      const DeepCollectionEquality().hash(_coupons),
      customer,
      numberOfAdults);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ProductCheckoutResponseImplCopyWith<_$ProductCheckoutResponseImpl>
      get copyWith => __$$ProductCheckoutResponseImplCopyWithImpl<
          _$ProductCheckoutResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ProductCheckoutResponseImplToJson(
      this,
    );
  }
}

abstract class _ProductCheckoutResponse implements ProductCheckoutResponse {
  const factory _ProductCheckoutResponse(
          {required final int? status,
          final List<ProductCheckoutResponseData>? data,
          final dynamic message,
          final List<CustomerPolicyModel>? coupons,
          final CustomerModel? customer,
          @JsonKey(name: "numberOfAdults") final int numberOfAdults}) =
      _$ProductCheckoutResponseImpl;

  factory _ProductCheckoutResponse.fromJson(Map<String, dynamic> json) =
      _$ProductCheckoutResponseImpl.fromJson;

  @override
  int? get status;
  @override
  List<ProductCheckoutResponseData>? get data;
  @override
  dynamic get message;
  @override
  List<CustomerPolicyModel>? get coupons;
  @override
  CustomerModel? get customer;
  @override
  @JsonKey(name: "numberOfAdults")
  int get numberOfAdults;
  @override
  @JsonKey(ignore: true)
  _$$ProductCheckoutResponseImplCopyWith<_$ProductCheckoutResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}

ProductCheckoutResponseData _$ProductCheckoutResponseDataFromJson(
    Map<String, dynamic> json) {
  return _ProductCheckoutResponseData.fromJson(json);
}

/// @nodoc
mixin _$ProductCheckoutResponseData {
  int get id => throw _privateConstructorUsedError;
  List<ProductCheckoutModel> get orderItem =>
      throw _privateConstructorUsedError;
  bool get statusCancel => throw _privateConstructorUsedError;
  List<ProductCancelModel> get itemCancels =>
      throw _privateConstructorUsedError;
  List<OrderHistory> get orderHistory => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ProductCheckoutResponseDataCopyWith<ProductCheckoutResponseData>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProductCheckoutResponseDataCopyWith<$Res> {
  factory $ProductCheckoutResponseDataCopyWith(
          ProductCheckoutResponseData value,
          $Res Function(ProductCheckoutResponseData) then) =
      _$ProductCheckoutResponseDataCopyWithImpl<$Res,
          ProductCheckoutResponseData>;
  @useResult
  $Res call(
      {int id,
      List<ProductCheckoutModel> orderItem,
      bool statusCancel,
      List<ProductCancelModel> itemCancels,
      List<OrderHistory> orderHistory});
}

/// @nodoc
class _$ProductCheckoutResponseDataCopyWithImpl<$Res,
        $Val extends ProductCheckoutResponseData>
    implements $ProductCheckoutResponseDataCopyWith<$Res> {
  _$ProductCheckoutResponseDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? orderItem = null,
    Object? statusCancel = null,
    Object? itemCancels = null,
    Object? orderHistory = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      orderItem: null == orderItem
          ? _value.orderItem
          : orderItem // ignore: cast_nullable_to_non_nullable
              as List<ProductCheckoutModel>,
      statusCancel: null == statusCancel
          ? _value.statusCancel
          : statusCancel // ignore: cast_nullable_to_non_nullable
              as bool,
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
}

/// @nodoc
abstract class _$$ProductCheckoutResponseDataImplCopyWith<$Res>
    implements $ProductCheckoutResponseDataCopyWith<$Res> {
  factory _$$ProductCheckoutResponseDataImplCopyWith(
          _$ProductCheckoutResponseDataImpl value,
          $Res Function(_$ProductCheckoutResponseDataImpl) then) =
      __$$ProductCheckoutResponseDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      List<ProductCheckoutModel> orderItem,
      bool statusCancel,
      List<ProductCancelModel> itemCancels,
      List<OrderHistory> orderHistory});
}

/// @nodoc
class __$$ProductCheckoutResponseDataImplCopyWithImpl<$Res>
    extends _$ProductCheckoutResponseDataCopyWithImpl<$Res,
        _$ProductCheckoutResponseDataImpl>
    implements _$$ProductCheckoutResponseDataImplCopyWith<$Res> {
  __$$ProductCheckoutResponseDataImplCopyWithImpl(
      _$ProductCheckoutResponseDataImpl _value,
      $Res Function(_$ProductCheckoutResponseDataImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? orderItem = null,
    Object? statusCancel = null,
    Object? itemCancels = null,
    Object? orderHistory = null,
  }) {
    return _then(_$ProductCheckoutResponseDataImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      orderItem: null == orderItem
          ? _value._orderItem
          : orderItem // ignore: cast_nullable_to_non_nullable
              as List<ProductCheckoutModel>,
      statusCancel: null == statusCancel
          ? _value.statusCancel
          : statusCancel // ignore: cast_nullable_to_non_nullable
              as bool,
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

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class _$ProductCheckoutResponseDataImpl
    with DiagnosticableTreeMixin
    implements _ProductCheckoutResponseData {
  const _$ProductCheckoutResponseDataImpl(
      {required this.id,
      required final List<ProductCheckoutModel> orderItem,
      this.statusCancel = false,
      final List<ProductCancelModel> itemCancels = const [],
      final List<OrderHistory> orderHistory = const []})
      : _orderItem = orderItem,
        _itemCancels = itemCancels,
        _orderHistory = orderHistory;

  factory _$ProductCheckoutResponseDataImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$ProductCheckoutResponseDataImplFromJson(json);

  @override
  final int id;
  final List<ProductCheckoutModel> _orderItem;
  @override
  List<ProductCheckoutModel> get orderItem {
    if (_orderItem is EqualUnmodifiableListView) return _orderItem;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_orderItem);
  }

  @override
  @JsonKey()
  final bool statusCancel;
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
    return 'ProductCheckoutResponseData(id: $id, orderItem: $orderItem, statusCancel: $statusCancel, itemCancels: $itemCancels, orderHistory: $orderHistory)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'ProductCheckoutResponseData'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('orderItem', orderItem))
      ..add(DiagnosticsProperty('statusCancel', statusCancel))
      ..add(DiagnosticsProperty('itemCancels', itemCancels))
      ..add(DiagnosticsProperty('orderHistory', orderHistory));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProductCheckoutResponseDataImpl &&
            (identical(other.id, id) || other.id == id) &&
            const DeepCollectionEquality()
                .equals(other._orderItem, _orderItem) &&
            (identical(other.statusCancel, statusCancel) ||
                other.statusCancel == statusCancel) &&
            const DeepCollectionEquality()
                .equals(other._itemCancels, _itemCancels) &&
            const DeepCollectionEquality()
                .equals(other._orderHistory, _orderHistory));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      const DeepCollectionEquality().hash(_orderItem),
      statusCancel,
      const DeepCollectionEquality().hash(_itemCancels),
      const DeepCollectionEquality().hash(_orderHistory));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ProductCheckoutResponseDataImplCopyWith<_$ProductCheckoutResponseDataImpl>
      get copyWith => __$$ProductCheckoutResponseDataImplCopyWithImpl<
          _$ProductCheckoutResponseDataImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ProductCheckoutResponseDataImplToJson(
      this,
    );
  }
}

abstract class _ProductCheckoutResponseData
    implements ProductCheckoutResponseData {
  const factory _ProductCheckoutResponseData(
          {required final int id,
          required final List<ProductCheckoutModel> orderItem,
          final bool statusCancel,
          final List<ProductCancelModel> itemCancels,
          final List<OrderHistory> orderHistory}) =
      _$ProductCheckoutResponseDataImpl;

  factory _ProductCheckoutResponseData.fromJson(Map<String, dynamic> json) =
      _$ProductCheckoutResponseDataImpl.fromJson;

  @override
  int get id;
  @override
  List<ProductCheckoutModel> get orderItem;
  @override
  bool get statusCancel;
  @override
  List<ProductCancelModel> get itemCancels;
  @override
  List<OrderHistory> get orderHistory;
  @override
  @JsonKey(ignore: true)
  _$$ProductCheckoutResponseDataImplCopyWith<_$ProductCheckoutResponseDataImpl>
      get copyWith => throw _privateConstructorUsedError;
}
