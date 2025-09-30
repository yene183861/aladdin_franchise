// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'device_remote.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

DeviceRemoteModel _$DeviceRemoteModelFromJson(Map<String, dynamic> json) {
  return _DeviceRemoteModel.fromJson(json);
}

/// @nodoc
mixin _$DeviceRemoteModel {
  String get id => throw _privateConstructorUsedError;
  int get value => throw _privateConstructorUsedError;
  String? get token => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DeviceRemoteModelCopyWith<DeviceRemoteModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DeviceRemoteModelCopyWith<$Res> {
  factory $DeviceRemoteModelCopyWith(
          DeviceRemoteModel value, $Res Function(DeviceRemoteModel) then) =
      _$DeviceRemoteModelCopyWithImpl<$Res, DeviceRemoteModel>;
  @useResult
  $Res call({String id, int value, String? token});
}

/// @nodoc
class _$DeviceRemoteModelCopyWithImpl<$Res, $Val extends DeviceRemoteModel>
    implements $DeviceRemoteModelCopyWith<$Res> {
  _$DeviceRemoteModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? value = null,
    Object? token = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as int,
      token: freezed == token
          ? _value.token
          : token // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DeviceRemoteModelImplCopyWith<$Res>
    implements $DeviceRemoteModelCopyWith<$Res> {
  factory _$$DeviceRemoteModelImplCopyWith(_$DeviceRemoteModelImpl value,
          $Res Function(_$DeviceRemoteModelImpl) then) =
      __$$DeviceRemoteModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, int value, String? token});
}

/// @nodoc
class __$$DeviceRemoteModelImplCopyWithImpl<$Res>
    extends _$DeviceRemoteModelCopyWithImpl<$Res, _$DeviceRemoteModelImpl>
    implements _$$DeviceRemoteModelImplCopyWith<$Res> {
  __$$DeviceRemoteModelImplCopyWithImpl(_$DeviceRemoteModelImpl _value,
      $Res Function(_$DeviceRemoteModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? value = null,
    Object? token = freezed,
  }) {
    return _then(_$DeviceRemoteModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as int,
      token: freezed == token
          ? _value.token
          : token // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class _$DeviceRemoteModelImpl
    with DiagnosticableTreeMixin
    implements _DeviceRemoteModel {
  const _$DeviceRemoteModelImpl(
      {required this.id, required this.value, required this.token});

  factory _$DeviceRemoteModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$DeviceRemoteModelImplFromJson(json);

  @override
  final String id;
  @override
  final int value;
  @override
  final String? token;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'DeviceRemoteModel(id: $id, value: $value, token: $token)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'DeviceRemoteModel'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('value', value))
      ..add(DiagnosticsProperty('token', token));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DeviceRemoteModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.value, value) || other.value == value) &&
            (identical(other.token, token) || other.token == token));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, value, token);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DeviceRemoteModelImplCopyWith<_$DeviceRemoteModelImpl> get copyWith =>
      __$$DeviceRemoteModelImplCopyWithImpl<_$DeviceRemoteModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DeviceRemoteModelImplToJson(
      this,
    );
  }
}

abstract class _DeviceRemoteModel implements DeviceRemoteModel {
  const factory _DeviceRemoteModel(
      {required final String id,
      required final int value,
      required final String? token}) = _$DeviceRemoteModelImpl;

  factory _DeviceRemoteModel.fromJson(Map<String, dynamic> json) =
      _$DeviceRemoteModelImpl.fromJson;

