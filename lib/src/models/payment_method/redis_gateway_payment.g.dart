// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'redis_gateway_payment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RedisGatewayPaymentImpl _$$RedisGatewayPaymentImplFromJson(
        Map<String, dynamic> json) =>
    _$RedisGatewayPaymentImpl(
      host: json['host'] as String? ?? '',
      port: (json['port'] as num?)?.toInt() ?? 6379,
      username: json['username'] as String?,
      password: json['password'] as String?,
    );

Map<String, dynamic> _$$RedisGatewayPaymentImplToJson(
        _$RedisGatewayPaymentImpl instance) =>
    <String, dynamic>{
      'host': instance.host,
      'port': instance.port,
      'username': instance.username,
      'password': instance.password,
    };
