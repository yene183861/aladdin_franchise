// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'add_voucher.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

VoucherResponse _$VoucherResponseFromJson(Map<String, dynamic> json) {
  return _VoucherResponse.fromJson(json);
}

/// @nodoc
mixin _$VoucherResponse {
  String get status => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  VoucherModel? get data => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $VoucherResponseCopyWith<VoucherResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VoucherResponseCopyWith<$Res> {
  factory $VoucherResponseCopyWith(
          VoucherResponse value, $Res Function(VoucherResponse) then) =
      _$VoucherResponseCopyWithImpl<$Res, VoucherResponse>;
  @useResult
  $Res call({String status, String message, VoucherModel? data});

  $VoucherModelCopyWith<$Res>? get data;
}

/// @nodoc
class _$VoucherResponseCopyWithImpl<$Res, $Val extends VoucherResponse>
    implements $VoucherResponseCopyWith<$Res> {
  _$VoucherResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? message = null,
    Object? data = freezed,
  }) {
    return _then(_value.copyWith(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as VoucherModel?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $VoucherModelCopyWith<$Res>? get data {
    if (_value.data == null) {
      return null;
    }

    return $VoucherModelCopyWith<$Res>(_value.data!, (value) {
      return _then(_value.copyWith(data: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$VoucherResponseImplCopyWith<$Res>
    implements $VoucherResponseCopyWith<$Res> {
  factory _$$VoucherResponseImplCopyWith(_$VoucherResponseImpl value,
          $Res Function(_$VoucherResponseImpl) then) =
      __$$VoucherResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String status, String message, VoucherModel? data});

  @override
  $VoucherModelCopyWith<$Res>? get data;
}

/// @nodoc
class __$$VoucherResponseImplCopyWithImpl<$Res>
    extends _$VoucherResponseCopyWithImpl<$Res, _$VoucherResponseImpl>
    implements _$$VoucherResponseImplCopyWith<$Res> {
  __$$VoucherResponseImplCopyWithImpl(
      _$VoucherResponseImpl _value, $Res Function(_$VoucherResponseImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? message = null,
    Object? data = freezed,
  }) {
    return _then(_$VoucherResponseImpl(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as VoucherModel?,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class _$VoucherResponseImpl
    with DiagnosticableTreeMixin
    implements _VoucherResponse {
  const _$VoucherResponseImpl({this.status = '', this.message = '', this.data});

  factory _$VoucherResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$VoucherResponseImplFromJson(json);

  @override
  @JsonKey()
  final String status;
  @override
  @JsonKey()
  final String message;
  @override
  final VoucherModel? data;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'VoucherResponse(status: $status, message: $message, data: $data)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'VoucherResponse'))
      ..add(DiagnosticsProperty('status', status))
      ..add(DiagnosticsProperty('message', message))
      ..add(DiagnosticsProperty('data', data));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VoucherResponseImpl &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.data, data) || other.data == data));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, status, message, data);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$VoucherResponseImplCopyWith<_$VoucherResponseImpl> get copyWith =>
      __$$VoucherResponseImplCopyWithImpl<_$VoucherResponseImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$VoucherResponseImplToJson(
      this,
    );
  }
}

abstract class _VoucherResponse implements VoucherResponse {
  const factory _VoucherResponse(
      {final String status,
      final String message,
      final VoucherModel? data}) = _$VoucherResponseImpl;

  factory _VoucherResponse.fromJson(Map<String, dynamic> json) =
      _$VoucherResponseImpl.fromJson;

  @override
  String get status;
  @override
  String get message;
  @override
  VoucherModel? get data;
  @override
  @JsonKey(ignore: true)
  _$$VoucherResponseImplCopyWith<_$VoucherResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
