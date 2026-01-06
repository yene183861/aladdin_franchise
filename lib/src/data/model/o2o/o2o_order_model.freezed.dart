// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'o2o_order_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

O2OOrderModel _$O2OOrderModelFromJson(Map<String, dynamic> json) {
  return _O2OOrderModel.fromJson(json);
}

/// @nodoc
mixin _$O2OOrderModel {
  int get orderId => throw _privateConstructorUsedError;
  List<String> get qrOrderO2o => throw _privateConstructorUsedError;
  int get restaurantId => throw _privateConstructorUsedError;
  String get tableName => throw _privateConstructorUsedError;
  List<RequestOrderModel> get items => throw _privateConstructorUsedError;
  String get orderCode => throw _privateConstructorUsedError;
  int get userId => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $O2OOrderModelCopyWith<O2OOrderModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $O2OOrderModelCopyWith<$Res> {
  factory $O2OOrderModelCopyWith(
          O2OOrderModel value, $Res Function(O2OOrderModel) then) =
      _$O2OOrderModelCopyWithImpl<$Res, O2OOrderModel>;
  @useResult
  $Res call(
      {int orderId,
      List<String> qrOrderO2o,
      int restaurantId,
      String tableName,
      List<RequestOrderModel> items,
      String orderCode,
      int userId});
}

/// @nodoc
class _$O2OOrderModelCopyWithImpl<$Res, $Val extends O2OOrderModel>
    implements $O2OOrderModelCopyWith<$Res> {
  _$O2OOrderModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? orderId = null,
    Object? qrOrderO2o = null,
    Object? restaurantId = null,
    Object? tableName = null,
    Object? items = null,
    Object? orderCode = null,
    Object? userId = null,
  }) {
    return _then(_value.copyWith(
      orderId: null == orderId
          ? _value.orderId
          : orderId // ignore: cast_nullable_to_non_nullable
              as int,
      qrOrderO2o: null == qrOrderO2o
          ? _value.qrOrderO2o
          : qrOrderO2o // ignore: cast_nullable_to_non_nullable
              as List<String>,
      restaurantId: null == restaurantId
          ? _value.restaurantId
          : restaurantId // ignore: cast_nullable_to_non_nullable
              as int,
      tableName: null == tableName
          ? _value.tableName
          : tableName // ignore: cast_nullable_to_non_nullable
              as String,
      items: null == items
          ? _value.items
          : items // ignore: cast_nullable_to_non_nullable
              as List<RequestOrderModel>,
      orderCode: null == orderCode
          ? _value.orderCode
          : orderCode // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$O2OOrderModelImplCopyWith<$Res>
    implements $O2OOrderModelCopyWith<$Res> {
  factory _$$O2OOrderModelImplCopyWith(
          _$O2OOrderModelImpl value, $Res Function(_$O2OOrderModelImpl) then) =
      __$$O2OOrderModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int orderId,
      List<String> qrOrderO2o,
      int restaurantId,
      String tableName,
      List<RequestOrderModel> items,
      String orderCode,
      int userId});
}

/// @nodoc
class __$$O2OOrderModelImplCopyWithImpl<$Res>
    extends _$O2OOrderModelCopyWithImpl<$Res, _$O2OOrderModelImpl>
    implements _$$O2OOrderModelImplCopyWith<$Res> {
  __$$O2OOrderModelImplCopyWithImpl(
      _$O2OOrderModelImpl _value, $Res Function(_$O2OOrderModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? orderId = null,
    Object? qrOrderO2o = null,
    Object? restaurantId = null,
    Object? tableName = null,
    Object? items = null,
    Object? orderCode = null,
    Object? userId = null,
  }) {
    return _then(_$O2OOrderModelImpl(
      orderId: null == orderId
          ? _value.orderId
          : orderId // ignore: cast_nullable_to_non_nullable
              as int,
      qrOrderO2o: null == qrOrderO2o
          ? _value._qrOrderO2o
          : qrOrderO2o // ignore: cast_nullable_to_non_nullable
              as List<String>,
      restaurantId: null == restaurantId
          ? _value.restaurantId
          : restaurantId // ignore: cast_nullable_to_non_nullable
              as int,
      tableName: null == tableName
          ? _value.tableName
          : tableName // ignore: cast_nullable_to_non_nullable
              as String,
      items: null == items
          ? _value._items
          : items // ignore: cast_nullable_to_non_nullable
              as List<RequestOrderModel>,
      orderCode: null == orderCode
          ? _value.orderCode
          : orderCode // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class _$O2OOrderModelImpl extends _O2OOrderModel with DiagnosticableTreeMixin {
  const _$O2OOrderModelImpl(
      {this.orderId = -1,
      final List<String> qrOrderO2o = const [],
      this.restaurantId = -1,
      this.tableName = '',
      final List<RequestOrderModel> items = const [],
      this.orderCode = '',
      this.userId = -1})
      : _qrOrderO2o = qrOrderO2o,
        _items = items,
        super._();

  factory _$O2OOrderModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$O2OOrderModelImplFromJson(json);

  @override
  @JsonKey()
  final int orderId;
  final List<String> _qrOrderO2o;
  @override
  @JsonKey()
  List<String> get qrOrderO2o {
    if (_qrOrderO2o is EqualUnmodifiableListView) return _qrOrderO2o;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_qrOrderO2o);
  }

  @override
  @JsonKey()
  final int restaurantId;
  @override
  @JsonKey()
  final String tableName;
  final List<RequestOrderModel> _items;
  @override
  @JsonKey()
  List<RequestOrderModel> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  @override
  @JsonKey()
  final String orderCode;
  @override
  @JsonKey()
  final int userId;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'O2OOrderModel(orderId: $orderId, qrOrderO2o: $qrOrderO2o, restaurantId: $restaurantId, tableName: $tableName, items: $items, orderCode: $orderCode, userId: $userId)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'O2OOrderModel'))
      ..add(DiagnosticsProperty('orderId', orderId))
      ..add(DiagnosticsProperty('qrOrderO2o', qrOrderO2o))
      ..add(DiagnosticsProperty('restaurantId', restaurantId))
      ..add(DiagnosticsProperty('tableName', tableName))
      ..add(DiagnosticsProperty('items', items))
      ..add(DiagnosticsProperty('orderCode', orderCode))
      ..add(DiagnosticsProperty('userId', userId));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$O2OOrderModelImpl &&
            (identical(other.orderId, orderId) || other.orderId == orderId) &&
            const DeepCollectionEquality()
                .equals(other._qrOrderO2o, _qrOrderO2o) &&
            (identical(other.restaurantId, restaurantId) ||
                other.restaurantId == restaurantId) &&
            (identical(other.tableName, tableName) ||
                other.tableName == tableName) &&
            const DeepCollectionEquality().equals(other._items, _items) &&
            (identical(other.orderCode, orderCode) ||
                other.orderCode == orderCode) &&
            (identical(other.userId, userId) || other.userId == userId));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      orderId,
      const DeepCollectionEquality().hash(_qrOrderO2o),
      restaurantId,
      tableName,
      const DeepCollectionEquality().hash(_items),
      orderCode,
      userId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$O2OOrderModelImplCopyWith<_$O2OOrderModelImpl> get copyWith =>
      __$$O2OOrderModelImplCopyWithImpl<_$O2OOrderModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$O2OOrderModelImplToJson(
      this,
    );
  }
}

abstract class _O2OOrderModel extends O2OOrderModel {
  const factory _O2OOrderModel(
      {final int orderId,
      final List<String> qrOrderO2o,
      final int restaurantId,
      final String tableName,
      final List<RequestOrderModel> items,
      final String orderCode,
      final int userId}) = _$O2OOrderModelImpl;
  const _O2OOrderModel._() : super._();

  factory _O2OOrderModel.fromJson(Map<String, dynamic> json) =
      _$O2OOrderModelImpl.fromJson;

  @override
  int get orderId;
  @override
  List<String> get qrOrderO2o;
  @override
  int get restaurantId;
  @override
  String get tableName;
  @override
  List<RequestOrderModel> get items;
  @override
  String get orderCode;
  @override
  int get userId;
  @override
  @JsonKey(ignore: true)
  _$$O2OOrderModelImplCopyWith<_$O2OOrderModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
