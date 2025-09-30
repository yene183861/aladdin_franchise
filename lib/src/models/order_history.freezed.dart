// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'order_history.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

OrderHistory _$OrderHistoryFromJson(Map<String, dynamic> json) {
  return _OrderHistory.fromJson(json);
}

/// @nodoc
mixin _$OrderHistory {
  int get id => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  int get timesOrder => throw _privateConstructorUsedError;
  String get notes => throw _privateConstructorUsedError;
  @JsonKey(name: 'line_items')
  List<ProductHistory> get products => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $OrderHistoryCopyWith<OrderHistory> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OrderHistoryCopyWith<$Res> {
  factory $OrderHistoryCopyWith(
          OrderHistory value, $Res Function(OrderHistory) then) =
      _$OrderHistoryCopyWithImpl<$Res, OrderHistory>;
  @useResult
  $Res call(
      {int id,
      DateTime createdAt,
      int timesOrder,
      String notes,
      @JsonKey(name: 'line_items') List<ProductHistory> products});
}

/// @nodoc
class _$OrderHistoryCopyWithImpl<$Res, $Val extends OrderHistory>
    implements $OrderHistoryCopyWith<$Res> {
  _$OrderHistoryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? createdAt = null,
    Object? timesOrder = null,
    Object? notes = null,
    Object? products = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      timesOrder: null == timesOrder
          ? _value.timesOrder
          : timesOrder // ignore: cast_nullable_to_non_nullable
              as int,
      notes: null == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String,
      products: null == products
          ? _value.products
          : products // ignore: cast_nullable_to_non_nullable
              as List<ProductHistory>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$OrderHistoryImplCopyWith<$Res>
    implements $OrderHistoryCopyWith<$Res> {
  factory _$$OrderHistoryImplCopyWith(
          _$OrderHistoryImpl value, $Res Function(_$OrderHistoryImpl) then) =
      __$$OrderHistoryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      DateTime createdAt,
      int timesOrder,
      String notes,
      @JsonKey(name: 'line_items') List<ProductHistory> products});
}

/// @nodoc
class __$$OrderHistoryImplCopyWithImpl<$Res>
    extends _$OrderHistoryCopyWithImpl<$Res, _$OrderHistoryImpl>
    implements _$$OrderHistoryImplCopyWith<$Res> {
  __$$OrderHistoryImplCopyWithImpl(
      _$OrderHistoryImpl _value, $Res Function(_$OrderHistoryImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? createdAt = null,
    Object? timesOrder = null,
    Object? notes = null,
    Object? products = null,
  }) {
    return _then(_$OrderHistoryImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      timesOrder: null == timesOrder
          ? _value.timesOrder
          : timesOrder // ignore: cast_nullable_to_non_nullable
              as int,
      notes: null == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String,
      products: null == products
          ? _value._products
          : products // ignore: cast_nullable_to_non_nullable
              as List<ProductHistory>,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class _$OrderHistoryImpl with DiagnosticableTreeMixin implements _OrderHistory {
  const _$OrderHistoryImpl(
      {this.id = -1,
      required this.createdAt,
      this.timesOrder = 0,
      this.notes = '',
      @JsonKey(name: 'line_items')
      final List<ProductHistory> products = const []})
      : _products = products;

  factory _$OrderHistoryImpl.fromJson(Map<String, dynamic> json) =>
      _$$OrderHistoryImplFromJson(json);

  @override
  @JsonKey()
  final int id;
  @override
  final DateTime createdAt;
  @override
  @JsonKey()
  final int timesOrder;
  @override
  @JsonKey()
  final String notes;
  final List<ProductHistory> _products;
  @override
  @JsonKey(name: 'line_items')
  List<ProductHistory> get products {
    if (_products is EqualUnmodifiableListView) return _products;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_products);
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'OrderHistory(id: $id, createdAt: $createdAt, timesOrder: $timesOrder, notes: $notes, products: $products)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'OrderHistory'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('createdAt', createdAt))
      ..add(DiagnosticsProperty('timesOrder', timesOrder))
      ..add(DiagnosticsProperty('notes', notes))
      ..add(DiagnosticsProperty('products', products));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OrderHistoryImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.timesOrder, timesOrder) ||
                other.timesOrder == timesOrder) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            const DeepCollectionEquality().equals(other._products, _products));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, createdAt, timesOrder, notes,
      const DeepCollectionEquality().hash(_products));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$OrderHistoryImplCopyWith<_$OrderHistoryImpl> get copyWith =>
      __$$OrderHistoryImplCopyWithImpl<_$OrderHistoryImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OrderHistoryImplToJson(
      this,
    );
  }
}

