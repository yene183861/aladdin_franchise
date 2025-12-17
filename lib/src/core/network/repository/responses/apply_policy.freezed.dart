// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'apply_policy.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ApplyPolicyResponse _$ApplyPolicyResponseFromJson(Map<String, dynamic> json) {
  return _ApplyPolicyResponse.fromJson(json);
}

/// @nodoc
mixin _$ApplyPolicyResponse {
  ApplyPolicyResponseData get data => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ApplyPolicyResponseCopyWith<ApplyPolicyResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ApplyPolicyResponseCopyWith<$Res> {
  factory $ApplyPolicyResponseCopyWith(
          ApplyPolicyResponse value, $Res Function(ApplyPolicyResponse) then) =
      _$ApplyPolicyResponseCopyWithImpl<$Res, ApplyPolicyResponse>;
  @useResult
  $Res call({ApplyPolicyResponseData data});

  $ApplyPolicyResponseDataCopyWith<$Res> get data;
}

/// @nodoc
class _$ApplyPolicyResponseCopyWithImpl<$Res, $Val extends ApplyPolicyResponse>
    implements $ApplyPolicyResponseCopyWith<$Res> {
  _$ApplyPolicyResponseCopyWithImpl(this._value, this._then);

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
              as ApplyPolicyResponseData,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $ApplyPolicyResponseDataCopyWith<$Res> get data {
    return $ApplyPolicyResponseDataCopyWith<$Res>(_value.data, (value) {
      return _then(_value.copyWith(data: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ApplyPolicyResponseImplCopyWith<$Res>
    implements $ApplyPolicyResponseCopyWith<$Res> {
  factory _$$ApplyPolicyResponseImplCopyWith(_$ApplyPolicyResponseImpl value,
          $Res Function(_$ApplyPolicyResponseImpl) then) =
      __$$ApplyPolicyResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({ApplyPolicyResponseData data});

  @override
  $ApplyPolicyResponseDataCopyWith<$Res> get data;
}

/// @nodoc
class __$$ApplyPolicyResponseImplCopyWithImpl<$Res>
    extends _$ApplyPolicyResponseCopyWithImpl<$Res, _$ApplyPolicyResponseImpl>
    implements _$$ApplyPolicyResponseImplCopyWith<$Res> {
  __$$ApplyPolicyResponseImplCopyWithImpl(_$ApplyPolicyResponseImpl _value,
      $Res Function(_$ApplyPolicyResponseImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = null,
  }) {
    return _then(_$ApplyPolicyResponseImpl(
      data: null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as ApplyPolicyResponseData,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class _$ApplyPolicyResponseImpl
    with DiagnosticableTreeMixin
    implements _ApplyPolicyResponse {
  const _$ApplyPolicyResponseImpl({required this.data});

  factory _$ApplyPolicyResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$ApplyPolicyResponseImplFromJson(json);

  @override
  final ApplyPolicyResponseData data;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ApplyPolicyResponse(data: $data)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'ApplyPolicyResponse'))
      ..add(DiagnosticsProperty('data', data));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ApplyPolicyResponseImpl &&
            (identical(other.data, data) || other.data == data));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, data);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ApplyPolicyResponseImplCopyWith<_$ApplyPolicyResponseImpl> get copyWith =>
      __$$ApplyPolicyResponseImplCopyWithImpl<_$ApplyPolicyResponseImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ApplyPolicyResponseImplToJson(
      this,
    );
  }
}

abstract class _ApplyPolicyResponse implements ApplyPolicyResponse {
  const factory _ApplyPolicyResponse(
          {required final ApplyPolicyResponseData data}) =
      _$ApplyPolicyResponseImpl;

  factory _ApplyPolicyResponse.fromJson(Map<String, dynamic> json) =
      _$ApplyPolicyResponseImpl.fromJson;

  @override
  ApplyPolicyResponseData get data;
  @override
  @JsonKey(ignore: true)
  _$$ApplyPolicyResponseImplCopyWith<_$ApplyPolicyResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ApplyPolicyResponseData _$ApplyPolicyResponseDataFromJson(
    Map<String, dynamic> json) {
  return _ApplyPolicyResponseData.fromJson(json);
}

/// @nodoc
mixin _$ApplyPolicyResponseData {
  int get status => throw _privateConstructorUsedError;
  List<PolicyResultModel> get data => throw _privateConstructorUsedError;
  dynamic get dataCreateVouchers => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ApplyPolicyResponseDataCopyWith<ApplyPolicyResponseData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ApplyPolicyResponseDataCopyWith<$Res> {
  factory $ApplyPolicyResponseDataCopyWith(ApplyPolicyResponseData value,
          $Res Function(ApplyPolicyResponseData) then) =
      _$ApplyPolicyResponseDataCopyWithImpl<$Res, ApplyPolicyResponseData>;
  @useResult
  $Res call(
      {int status, List<PolicyResultModel> data, dynamic dataCreateVouchers});
}

/// @nodoc
class _$ApplyPolicyResponseDataCopyWithImpl<$Res,
        $Val extends ApplyPolicyResponseData>
    implements $ApplyPolicyResponseDataCopyWith<$Res> {
  _$ApplyPolicyResponseDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? data = null,
    Object? dataCreateVouchers = freezed,
  }) {
    return _then(_value.copyWith(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as int,
      data: null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as List<PolicyResultModel>,
      dataCreateVouchers: freezed == dataCreateVouchers
          ? _value.dataCreateVouchers
          : dataCreateVouchers // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ApplyPolicyResponseDataImplCopyWith<$Res>
    implements $ApplyPolicyResponseDataCopyWith<$Res> {
  factory _$$ApplyPolicyResponseDataImplCopyWith(
          _$ApplyPolicyResponseDataImpl value,
          $Res Function(_$ApplyPolicyResponseDataImpl) then) =
      __$$ApplyPolicyResponseDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int status, List<PolicyResultModel> data, dynamic dataCreateVouchers});
}

/// @nodoc
class __$$ApplyPolicyResponseDataImplCopyWithImpl<$Res>
    extends _$ApplyPolicyResponseDataCopyWithImpl<$Res,
        _$ApplyPolicyResponseDataImpl>
    implements _$$ApplyPolicyResponseDataImplCopyWith<$Res> {
  __$$ApplyPolicyResponseDataImplCopyWithImpl(
      _$ApplyPolicyResponseDataImpl _value,
      $Res Function(_$ApplyPolicyResponseDataImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? data = null,
    Object? dataCreateVouchers = freezed,
  }) {
    return _then(_$ApplyPolicyResponseDataImpl(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as int,
      data: null == data
          ? _value._data
          : data // ignore: cast_nullable_to_non_nullable
              as List<PolicyResultModel>,
      dataCreateVouchers: freezed == dataCreateVouchers
          ? _value.dataCreateVouchers
          : dataCreateVouchers // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$ApplyPolicyResponseDataImpl
    with DiagnosticableTreeMixin
    implements _ApplyPolicyResponseData {
  const _$ApplyPolicyResponseDataImpl(
      {required this.status,
      required final List<PolicyResultModel> data,
      required this.dataCreateVouchers})
      : _data = data;

  factory _$ApplyPolicyResponseDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$ApplyPolicyResponseDataImplFromJson(json);

  @override
  final int status;
  final List<PolicyResultModel> _data;
  @override
  List<PolicyResultModel> get data {
    if (_data is EqualUnmodifiableListView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_data);
  }

  @override
  final dynamic dataCreateVouchers;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ApplyPolicyResponseData(status: $status, data: $data, dataCreateVouchers: $dataCreateVouchers)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'ApplyPolicyResponseData'))
      ..add(DiagnosticsProperty('status', status))
      ..add(DiagnosticsProperty('data', data))
      ..add(DiagnosticsProperty('dataCreateVouchers', dataCreateVouchers));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ApplyPolicyResponseDataImpl &&
            (identical(other.status, status) || other.status == status) &&
            const DeepCollectionEquality().equals(other._data, _data) &&
            const DeepCollectionEquality()
                .equals(other.dataCreateVouchers, dataCreateVouchers));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      status,
      const DeepCollectionEquality().hash(_data),
      const DeepCollectionEquality().hash(dataCreateVouchers));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ApplyPolicyResponseDataImplCopyWith<_$ApplyPolicyResponseDataImpl>
      get copyWith => __$$ApplyPolicyResponseDataImplCopyWithImpl<
          _$ApplyPolicyResponseDataImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ApplyPolicyResponseDataImplToJson(
      this,
    );
  }
}

abstract class _ApplyPolicyResponseData implements ApplyPolicyResponseData {
  const factory _ApplyPolicyResponseData(
          {required final int status,
          required final List<PolicyResultModel> data,
          required final dynamic dataCreateVouchers}) =
      _$ApplyPolicyResponseDataImpl;

  factory _ApplyPolicyResponseData.fromJson(Map<String, dynamic> json) =
      _$ApplyPolicyResponseDataImpl.fromJson;

  @override
  int get status;
  @override
  List<PolicyResultModel> get data;
  @override
  dynamic get dataCreateVouchers;
  @override
  @JsonKey(ignore: true)
  _$$ApplyPolicyResponseDataImplCopyWith<_$ApplyPolicyResponseDataImpl>
      get copyWith => throw _privateConstructorUsedError;
}
