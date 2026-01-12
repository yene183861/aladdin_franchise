// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'printer.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

PrinterModel _$PrinterModelFromJson(Map<String, dynamic> json) {
  return _PrinterModel.fromJson(json);
}

/// @nodoc
mixin _$PrinterModel {
  String? get ip => throw _privateConstructorUsedError;
  int? get port => throw _privateConstructorUsedError;
  int get type => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  int get typeAreaLocation => throw _privateConstructorUsedError;
  @JsonKey(includeFromJson: false, includeToJson: false)
  bool get pingStatus => throw _privateConstructorUsedError;
  @JsonKey(includeFromJson: false, includeToJson: false)
  bool get defaultPrinter => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PrinterModelCopyWith<PrinterModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PrinterModelCopyWith<$Res> {
  factory $PrinterModelCopyWith(
          PrinterModel value, $Res Function(PrinterModel) then) =
      _$PrinterModelCopyWithImpl<$Res, PrinterModel>;
  @useResult
  $Res call(
      {String? ip,
      int? port,
      int type,
      String name,
      int typeAreaLocation,
      @JsonKey(includeFromJson: false, includeToJson: false) bool pingStatus,
      @JsonKey(includeFromJson: false, includeToJson: false)
      bool defaultPrinter});
}

/// @nodoc
class _$PrinterModelCopyWithImpl<$Res, $Val extends PrinterModel>
    implements $PrinterModelCopyWith<$Res> {
  _$PrinterModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? ip = freezed,
    Object? port = freezed,
    Object? type = null,
    Object? name = null,
    Object? typeAreaLocation = null,
    Object? pingStatus = null,
    Object? defaultPrinter = null,
  }) {
    return _then(_value.copyWith(
      ip: freezed == ip
          ? _value.ip
          : ip // ignore: cast_nullable_to_non_nullable
              as String?,
      port: freezed == port
          ? _value.port
          : port // ignore: cast_nullable_to_non_nullable
              as int?,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      typeAreaLocation: null == typeAreaLocation
          ? _value.typeAreaLocation
          : typeAreaLocation // ignore: cast_nullable_to_non_nullable
              as int,
      pingStatus: null == pingStatus
          ? _value.pingStatus
          : pingStatus // ignore: cast_nullable_to_non_nullable
              as bool,
      defaultPrinter: null == defaultPrinter
          ? _value.defaultPrinter
          : defaultPrinter // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PrinterModelImplCopyWith<$Res>
    implements $PrinterModelCopyWith<$Res> {
  factory _$$PrinterModelImplCopyWith(
          _$PrinterModelImpl value, $Res Function(_$PrinterModelImpl) then) =
      __$$PrinterModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? ip,
      int? port,
      int type,
      String name,
      int typeAreaLocation,
      @JsonKey(includeFromJson: false, includeToJson: false) bool pingStatus,
      @JsonKey(includeFromJson: false, includeToJson: false)
      bool defaultPrinter});
}

/// @nodoc
class __$$PrinterModelImplCopyWithImpl<$Res>
    extends _$PrinterModelCopyWithImpl<$Res, _$PrinterModelImpl>
    implements _$$PrinterModelImplCopyWith<$Res> {
  __$$PrinterModelImplCopyWithImpl(
      _$PrinterModelImpl _value, $Res Function(_$PrinterModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? ip = freezed,
    Object? port = freezed,
    Object? type = null,
    Object? name = null,
    Object? typeAreaLocation = null,
    Object? pingStatus = null,
    Object? defaultPrinter = null,
  }) {
    return _then(_$PrinterModelImpl(
      ip: freezed == ip
          ? _value.ip
          : ip // ignore: cast_nullable_to_non_nullable
              as String?,
      port: freezed == port
          ? _value.port
          : port // ignore: cast_nullable_to_non_nullable
              as int?,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      typeAreaLocation: null == typeAreaLocation
          ? _value.typeAreaLocation
          : typeAreaLocation // ignore: cast_nullable_to_non_nullable
              as int,
      pingStatus: null == pingStatus
          ? _value.pingStatus
          : pingStatus // ignore: cast_nullable_to_non_nullable
              as bool,
      defaultPrinter: null == defaultPrinter
          ? _value.defaultPrinter
          : defaultPrinter // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class _$PrinterModelImpl extends _PrinterModel {
  const _$PrinterModelImpl(
      {this.ip,
      this.port,
      this.type = 1,
      this.name = 'Máy in',
      this.typeAreaLocation = 1,
      @JsonKey(includeFromJson: false, includeToJson: false)
      this.pingStatus = true,
      @JsonKey(includeFromJson: false, includeToJson: false)
      this.defaultPrinter = false})
      : super._();

  factory _$PrinterModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$PrinterModelImplFromJson(json);

  @override
  final String? ip;
  @override
  final int? port;
  @override
  @JsonKey()
  final int type;
  @override
  @JsonKey()
  final String name;
  @override
  @JsonKey()
  final int typeAreaLocation;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  final bool pingStatus;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  final bool defaultPrinter;

  @override
  String toString() {
    return 'PrinterModel(ip: $ip, port: $port, type: $type, name: $name, typeAreaLocation: $typeAreaLocation, pingStatus: $pingStatus, defaultPrinter: $defaultPrinter)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PrinterModelImplCopyWith<_$PrinterModelImpl> get copyWith =>
      __$$PrinterModelImplCopyWithImpl<_$PrinterModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PrinterModelImplToJson(
      this,
    );
  }
}

abstract class _PrinterModel extends PrinterModel {
  const factory _PrinterModel(
      {final String? ip,
      final int? port,
      final int type,
      final String name,
      final int typeAreaLocation,
      @JsonKey(includeFromJson: false, includeToJson: false)
      final bool pingStatus,
      @JsonKey(includeFromJson: false, includeToJson: false)
      final bool defaultPrinter}) = _$PrinterModelImpl;
  const _PrinterModel._() : super._();

  factory _PrinterModel.fromJson(Map<String, dynamic> json) =
      _$PrinterModelImpl.fromJson;

  @override
  String? get ip;
  @override
  int? get port;
  @override
  int get type;
  @override
  String get name;
  @override
  int get typeAreaLocation;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  bool get pingStatus;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  bool get defaultPrinter;
  @override
  @JsonKey(ignore: true)
  _$$PrinterModelImplCopyWith<_$PrinterModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
