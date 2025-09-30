// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'table.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TableModel _$TableModelFromJson(Map<String, dynamic> json) {
  return _TableModel.fromJson(json);
}

/// @nodoc
mixin _$TableModel {
  int get id => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  int? get capacity => throw _privateConstructorUsedError;
  int? get status => throw _privateConstructorUsedError;
  int? get restaurantId => throw _privateConstructorUsedError;

  /// id của bàn thật ánh xạ với bàn chờ cho TTTM
  /// null nếu là bàn thật
  int? get parentId => throw _privateConstructorUsedError;
  @JsonKey(includeToJson: false, includeFromJson: false)
  int get typeOrder => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TableModelCopyWith<TableModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TableModelCopyWith<$Res> {
  factory $TableModelCopyWith(
          TableModel value, $Res Function(TableModel) then) =
      _$TableModelCopyWithImpl<$Res, TableModel>;
  @useResult
  $Res call(
      {int id,
      String? name,
      int? capacity,
      int? status,
      int? restaurantId,
      int? parentId,
      @JsonKey(includeToJson: false, includeFromJson: false) int typeOrder});
}

/// @nodoc
class _$TableModelCopyWithImpl<$Res, $Val extends TableModel>
    implements $TableModelCopyWith<$Res> {
  _$TableModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = freezed,
    Object? capacity = freezed,
    Object? status = freezed,
    Object? restaurantId = freezed,
    Object? parentId = freezed,
    Object? typeOrder = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      capacity: freezed == capacity
          ? _value.capacity
          : capacity // ignore: cast_nullable_to_non_nullable
              as int?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as int?,
      restaurantId: freezed == restaurantId
          ? _value.restaurantId
          : restaurantId // ignore: cast_nullable_to_non_nullable
              as int?,
      parentId: freezed == parentId
          ? _value.parentId
          : parentId // ignore: cast_nullable_to_non_nullable
              as int?,
      typeOrder: null == typeOrder
          ? _value.typeOrder
          : typeOrder // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TableModelImplCopyWith<$Res>
    implements $TableModelCopyWith<$Res> {
  factory _$$TableModelImplCopyWith(
          _$TableModelImpl value, $Res Function(_$TableModelImpl) then) =
      __$$TableModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String? name,
      int? capacity,
      int? status,
      int? restaurantId,
      int? parentId,
      @JsonKey(includeToJson: false, includeFromJson: false) int typeOrder});
}

/// @nodoc
class __$$TableModelImplCopyWithImpl<$Res>
    extends _$TableModelCopyWithImpl<$Res, _$TableModelImpl>
    implements _$$TableModelImplCopyWith<$Res> {
  __$$TableModelImplCopyWithImpl(
      _$TableModelImpl _value, $Res Function(_$TableModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = freezed,
    Object? capacity = freezed,
    Object? status = freezed,
    Object? restaurantId = freezed,
    Object? parentId = freezed,
    Object? typeOrder = null,
  }) {
    return _then(_$TableModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      capacity: freezed == capacity
          ? _value.capacity
          : capacity // ignore: cast_nullable_to_non_nullable
              as int?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as int?,
      restaurantId: freezed == restaurantId
          ? _value.restaurantId
          : restaurantId // ignore: cast_nullable_to_non_nullable
              as int?,
      parentId: freezed == parentId
          ? _value.parentId
          : parentId // ignore: cast_nullable_to_non_nullable
              as int?,
      typeOrder: null == typeOrder
          ? _value.typeOrder
          : typeOrder // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class _$TableModelImpl with DiagnosticableTreeMixin implements _TableModel {
  const _$TableModelImpl(
      {required this.id,
      this.name,
      this.capacity,
      this.status,
      this.restaurantId,
      this.parentId,
      @JsonKey(includeToJson: false, includeFromJson: false)
      this.typeOrder = AppConfig.orderOfflineValue});

  factory _$TableModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$TableModelImplFromJson(json);

  @override
  final int id;
  @override
  final String? name;
  @override
  final int? capacity;
  @override
  final int? status;
  @override
  final int? restaurantId;

  /// id của bàn thật ánh xạ với bàn chờ cho TTTM
  /// null nếu là bàn thật
  @override
  final int? parentId;
  @override
  @JsonKey(includeToJson: false, includeFromJson: false)
  final int typeOrder;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'TableModel(id: $id, name: $name, capacity: $capacity, status: $status, restaurantId: $restaurantId, parentId: $parentId, typeOrder: $typeOrder)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'TableModel'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('name', name))
      ..add(DiagnosticsProperty('capacity', capacity))
      ..add(DiagnosticsProperty('status', status))
      ..add(DiagnosticsProperty('restaurantId', restaurantId))
      ..add(DiagnosticsProperty('parentId', parentId))
      ..add(DiagnosticsProperty('typeOrder', typeOrder));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TableModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.capacity, capacity) ||
                other.capacity == capacity) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.restaurantId, restaurantId) ||
                other.restaurantId == restaurantId) &&
            (identical(other.parentId, parentId) ||
                other.parentId == parentId) &&
            (identical(other.typeOrder, typeOrder) ||
                other.typeOrder == typeOrder));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, capacity, status,
      restaurantId, parentId, typeOrder);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TableModelImplCopyWith<_$TableModelImpl> get copyWith =>
      __$$TableModelImplCopyWithImpl<_$TableModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TableModelImplToJson(
      this,
    );
  }
}

abstract class _TableModel implements TableModel {
  const factory _TableModel(
      {required final int id,
      final String? name,
      final int? capacity,
      final int? status,
      final int? restaurantId,
      final int? parentId,
      @JsonKey(includeToJson: false, includeFromJson: false)
      final int typeOrder}) = _$TableModelImpl;

  factory _TableModel.fromJson(Map<String, dynamic> json) =
      _$TableModelImpl.fromJson;

  @override
  int get id;
  @override
  String? get name;
  @override
  int? get capacity;
  @override
  int? get status;
  @override
  int? get restaurantId;
  @override

  /// id của bàn thật ánh xạ với bàn chờ cho TTTM
  /// null nếu là bàn thật
  int? get parentId;
  @override
  @JsonKey(includeToJson: false, includeFromJson: false)
  int get typeOrder;
  @override
  @JsonKey(ignore: true)
  _$$TableModelImplCopyWith<_$TableModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