  @override
  String get id;
  @override
  int get value;
  @override
  String? get token;
  @override
  @JsonKey(ignore: true)
  _$$DeviceRemoteModelImplCopyWith<_$DeviceRemoteModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

DataRemoteModel _$DataRemoteModelFromJson(Map<String, dynamic> json) {
  return _DataRemoteModel.fromJson(json);
}

/// @nodoc
mixin _$DataRemoteModel {
  String? get type => throw _privateConstructorUsedError;
  String? get styleId => throw _privateConstructorUsedError;
  String? get ipConfig => throw _privateConstructorUsedError;
  String? get enableOrderOnline => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DataRemoteModelCopyWith<DataRemoteModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DataRemoteModelCopyWith<$Res> {
  factory $DataRemoteModelCopyWith(
          DataRemoteModel value, $Res Function(DataRemoteModel) then) =
      _$DataRemoteModelCopyWithImpl<$Res, DataRemoteModel>;
  @useResult
  $Res call(
      {String? type,
      String? styleId,
      String? ipConfig,
      String? enableOrderOnline});
}

/// @nodoc
class _$DataRemoteModelCopyWithImpl<$Res, $Val extends DataRemoteModel>
    implements $DataRemoteModelCopyWith<$Res> {
  _$DataRemoteModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = freezed,
    Object? styleId = freezed,
    Object? ipConfig = freezed,
    Object? enableOrderOnline = freezed,
  }) {
    return _then(_value.copyWith(
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String?,
      styleId: freezed == styleId
          ? _value.styleId
          : styleId // ignore: cast_nullable_to_non_nullable
              as String?,
      ipConfig: freezed == ipConfig
          ? _value.ipConfig
          : ipConfig // ignore: cast_nullable_to_non_nullable
              as String?,
      enableOrderOnline: freezed == enableOrderOnline
          ? _value.enableOrderOnline
          : enableOrderOnline // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DataRemoteModelImplCopyWith<$Res>
    implements $DataRemoteModelCopyWith<$Res> {
  factory _$$DataRemoteModelImplCopyWith(_$DataRemoteModelImpl value,
          $Res Function(_$DataRemoteModelImpl) then) =
      __$$DataRemoteModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? type,
      String? styleId,
      String? ipConfig,
      String? enableOrderOnline});
}

/// @nodoc
class __$$DataRemoteModelImplCopyWithImpl<$Res>
    extends _$DataRemoteModelCopyWithImpl<$Res, _$DataRemoteModelImpl>
    implements _$$DataRemoteModelImplCopyWith<$Res> {
  __$$DataRemoteModelImplCopyWithImpl(
      _$DataRemoteModelImpl _value, $Res Function(_$DataRemoteModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = freezed,
    Object? styleId = freezed,
    Object? ipConfig = freezed,
    Object? enableOrderOnline = freezed,
  }) {
    return _then(_$DataRemoteModelImpl(
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String?,
      styleId: freezed == styleId
          ? _value.styleId
          : styleId // ignore: cast_nullable_to_non_nullable
              as String?,
      ipConfig: freezed == ipConfig
          ? _value.ipConfig
          : ipConfig // ignore: cast_nullable_to_non_nullable
              as String?,
      enableOrderOnline: freezed == enableOrderOnline
          ? _value.enableOrderOnline
          : enableOrderOnline // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class _$DataRemoteModelImpl
    with DiagnosticableTreeMixin
    implements _DataRemoteModel {
  const _$DataRemoteModelImpl(
      {required this.type,
      required this.styleId,
      required this.ipConfig,
      required this.enableOrderOnline});

  factory _$DataRemoteModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$DataRemoteModelImplFromJson(json);

  @override
  final String? type;
  @override
  final String? styleId;
  @override
  final String? ipConfig;
  @override
  final String? enableOrderOnline;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'DataRemoteModel(type: $type, styleId: $styleId, ipConfig: $ipConfig, enableOrderOnline: $enableOrderOnline)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'DataRemoteModel'))
      ..add(DiagnosticsProperty('type', type))
      ..add(DiagnosticsProperty('styleId', styleId))
      ..add(DiagnosticsProperty('ipConfig', ipConfig))
      ..add(DiagnosticsProperty('enableOrderOnline', enableOrderOnline));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DataRemoteModelImpl &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.styleId, styleId) || other.styleId == styleId) &&
            (identical(other.ipConfig, ipConfig) ||
                other.ipConfig == ipConfig) &&
            (identical(other.enableOrderOnline, enableOrderOnline) ||
                other.enableOrderOnline == enableOrderOnline));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, type, styleId, ipConfig, enableOrderOnline);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DataRemoteModelImplCopyWith<_$DataRemoteModelImpl> get copyWith =>
      __$$DataRemoteModelImplCopyWithImpl<_$DataRemoteModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DataRemoteModelImplToJson(
      this,
    );
  }
}

abstract class _DataRemoteModel implements DataRemoteModel {
  const factory _DataRemoteModel(
      {required final String? type,
      required final String? styleId,
      required final String? ipConfig,
      required final String? enableOrderOnline}) = _$DataRemoteModelImpl;

  factory _DataRemoteModel.fromJson(Map<String, dynamic> json) =
      _$DataRemoteModelImpl.fromJson;

  @override
  String? get type;
  @override
  String? get styleId;
  @override
  String? get ipConfig;
  @override
  String? get enableOrderOnline;
  @override
  @JsonKey(ignore: true)
  _$$DataRemoteModelImplCopyWith<_$DataRemoteModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
