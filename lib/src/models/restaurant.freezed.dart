// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'restaurant.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

RestaurantModel _$RestaurantModelFromJson(Map<String, dynamic> json) {
  return _RestaurantModel.fromJson(json);
}

/// @nodoc
mixin _$RestaurantModel {
  int get id => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  String? get address => throw _privateConstructorUsedError;
  int? get tableStatus => throw _privateConstructorUsedError;
  String? get currentStatus => throw _privateConstructorUsedError;
  String? get image => throw _privateConstructorUsedError;
  String? get logo => throw _privateConstructorUsedError;
  bool get posStatus => throw _privateConstructorUsedError;
  int get areaStatus => throw _privateConstructorUsedError;
  bool get o2oStatus => throw _privateConstructorUsedError;
  String get urlServerO2o => throw _privateConstructorUsedError;
  @JsonKey(name: 'redis_production')
  RedisGatewayPayment get redisGatewayPayment =>
      throw _privateConstructorUsedError;
  bool get reservationStatus => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RestaurantModelCopyWith<RestaurantModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RestaurantModelCopyWith<$Res> {
  factory $RestaurantModelCopyWith(
          RestaurantModel value, $Res Function(RestaurantModel) then) =
      _$RestaurantModelCopyWithImpl<$Res, RestaurantModel>;
  @useResult
  $Res call(
      {int id,
      String? name,
      String? description,
      String? address,
      int? tableStatus,
      String? currentStatus,
      String? image,
      String? logo,
      bool posStatus,
      int areaStatus,
      bool o2oStatus,
      String urlServerO2o,
      @JsonKey(name: 'redis_production')
      RedisGatewayPayment redisGatewayPayment,
      bool reservationStatus});

  $RedisGatewayPaymentCopyWith<$Res> get redisGatewayPayment;
}

/// @nodoc
class _$RestaurantModelCopyWithImpl<$Res, $Val extends RestaurantModel>
    implements $RestaurantModelCopyWith<$Res> {
  _$RestaurantModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = freezed,
    Object? description = freezed,
    Object? address = freezed,
    Object? tableStatus = freezed,
    Object? currentStatus = freezed,
    Object? image = freezed,
    Object? logo = freezed,
    Object? posStatus = null,
    Object? areaStatus = null,
    Object? o2oStatus = null,
    Object? urlServerO2o = null,
    Object? redisGatewayPayment = null,
    Object? reservationStatus = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      address: freezed == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String?,
      tableStatus: freezed == tableStatus
          ? _value.tableStatus
          : tableStatus // ignore: cast_nullable_to_non_nullable
              as int?,
      currentStatus: freezed == currentStatus
          ? _value.currentStatus
          : currentStatus // ignore: cast_nullable_to_non_nullable
              as String?,
      image: freezed == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String?,
      logo: freezed == logo
          ? _value.logo
          : logo // ignore: cast_nullable_to_non_nullable
              as String?,
      posStatus: null == posStatus
          ? _value.posStatus
          : posStatus // ignore: cast_nullable_to_non_nullable
              as bool,
      areaStatus: null == areaStatus
          ? _value.areaStatus
          : areaStatus // ignore: cast_nullable_to_non_nullable
              as int,
      o2oStatus: null == o2oStatus
          ? _value.o2oStatus
          : o2oStatus // ignore: cast_nullable_to_non_nullable
              as bool,
      urlServerO2o: null == urlServerO2o
          ? _value.urlServerO2o
          : urlServerO2o // ignore: cast_nullable_to_non_nullable
              as String,
      redisGatewayPayment: null == redisGatewayPayment
          ? _value.redisGatewayPayment
          : redisGatewayPayment // ignore: cast_nullable_to_non_nullable
              as RedisGatewayPayment,
      reservationStatus: null == reservationStatus
          ? _value.reservationStatus
          : reservationStatus // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $RedisGatewayPaymentCopyWith<$Res> get redisGatewayPayment {
    return $RedisGatewayPaymentCopyWith<$Res>(_value.redisGatewayPayment,
        (value) {
      return _then(_value.copyWith(redisGatewayPayment: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$RestaurantModelImplCopyWith<$Res>
    implements $RestaurantModelCopyWith<$Res> {
  factory _$$RestaurantModelImplCopyWith(_$RestaurantModelImpl value,
          $Res Function(_$RestaurantModelImpl) then) =
      __$$RestaurantModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String? name,
      String? description,
      String? address,
      int? tableStatus,
      String? currentStatus,
      String? image,
      String? logo,
      bool posStatus,
      int areaStatus,
      bool o2oStatus,
      String urlServerO2o,
      @JsonKey(name: 'redis_production')
      RedisGatewayPayment redisGatewayPayment,
      bool reservationStatus});

  @override
  $RedisGatewayPaymentCopyWith<$Res> get redisGatewayPayment;
}

/// @nodoc
class __$$RestaurantModelImplCopyWithImpl<$Res>
    extends _$RestaurantModelCopyWithImpl<$Res, _$RestaurantModelImpl>
    implements _$$RestaurantModelImplCopyWith<$Res> {
  __$$RestaurantModelImplCopyWithImpl(
      _$RestaurantModelImpl _value, $Res Function(_$RestaurantModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = freezed,
    Object? description = freezed,
    Object? address = freezed,
    Object? tableStatus = freezed,
    Object? currentStatus = freezed,
    Object? image = freezed,
    Object? logo = freezed,
    Object? posStatus = null,
    Object? areaStatus = null,
    Object? o2oStatus = null,
    Object? urlServerO2o = null,
    Object? redisGatewayPayment = null,
    Object? reservationStatus = null,
  }) {
    return _then(_$RestaurantModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      address: freezed == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String?,
      tableStatus: freezed == tableStatus
          ? _value.tableStatus
          : tableStatus // ignore: cast_nullable_to_non_nullable
              as int?,
      currentStatus: freezed == currentStatus
          ? _value.currentStatus
          : currentStatus // ignore: cast_nullable_to_non_nullable
              as String?,
      image: freezed == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String?,
      logo: freezed == logo
          ? _value.logo
          : logo // ignore: cast_nullable_to_non_nullable
              as String?,
      posStatus: null == posStatus
          ? _value.posStatus
          : posStatus // ignore: cast_nullable_to_non_nullable
              as bool,
      areaStatus: null == areaStatus
          ? _value.areaStatus
          : areaStatus // ignore: cast_nullable_to_non_nullable
              as int,
      o2oStatus: null == o2oStatus
          ? _value.o2oStatus
          : o2oStatus // ignore: cast_nullable_to_non_nullable
              as bool,
      urlServerO2o: null == urlServerO2o
          ? _value.urlServerO2o
          : urlServerO2o // ignore: cast_nullable_to_non_nullable
              as String,
      redisGatewayPayment: null == redisGatewayPayment
          ? _value.redisGatewayPayment
          : redisGatewayPayment // ignore: cast_nullable_to_non_nullable
              as RedisGatewayPayment,
      reservationStatus: null == reservationStatus
          ? _value.reservationStatus
          : reservationStatus // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class _$RestaurantModelImpl
    with DiagnosticableTreeMixin
    implements _RestaurantModel {
  const _$RestaurantModelImpl(
      {required this.id,
      this.name,
      this.description,
      this.address,
      this.tableStatus,
      this.currentStatus,
      this.image,
      this.logo,
      this.posStatus = false,
      this.areaStatus = AreaStatus.full,
      this.o2oStatus = false,
      this.urlServerO2o = '',
      @JsonKey(name: 'redis_production')
      this.redisGatewayPayment = const RedisGatewayPayment(),
      this.reservationStatus = false});

  factory _$RestaurantModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$RestaurantModelImplFromJson(json);

  @override
  final int id;
  @override
  final String? name;
  @override
  final String? description;
  @override
  final String? address;
  @override
  final int? tableStatus;
  @override
  final String? currentStatus;
  @override
  final String? image;
  @override
  final String? logo;
  @override
  @JsonKey()
  final bool posStatus;
  @override
  @JsonKey()
  final int areaStatus;
  @override
  @JsonKey()
  final bool o2oStatus;
  @override
  @JsonKey()
  final String urlServerO2o;
  @override
  @JsonKey(name: 'redis_production')
  final RedisGatewayPayment redisGatewayPayment;
  @override
  @JsonKey()
  final bool reservationStatus;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'RestaurantModel(id: $id, name: $name, description: $description, address: $address, tableStatus: $tableStatus, currentStatus: $currentStatus, image: $image, logo: $logo, posStatus: $posStatus, areaStatus: $areaStatus, o2oStatus: $o2oStatus, urlServerO2o: $urlServerO2o, redisGatewayPayment: $redisGatewayPayment, reservationStatus: $reservationStatus)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'RestaurantModel'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('name', name))
      ..add(DiagnosticsProperty('description', description))
      ..add(DiagnosticsProperty('address', address))
      ..add(DiagnosticsProperty('tableStatus', tableStatus))
      ..add(DiagnosticsProperty('currentStatus', currentStatus))
      ..add(DiagnosticsProperty('image', image))
      ..add(DiagnosticsProperty('logo', logo))
      ..add(DiagnosticsProperty('posStatus', posStatus))
      ..add(DiagnosticsProperty('areaStatus', areaStatus))
      ..add(DiagnosticsProperty('o2oStatus', o2oStatus))
      ..add(DiagnosticsProperty('urlServerO2o', urlServerO2o))
      ..add(DiagnosticsProperty('redisGatewayPayment', redisGatewayPayment))
      ..add(DiagnosticsProperty('reservationStatus', reservationStatus));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RestaurantModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.tableStatus, tableStatus) ||
                other.tableStatus == tableStatus) &&
            (identical(other.currentStatus, currentStatus) ||
                other.currentStatus == currentStatus) &&
            (identical(other.image, image) || other.image == image) &&
            (identical(other.logo, logo) || other.logo == logo) &&
            (identical(other.posStatus, posStatus) ||
                other.posStatus == posStatus) &&
            (identical(other.areaStatus, areaStatus) ||
                other.areaStatus == areaStatus) &&
            (identical(other.o2oStatus, o2oStatus) ||
                other.o2oStatus == o2oStatus) &&
            (identical(other.urlServerO2o, urlServerO2o) ||
                other.urlServerO2o == urlServerO2o) &&
            (identical(other.redisGatewayPayment, redisGatewayPayment) ||
                other.redisGatewayPayment == redisGatewayPayment) &&
            (identical(other.reservationStatus, reservationStatus) ||
                other.reservationStatus == reservationStatus));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      description,
      address,
      tableStatus,
      currentStatus,
      image,
      logo,
      posStatus,
      areaStatus,
      o2oStatus,
      urlServerO2o,
      redisGatewayPayment,
      reservationStatus);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RestaurantModelImplCopyWith<_$RestaurantModelImpl> get copyWith =>
      __$$RestaurantModelImplCopyWithImpl<_$RestaurantModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RestaurantModelImplToJson(
      this,
    );
  }
}

abstract class _RestaurantModel implements RestaurantModel {
  const factory _RestaurantModel(
      {required final int id,
      final String? name,
      final String? description,
      final String? address,
      final int? tableStatus,
      final String? currentStatus,
      final String? image,
      final String? logo,
      final bool posStatus,
      final int areaStatus,
      final bool o2oStatus,
      final String urlServerO2o,
      @JsonKey(name: 'redis_production')
      final RedisGatewayPayment redisGatewayPayment,
      final bool reservationStatus}) = _$RestaurantModelImpl;

  factory _RestaurantModel.fromJson(Map<String, dynamic> json) =
      _$RestaurantModelImpl.fromJson;

  @override
  int get id;
  @override
  String? get name;
  @override
  String? get description;
  @override
  String? get address;
  @override
  int? get tableStatus;
  @override
  String? get currentStatus;
  @override
  String? get image;
  @override
  String? get logo;
  @override
  bool get posStatus;
  @override
  int get areaStatus;
  @override
  bool get o2oStatus;
  @override
  String get urlServerO2o;
  @override
  @JsonKey(name: 'redis_production')
  RedisGatewayPayment get redisGatewayPayment;
  @override
  bool get reservationStatus;
  @override
  @JsonKey(ignore: true)
  _$$RestaurantModelImplCopyWith<_$RestaurantModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
