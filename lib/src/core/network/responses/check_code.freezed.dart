// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'check_code.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

CheckCodeResponse _$CheckCodeResponseFromJson(Map<String, dynamic> json) {
  return _CheckCodeResponse.fromJson(json);
}

/// @nodoc
mixin _$CheckCodeResponse {
  CheckCodeResponseData get data => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CheckCodeResponseCopyWith<CheckCodeResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CheckCodeResponseCopyWith<$Res> {
  factory $CheckCodeResponseCopyWith(
          CheckCodeResponse value, $Res Function(CheckCodeResponse) then) =
      _$CheckCodeResponseCopyWithImpl<$Res, CheckCodeResponse>;
  @useResult
  $Res call({CheckCodeResponseData data});

  $CheckCodeResponseDataCopyWith<$Res> get data;
}

/// @nodoc
class _$CheckCodeResponseCopyWithImpl<$Res, $Val extends CheckCodeResponse>
    implements $CheckCodeResponseCopyWith<$Res> {
  _$CheckCodeResponseCopyWithImpl(this._value, this._then);

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
              as CheckCodeResponseData,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $CheckCodeResponseDataCopyWith<$Res> get data {
    return $CheckCodeResponseDataCopyWith<$Res>(_value.data, (value) {
      return _then(_value.copyWith(data: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$CheckCodeResponseImplCopyWith<$Res>
    implements $CheckCodeResponseCopyWith<$Res> {
  factory _$$CheckCodeResponseImplCopyWith(_$CheckCodeResponseImpl value,
          $Res Function(_$CheckCodeResponseImpl) then) =
      __$$CheckCodeResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({CheckCodeResponseData data});

  @override
  $CheckCodeResponseDataCopyWith<$Res> get data;
}

/// @nodoc
class __$$CheckCodeResponseImplCopyWithImpl<$Res>
    extends _$CheckCodeResponseCopyWithImpl<$Res, _$CheckCodeResponseImpl>
    implements _$$CheckCodeResponseImplCopyWith<$Res> {
  __$$CheckCodeResponseImplCopyWithImpl(_$CheckCodeResponseImpl _value,
      $Res Function(_$CheckCodeResponseImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = null,
  }) {
    return _then(_$CheckCodeResponseImpl(
      data: null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as CheckCodeResponseData,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class _$CheckCodeResponseImpl
    with DiagnosticableTreeMixin
    implements _CheckCodeResponse {
  const _$CheckCodeResponseImpl({required this.data});

  factory _$CheckCodeResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$CheckCodeResponseImplFromJson(json);

  @override
  final CheckCodeResponseData data;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'CheckCodeResponse(data: $data)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'CheckCodeResponse'))
      ..add(DiagnosticsProperty('data', data));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CheckCodeResponseImpl &&
            (identical(other.data, data) || other.data == data));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, data);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CheckCodeResponseImplCopyWith<_$CheckCodeResponseImpl> get copyWith =>
      __$$CheckCodeResponseImplCopyWithImpl<_$CheckCodeResponseImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CheckCodeResponseImplToJson(
      this,
    );
  }
}

abstract class _CheckCodeResponse implements CheckCodeResponse {
  const factory _CheckCodeResponse(
      {required final CheckCodeResponseData data}) = _$CheckCodeResponseImpl;

  factory _CheckCodeResponse.fromJson(Map<String, dynamic> json) =
      _$CheckCodeResponseImpl.fromJson;

  @override
  CheckCodeResponseData get data;
  @override
  @JsonKey(ignore: true)
  _$$CheckCodeResponseImplCopyWith<_$CheckCodeResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CheckCodeResponseData _$CheckCodeResponseDataFromJson(
    Map<String, dynamic> json) {
  return _CheckCodeResponseData.fromJson(json);
}

/// @nodoc
mixin _$CheckCodeResponseData {
  bool get checkCode => throw _privateConstructorUsedError;
  String? get appCheck => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CheckCodeResponseDataCopyWith<CheckCodeResponseData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CheckCodeResponseDataCopyWith<$Res> {
  factory $CheckCodeResponseDataCopyWith(CheckCodeResponseData value,
          $Res Function(CheckCodeResponseData) then) =
      _$CheckCodeResponseDataCopyWithImpl<$Res, CheckCodeResponseData>;
  @useResult
  $Res call({bool checkCode, String? appCheck});
}

/// @nodoc
class _$CheckCodeResponseDataCopyWithImpl<$Res,
        $Val extends CheckCodeResponseData>
    implements $CheckCodeResponseDataCopyWith<$Res> {
  _$CheckCodeResponseDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? checkCode = null,
    Object? appCheck = freezed,
  }) {
    return _then(_value.copyWith(
      checkCode: null == checkCode
          ? _value.checkCode
          : checkCode // ignore: cast_nullable_to_non_nullable
              as bool,
      appCheck: freezed == appCheck
          ? _value.appCheck
          : appCheck // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CheckCodeResponseDataImplCopyWith<$Res>
    implements $CheckCodeResponseDataCopyWith<$Res> {
  factory _$$CheckCodeResponseDataImplCopyWith(
          _$CheckCodeResponseDataImpl value,
          $Res Function(_$CheckCodeResponseDataImpl) then) =
      __$$CheckCodeResponseDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool checkCode, String? appCheck});
}

/// @nodoc
class __$$CheckCodeResponseDataImplCopyWithImpl<$Res>
    extends _$CheckCodeResponseDataCopyWithImpl<$Res,
        _$CheckCodeResponseDataImpl>
    implements _$$CheckCodeResponseDataImplCopyWith<$Res> {
  __$$CheckCodeResponseDataImplCopyWithImpl(_$CheckCodeResponseDataImpl _value,
      $Res Function(_$CheckCodeResponseDataImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? checkCode = null,
    Object? appCheck = freezed,
  }) {
    return _then(_$CheckCodeResponseDataImpl(
      checkCode: null == checkCode
          ? _value.checkCode
          : checkCode // ignore: cast_nullable_to_non_nullable
              as bool,
      appCheck: freezed == appCheck
          ? _value.appCheck
          : appCheck // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$CheckCodeResponseDataImpl
    with DiagnosticableTreeMixin
    implements _CheckCodeResponseData {
  const _$CheckCodeResponseDataImpl({required this.checkCode, this.appCheck});

  factory _$CheckCodeResponseDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$CheckCodeResponseDataImplFromJson(json);

  @override
  final bool checkCode;
  @override
  final String? appCheck;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'CheckCodeResponseData(checkCode: $checkCode, appCheck: $appCheck)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'CheckCodeResponseData'))
      ..add(DiagnosticsProperty('checkCode', checkCode))
      ..add(DiagnosticsProperty('appCheck', appCheck));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CheckCodeResponseDataImpl &&
            (identical(other.checkCode, checkCode) ||
                other.checkCode == checkCode) &&
            (identical(other.appCheck, appCheck) ||
                other.appCheck == appCheck));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, checkCode, appCheck);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CheckCodeResponseDataImplCopyWith<_$CheckCodeResponseDataImpl>
      get copyWith => __$$CheckCodeResponseDataImplCopyWithImpl<
          _$CheckCodeResponseDataImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CheckCodeResponseDataImplToJson(
      this,
    );
  }
}

abstract class _CheckCodeResponseData implements CheckCodeResponseData {
  const factory _CheckCodeResponseData(
      {required final bool checkCode,
      final String? appCheck}) = _$CheckCodeResponseDataImpl;

  factory _CheckCodeResponseData.fromJson(Map<String, dynamic> json) =
      _$CheckCodeResponseDataImpl.fromJson;

  @override
  bool get checkCode;
  @override
  String? get appCheck;
  @override
  @JsonKey(ignore: true)
  _$$CheckCodeResponseDataImplCopyWith<_$CheckCodeResponseDataImpl>
      get copyWith => throw _privateConstructorUsedError;
}
