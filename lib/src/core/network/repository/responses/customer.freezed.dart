// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'customer.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

CustomerResponse _$CustomerResponseFromJson(Map<String, dynamic> json) {
  return _CustomerResponse.fromJson(json);
}

/// @nodoc
mixin _$CustomerResponse {
  CustomerResponseData get data => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CustomerResponseCopyWith<CustomerResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CustomerResponseCopyWith<$Res> {
  factory $CustomerResponseCopyWith(
          CustomerResponse value, $Res Function(CustomerResponse) then) =
      _$CustomerResponseCopyWithImpl<$Res, CustomerResponse>;
  @useResult
  $Res call({CustomerResponseData data});

  $CustomerResponseDataCopyWith<$Res> get data;
}

/// @nodoc
class _$CustomerResponseCopyWithImpl<$Res, $Val extends CustomerResponse>
    implements $CustomerResponseCopyWith<$Res> {
  _$CustomerResponseCopyWithImpl(this._value, this._then);

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
              as CustomerResponseData,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $CustomerResponseDataCopyWith<$Res> get data {
    return $CustomerResponseDataCopyWith<$Res>(_value.data, (value) {
      return _then(_value.copyWith(data: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$CustomerResponseImplCopyWith<$Res>
    implements $CustomerResponseCopyWith<$Res> {
  factory _$$CustomerResponseImplCopyWith(_$CustomerResponseImpl value,
          $Res Function(_$CustomerResponseImpl) then) =
      __$$CustomerResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({CustomerResponseData data});

  @override
  $CustomerResponseDataCopyWith<$Res> get data;
}

/// @nodoc
class __$$CustomerResponseImplCopyWithImpl<$Res>
    extends _$CustomerResponseCopyWithImpl<$Res, _$CustomerResponseImpl>
    implements _$$CustomerResponseImplCopyWith<$Res> {
  __$$CustomerResponseImplCopyWithImpl(_$CustomerResponseImpl _value,
      $Res Function(_$CustomerResponseImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = null,
  }) {
    return _then(_$CustomerResponseImpl(
      data: null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as CustomerResponseData,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class _$CustomerResponseImpl
    with DiagnosticableTreeMixin
    implements _CustomerResponse {
  const _$CustomerResponseImpl({required this.data});

  factory _$CustomerResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$CustomerResponseImplFromJson(json);

  @override
  final CustomerResponseData data;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'CustomerResponse(data: $data)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'CustomerResponse'))
      ..add(DiagnosticsProperty('data', data));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CustomerResponseImpl &&
            (identical(other.data, data) || other.data == data));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, data);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CustomerResponseImplCopyWith<_$CustomerResponseImpl> get copyWith =>
      __$$CustomerResponseImplCopyWithImpl<_$CustomerResponseImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CustomerResponseImplToJson(
      this,
    );
  }
}

abstract class _CustomerResponse implements CustomerResponse {
  const factory _CustomerResponse({required final CustomerResponseData data}) =
      _$CustomerResponseImpl;

  factory _CustomerResponse.fromJson(Map<String, dynamic> json) =
      _$CustomerResponseImpl.fromJson;

  @override
  CustomerResponseData get data;
  @override
  @JsonKey(ignore: true)
  _$$CustomerResponseImplCopyWith<_$CustomerResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CustomerResponseData _$CustomerResponseDataFromJson(Map<String, dynamic> json) {
  return _CustomerResponseData.fromJson(json);
}

/// @nodoc
mixin _$CustomerResponseData {
  int get status => throw _privateConstructorUsedError;
  dynamic get customer => throw _privateConstructorUsedError;
  List<CustomerPolicyModel>? get data => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CustomerResponseDataCopyWith<CustomerResponseData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CustomerResponseDataCopyWith<$Res> {
  factory $CustomerResponseDataCopyWith(CustomerResponseData value,
          $Res Function(CustomerResponseData) then) =
      _$CustomerResponseDataCopyWithImpl<$Res, CustomerResponseData>;
  @useResult
  $Res call({int status, dynamic customer, List<CustomerPolicyModel>? data});
}

/// @nodoc
class _$CustomerResponseDataCopyWithImpl<$Res,
        $Val extends CustomerResponseData>
    implements $CustomerResponseDataCopyWith<$Res> {
  _$CustomerResponseDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? customer = freezed,
    Object? data = freezed,
  }) {
    return _then(_value.copyWith(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as int,
      customer: freezed == customer
          ? _value.customer
          : customer // ignore: cast_nullable_to_non_nullable
              as dynamic,
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as List<CustomerPolicyModel>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CustomerResponseDataImplCopyWith<$Res>
    implements $CustomerResponseDataCopyWith<$Res> {
  factory _$$CustomerResponseDataImplCopyWith(_$CustomerResponseDataImpl value,
          $Res Function(_$CustomerResponseDataImpl) then) =
      __$$CustomerResponseDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int status, dynamic customer, List<CustomerPolicyModel>? data});
}

/// @nodoc
class __$$CustomerResponseDataImplCopyWithImpl<$Res>
    extends _$CustomerResponseDataCopyWithImpl<$Res, _$CustomerResponseDataImpl>
    implements _$$CustomerResponseDataImplCopyWith<$Res> {
  __$$CustomerResponseDataImplCopyWithImpl(_$CustomerResponseDataImpl _value,
      $Res Function(_$CustomerResponseDataImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? customer = freezed,
    Object? data = freezed,
  }) {
    return _then(_$CustomerResponseDataImpl(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as int,
      customer: freezed == customer
          ? _value.customer
          : customer // ignore: cast_nullable_to_non_nullable
              as dynamic,
      data: freezed == data
          ? _value._data
          : data // ignore: cast_nullable_to_non_nullable
              as List<CustomerPolicyModel>?,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class _$CustomerResponseDataImpl
    with DiagnosticableTreeMixin
    implements _CustomerResponseData {
  const _$CustomerResponseDataImpl(
      {required this.status,
      required this.customer,
      required final List<CustomerPolicyModel>? data})
      : _data = data;

  factory _$CustomerResponseDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$CustomerResponseDataImplFromJson(json);

  @override
  final int status;
  @override
  final dynamic customer;
  final List<CustomerPolicyModel>? _data;
  @override
  List<CustomerPolicyModel>? get data {
    final value = _data;
    if (value == null) return null;
    if (_data is EqualUnmodifiableListView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'CustomerResponseData(status: $status, customer: $customer, data: $data)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'CustomerResponseData'))
      ..add(DiagnosticsProperty('status', status))
      ..add(DiagnosticsProperty('customer', customer))
      ..add(DiagnosticsProperty('data', data));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CustomerResponseDataImpl &&
            (identical(other.status, status) || other.status == status) &&
            const DeepCollectionEquality().equals(other.customer, customer) &&
            const DeepCollectionEquality().equals(other._data, _data));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      status,
      const DeepCollectionEquality().hash(customer),
      const DeepCollectionEquality().hash(_data));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CustomerResponseDataImplCopyWith<_$CustomerResponseDataImpl>
      get copyWith =>
          __$$CustomerResponseDataImplCopyWithImpl<_$CustomerResponseDataImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CustomerResponseDataImplToJson(
      this,
    );
  }
}

abstract class _CustomerResponseData implements CustomerResponseData {
  const factory _CustomerResponseData(
          {required final int status,
          required final dynamic customer,
          required final List<CustomerPolicyModel>? data}) =
      _$CustomerResponseDataImpl;

  factory _CustomerResponseData.fromJson(Map<String, dynamic> json) =
      _$CustomerResponseDataImpl.fromJson;

  @override
  int get status;
  @override
  dynamic get customer;
  @override
  List<CustomerPolicyModel>? get data;
  @override
  @JsonKey(ignore: true)
  _$$CustomerResponseDataImplCopyWith<_$CustomerResponseDataImpl>
      get copyWith => throw _privateConstructorUsedError;
}
