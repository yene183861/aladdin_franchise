// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'restaurant.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RestaurantModelImpl _$$RestaurantModelImplFromJson(
        Map<String, dynamic> json) =>
    _$RestaurantModelImpl(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String?,
      description: json['description'] as String?,
      address: json['address'] as String?,
      tableStatus: (json['table_status'] as num?)?.toInt(),
      currentStatus: json['current_status'] as String?,
      image: json['image'] as String?,
      logo: json['logo'] as String?,
      posStatus: json['pos_status'] as bool? ?? false,
      areaStatus: (json['area_status'] as num?)?.toInt() ?? AreaStatus.full,
      o2oStatus: json['o2o_status'] as bool? ?? false,
      urlServerO2o: json['url_server_o2o'] as String? ?? '',
      redisGatewayPayment: json['redis_production'] == null
          ? const RedisGatewayPayment()
          : RedisGatewayPayment.fromJson(
              json['redis_production'] as Map<String, dynamic>),
      reservationStatus: json['reservation_status'] as bool? ?? false,
    );

Map<String, dynamic> _$$RestaurantModelImplToJson(
        _$RestaurantModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'address': instance.address,
      'table_status': instance.tableStatus,
      'current_status': instance.currentStatus,
      'image': instance.image,
      'logo': instance.logo,
      'pos_status': instance.posStatus,
      'area_status': instance.areaStatus,
      'o2o_status': instance.o2oStatus,
      'url_server_o2o': instance.urlServerO2o,
      'redis_production': instance.redisGatewayPayment.toJson(),
      'reservation_status': instance.reservationStatus,
    };
