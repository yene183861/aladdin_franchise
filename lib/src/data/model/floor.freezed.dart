// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'floor.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

FloorModel _$FloorModelFromJson(Map<String, dynamic> json) {
  return _FloorModel.fromJson(json);
}

/// @nodoc
mixin _$FloorModel {
  String get name => throw _privateConstructorUsedError;
  String get id => throw _privateConstructorUsedError;
  int get restaurantId => throw _privateConstructorUsedError;
  bool get isDefault => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $FloorModelCopyWith<FloorModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FloorModelCopyWith<$Res> {
  factory $FloorModelCopyWith(
          FloorModel value, $Res Function(FloorModel) then) =
      _$FloorModelCopyWithImpl<$Res, FloorModel>;
  @useResult
  $Res call({String name, String id, int restaurantId, bool isDefault});
}

/// @nodoc
class _$FloorModelCopyWithImpl<$Res, $Val extends FloorModel>
    implements $FloorModelCopyWith<$Res> {
  _$FloorModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? id = null,
    Object? restaurantId = null,
    Object? isDefault = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      restaurantId: null == restaurantId
          ? _value.restaurantId
          : restaurantId // ignore: cast_nullable_to_non_nullable
              as int,
      isDefault: null == isDefault
          ? _value.isDefault
          : isDefault // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FloorModelImplCopyWith<$Res>
    implements $FloorModelCopyWith<$Res> {
  factory _$$FloorModelImplCopyWith(
          _$FloorModelImpl value, $Res Function(_$FloorModelImpl) then) =
      __$$FloorModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name, String id, int restaurantId, bool isDefault});
}

/// @nodoc
class __$$FloorModelImplCopyWithImpl<$Res>
    extends _$FloorModelCopyWithImpl<$Res, _$FloorModelImpl>
    implements _$$FloorModelImplCopyWith<$Res> {
  __$$FloorModelImplCopyWithImpl(
      _$FloorModelImpl _value, $Res Function(_$FloorModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? id = null,
    Object? restaurantId = null,
    Object? isDefault = null,
  }) {
    return _then(_$FloorModelImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      restaurantId: null == restaurantId
          ? _value.restaurantId
          : restaurantId // ignore: cast_nullable_to_non_nullable
              as int,
      isDefault: null == isDefault
          ? _value.isDefault
          : isDefault // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class _$FloorModelImpl implements _FloorModel {
  const _$FloorModelImpl(
      {this.name = '',
      this.id = '',
      this.restaurantId = -1,
      this.isDefault = false});

  factory _$FloorModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$FloorModelImplFromJson(json);

  @override
  @JsonKey()
  final String name;
  @override
  @JsonKey()
  final String id;
  @override
  @JsonKey()
  final int restaurantId;
  @override
  @JsonKey()
  final bool isDefault;

  @override
  String toString() {
    return 'FloorModel(name: $name, id: $id, restaurantId: $restaurantId, isDefault: $isDefault)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FloorModelImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.restaurantId, restaurantId) ||
                other.restaurantId == restaurantId) &&
            (identical(other.isDefault, isDefault) ||
                other.isDefault == isDefault));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, name, id, restaurantId, isDefault);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FloorModelImplCopyWith<_$FloorModelImpl> get copyWith =>
      __$$FloorModelImplCopyWithImpl<_$FloorModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FloorModelImplToJson(
      this,
    );
  }
}

abstract class _FloorModel implements FloorModel {
  const factory _FloorModel(
      {final String name,
      final String id,
      final int restaurantId,
      final bool isDefault}) = _$FloorModelImpl;

  factory _FloorModel.fromJson(Map<String, dynamic> json) =
      _$FloorModelImpl.fromJson;

  @override
  String get name;
  @override
  String get id;
  @override
  int get restaurantId;
  @override
  bool get isDefault;
  @override
  @JsonKey(ignore: true)
  _$$FloorModelImplCopyWith<_$FloorModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
