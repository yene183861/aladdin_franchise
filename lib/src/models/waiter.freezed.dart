// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'waiter.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

WaiterModel _$WaiterModelFromJson(Map<String, dynamic> json) {
  return _WaiterModel.fromJson(json);
}

/// @nodoc
mixin _$WaiterModel {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get fullName => throw _privateConstructorUsedError;
  @JsonKey(name: 'user_name')
  String get username => throw _privateConstructorUsedError;
  String get password => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $WaiterModelCopyWith<WaiterModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WaiterModelCopyWith<$Res> {
  factory $WaiterModelCopyWith(
          WaiterModel value, $Res Function(WaiterModel) then) =
      _$WaiterModelCopyWithImpl<$Res, WaiterModel>;
  @useResult
  $Res call(
      {int id,
      String name,
      String fullName,
      @JsonKey(name: 'user_name') String username,
      String password});
}

/// @nodoc
class _$WaiterModelCopyWithImpl<$Res, $Val extends WaiterModel>
    implements $WaiterModelCopyWith<$Res> {
  _$WaiterModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? fullName = null,
    Object? username = null,
    Object? password = null,
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
      fullName: null == fullName
          ? _value.fullName
          : fullName // ignore: cast_nullable_to_non_nullable
              as String,
      username: null == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
      password: null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$WaiterModelImplCopyWith<$Res>
    implements $WaiterModelCopyWith<$Res> {
  factory _$$WaiterModelImplCopyWith(
          _$WaiterModelImpl value, $Res Function(_$WaiterModelImpl) then) =
      __$$WaiterModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String name,
      String fullName,
      @JsonKey(name: 'user_name') String username,
      String password});
}

/// @nodoc
class __$$WaiterModelImplCopyWithImpl<$Res>
    extends _$WaiterModelCopyWithImpl<$Res, _$WaiterModelImpl>
    implements _$$WaiterModelImplCopyWith<$Res> {
  __$$WaiterModelImplCopyWithImpl(
      _$WaiterModelImpl _value, $Res Function(_$WaiterModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? fullName = null,
    Object? username = null,
    Object? password = null,
  }) {
    return _then(_$WaiterModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      fullName: null == fullName
          ? _value.fullName
          : fullName // ignore: cast_nullable_to_non_nullable
              as String,
      username: null == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
      password: null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class _$WaiterModelImpl with DiagnosticableTreeMixin implements _WaiterModel {
  const _$WaiterModelImpl(
      {required this.id,
      required this.name,
      this.fullName = "No name",
      @JsonKey(name: 'user_name') this.username = "",
      this.password = ""});

  factory _$WaiterModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$WaiterModelImplFromJson(json);

  @override
  final int id;
  @override
  final String name;
  @override
  @JsonKey()
  final String fullName;
  @override
  @JsonKey(name: 'user_name')
  final String username;
  @override
  @JsonKey()
  final String password;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'WaiterModel(id: $id, name: $name, fullName: $fullName, username: $username, password: $password)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'WaiterModel'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('name', name))
      ..add(DiagnosticsProperty('fullName', fullName))
      ..add(DiagnosticsProperty('username', username))
      ..add(DiagnosticsProperty('password', password));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WaiterModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.fullName, fullName) ||
                other.fullName == fullName) &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.password, password) ||
                other.password == password));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, name, fullName, username, password);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$WaiterModelImplCopyWith<_$WaiterModelImpl> get copyWith =>
      __$$WaiterModelImplCopyWithImpl<_$WaiterModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WaiterModelImplToJson(
      this,
    );
  }
}

abstract class _WaiterModel implements WaiterModel {
  const factory _WaiterModel(
      {required final int id,
      required final String name,
      final String fullName,
      @JsonKey(name: 'user_name') final String username,
      final String password}) = _$WaiterModelImpl;

  factory _WaiterModel.fromJson(Map<String, dynamic> json) =
      _$WaiterModelImpl.fromJson;

  @override
  int get id;
  @override
  String get name;
  @override
  String get fullName;
  @override
  @JsonKey(name: 'user_name')
  String get username;
  @override
  String get password;
  @override
  @JsonKey(ignore: true)
  _$$WaiterModelImplCopyWith<_$WaiterModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
