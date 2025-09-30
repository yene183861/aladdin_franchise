// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'customer_create.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

CustomerCreateResponse _$CustomerCreateResponseFromJson(
    Map<String, dynamic> json) {
  return _CustomerCreateResponse.fromJson(json);
}

/// @nodoc
mixin _$CustomerCreateResponse {
  CustomerCreateResponseData get data => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CustomerCreateResponseCopyWith<CustomerCreateResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CustomerCreateResponseCopyWith<$Res> {
  factory $CustomerCreateResponseCopyWith(CustomerCreateResponse value,
          $Res Function(CustomerCreateResponse) then) =
      _$CustomerCreateResponseCopyWithImpl<$Res, CustomerCreateResponse>;
  @useResult
  $Res call({CustomerCreateResponseData data});

  $CustomerCreateResponseDataCopyWith<$Res> get data;
}

/// @nodoc
class _$CustomerCreateResponseCopyWithImpl<$Res,
        $Val extends CustomerCreateResponse>
    implements $CustomerCreateResponseCopyWith<$Res> {
  _$CustomerCreateResponseCopyWithImpl(this._value, this._then);

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
              as CustomerCreateResponseData,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $CustomerCreateResponseDataCopyWith<$Res> get data {
    return $CustomerCreateResponseDataCopyWith<$Res>(_value.data, (value) {
      return _then(_value.copyWith(data: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$CustomerCreateResponseImplCopyWith<$Res>
    implements $CustomerCreateResponseCopyWith<$Res> {
  factory _$$CustomerCreateResponseImplCopyWith(
          _$CustomerCreateResponseImpl value,
          $Res Function(_$CustomerCreateResponseImpl) then) =
      __$$CustomerCreateResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({CustomerCreateResponseData data});

  @override
  $CustomerCreateResponseDataCopyWith<$Res> get data;
}

/// @nodoc
class __$$CustomerCreateResponseImplCopyWithImpl<$Res>
    extends _$CustomerCreateResponseCopyWithImpl<$Res,
        _$CustomerCreateResponseImpl>
    implements _$$CustomerCreateResponseImplCopyWith<$Res> {
  __$$CustomerCreateResponseImplCopyWithImpl(
      _$CustomerCreateResponseImpl _value,
      $Res Function(_$CustomerCreateResponseImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = null,
  }) {
    return _then(_$CustomerCreateResponseImpl(
      data: null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as CustomerCreateResponseData,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class _$CustomerCreateResponseImpl
    with DiagnosticableTreeMixin
    implements _CustomerCreateResponse {
  const _$CustomerCreateResponseImpl({required this.data});

  factory _$CustomerCreateResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$CustomerCreateResponseImplFromJson(json);

  @override
  final CustomerCreateResponseData data;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'CustomerCreateResponse(data: $data)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'CustomerCreateResponse'))
      ..add(DiagnosticsProperty('data', data));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CustomerCreateResponseImpl &&
            (identical(other.data, data) || other.data == data));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, data);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CustomerCreateResponseImplCopyWith<_$CustomerCreateResponseImpl>
      get copyWith => __$$CustomerCreateResponseImplCopyWithImpl<
          _$CustomerCreateResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CustomerCreateResponseImplToJson(
      this,
    );
  }
}

abstract class _CustomerCreateResponse implements CustomerCreateResponse {
  const factory _CustomerCreateResponse(
          {required final CustomerCreateResponseData data}) =
      _$CustomerCreateResponseImpl;

  factory _CustomerCreateResponse.fromJson(Map<String, dynamic> json) =
      _$CustomerCreateResponseImpl.fromJson;

  @override
  CustomerCreateResponseData get data;
  @override
  @JsonKey(ignore: true)
  _$$CustomerCreateResponseImplCopyWith<_$CustomerCreateResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}

CustomerCreateResponseData _$CustomerCreateResponseDataFromJson(
    Map<String, dynamic> json) {
  return _CustomerCreateResponseData.fromJson(json);
}

/// @nodoc
mixin _$CustomerCreateResponseData {
  int get status => throw _privateConstructorUsedError;
  dynamic get data => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CustomerCreateResponseDataCopyWith<CustomerCreateResponseData>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CustomerCreateResponseDataCopyWith<$Res> {
  factory $CustomerCreateResponseDataCopyWith(CustomerCreateResponseData value,
          $Res Function(CustomerCreateResponseData) then) =
      _$CustomerCreateResponseDataCopyWithImpl<$Res,
          CustomerCreateResponseData>;
  @useResult
  $Res call({int status, dynamic data});
}

/// @nodoc
class _$CustomerCreateResponseDataCopyWithImpl<$Res,
        $Val extends CustomerCreateResponseData>
    implements $CustomerCreateResponseDataCopyWith<$Res> {
  _$CustomerCreateResponseDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? data = freezed,
  }) {
    return _then(_value.copyWith(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as int,
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CustomerCreateResponseDataImplCopyWith<$Res>
    implements $CustomerCreateResponseDataCopyWith<$Res> {
  factory _$$CustomerCreateResponseDataImplCopyWith(
          _$CustomerCreateResponseDataImpl value,
          $Res Function(_$CustomerCreateResponseDataImpl) then) =
      __$$CustomerCreateResponseDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int status, dynamic data});
}

/// @nodoc
class __$$CustomerCreateResponseDataImplCopyWithImpl<$Res>
    extends _$CustomerCreateResponseDataCopyWithImpl<$Res,
        _$CustomerCreateResponseDataImpl>
    implements _$$CustomerCreateResponseDataImplCopyWith<$Res> {
  __$$CustomerCreateResponseDataImplCopyWithImpl(
      _$CustomerCreateResponseDataImpl _value,
      $Res Function(_$CustomerCreateResponseDataImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? data = freezed,
  }) {
    return _then(_$CustomerCreateResponseDataImpl(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as int,
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class _$CustomerCreateResponseDataImpl
    with DiagnosticableTreeMixin
    implements _CustomerCreateResponseData {
  const _$CustomerCreateResponseDataImpl({required this.status, this.data});

  factory _$CustomerCreateResponseDataImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$CustomerCreateResponseDataImplFromJson(json);

  @override
  final int status;
  @override
  final dynamic data;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'CustomerCreateResponseData(status: $status, data: $data)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'CustomerCreateResponseData'))
      ..add(DiagnosticsProperty('status', status))
      ..add(DiagnosticsProperty('data', data));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CustomerCreateResponseDataImpl &&
            (identical(other.status, status) || other.status == status) &&
            const DeepCollectionEquality().equals(other.data, data));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, status, const DeepCollectionEquality().hash(data));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CustomerCreateResponseDataImplCopyWith<_$CustomerCreateResponseDataImpl>
      get copyWith => __$$CustomerCreateResponseDataImplCopyWithImpl<
          _$CustomerCreateResponseDataImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CustomerCreateResponseDataImplToJson(
      this,
    );
  }
}

abstract class _CustomerCreateResponseData
    implements CustomerCreateResponseData {
  const factory _CustomerCreateResponseData(
      {required final int status,
      final dynamic data}) = _$CustomerCreateResponseDataImpl;

  factory _CustomerCreateResponseData.fromJson(Map<String, dynamic> json) =
      _$CustomerCreateResponseDataImpl.fromJson;

  @override
  int get status;
  @override
  dynamic get data;
  @override
  @JsonKey(ignore: true)
  _$$CustomerCreateResponseDataImplCopyWith<_$CustomerCreateResponseDataImpl>
      get copyWith => throw _privateConstructorUsedError;
}
