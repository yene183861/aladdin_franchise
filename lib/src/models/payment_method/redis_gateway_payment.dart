import 'package:freezed_annotation/freezed_annotation.dart';

part 'redis_gateway_payment.freezed.dart';
part 'redis_gateway_payment.g.dart';

@freezed
class RedisGatewayPayment with _$RedisGatewayPayment {
  @JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
  const factory RedisGatewayPayment({
    @Default('') String host,
    @Default(6379) int port,
    String? username,
    String? password,
  }) = _RedisGatewayPayment;

  factory RedisGatewayPayment.fromJson(Map<String, dynamic> json) =>
      _$RedisGatewayPaymentFromJson(json);

  const RedisGatewayPayment._();

  bool isEmpty() => host.isEmpty;
}
