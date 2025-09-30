// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'history_order.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

HistoryOrderModel _$HistoryOrderModelFromJson(Map<String, dynamic> json) {
  return _HistoryOrderModel.fromJson(json);
}

/// @nodoc
mixin _$HistoryOrderModel {
  String get orderCode => throw _privateConstructorUsedError;
  String get tableName => throw _privateConstructorUsedError; // đang k có
  String get notes => throw _privateConstructorUsedError;
  DateTime? get orderCreated => throw _privateConstructorUsedError;
  int get orderStatus => throw _privateConstructorUsedError;
  String get orderStatusName => throw _privateConstructorUsedError;
  HistoryOrderExcuteModel get orderExcute => throw _privateConstructorUsedError;
  CustomerModel? get customer => throw _privateConstructorUsedError;
  List<CustomerPolicyModel> get coupons => throw _privateConstructorUsedError;
  PriceDataBill? get price => throw _privateConstructorUsedError;
  List<ProductCheckoutHistoryModel> get orderItems =>
      throw _privateConstructorUsedError;
  List<ProductCheckoutHistoryModel> get orderHistories =>
      throw _privateConstructorUsedError;
  int get orderType => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $HistoryOrderModelCopyWith<HistoryOrderModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HistoryOrderModelCopyWith<$Res> {
  factory $HistoryOrderModelCopyWith(
          HistoryOrderModel value, $Res Function(HistoryOrderModel) then) =
      _$HistoryOrderModelCopyWithImpl<$Res, HistoryOrderModel>;
  @useResult
  $Res call(
      {String orderCode,
      String tableName,
      String notes,
      DateTime? orderCreated,
      int orderStatus,
      String orderStatusName,
      HistoryOrderExcuteModel orderExcute,
      CustomerModel? customer,
      List<CustomerPolicyModel> coupons,
      PriceDataBill? price,
      List<ProductCheckoutHistoryModel> orderItems,
      List<ProductCheckoutHistoryModel> orderHistories,
      int orderType});

  $HistoryOrderExcuteModelCopyWith<$Res> get orderExcute;
  $CustomerModelCopyWith<$Res>? get customer;
  $PriceDataBillCopyWith<$Res>? get price;
}

/// @nodoc
class _$HistoryOrderModelCopyWithImpl<$Res, $Val extends HistoryOrderModel>
    implements $HistoryOrderModelCopyWith<$Res> {
  _$HistoryOrderModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? orderCode = null,
    Object? tableName = null,
    Object? notes = null,
    Object? orderCreated = freezed,
    Object? orderStatus = null,
    Object? orderStatusName = null,
    Object? orderExcute = null,
    Object? customer = freezed,
    Object? coupons = null,
    Object? price = freezed,
    Object? orderItems = null,
    Object? orderHistories = null,
    Object? orderType = null,
  }) {
    return _then(_value.copyWith(
      orderCode: null == orderCode
          ? _value.orderCode
          : orderCode // ignore: cast_nullable_to_non_nullable
              as String,
      tableName: null == tableName
          ? _value.tableName
          : tableName // ignore: cast_nullable_to_non_nullable
              as String,
      notes: null == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String,
      orderCreated: freezed == orderCreated
          ? _value.orderCreated
          : orderCreated // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      orderStatus: null == orderStatus
          ? _value.orderStatus
          : orderStatus // ignore: cast_nullable_to_non_nullable
              as int,
      orderStatusName: null == orderStatusName
          ? _value.orderStatusName
          : orderStatusName // ignore: cast_nullable_to_non_nullable
              as String,
      orderExcute: null == orderExcute
          ? _value.orderExcute
          : orderExcute // ignore: cast_nullable_to_non_nullable
              as HistoryOrderExcuteModel,
      customer: freezed == customer
          ? _value.customer
          : customer // ignore: cast_nullable_to_non_nullable
              as CustomerModel?,
      coupons: null == coupons
          ? _value.coupons
          : coupons // ignore: cast_nullable_to_non_nullable
              as List<CustomerPolicyModel>,
      price: freezed == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as PriceDataBill?,
      orderItems: null == orderItems
          ? _value.orderItems
          : orderItems // ignore: cast_nullable_to_non_nullable
              as List<ProductCheckoutHistoryModel>,
      orderHistories: null == orderHistories
          ? _value.orderHistories
          : orderHistories // ignore: cast_nullable_to_non_nullable
              as List<ProductCheckoutHistoryModel>,
      orderType: null == orderType
          ? _value.orderType
          : orderType // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $HistoryOrderExcuteModelCopyWith<$Res> get orderExcute {
    return $HistoryOrderExcuteModelCopyWith<$Res>(_value.orderExcute, (value) {
      return _then(_value.copyWith(orderExcute: value) as $Val);
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
}

/// @nodoc
abstract class _$$HistoryOrderModelImplCopyWith<$Res>
    implements $HistoryOrderModelCopyWith<$Res> {
  factory _$$HistoryOrderModelImplCopyWith(_$HistoryOrderModelImpl value,
          $Res Function(_$HistoryOrderModelImpl) then) =
      __$$HistoryOrderModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String orderCode,
      String tableName,
      String notes,
      DateTime? orderCreated,
      int orderStatus,
      String orderStatusName,
      HistoryOrderExcuteModel orderExcute,
      CustomerModel? customer,
      List<CustomerPolicyModel> coupons,
      PriceDataBill? price,
      List<ProductCheckoutHistoryModel> orderItems,
      List<ProductCheckoutHistoryModel> orderHistories,
      int orderType});

  @override
  $HistoryOrderExcuteModelCopyWith<$Res> get orderExcute;
  @override
  $CustomerModelCopyWith<$Res>? get customer;
  @override
  $PriceDataBillCopyWith<$Res>? get price;
}

/// @nodoc
class __$$HistoryOrderModelImplCopyWithImpl<$Res>
    extends _$HistoryOrderModelCopyWithImpl<$Res, _$HistoryOrderModelImpl>
    implements _$$HistoryOrderModelImplCopyWith<$Res> {
  __$$HistoryOrderModelImplCopyWithImpl(_$HistoryOrderModelImpl _value,
      $Res Function(_$HistoryOrderModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? orderCode = null,
    Object? tableName = null,
    Object? notes = null,
    Object? orderCreated = freezed,
    Object? orderStatus = null,
    Object? orderStatusName = null,
    Object? orderExcute = null,
    Object? customer = freezed,
    Object? coupons = null,
    Object? price = freezed,
    Object? orderItems = null,
    Object? orderHistories = null,
    Object? orderType = null,
  }) {
    return _then(_$HistoryOrderModelImpl(
      orderCode: null == orderCode
          ? _value.orderCode
          : orderCode // ignore: cast_nullable_to_non_nullable
              as String,
      tableName: null == tableName
          ? _value.tableName
          : tableName // ignore: cast_nullable_to_non_nullable
              as String,
      notes: null == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String,
      orderCreated: freezed == orderCreated
          ? _value.orderCreated
          : orderCreated // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      orderStatus: null == orderStatus
          ? _value.orderStatus
          : orderStatus // ignore: cast_nullable_to_non_nullable
              as int,
      orderStatusName: null == orderStatusName
          ? _value.orderStatusName
          : orderStatusName // ignore: cast_nullable_to_non_nullable
              as String,
      orderExcute: null == orderExcute
          ? _value.orderExcute
          : orderExcute // ignore: cast_nullable_to_non_nullable
              as HistoryOrderExcuteModel,
      customer: freezed == customer
          ? _value.customer
          : customer // ignore: cast_nullable_to_non_nullable
              as CustomerModel?,
      coupons: null == coupons
          ? _value._coupons
          : coupons // ignore: cast_nullable_to_non_nullable
              as List<CustomerPolicyModel>,
      price: freezed == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as PriceDataBill?,
      orderItems: null == orderItems
          ? _value._orderItems
          : orderItems // ignore: cast_nullable_to_non_nullable
              as List<ProductCheckoutHistoryModel>,
      orderHistories: null == orderHistories
          ? _value._orderHistories
          : orderHistories // ignore: cast_nullable_to_non_nullable
              as List<ProductCheckoutHistoryModel>,
      orderType: null == orderType
          ? _value.orderType
          : orderType // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _$HistoryOrderModelImpl extends _HistoryOrderModel
    with DiagnosticableTreeMixin {
  const _$HistoryOrderModelImpl(
      {this.orderCode = '',
      this.tableName = '',
      this.notes = '',
      this.orderCreated,
      this.orderStatus = 15,
      this.orderStatusName = '',
      this.orderExcute = const HistoryOrderExcuteModel(),
      this.customer,
      final List<CustomerPolicyModel> coupons = const [],
      this.price,
      final List<ProductCheckoutHistoryModel> orderItems = const [],
      final List<ProductCheckoutHistoryModel> orderHistories = const [],
      this.orderType = AppConfig.orderOfflineValue})
      : _coupons = coupons,
        _orderItems = orderItems,
        _orderHistories = orderHistories,
        super._();

  factory _$HistoryOrderModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$HistoryOrderModelImplFromJson(json);

  @override
  @JsonKey()
  final String orderCode;
  @override
  @JsonKey()
  final String tableName;
// đang k có
  @override
  @JsonKey()
  final String notes;
  @override
  final DateTime? orderCreated;
  @override
  @JsonKey()
  final int orderStatus;
  @override
  @JsonKey()
  final String orderStatusName;
  @override
  @JsonKey()
  final HistoryOrderExcuteModel orderExcute;
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

  @override
  final PriceDataBill? price;
  final List<ProductCheckoutHistoryModel> _orderItems;
  @override
  @JsonKey()
  List<ProductCheckoutHistoryModel> get orderItems {
    if (_orderItems is EqualUnmodifiableListView) return _orderItems;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_orderItems);
  }

  final List<ProductCheckoutHistoryModel> _orderHistories;
  @override
  @JsonKey()
  List<ProductCheckoutHistoryModel> get orderHistories {
    if (_orderHistories is EqualUnmodifiableListView) return _orderHistories;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_orderHistories);
  }

  @override
  @JsonKey()
  final int orderType;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'HistoryOrderModel(orderCode: $orderCode, tableName: $tableName, notes: $notes, orderCreated: $orderCreated, orderStatus: $orderStatus, orderStatusName: $orderStatusName, orderExcute: $orderExcute, customer: $customer, coupons: $coupons, price: $price, orderItems: $orderItems, orderHistories: $orderHistories, orderType: $orderType)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'HistoryOrderModel'))
      ..add(DiagnosticsProperty('orderCode', orderCode))
      ..add(DiagnosticsProperty('tableName', tableName))
      ..add(DiagnosticsProperty('notes', notes))
      ..add(DiagnosticsProperty('orderCreated', orderCreated))
      ..add(DiagnosticsProperty('orderStatus', orderStatus))
      ..add(DiagnosticsProperty('orderStatusName', orderStatusName))
      ..add(DiagnosticsProperty('orderExcute', orderExcute))
      ..add(DiagnosticsProperty('customer', customer))
      ..add(DiagnosticsProperty('coupons', coupons))
      ..add(DiagnosticsProperty('price', price))
      ..add(DiagnosticsProperty('orderItems', orderItems))
      ..add(DiagnosticsProperty('orderHistories', orderHistories))
      ..add(DiagnosticsProperty('orderType', orderType));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HistoryOrderModelImpl &&
            (identical(other.orderCode, orderCode) ||
                other.orderCode == orderCode) &&
            (identical(other.tableName, tableName) ||
                other.tableName == tableName) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            (identical(other.orderCreated, orderCreated) ||
                other.orderCreated == orderCreated) &&
            (identical(other.orderStatus, orderStatus) ||
                other.orderStatus == orderStatus) &&
            (identical(other.orderStatusName, orderStatusName) ||
                other.orderStatusName == orderStatusName) &&
            (identical(other.orderExcute, orderExcute) ||
                other.orderExcute == orderExcute) &&
            (identical(other.customer, customer) ||
                other.customer == customer) &&
            const DeepCollectionEquality().equals(other._coupons, _coupons) &&
            (identical(other.price, price) || other.price == price) &&
            const DeepCollectionEquality()
                .equals(other._orderItems, _orderItems) &&
            const DeepCollectionEquality()
                .equals(other._orderHistories, _orderHistories) &&
            (identical(other.orderType, orderType) ||
                other.orderType == orderType));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      orderCode,
      tableName,
      notes,
      orderCreated,
      orderStatus,
      orderStatusName,
      orderExcute,
      customer,
      const DeepCollectionEquality().hash(_coupons),
      price,
      const DeepCollectionEquality().hash(_orderItems),
      const DeepCollectionEquality().hash(_orderHistories),
      orderType);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$HistoryOrderModelImplCopyWith<_$HistoryOrderModelImpl> get copyWith =>
      __$$HistoryOrderModelImplCopyWithImpl<_$HistoryOrderModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$HistoryOrderModelImplToJson(
      this,
    );
  }
}

abstract class _HistoryOrderModel extends HistoryOrderModel {
  const factory _HistoryOrderModel(
      {final String orderCode,
      final String tableName,
      final String notes,
      final DateTime? orderCreated,
      final int orderStatus,
      final String orderStatusName,
      final HistoryOrderExcuteModel orderExcute,
      final CustomerModel? customer,
      final List<CustomerPolicyModel> coupons,
      final PriceDataBill? price,
      final List<ProductCheckoutHistoryModel> orderItems,
      final List<ProductCheckoutHistoryModel> orderHistories,
      final int orderType}) = _$HistoryOrderModelImpl;
  const _HistoryOrderModel._() : super._();

  factory _HistoryOrderModel.fromJson(Map<String, dynamic> json) =
      _$HistoryOrderModelImpl.fromJson;

  @override
  String get orderCode;
  @override
  String get tableName;
  @override // đang k có
  String get notes;
  @override
  DateTime? get orderCreated;
  @override
  int get orderStatus;
  @override
  String get orderStatusName;
  @override
  HistoryOrderExcuteModel get orderExcute;
  @override
  CustomerModel? get customer;
  @override
  List<CustomerPolicyModel> get coupons;
  @override
  PriceDataBill? get price;
  @override
  List<ProductCheckoutHistoryModel> get orderItems;
  @override
  List<ProductCheckoutHistoryModel> get orderHistories;
  @override
  int get orderType;
  @override
  @JsonKey(ignore: true)
  _$$HistoryOrderModelImplCopyWith<_$HistoryOrderModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

HistoryOrderExcuteModel _$HistoryOrderExcuteModelFromJson(
    Map<String, dynamic> json) {
  return _HistoryOrderExcuteModel.fromJson(json);
}

/// @nodoc
mixin _$HistoryOrderExcuteModel {
  int get flag => throw _privateConstructorUsedError;
  int get order => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $HistoryOrderExcuteModelCopyWith<HistoryOrderExcuteModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HistoryOrderExcuteModelCopyWith<$Res> {
  factory $HistoryOrderExcuteModelCopyWith(HistoryOrderExcuteModel value,
          $Res Function(HistoryOrderExcuteModel) then) =
      _$HistoryOrderExcuteModelCopyWithImpl<$Res, HistoryOrderExcuteModel>;
  @useResult
  $Res call({int flag, int order});
}

/// @nodoc
class _$HistoryOrderExcuteModelCopyWithImpl<$Res,
        $Val extends HistoryOrderExcuteModel>
    implements $HistoryOrderExcuteModelCopyWith<$Res> {
  _$HistoryOrderExcuteModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? flag = null,
    Object? order = null,
  }) {
    return _then(_value.copyWith(
      flag: null == flag
          ? _value.flag
          : flag // ignore: cast_nullable_to_non_nullable
              as int,
      order: null == order
          ? _value.order
          : order // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$HistoryOrderExcuteModelImplCopyWith<$Res>
    implements $HistoryOrderExcuteModelCopyWith<$Res> {
  factory _$$HistoryOrderExcuteModelImplCopyWith(
          _$HistoryOrderExcuteModelImpl value,
          $Res Function(_$HistoryOrderExcuteModelImpl) then) =
      __$$HistoryOrderExcuteModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int flag, int order});
}

/// @nodoc
class __$$HistoryOrderExcuteModelImplCopyWithImpl<$Res>
    extends _$HistoryOrderExcuteModelCopyWithImpl<$Res,
        _$HistoryOrderExcuteModelImpl>
    implements _$$HistoryOrderExcuteModelImplCopyWith<$Res> {
  __$$HistoryOrderExcuteModelImplCopyWithImpl(
      _$HistoryOrderExcuteModelImpl _value,
      $Res Function(_$HistoryOrderExcuteModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? flag = null,
    Object? order = null,
  }) {
    return _then(_$HistoryOrderExcuteModelImpl(
      flag: null == flag
          ? _value.flag
          : flag // ignore: cast_nullable_to_non_nullable
              as int,
      order: null == order
          ? _value.order
          : order // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _$HistoryOrderExcuteModelImpl extends _HistoryOrderExcuteModel
    with DiagnosticableTreeMixin {
  const _$HistoryOrderExcuteModelImpl({this.flag = 0, this.order = 0})
      : super._();

  factory _$HistoryOrderExcuteModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$HistoryOrderExcuteModelImplFromJson(json);

  @override
  @JsonKey()
  final int flag;
  @override
  @JsonKey()
  final int order;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'HistoryOrderExcuteModel(flag: $flag, order: $order)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'HistoryOrderExcuteModel'))
      ..add(DiagnosticsProperty('flag', flag))
      ..add(DiagnosticsProperty('order', order));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HistoryOrderExcuteModelImpl &&
            (identical(other.flag, flag) || other.flag == flag) &&
            (identical(other.order, order) || other.order == order));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, flag, order);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$HistoryOrderExcuteModelImplCopyWith<_$HistoryOrderExcuteModelImpl>
      get copyWith => __$$HistoryOrderExcuteModelImplCopyWithImpl<
          _$HistoryOrderExcuteModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$HistoryOrderExcuteModelImplToJson(
      this,
    );
  }
}

abstract class _HistoryOrderExcuteModel extends HistoryOrderExcuteModel {
  const factory _HistoryOrderExcuteModel({final int flag, final int order}) =
      _$HistoryOrderExcuteModelImpl;
  const _HistoryOrderExcuteModel._() : super._();

  factory _HistoryOrderExcuteModel.fromJson(Map<String, dynamic> json) =
      _$HistoryOrderExcuteModelImpl.fromJson;

  @override
  int get flag;
  @override
  int get order;
  @override
  @JsonKey(ignore: true)
  _$$HistoryOrderExcuteModelImplCopyWith<_$HistoryOrderExcuteModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}

HistoryOrderProductModel _$HistoryOrderProductModelFromJson(
    Map<String, dynamic> json) {
  return _HistoryOrderProductModel.fromJson(json);
}

/// @nodoc
mixin _$HistoryOrderProductModel {
  int? get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get codeProduct => throw _privateConstructorUsedError;
  String get quantity => throw _privateConstructorUsedError;
  String get unitPrice => throw _privateConstructorUsedError;
  int? get printerType => throw _privateConstructorUsedError;
  int get timesOrder => throw _privateConstructorUsedError;
  String get notes => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $HistoryOrderProductModelCopyWith<HistoryOrderProductModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HistoryOrderProductModelCopyWith<$Res> {
  factory $HistoryOrderProductModelCopyWith(HistoryOrderProductModel value,
          $Res Function(HistoryOrderProductModel) then) =
      _$HistoryOrderProductModelCopyWithImpl<$Res, HistoryOrderProductModel>;
  @useResult
  $Res call(
      {int? id,
      String name,
      String codeProduct,
      String quantity,
      String unitPrice,
      int? printerType,
      int timesOrder,
      String notes});
}

/// @nodoc
class _$HistoryOrderProductModelCopyWithImpl<$Res,
        $Val extends HistoryOrderProductModel>
    implements $HistoryOrderProductModelCopyWith<$Res> {
  _$HistoryOrderProductModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = null,
    Object? codeProduct = null,
    Object? quantity = null,
    Object? unitPrice = null,
    Object? printerType = freezed,
    Object? timesOrder = null,
    Object? notes = null,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      codeProduct: null == codeProduct
          ? _value.codeProduct
          : codeProduct // ignore: cast_nullable_to_non_nullable
              as String,
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as String,
      unitPrice: null == unitPrice
          ? _value.unitPrice
          : unitPrice // ignore: cast_nullable_to_non_nullable
              as String,
      printerType: freezed == printerType
          ? _value.printerType
          : printerType // ignore: cast_nullable_to_non_nullable
              as int?,
      timesOrder: null == timesOrder
          ? _value.timesOrder
          : timesOrder // ignore: cast_nullable_to_non_nullable
              as int,
      notes: null == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$HistoryOrderProductModelImplCopyWith<$Res>
    implements $HistoryOrderProductModelCopyWith<$Res> {
  factory _$$HistoryOrderProductModelImplCopyWith(
          _$HistoryOrderProductModelImpl value,
          $Res Function(_$HistoryOrderProductModelImpl) then) =
      __$$HistoryOrderProductModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? id,
      String name,
      String codeProduct,
      String quantity,
      String unitPrice,
      int? printerType,
      int timesOrder,
      String notes});
}

/// @nodoc
class __$$HistoryOrderProductModelImplCopyWithImpl<$Res>
    extends _$HistoryOrderProductModelCopyWithImpl<$Res,
        _$HistoryOrderProductModelImpl>
    implements _$$HistoryOrderProductModelImplCopyWith<$Res> {
  __$$HistoryOrderProductModelImplCopyWithImpl(
      _$HistoryOrderProductModelImpl _value,
      $Res Function(_$HistoryOrderProductModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = null,
    Object? codeProduct = null,
    Object? quantity = null,
    Object? unitPrice = null,
    Object? printerType = freezed,
    Object? timesOrder = null,
    Object? notes = null,
  }) {
    return _then(_$HistoryOrderProductModelImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      codeProduct: null == codeProduct
          ? _value.codeProduct
          : codeProduct // ignore: cast_nullable_to_non_nullable
              as String,
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as String,
      unitPrice: null == unitPrice
          ? _value.unitPrice
          : unitPrice // ignore: cast_nullable_to_non_nullable
              as String,
      printerType: freezed == printerType
          ? _value.printerType
          : printerType // ignore: cast_nullable_to_non_nullable
              as int?,
      timesOrder: null == timesOrder
          ? _value.timesOrder
          : timesOrder // ignore: cast_nullable_to_non_nullable
              as int,
      notes: null == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _$HistoryOrderProductModelImpl extends _HistoryOrderProductModel
    with DiagnosticableTreeMixin {
  const _$HistoryOrderProductModelImpl(
      {this.id,
      this.name = '',
      this.codeProduct = '',
      this.quantity = '-1',
      this.unitPrice = '0',
      this.printerType,
      this.timesOrder = 0,
      this.notes = ''})
      : super._();

  factory _$HistoryOrderProductModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$HistoryOrderProductModelImplFromJson(json);

  @override
  final int? id;
  @override
  @JsonKey()
  final String name;
  @override
  @JsonKey()
  final String codeProduct;
  @override
  @JsonKey()
  final String quantity;
  @override
  @JsonKey()
  final String unitPrice;
  @override
  final int? printerType;
  @override
  @JsonKey()
  final int timesOrder;
  @override
  @JsonKey()
  final String notes;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'HistoryOrderProductModel(id: $id, name: $name, codeProduct: $codeProduct, quantity: $quantity, unitPrice: $unitPrice, printerType: $printerType, timesOrder: $timesOrder, notes: $notes)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'HistoryOrderProductModel'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('name', name))
      ..add(DiagnosticsProperty('codeProduct', codeProduct))
      ..add(DiagnosticsProperty('quantity', quantity))
      ..add(DiagnosticsProperty('unitPrice', unitPrice))
      ..add(DiagnosticsProperty('printerType', printerType))
      ..add(DiagnosticsProperty('timesOrder', timesOrder))
      ..add(DiagnosticsProperty('notes', notes));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HistoryOrderProductModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.codeProduct, codeProduct) ||
                other.codeProduct == codeProduct) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity) &&
            (identical(other.unitPrice, unitPrice) ||
                other.unitPrice == unitPrice) &&
            (identical(other.printerType, printerType) ||
                other.printerType == printerType) &&
            (identical(other.timesOrder, timesOrder) ||
                other.timesOrder == timesOrder) &&
            (identical(other.notes, notes) || other.notes == notes));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, codeProduct, quantity,
      unitPrice, printerType, timesOrder, notes);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$HistoryOrderProductModelImplCopyWith<_$HistoryOrderProductModelImpl>
      get copyWith => __$$HistoryOrderProductModelImplCopyWithImpl<
          _$HistoryOrderProductModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$HistoryOrderProductModelImplToJson(
      this,
    );
  }
}

abstract class _HistoryOrderProductModel extends HistoryOrderProductModel {
  const factory _HistoryOrderProductModel(
      {final int? id,
      final String name,
      final String codeProduct,
      final String quantity,
      final String unitPrice,
      final int? printerType,
      final int timesOrder,
      final String notes}) = _$HistoryOrderProductModelImpl;
  const _HistoryOrderProductModel._() : super._();

  factory _HistoryOrderProductModel.fromJson(Map<String, dynamic> json) =
      _$HistoryOrderProductModelImpl.fromJson;

  @override
  int? get id;
  @override
  String get name;
  @override
  String get codeProduct;
  @override
  String get quantity;
  @override
  String get unitPrice;
  @override
  int? get printerType;
  @override
  int get timesOrder;
  @override
  String get notes;
  @override
  @JsonKey(ignore: true)
  _$$HistoryOrderProductModelImplCopyWith<_$HistoryOrderProductModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}
