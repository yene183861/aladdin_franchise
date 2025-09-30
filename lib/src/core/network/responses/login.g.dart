// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LoginResponseImpl _$$LoginResponseImplFromJson(Map<String, dynamic> json) =>
    _$LoginResponseImpl(
      status: (json['status'] as num?)?.toInt(),
      message: json['message'] as String?,
      user: json['data'] == null
          ? null
          : UserModel.fromJson(json['data'] as Map<String, dynamic>),
      token: json['token'] as String?,
      restaurant: json['restaurant'] == null
          ? null
          : RestaurantModel.fromJson(
              json['restaurant'] as Map<String, dynamic>),
      waiterId: (json['waiter_id'] as num?)?.toInt(),
      questionRatings: (json['question_ratings'] as List<dynamic>?)
              ?.map((e) => CustomerRating.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      customerPortraits: (json['portraits'] as List<dynamic>?)
              ?.map((e) => CustomerPortrait.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      redisPort: (json['redis_port'] as num?)?.toInt() ?? kRedisPortDefault,
    );

Map<String, dynamic> _$$LoginResponseImplToJson(_$LoginResponseImpl instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.user?.toJson(),
      'token': instance.token,
      'restaurant': instance.restaurant?.toJson(),
      'waiter_id': instance.waiterId,
      'question_ratings':
          instance.questionRatings.map((e) => e.toJson()).toList(),
      'portraits': instance.customerPortraits.map((e) => e.toJson()).toList(),
      'redis_port': instance.redisPort,
    };
