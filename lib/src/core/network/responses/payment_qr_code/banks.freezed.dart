// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'banks.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

BankPaymentResponse _$BankPaymentResponseFromJson(Map<String, dynamic> json) {
  return _BankPaymentResponse.fromJson(json);
}

/// @nodoc
mixin _$BankPaymentResponse {
  int get status => throw _privateConstructorUsedError;
  List<UserBankModel> get data => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $BankPaymentResponseCopyWith<BankPaymentResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BankPaymentResponseCopyWith<$Res> {
  factory $BankPaymentResponseCopyWith(
          BankPaymentResponse value, $Res Function(BankPaymentResponse) then) =
      _$BankPaymentResponseCopyWithImpl<$Res, BankPaymentResponse>;
  @useResult
  $Res call({int status, List<UserBankModel> data});
}

/// @nodoc
class _$BankPaymentResponseCopyWithImpl<$Res, $Val extends BankPaymentResponse>
    implements $BankPaymentResponseCopyWith<$Res> {
  _$BankPaymentResponseCopyWithImpl(this._value, this._then);

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
              as List<UserBankModel>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BankPaymentResponseImplCopyWith<$Res>
    implements $BankPaymentResponseCopyWith<$Res> {
  factory _$$BankPaymentResponseImplCopyWith(_$BankPaymentResponseImpl value,
          $Res Function(_$BankPaymentResponseImpl) then) =
      __$$BankPaymentResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int status, List<UserBankModel> data});
}

/// @nodoc
class __$$BankPaymentResponseImplCopyWithImpl<$Res>
    extends _$BankPaymentResponseCopyWithImpl<$Res, _$BankPaymentResponseImpl>
    implements _$$BankPaymentResponseImplCopyWith<$Res> {
  __$$BankPaymentResponseImplCopyWithImpl(_$BankPaymentResponseImpl _value,
      $Res Function(_$BankPaymentResponseImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? data = null,
  }) {
    return _then(_$BankPaymentResponseImpl(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as int,
      data: null == data
          ? _value._data
          : data // ignore: cast_nullable_to_non_nullable
              as List<UserBankModel>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$BankPaymentResponseImpl
    with DiagnosticableTreeMixin
    implements _BankPaymentResponse {
  const _$BankPaymentResponseImpl(
      {this.status = -1, final List<UserBankModel> data = const []})
      : _data = data;

  factory _$BankPaymentResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$BankPaymentResponseImplFromJson(json);

  @override
  @JsonKey()
  final int status;
  final List<UserBankModel> _data;
  @override
  @JsonKey()
  List<UserBankModel> get data {
    if (_data is EqualUnmodifiableListView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_data);
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'BankPaymentResponse(status: $status, data: $data)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'BankPaymentResponse'))
      ..add(DiagnosticsProperty('status', status))
      ..add(DiagnosticsProperty('data', data));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BankPaymentResponseImpl &&
            (identical(other.status, status) || other.status == status) &&
            const DeepCollectionEquality().equals(other._data, _data));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, status, const DeepCollectionEquality().hash(_data));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$BankPaymentResponseImplCopyWith<_$BankPaymentResponseImpl> get copyWith =>
      __$$BankPaymentResponseImplCopyWithImpl<_$BankPaymentResponseImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BankPaymentResponseImplToJson(
      this,
    );
  }
}

abstract class _BankPaymentResponse implements BankPaymentResponse {
  const factory _BankPaymentResponse(
      {final int status,
      final List<UserBankModel> data}) = _$BankPaymentResponseImpl;

  factory _BankPaymentResponse.fromJson(Map<String, dynamic> json) =
      _$BankPaymentResponseImpl.fromJson;

  @override
  int get status;
  @override
  List<UserBankModel> get data;
  @override
  @JsonKey(ignore: true)
  _$$BankPaymentResponseImplCopyWith<_$BankPaymentResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
