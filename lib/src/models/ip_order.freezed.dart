// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ip_order.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

IpOrderModel _$IpOrderModelFromJson(Map<String, dynamic> json) {
  return _IpOrderModel.fromJson(json);
}

/// @nodoc
mixin _$IpOrderModel {
  String get ip => throw _privateConstructorUsedError;
  int get port => throw _privateConstructorUsedError;
  int get type => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $IpOrderModelCopyWith<IpOrderModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $IpOrderModelCopyWith<$Res> {
  factory $IpOrderModelCopyWith(
          IpOrderModel value, $Res Function(IpOrderModel) then) =
      _$IpOrderModelCopyWithImpl<$Res, IpOrderModel>;
  @useResult
  $Res call({String ip, int port, int type, String name});
}

/// @nodoc
class _$IpOrderModelCopyWithImpl<$Res, $Val extends IpOrderModel>
    implements $IpOrderModelCopyWith<$Res> {
  _$IpOrderModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? ip = null,
    Object? port = null,
    Object? type = null,
    Object? name = null,
  }) {
    return _then(_value.copyWith(
      ip: null == ip
          ? _value.ip
          : ip // ignore: cast_nullable_to_non_nullable
              as String,
      port: null == port
          ? _value.port
          : port // ignore: cast_nullable_to_non_nullable
              as int,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$IpOrderModelImplCopyWith<$Res>
    implements $IpOrderModelCopyWith<$Res> {
  factory _$$IpOrderModelImplCopyWith(
          _$IpOrderModelImpl value, $Res Function(_$IpOrderModelImpl) then) =
      __$$IpOrderModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String ip, int port, int type, String name});
}

/// @nodoc
class __$$IpOrderModelImplCopyWithImpl<$Res>
    extends _$IpOrderModelCopyWithImpl<$Res, _$IpOrderModelImpl>
    implements _$$IpOrderModelImplCopyWith<$Res> {
  __$$IpOrderModelImplCopyWithImpl(
      _$IpOrderModelImpl _value, $Res Function(_$IpOrderModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? ip = null,
    Object? port = null,
    Object? type = null,
    Object? name = null,
  }) {
    return _then(_$IpOrderModelImpl(
      ip: null == ip
          ? _value.ip
          : ip // ignore: cast_nullable_to_non_nullable
              as String,
      port: null == port
          ? _value.port
          : port // ignore: cast_nullable_to_non_nullable
              as int,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class _$IpOrderModelImpl extends _IpOrderModel with DiagnosticableTreeMixin {
  const _$IpOrderModelImpl(
      {required this.ip,
      required this.port,
      required this.type,
      this.name = 'Máy in'})
      : super._();

  factory _$IpOrderModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$IpOrderModelImplFromJson(json);

  @override
  final String ip;
  @override
  final int port;
  @override
  final int type;
  @override
  @JsonKey()
  final String name;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'IpOrderModel(ip: $ip, port: $port, type: $type, name: $name)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'IpOrderModel'))
      ..add(DiagnosticsProperty('ip', ip))
      ..add(DiagnosticsProperty('port', port))
      ..add(DiagnosticsProperty('type', type))
      ..add(DiagnosticsProperty('name', name));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$IpOrderModelImpl &&
            (identical(other.ip, ip) || other.ip == ip) &&
            (identical(other.port, port) || other.port == port) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.name, name) || other.name == name));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, ip, port, type, name);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$IpOrderModelImplCopyWith<_$IpOrderModelImpl> get copyWith =>
      __$$IpOrderModelImplCopyWithImpl<_$IpOrderModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$IpOrderModelImplToJson(
      this,
    );
  }
}

abstract class _IpOrderModel extends IpOrderModel {
  const factory _IpOrderModel(
      {required final String ip,
      required final int port,
      required final int type,
      final String name}) = _$IpOrderModelImpl;
  const _IpOrderModel._() : super._();

  factory _IpOrderModel.fromJson(Map<String, dynamic> json) =
      _$IpOrderModelImpl.fromJson;

  @override
  String get ip;
  @override
  int get port;
  @override
  int get type;
  @override
  String get name;
  @override
  @JsonKey(ignore: true)
  _$$IpOrderModelImplCopyWith<_$IpOrderModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