abstract class _OrderHistory implements OrderHistory {
  const factory _OrderHistory(
          {final int id,
          required final DateTime createdAt,
          final int timesOrder,
          final String notes,
          @JsonKey(name: 'line_items') final List<ProductHistory> products}) =
      _$OrderHistoryImpl;

  factory _OrderHistory.fromJson(Map<String, dynamic> json) =
      _$OrderHistoryImpl.fromJson;

  @override
  int get id;
  @override
  DateTime get createdAt;
  @override
  int get timesOrder;
  @override
  String get notes;
  @override
  @JsonKey(name: 'line_items')
  List<ProductHistory> get products;
  @override
  @JsonKey(ignore: true)
  _$$OrderHistoryImplCopyWith<_$OrderHistoryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ProductHistory _$ProductHistoryFromJson(Map<String, dynamic> json) {
  return _ProductHistory.fromJson(json);
}

/// @nodoc
mixin _$ProductHistory {
  int get id => throw _privateConstructorUsedError;
  int get orderTimeId => throw _privateConstructorUsedError;
  int get timesOrder => throw _privateConstructorUsedError;
  int get itemId => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get unit => throw _privateConstructorUsedError;
  String get notes => throw _privateConstructorUsedError;
  int get quantity => throw _privateConstructorUsedError;
  int get quantityCancel => throw _privateConstructorUsedError;
  int get status => throw _privateConstructorUsedError;
  bool get cancel => throw _privateConstructorUsedError;
  String get nameEn => throw _privateConstructorUsedError; // Auxiliary
  DateTime? get timeByOrderHistory => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ProductHistoryCopyWith<ProductHistory> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProductHistoryCopyWith<$Res> {
  factory $ProductHistoryCopyWith(
          ProductHistory value, $Res Function(ProductHistory) then) =
      _$ProductHistoryCopyWithImpl<$Res, ProductHistory>;
  @useResult
  $Res call(
      {int id,
      int orderTimeId,
      int timesOrder,
      int itemId,
      String name,
      String unit,
      String notes,
      int quantity,
      int quantityCancel,
      int status,
      bool cancel,
      String nameEn,
      DateTime? timeByOrderHistory});
}

/// @nodoc
class _$ProductHistoryCopyWithImpl<$Res, $Val extends ProductHistory>
    implements $ProductHistoryCopyWith<$Res> {
  _$ProductHistoryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? orderTimeId = null,
    Object? timesOrder = null,
    Object? itemId = null,
    Object? name = null,
    Object? unit = null,
    Object? notes = null,
    Object? quantity = null,
    Object? quantityCancel = null,
    Object? status = null,
    Object? cancel = null,
    Object? nameEn = null,
    Object? timeByOrderHistory = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      orderTimeId: null == orderTimeId
          ? _value.orderTimeId
          : orderTimeId // ignore: cast_nullable_to_non_nullable
              as int,
      timesOrder: null == timesOrder
          ? _value.timesOrder
          : timesOrder // ignore: cast_nullable_to_non_nullable
              as int,
      itemId: null == itemId
          ? _value.itemId
          : itemId // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      unit: null == unit
          ? _value.unit
          : unit // ignore: cast_nullable_to_non_nullable
              as String,
      notes: null == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String,
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as int,
      quantityCancel: null == quantityCancel
          ? _value.quantityCancel
          : quantityCancel // ignore: cast_nullable_to_non_nullable
              as int,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as int,
      cancel: null == cancel
          ? _value.cancel
          : cancel // ignore: cast_nullable_to_non_nullable
              as bool,
      nameEn: null == nameEn
          ? _value.nameEn
          : nameEn // ignore: cast_nullable_to_non_nullable
              as String,
      timeByOrderHistory: freezed == timeByOrderHistory
          ? _value.timeByOrderHistory
          : timeByOrderHistory // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ProductHistoryImplCopyWith<$Res>
    implements $ProductHistoryCopyWith<$Res> {
  factory _$$ProductHistoryImplCopyWith(_$ProductHistoryImpl value,
          $Res Function(_$ProductHistoryImpl) then) =
      __$$ProductHistoryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      int orderTimeId,
      int timesOrder,
      int itemId,
      String name,
      String unit,
      String notes,
      int quantity,
      int quantityCancel,
      int status,
      bool cancel,
      String nameEn,
      DateTime? timeByOrderHistory});
}

/// @nodoc
class __$$ProductHistoryImplCopyWithImpl<$Res>
    extends _$ProductHistoryCopyWithImpl<$Res, _$ProductHistoryImpl>
    implements _$$ProductHistoryImplCopyWith<$Res> {
  __$$ProductHistoryImplCopyWithImpl(
      _$ProductHistoryImpl _value, $Res Function(_$ProductHistoryImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? orderTimeId = null,
    Object? timesOrder = null,
    Object? itemId = null,
    Object? name = null,
    Object? unit = null,
    Object? notes = null,
    Object? quantity = null,
    Object? quantityCancel = null,
    Object? status = null,
    Object? cancel = null,
    Object? nameEn = null,
    Object? timeByOrderHistory = freezed,
  }) {
    return _then(_$ProductHistoryImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      orderTimeId: null == orderTimeId
          ? _value.orderTimeId
          : orderTimeId // ignore: cast_nullable_to_non_nullable
              as int,
      timesOrder: null == timesOrder
          ? _value.timesOrder
          : timesOrder // ignore: cast_nullable_to_non_nullable
              as int,
      itemId: null == itemId
          ? _value.itemId
          : itemId // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      unit: null == unit
          ? _value.unit
          : unit // ignore: cast_nullable_to_non_nullable
              as String,
      notes: null == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String,
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as int,
      quantityCancel: null == quantityCancel
          ? _value.quantityCancel
          : quantityCancel // ignore: cast_nullable_to_non_nullable
              as int,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as int,
      cancel: null == cancel
          ? _value.cancel
          : cancel // ignore: cast_nullable_to_non_nullable
              as bool,
      nameEn: null == nameEn
          ? _value.nameEn
          : nameEn // ignore: cast_nullable_to_non_nullable
              as String,
      timeByOrderHistory: freezed == timeByOrderHistory
          ? _value.timeByOrderHistory
          : timeByOrderHistory // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class _$ProductHistoryImpl extends _ProductHistory
    with DiagnosticableTreeMixin {
  const _$ProductHistoryImpl(
      {this.id = -1,
      this.orderTimeId = -1,
      this.timesOrder = -1,
      this.itemId = -1,
      this.name = '',
      this.unit = '',
      this.notes = '',
      this.quantity = 0,
      this.quantityCancel = 0,
      this.status = 0,
      this.cancel = false,
      this.nameEn = '',
      this.timeByOrderHistory})
      : super._();

  factory _$ProductHistoryImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProductHistoryImplFromJson(json);

  @override
  @JsonKey()
  final int id;
  @override
  @JsonKey()
  final int orderTimeId;
  @override
  @JsonKey()
  final int timesOrder;
  @override
  @JsonKey()
  final int itemId;
  @override
  @JsonKey()
  final String name;
  @override
  @JsonKey()
  final String unit;
  @override
  @JsonKey()
  final String notes;
  @override
  @JsonKey()
  final int quantity;
  @override
  @JsonKey()
  final int quantityCancel;
  @override
  @JsonKey()
  final int status;
  @override
  @JsonKey()
  final bool cancel;
  @override
  @JsonKey()
  final String nameEn;
// Auxiliary
  @override
  final DateTime? timeByOrderHistory;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ProductHistory(id: $id, orderTimeId: $orderTimeId, timesOrder: $timesOrder, itemId: $itemId, name: $name, unit: $unit, notes: $notes, quantity: $quantity, quantityCancel: $quantityCancel, status: $status, cancel: $cancel, nameEn: $nameEn, timeByOrderHistory: $timeByOrderHistory)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'ProductHistory'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('orderTimeId', orderTimeId))
      ..add(DiagnosticsProperty('timesOrder', timesOrder))
      ..add(DiagnosticsProperty('itemId', itemId))
      ..add(DiagnosticsProperty('name', name))
      ..add(DiagnosticsProperty('unit', unit))
      ..add(DiagnosticsProperty('notes', notes))
      ..add(DiagnosticsProperty('quantity', quantity))
      ..add(DiagnosticsProperty('quantityCancel', quantityCancel))
      ..add(DiagnosticsProperty('status', status))
      ..add(DiagnosticsProperty('cancel', cancel))
      ..add(DiagnosticsProperty('nameEn', nameEn))
      ..add(DiagnosticsProperty('timeByOrderHistory', timeByOrderHistory));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProductHistoryImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.orderTimeId, orderTimeId) ||
                other.orderTimeId == orderTimeId) &&
            (identical(other.timesOrder, timesOrder) ||
                other.timesOrder == timesOrder) &&
            (identical(other.itemId, itemId) || other.itemId == itemId) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.unit, unit) || other.unit == unit) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity) &&
            (identical(other.quantityCancel, quantityCancel) ||
                other.quantityCancel == quantityCancel) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.cancel, cancel) || other.cancel == cancel) &&
            (identical(other.nameEn, nameEn) || other.nameEn == nameEn) &&
            (identical(other.timeByOrderHistory, timeByOrderHistory) ||
                other.timeByOrderHistory == timeByOrderHistory));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      orderTimeId,
      timesOrder,
      itemId,
      name,
      unit,
      notes,
      quantity,
      quantityCancel,
      status,
      cancel,
      nameEn,
      timeByOrderHistory);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ProductHistoryImplCopyWith<_$ProductHistoryImpl> get copyWith =>
      __$$ProductHistoryImplCopyWithImpl<_$ProductHistoryImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ProductHistoryImplToJson(
      this,
    );
  }
}

abstract class _ProductHistory extends ProductHistory {
  const factory _ProductHistory(
      {final int id,
      final int orderTimeId,
      final int timesOrder,
      final int itemId,
      final String name,
      final String unit,
      final String notes,
      final int quantity,
      final int quantityCancel,
      final int status,
      final bool cancel,
      final String nameEn,
      final DateTime? timeByOrderHistory}) = _$ProductHistoryImpl;
  const _ProductHistory._() : super._();

  factory _ProductHistory.fromJson(Map<String, dynamic> json) =
      _$ProductHistoryImpl.fromJson;

  @override
  int get id;
  @override
  int get orderTimeId;
  @override
  int get timesOrder;
  @override
  int get itemId;
  @override
  String get name;
  @override
  String get unit;
  @override
  String get notes;
  @override
  int get quantity;
  @override
  int get quantityCancel;
  @override
  int get status;
  @override
  bool get cancel;
  @override
  String get nameEn;
  @override // Auxiliary
  DateTime? get timeByOrderHistory;
  @override
  @JsonKey(ignore: true)
  _$$ProductHistoryImplCopyWith<_$ProductHistoryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
