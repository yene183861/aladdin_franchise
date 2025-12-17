// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'coupon.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

CouponResponse _$CouponResponseFromJson(Map<String, dynamic> json) {
  return _CouponResponse.fromJson(json);
}

/// @nodoc
mixin _$CouponResponse {
  CouponResponseData get data => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CouponResponseCopyWith<CouponResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CouponResponseCopyWith<$Res> {
  factory $CouponResponseCopyWith(
          CouponResponse value, $Res Function(CouponResponse) then) =
      _$CouponResponseCopyWithImpl<$Res, CouponResponse>;
  @useResult
  $Res call({CouponResponseData data});

  $CouponResponseDataCopyWith<$Res> get data;
}

/// @nodoc
class _$CouponResponseCopyWithImpl<$Res, $Val extends CouponResponse>
    implements $CouponResponseCopyWith<$Res> {
  _$CouponResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = null,
  }) {
    return _then(_value.copyWith(
      data: null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as CouponResponseData,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $CouponResponseDataCopyWith<$Res> get data {
    return $CouponResponseDataCopyWith<$Res>(_value.data, (value) {
      return _then(_value.copyWith(data: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$CouponResponseImplCopyWith<$Res>
    implements $CouponResponseCopyWith<$Res> {
  factory _$$CouponResponseImplCopyWith(_$CouponResponseImpl value,
          $Res Function(_$CouponResponseImpl) then) =
      __$$CouponResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({CouponResponseData data});

  @override
  $CouponResponseDataCopyWith<$Res> get data;
}

/// @nodoc
class __$$CouponResponseImplCopyWithImpl<$Res>
    extends _$CouponResponseCopyWithImpl<$Res, _$CouponResponseImpl>
    implements _$$CouponResponseImplCopyWith<$Res> {
  __$$CouponResponseImplCopyWithImpl(
      _$CouponResponseImpl _value, $Res Function(_$CouponResponseImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = null,
  }) {
    return _then(_$CouponResponseImpl(
      data: null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as CouponResponseData,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class _$CouponResponseImpl
    with DiagnosticableTreeMixin
    implements _CouponResponse {
  const _$CouponResponseImpl({required this.data});

  factory _$CouponResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$CouponResponseImplFromJson(json);

  @override
  final CouponResponseData data;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'CouponResponse(data: $data)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'CouponResponse'))
      ..add(DiagnosticsProperty('data', data));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CouponResponseImpl &&
            (identical(other.data, data) || other.data == data));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, data);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CouponResponseImplCopyWith<_$CouponResponseImpl> get copyWith =>
      __$$CouponResponseImplCopyWithImpl<_$CouponResponseImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CouponResponseImplToJson(
      this,
    );
  }
}

abstract class _CouponResponse implements CouponResponse {
  const factory _CouponResponse({required final CouponResponseData data}) =
      _$CouponResponseImpl;

  factory _CouponResponse.fromJson(Map<String, dynamic> json) =
      _$CouponResponseImpl.fromJson;

  @override
  CouponResponseData get data;
  @override
  @JsonKey(ignore: true)
  _$$CouponResponseImplCopyWith<_$CouponResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CouponResponseData _$CouponResponseDataFromJson(Map<String, dynamic> json) {
  return _CouponResponseData.fromJson(json);
}

/// @nodoc
mixin _$CouponResponseData {
  int get status => throw _privateConstructorUsedError;
  List<CustomerPolicyModel> get data => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CouponResponseDataCopyWith<CouponResponseData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CouponResponseDataCopyWith<$Res> {
  factory $CouponResponseDataCopyWith(
          CouponResponseData value, $Res Function(CouponResponseData) then) =
      _$CouponResponseDataCopyWithImpl<$Res, CouponResponseData>;
  @useResult
  $Res call({int status, List<CustomerPolicyModel> data, String message});
}

/// @nodoc
class _$CouponResponseDataCopyWithImpl<$Res, $Val extends CouponResponseData>
    implements $CouponResponseDataCopyWith<$Res> {
  _$CouponResponseDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? data = null,
    Object? message = null,
  }) {
    return _then(_value.copyWith(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as int,
      data: null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as List<CustomerPolicyModel>,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CouponResponseDataImplCopyWith<$Res>
    implements $CouponResponseDataCopyWith<$Res> {
  factory _$$CouponResponseDataImplCopyWith(_$CouponResponseDataImpl value,
          $Res Function(_$CouponResponseDataImpl) then) =
      __$$CouponResponseDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int status, List<CustomerPolicyModel> data, String message});
}

/// @nodoc
class __$$CouponResponseDataImplCopyWithImpl<$Res>
    extends _$CouponResponseDataCopyWithImpl<$Res, _$CouponResponseDataImpl>
    implements _$$CouponResponseDataImplCopyWith<$Res> {
  __$$CouponResponseDataImplCopyWithImpl(_$CouponResponseDataImpl _value,
      $Res Function(_$CouponResponseDataImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? data = null,
    Object? message = null,
  }) {
    return _then(_$CouponResponseDataImpl(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as int,
      data: null == data
          ? _value._data
          : data // ignore: cast_nullable_to_non_nullable
              as List<CustomerPolicyModel>,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class _$CouponResponseDataImpl
    with DiagnosticableTreeMixin
    implements _CouponResponseData {
  const _$CouponResponseDataImpl(
      {required this.status,
      required final List<CustomerPolicyModel> data,
      this.message = ""})
      : _data = data;

  factory _$CouponResponseDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$CouponResponseDataImplFromJson(json);

  @override
  final int status;
  final List<CustomerPolicyModel> _data;
  @override
  List<CustomerPolicyModel> get data {
    if (_data is EqualUnmodifiableListView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_data);
  }

  @override
  @JsonKey()
  final String message;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'CouponResponseData(status: $status, data: $data, message: $message)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'CouponResponseData'))
      ..add(DiagnosticsProperty('status', status))
      ..add(DiagnosticsProperty('data', data))
      ..add(DiagnosticsProperty('message', message));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CouponResponseDataImpl &&
            (identical(other.status, status) || other.status == status) &&
            const DeepCollectionEquality().equals(other._data, _data) &&
            (identical(other.message, message) || other.message == message));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, status, const DeepCollectionEquality().hash(_data), message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CouponResponseDataImplCopyWith<_$CouponResponseDataImpl> get copyWith =>
      __$$CouponResponseDataImplCopyWithImpl<_$CouponResponseDataImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CouponResponseDataImplToJson(
      this,
    );
  }
}

abstract class _CouponResponseData implements CouponResponseData {
  const factory _CouponResponseData(
      {required final int status,
      required final List<CustomerPolicyModel> data,
      final String message}) = _$CouponResponseDataImpl;

  factory _CouponResponseData.fromJson(Map<String, dynamic> json) =
      _$CouponResponseDataImpl.fromJson;

  @override
  int get status;
  @override
  List<CustomerPolicyModel> get data;
  @override
  String get message;
  @override
  @JsonKey(ignore: true)
  _$$CouponResponseDataImplCopyWith<_$CouponResponseDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
