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

OrderModel _$OrderModelFromJson(Map<String, dynamic> json) {
  return _OrderModel.fromJson(json);
}

/// @nodoc
mixin _$OrderModel {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get misc =>
      throw _privateConstructorUsedError; // 0 false | 1 true Đơn bàn bị khôi phục lại
  int get isRestore => throw _privateConstructorUsedError;
  int? get waiterId => throw _privateConstructorUsedError; // qr order tại bàn
  @JsonKey(includeToJson: false)
  List<String> get qrO2O =>
      throw _privateConstructorUsedError; // @Default('') @JsonKey(includeToJson: false) String orderCode,
  /// chuỗi "1,2"
  String get tableId => throw _privateConstructorUsedError; // @JsonKey(
//   fromJson: ParsingUtils.parseDateTime,
//   toJson: ParsingUtils.toDateTime,
// )
  DateTime? get createdAt => throw _privateConstructorUsedError;
  @JsonKey(includeToJson: false, includeFromJson: false)
  int get typeOrder => throw _privateConstructorUsedError;
  @JsonKey(includeToJson: false)
  dynamic get reservationCrmId => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $OrderModelCopyWith<OrderModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OrderModelCopyWith<$Res> {
  factory $OrderModelCopyWith(
          OrderModel value, $Res Function(OrderModel) then) =
      _$OrderModelCopyWithImpl<$Res, OrderModel>;
  @useResult
  $Res call(
      {int id,
      String name,
      String misc,
      int isRestore,
      int? waiterId,
      @JsonKey(includeToJson: false) List<String> qrO2O,
      String tableId,
      DateTime? createdAt,
      @JsonKey(includeToJson: false, includeFromJson: false) int typeOrder,
      @JsonKey(includeToJson: false) dynamic reservationCrmId});
}

/// @nodoc
class _$OrderModelCopyWithImpl<$Res, $Val extends OrderModel>
    implements $OrderModelCopyWith<$Res> {
  _$OrderModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? misc = null,
    Object? isRestore = null,
    Object? waiterId = freezed,
    Object? qrO2O = null,
    Object? tableId = null,
    Object? createdAt = freezed,
    Object? typeOrder = null,
    Object? reservationCrmId = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      misc: null == misc
          ? _value.misc
          : misc // ignore: cast_nullable_to_non_nullable
              as String,
      isRestore: null == isRestore
          ? _value.isRestore
          : isRestore // ignore: cast_nullable_to_non_nullable
              as int,
      waiterId: freezed == waiterId
          ? _value.waiterId
          : waiterId // ignore: cast_nullable_to_non_nullable
              as int?,
      qrO2O: null == qrO2O
          ? _value.qrO2O
          : qrO2O // ignore: cast_nullable_to_non_nullable
              as List<String>,
      tableId: null == tableId
          ? _value.tableId
          : tableId // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      typeOrder: null == typeOrder
          ? _value.typeOrder
          : typeOrder // ignore: cast_nullable_to_non_nullable
              as int,
      reservationCrmId: freezed == reservationCrmId
          ? _value.reservationCrmId
          : reservationCrmId // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$OrderModelImplCopyWith<$Res>
    implements $OrderModelCopyWith<$Res> {
  factory _$$OrderModelImplCopyWith(
          _$OrderModelImpl value, $Res Function(_$OrderModelImpl) then) =
      __$$OrderModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String name,
      String misc,
      int isRestore,
      int? waiterId,
      @JsonKey(includeToJson: false) List<String> qrO2O,
      String tableId,
      DateTime? createdAt,
      @JsonKey(includeToJson: false, includeFromJson: false) int typeOrder,
      @JsonKey(includeToJson: false) dynamic reservationCrmId});
}

