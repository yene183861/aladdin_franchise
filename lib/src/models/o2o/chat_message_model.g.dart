// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_message_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ChatMessageModelImpl _$$ChatMessageModelImplFromJson(
        Map<String, dynamic> json) =>
    _$ChatMessageModelImpl(
      id: json['id'] ?? -1,
      restaurantId: json['restaurant_id'] ?? -1,
      orderId: json['order_id'] ?? -1,
      deviceId: json['device_id'] ?? -1,
      sender: json['sender'] as String? ?? '',
      userName: json['user_name'] as String? ?? '',
      message: json['message'] as String? ?? '',
      table: json['table'] as String? ?? '',
      createdAt: DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$$ChatMessageModelImplToJson(
        _$ChatMessageModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'restaurant_id': instance.restaurantId,
      'order_id': instance.orderId,
      'device_id': instance.deviceId,
      'sender': instance.sender,
      'user_name': instance.userName,
      'message': instance.message,
      'table': instance.table,
      'created_at': instance.createdAt.toIso8601String(),
    };
