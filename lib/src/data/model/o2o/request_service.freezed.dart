// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'request_service.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

RequestServiceModel _$RequestServiceModelFromJson(Map<String, dynamic> json) {
  return _RequestServiceModel.fromJson(json);
}

/// @nodoc
mixin _$RequestServiceModel {
  String get message => throw _privateConstructorUsedError;
  DateTime? get dateTime => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RequestServiceModelCopyWith<RequestServiceModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RequestServiceModelCopyWith<$Res> {
  factory $RequestServiceModelCopyWith(
          RequestServiceModel value, $Res Function(RequestServiceModel) then) =
      _$RequestServiceModelCopyWithImpl<$Res, RequestServiceModel>;
  @useResult
  $Res call({String message, DateTime? dateTime});
}

/// @nodoc
class _$RequestServiceModelCopyWithImpl<$Res, $Val extends RequestServiceModel>
    implements $RequestServiceModelCopyWith<$Res> {
  _$RequestServiceModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
    Object? dateTime = freezed,
  }) {
    return _then(_value.copyWith(
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      dateTime: freezed == dateTime
          ? _value.dateTime
          : dateTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RequestServiceModelImplCopyWith<$Res>
    implements $RequestServiceModelCopyWith<$Res> {
  factory _$$RequestServiceModelImplCopyWith(_$RequestServiceModelImpl value,
          $Res Function(_$RequestServiceModelImpl) then) =
      __$$RequestServiceModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String message, DateTime? dateTime});
}

/// @nodoc
class __$$RequestServiceModelImplCopyWithImpl<$Res>
    extends _$RequestServiceModelCopyWithImpl<$Res, _$RequestServiceModelImpl>
    implements _$$RequestServiceModelImplCopyWith<$Res> {
  __$$RequestServiceModelImplCopyWithImpl(_$RequestServiceModelImpl _value,
      $Res Function(_$RequestServiceModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
    Object? dateTime = freezed,
  }) {
    return _then(_$RequestServiceModelImpl(
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      dateTime: freezed == dateTime
          ? _value.dateTime
          : dateTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RequestServiceModelImpl extends _RequestServiceModel
    with DiagnosticableTreeMixin {
  const _$RequestServiceModelImpl({this.message = '', this.dateTime})
      : super._();

  factory _$RequestServiceModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$RequestServiceModelImplFromJson(json);

  @override
  @JsonKey()
  final String message;
  @override
  final DateTime? dateTime;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'RequestServiceModel(message: $message, dateTime: $dateTime)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'RequestServiceModel'))
      ..add(DiagnosticsProperty('message', message))
      ..add(DiagnosticsProperty('dateTime', dateTime));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RequestServiceModelImpl &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.dateTime, dateTime) ||
                other.dateTime == dateTime));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, message, dateTime);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RequestServiceModelImplCopyWith<_$RequestServiceModelImpl> get copyWith =>
      __$$RequestServiceModelImplCopyWithImpl<_$RequestServiceModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RequestServiceModelImplToJson(
      this,
    );
  }
}

abstract class _RequestServiceModel extends RequestServiceModel {
  const factory _RequestServiceModel(
      {final String message,
      final DateTime? dateTime}) = _$RequestServiceModelImpl;
  const _RequestServiceModel._() : super._();

  factory _RequestServiceModel.fromJson(Map<String, dynamic> json) =
      _$RequestServiceModelImpl.fromJson;

  @override
  String get message;
  @override
  DateTime? get dateTime;
  @override
  @JsonKey(ignore: true)
  _$$RequestServiceModelImplCopyWith<_$RequestServiceModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
