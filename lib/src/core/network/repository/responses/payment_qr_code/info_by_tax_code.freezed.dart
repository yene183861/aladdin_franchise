// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'info_by_tax_code.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

InfoByTaxCodeResponse _$InfoByTaxCodeResponseFromJson(
    Map<String, dynamic> json) {
  return _InfoByTaxCodeResponse.fromJson(json);
}

/// @nodoc
mixin _$InfoByTaxCodeResponse {
  int get status => throw _privateConstructorUsedError;
  MInvoiceInfo get data => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $InfoByTaxCodeResponseCopyWith<InfoByTaxCodeResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InfoByTaxCodeResponseCopyWith<$Res> {
  factory $InfoByTaxCodeResponseCopyWith(InfoByTaxCodeResponse value,
          $Res Function(InfoByTaxCodeResponse) then) =
      _$InfoByTaxCodeResponseCopyWithImpl<$Res, InfoByTaxCodeResponse>;
  @useResult
  $Res call({int status, MInvoiceInfo data});

  $MInvoiceInfoCopyWith<$Res> get data;
}

/// @nodoc
class _$InfoByTaxCodeResponseCopyWithImpl<$Res,
        $Val extends InfoByTaxCodeResponse>
    implements $InfoByTaxCodeResponseCopyWith<$Res> {
  _$InfoByTaxCodeResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? data = null,
  }) {
    return _then(_value.copyWith(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as int,
      data: null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as MInvoiceInfo,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $MInvoiceInfoCopyWith<$Res> get data {
    return $MInvoiceInfoCopyWith<$Res>(_value.data, (value) {
      return _then(_value.copyWith(data: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$InfoByTaxCodeResponseImplCopyWith<$Res>
    implements $InfoByTaxCodeResponseCopyWith<$Res> {
  factory _$$InfoByTaxCodeResponseImplCopyWith(
          _$InfoByTaxCodeResponseImpl value,
          $Res Function(_$InfoByTaxCodeResponseImpl) then) =
      __$$InfoByTaxCodeResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int status, MInvoiceInfo data});

  @override
  $MInvoiceInfoCopyWith<$Res> get data;
}

/// @nodoc
class __$$InfoByTaxCodeResponseImplCopyWithImpl<$Res>
    extends _$InfoByTaxCodeResponseCopyWithImpl<$Res,
        _$InfoByTaxCodeResponseImpl>
    implements _$$InfoByTaxCodeResponseImplCopyWith<$Res> {
  __$$InfoByTaxCodeResponseImplCopyWithImpl(_$InfoByTaxCodeResponseImpl _value,
      $Res Function(_$InfoByTaxCodeResponseImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? data = null,
  }) {
    return _then(_$InfoByTaxCodeResponseImpl(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as int,
      data: null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as MInvoiceInfo,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$InfoByTaxCodeResponseImpl
    with DiagnosticableTreeMixin
    implements _InfoByTaxCodeResponse {
  const _$InfoByTaxCodeResponseImpl(
      {this.status = -1, this.data = const MInvoiceInfo()});

  factory _$InfoByTaxCodeResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$InfoByTaxCodeResponseImplFromJson(json);

  @override
  @JsonKey()
  final int status;
  @override
  @JsonKey()
  final MInvoiceInfo data;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'InfoByTaxCodeResponse(status: $status, data: $data)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'InfoByTaxCodeResponse'))
      ..add(DiagnosticsProperty('status', status))
      ..add(DiagnosticsProperty('data', data));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InfoByTaxCodeResponseImpl &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.data, data) || other.data == data));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, status, data);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$InfoByTaxCodeResponseImplCopyWith<_$InfoByTaxCodeResponseImpl>
      get copyWith => __$$InfoByTaxCodeResponseImplCopyWithImpl<
          _$InfoByTaxCodeResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$InfoByTaxCodeResponseImplToJson(
      this,
    );
  }
}

abstract class _InfoByTaxCodeResponse implements InfoByTaxCodeResponse {
  const factory _InfoByTaxCodeResponse(
      {final int status,
      final MInvoiceInfo data}) = _$InfoByTaxCodeResponseImpl;

  factory _InfoByTaxCodeResponse.fromJson(Map<String, dynamic> json) =
      _$InfoByTaxCodeResponseImpl.fromJson;

  @override
  int get status;
  @override
  MInvoiceInfo get data;
  @override
  @JsonKey(ignore: true)
  _$$InfoByTaxCodeResponseImplCopyWith<_$InfoByTaxCodeResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}
