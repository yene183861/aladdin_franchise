// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'redis_gateway_payment.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

RedisGatewayPayment _$RedisGatewayPaymentFromJson(Map<String, dynamic> json) {
  return _RedisGatewayPayment.fromJson(json);
}

/// @nodoc
mixin _$RedisGatewayPayment {
  String get host => throw _privateConstructorUsedError;
  int get port => throw _privateConstructorUsedError;
  String? get username => throw _privateConstructorUsedError;
  String? get password => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RedisGatewayPaymentCopyWith<RedisGatewayPayment> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RedisGatewayPaymentCopyWith<$Res> {
  factory $RedisGatewayPaymentCopyWith(
          RedisGatewayPayment value, $Res Function(RedisGatewayPayment) then) =
      _$RedisGatewayPaymentCopyWithImpl<$Res, RedisGatewayPayment>;
  @useResult
  $Res call({String host, int port, String? username, String? password});
}

/// @nodoc
class _$RedisGatewayPaymentCopyWithImpl<$Res, $Val extends RedisGatewayPayment>
    implements $RedisGatewayPaymentCopyWith<$Res> {
  _$RedisGatewayPaymentCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? host = null,
    Object? port = null,
    Object? username = freezed,
    Object? password = freezed,
  }) {
    return _then(_value.copyWith(
      host: null == host
          ? _value.host
          : host // ignore: cast_nullable_to_non_nullable
              as String,
      port: null == port
          ? _value.port
          : port // ignore: cast_nullable_to_non_nullable
              as int,
      username: freezed == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String?,
      password: freezed == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RedisGatewayPaymentImplCopyWith<$Res>
    implements $RedisGatewayPaymentCopyWith<$Res> {
  factory _$$RedisGatewayPaymentImplCopyWith(_$RedisGatewayPaymentImpl value,
          $Res Function(_$RedisGatewayPaymentImpl) then) =
      __$$RedisGatewayPaymentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String host, int port, String? username, String? password});
}

/// @nodoc
class __$$RedisGatewayPaymentImplCopyWithImpl<$Res>
    extends _$RedisGatewayPaymentCopyWithImpl<$Res, _$RedisGatewayPaymentImpl>
    implements _$$RedisGatewayPaymentImplCopyWith<$Res> {
  __$$RedisGatewayPaymentImplCopyWithImpl(_$RedisGatewayPaymentImpl _value,
      $Res Function(_$RedisGatewayPaymentImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? host = null,
    Object? port = null,
    Object? username = freezed,
    Object? password = freezed,
  }) {
    return _then(_$RedisGatewayPaymentImpl(
      host: null == host
          ? _value.host
          : host // ignore: cast_nullable_to_non_nullable
              as String,
      port: null == port
          ? _value.port
          : port // ignore: cast_nullable_to_non_nullable
              as int,
      username: freezed == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String?,
      password: freezed == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class _$RedisGatewayPaymentImpl extends _RedisGatewayPayment {
  const _$RedisGatewayPaymentImpl(
      {this.host = '', this.port = 6379, this.username, this.password})
      : super._();

  factory _$RedisGatewayPaymentImpl.fromJson(Map<String, dynamic> json) =>
      _$$RedisGatewayPaymentImplFromJson(json);

  @override
  @JsonKey()
  final String host;
  @override
  @JsonKey()
  final int port;
  @override
  final String? username;
  @override
  final String? password;

  @override
  String toString() {
    return 'RedisGatewayPayment(host: $host, port: $port, username: $username, password: $password)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RedisGatewayPaymentImpl &&
            (identical(other.host, host) || other.host == host) &&
            (identical(other.port, port) || other.port == port) &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.password, password) ||
                other.password == password));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, host, port, username, password);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RedisGatewayPaymentImplCopyWith<_$RedisGatewayPaymentImpl> get copyWith =>
      __$$RedisGatewayPaymentImplCopyWithImpl<_$RedisGatewayPaymentImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RedisGatewayPaymentImplToJson(
      this,
    );
  }
}

abstract class _RedisGatewayPayment extends RedisGatewayPayment {
  const factory _RedisGatewayPayment(
      {final String host,
      final int port,
      final String? username,
      final String? password}) = _$RedisGatewayPaymentImpl;
  const _RedisGatewayPayment._() : super._();

  factory _RedisGatewayPayment.fromJson(Map<String, dynamic> json) =
      _$RedisGatewayPaymentImpl.fromJson;

  @override
  String get host;
  @override
  int get port;
  @override
  String? get username;
  @override
  String? get password;
  @override
  @JsonKey(ignore: true)
  _$$RedisGatewayPaymentImplCopyWith<_$RedisGatewayPaymentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