/// @nodoc
class __$$OrderModelImplCopyWithImpl<$Res>
    extends _$OrderModelCopyWithImpl<$Res, _$OrderModelImpl>
    implements _$$OrderModelImplCopyWith<$Res> {
  __$$OrderModelImplCopyWithImpl(
      _$OrderModelImpl _value, $Res Function(_$OrderModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? misc = null,
    Object? isRestore = null,
    Object? waiterId = freezed,
    Object? qrO2O = null,
    Object? tableId = null,
    Object? createdAt = freezed,
    Object? typeOrder = null,
    Object? reservationCrmId = freezed,
  }) {
    return _then(_$OrderModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      misc: null == misc
          ? _value.misc
          : misc // ignore: cast_nullable_to_non_nullable
              as String,
      isRestore: null == isRestore
          ? _value.isRestore
          : isRestore // ignore: cast_nullable_to_non_nullable
              as int,
      waiterId: freezed == waiterId
          ? _value.waiterId
          : waiterId // ignore: cast_nullable_to_non_nullable
              as int?,
      qrO2O: null == qrO2O
          ? _value._qrO2O
          : qrO2O // ignore: cast_nullable_to_non_nullable
              as List<String>,
      tableId: null == tableId
          ? _value.tableId
          : tableId // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      typeOrder: null == typeOrder
          ? _value.typeOrder
          : typeOrder // ignore: cast_nullable_to_non_nullable
              as int,
      reservationCrmId: freezed == reservationCrmId
          ? _value.reservationCrmId
          : reservationCrmId // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class _$OrderModelImpl extends _OrderModel with DiagnosticableTreeMixin {
  const _$OrderModelImpl(
      {this.id = -1,
      this.name = '',
      this.misc = '',
      this.isRestore = 0,
      this.waiterId,
      @JsonKey(includeToJson: false) final List<String> qrO2O = const [],
      this.tableId = '',
      this.createdAt,
      @JsonKey(includeToJson: false, includeFromJson: false)
      this.typeOrder = AppConfig.orderOfflineValue,
      @JsonKey(includeToJson: false) this.reservationCrmId = null})
      : _qrO2O = qrO2O,
        super._();

  factory _$OrderModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$OrderModelImplFromJson(json);

  @override
  @JsonKey()
  final int id;
  @override
  @JsonKey()
  final String name;
  @override
  @JsonKey()
  final String misc;
// 0 false | 1 true Đơn bàn bị khôi phục lại
  @override
  @JsonKey()
  final int isRestore;
  @override
  final int? waiterId;
// qr order tại bàn
  final List<String> _qrO2O;
// qr order tại bàn
  @override
  @JsonKey(includeToJson: false)
  List<String> get qrO2O {
    if (_qrO2O is EqualUnmodifiableListView) return _qrO2O;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_qrO2O);
  }

// @Default('') @JsonKey(includeToJson: false) String orderCode,
  /// chuỗi "1,2"
  @override
  @JsonKey()
  final String tableId;
// @JsonKey(
//   fromJson: ParsingUtils.parseDateTime,
//   toJson: ParsingUtils.toDateTime,
// )
  @override
  final DateTime? createdAt;
  @override
  @JsonKey(includeToJson: false, includeFromJson: false)
  final int typeOrder;
  @override
  @JsonKey(includeToJson: false)
  final dynamic reservationCrmId;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'OrderModel(id: $id, name: $name, misc: $misc, isRestore: $isRestore, waiterId: $waiterId, qrO2O: $qrO2O, tableId: $tableId, createdAt: $createdAt, typeOrder: $typeOrder, reservationCrmId: $reservationCrmId)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'OrderModel'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('name', name))
      ..add(DiagnosticsProperty('misc', misc))
      ..add(DiagnosticsProperty('isRestore', isRestore))
      ..add(DiagnosticsProperty('waiterId', waiterId))
      ..add(DiagnosticsProperty('qrO2O', qrO2O))
      ..add(DiagnosticsProperty('tableId', tableId))
      ..add(DiagnosticsProperty('createdAt', createdAt))
      ..add(DiagnosticsProperty('typeOrder', typeOrder))
      ..add(DiagnosticsProperty('reservationCrmId', reservationCrmId));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OrderModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.misc, misc) || other.misc == misc) &&
            (identical(other.isRestore, isRestore) ||
                other.isRestore == isRestore) &&
            (identical(other.waiterId, waiterId) ||
                other.waiterId == waiterId) &&
            const DeepCollectionEquality().equals(other._qrO2O, _qrO2O) &&
            (identical(other.tableId, tableId) || other.tableId == tableId) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.typeOrder, typeOrder) ||
                other.typeOrder == typeOrder) &&
            const DeepCollectionEquality()
                .equals(other.reservationCrmId, reservationCrmId));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      misc,
      isRestore,
      waiterId,
      const DeepCollectionEquality().hash(_qrO2O),
      tableId,
      createdAt,
      typeOrder,
      const DeepCollectionEquality().hash(reservationCrmId));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$OrderModelImplCopyWith<_$OrderModelImpl> get copyWith =>
      __$$OrderModelImplCopyWithImpl<_$OrderModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OrderModelImplToJson(
      this,
    );
  }
}

abstract class _OrderModel extends OrderModel {
  const factory _OrderModel(
          {final int id,
          final String name,
          final String misc,
          final int isRestore,
          final int? waiterId,
          @JsonKey(includeToJson: false) final List<String> qrO2O,
          final String tableId,
          final DateTime? createdAt,
          @JsonKey(includeToJson: false, includeFromJson: false)
          final int typeOrder,
          @JsonKey(includeToJson: false) final dynamic reservationCrmId}) =
      _$OrderModelImpl;
  const _OrderModel._() : super._();

  factory _OrderModel.fromJson(Map<String, dynamic> json) =
      _$OrderModelImpl.fromJson;

  @override
  int get id;
  @override
  String get name;
  @override
  String get misc;
  @override // 0 false | 1 true Đơn bàn bị khôi phục lại
  int get isRestore;
  @override
  int? get waiterId;
  @override // qr order tại bàn
  @JsonKey(includeToJson: false)
  List<String> get qrO2O;
  @override // @Default('') @JsonKey(includeToJson: false) String orderCode,
  /// chuỗi "1,2"
  String get tableId;
  @override // @JsonKey(
//   fromJson: ParsingUtils.parseDateTime,
//   toJson: ParsingUtils.toDateTime,
// )
  DateTime? get createdAt;
  @override
  @JsonKey(includeToJson: false, includeFromJson: false)
  int get typeOrder;
  @override
  @JsonKey(includeToJson: false)
  dynamic get reservationCrmId;
  @override
  @JsonKey(ignore: true)
  _$$OrderModelImplCopyWith<_$OrderModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
