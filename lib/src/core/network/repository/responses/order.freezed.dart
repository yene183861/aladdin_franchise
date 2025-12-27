// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'order.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

OrdersResponseData _$OrdersResponseDataFromJson(Map<String, dynamic> json) {
  return _OrdersResponseData.fromJson(json);
}

/// @nodoc
mixin _$OrdersResponseData {
  List<TableModel> get notUse => throw _privateConstructorUsedError;
  List<TableModel> get using => throw _privateConstructorUsedError;
  List<OrderModel> get userUsing => throw _privateConstructorUsedError;
  List<WaiterModel>? get waiters => throw _privateConstructorUsedError;
  dynamic get ipOrder => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $OrdersResponseDataCopyWith<OrdersResponseData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OrdersResponseDataCopyWith<$Res> {
  factory $OrdersResponseDataCopyWith(
          OrdersResponseData value, $Res Function(OrdersResponseData) then) =
      _$OrdersResponseDataCopyWithImpl<$Res, OrdersResponseData>;
  @useResult
  $Res call(
      {List<TableModel> notUse,
      List<TableModel> using,
      List<OrderModel> userUsing,
      List<WaiterModel>? waiters,
      dynamic ipOrder});
}

/// @nodoc
class _$OrdersResponseDataCopyWithImpl<$Res, $Val extends OrdersResponseData>
    implements $OrdersResponseDataCopyWith<$Res> {
  _$OrdersResponseDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? notUse = null,
    Object? using = null,
    Object? userUsing = null,
    Object? waiters = freezed,
    Object? ipOrder = freezed,
  }) {
    return _then(_value.copyWith(
      notUse: null == notUse
          ? _value.notUse
          : notUse // ignore: cast_nullable_to_non_nullable
              as List<TableModel>,
      using: null == using
          ? _value.using
          : using // ignore: cast_nullable_to_non_nullable
              as List<TableModel>,
      userUsing: null == userUsing
          ? _value.userUsing
          : userUsing // ignore: cast_nullable_to_non_nullable
              as List<OrderModel>,
      waiters: freezed == waiters
          ? _value.waiters
          : waiters // ignore: cast_nullable_to_non_nullable
              as List<WaiterModel>?,
      ipOrder: freezed == ipOrder
          ? _value.ipOrder
          : ipOrder // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$OrdersResponseDataImplCopyWith<$Res>
    implements $OrdersResponseDataCopyWith<$Res> {
  factory _$$OrdersResponseDataImplCopyWith(_$OrdersResponseDataImpl value,
          $Res Function(_$OrdersResponseDataImpl) then) =
      __$$OrdersResponseDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<TableModel> notUse,
      List<TableModel> using,
      List<OrderModel> userUsing,
      List<WaiterModel>? waiters,
      dynamic ipOrder});
}

/// @nodoc
class __$$OrdersResponseDataImplCopyWithImpl<$Res>
    extends _$OrdersResponseDataCopyWithImpl<$Res, _$OrdersResponseDataImpl>
    implements _$$OrdersResponseDataImplCopyWith<$Res> {
  __$$OrdersResponseDataImplCopyWithImpl(_$OrdersResponseDataImpl _value,
      $Res Function(_$OrdersResponseDataImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? notUse = null,
    Object? using = null,
    Object? userUsing = null,
    Object? waiters = freezed,
    Object? ipOrder = freezed,
  }) {
    return _then(_$OrdersResponseDataImpl(
      notUse: null == notUse
          ? _value._notUse
          : notUse // ignore: cast_nullable_to_non_nullable
              as List<TableModel>,
      using: null == using
          ? _value._using
          : using // ignore: cast_nullable_to_non_nullable
              as List<TableModel>,
      userUsing: null == userUsing
          ? _value._userUsing
          : userUsing // ignore: cast_nullable_to_non_nullable
              as List<OrderModel>,
      waiters: freezed == waiters
          ? _value._waiters
          : waiters // ignore: cast_nullable_to_non_nullable
              as List<WaiterModel>?,
      ipOrder: freezed == ipOrder
          ? _value.ipOrder
          : ipOrder // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class _$OrdersResponseDataImpl
    with DiagnosticableTreeMixin
    implements _OrdersResponseData {
  const _$OrdersResponseDataImpl(
      {final List<TableModel> notUse = const [],
      final List<TableModel> using = const [],
      final List<OrderModel> userUsing = const [],
      final List<WaiterModel>? waiters,
      this.ipOrder})
      : _notUse = notUse,
        _using = using,
        _userUsing = userUsing,
        _waiters = waiters;

  factory _$OrdersResponseDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$OrdersResponseDataImplFromJson(json);

  final List<TableModel> _notUse;
  @override
  @JsonKey()
  List<TableModel> get notUse {
    if (_notUse is EqualUnmodifiableListView) return _notUse;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_notUse);
  }

  final List<TableModel> _using;
  @override
  @JsonKey()
  List<TableModel> get using {
    if (_using is EqualUnmodifiableListView) return _using;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_using);
  }

  final List<OrderModel> _userUsing;
  @override
  @JsonKey()
  List<OrderModel> get userUsing {
    if (_userUsing is EqualUnmodifiableListView) return _userUsing;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_userUsing);
  }

  final List<WaiterModel>? _waiters;
  @override
  List<WaiterModel>? get waiters {
    final value = _waiters;
    if (value == null) return null;
    if (_waiters is EqualUnmodifiableListView) return _waiters;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final dynamic ipOrder;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'OrdersResponseData(notUse: $notUse, using: $using, userUsing: $userUsing, waiters: $waiters, ipOrder: $ipOrder)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'OrdersResponseData'))
      ..add(DiagnosticsProperty('notUse', notUse))
      ..add(DiagnosticsProperty('using', using))
      ..add(DiagnosticsProperty('userUsing', userUsing))
      ..add(DiagnosticsProperty('waiters', waiters))
      ..add(DiagnosticsProperty('ipOrder', ipOrder));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OrdersResponseDataImpl &&
            const DeepCollectionEquality().equals(other._notUse, _notUse) &&
            const DeepCollectionEquality().equals(other._using, _using) &&
            const DeepCollectionEquality()
                .equals(other._userUsing, _userUsing) &&
            const DeepCollectionEquality().equals(other._waiters, _waiters) &&
            const DeepCollectionEquality().equals(other.ipOrder, ipOrder));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_notUse),
      const DeepCollectionEquality().hash(_using),
      const DeepCollectionEquality().hash(_userUsing),
      const DeepCollectionEquality().hash(_waiters),
      const DeepCollectionEquality().hash(ipOrder));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$OrdersResponseDataImplCopyWith<_$OrdersResponseDataImpl> get copyWith =>
      __$$OrdersResponseDataImplCopyWithImpl<_$OrdersResponseDataImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OrdersResponseDataImplToJson(
      this,
    );
  }
}

abstract class _OrdersResponseData implements OrdersResponseData {
  const factory _OrdersResponseData(
      {final List<TableModel> notUse,
      final List<TableModel> using,
      final List<OrderModel> userUsing,
      final List<WaiterModel>? waiters,
      final dynamic ipOrder}) = _$OrdersResponseDataImpl;

  factory _OrdersResponseData.fromJson(Map<String, dynamic> json) =
      _$OrdersResponseDataImpl.fromJson;

  @override
  List<TableModel> get notUse;
  @override
  List<TableModel> get using;
  @override
  List<OrderModel> get userUsing;
  @override
  List<WaiterModel>? get waiters;
  @override
  dynamic get ipOrder;
  @override
  @JsonKey(ignore: true)
  _$$OrdersResponseDataImplCopyWith<_$OrdersResponseDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
