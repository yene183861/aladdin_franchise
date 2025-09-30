// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'restaurant_config.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

RestaurantConfigModel _$RestaurantConfigModelFromJson(
    Map<String, dynamic> json) {
  return _RestaurantConfigModel.fromJson(json);
}

/// @nodoc
mixin _$RestaurantConfigModel {
  String get address => throw _privateConstructorUsedError;
  String get ip => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  bool get orderOnline => throw _privateConstructorUsedError;
  int get style => throw _privateConstructorUsedError;
  bool? get isLocal => throw _privateConstructorUsedError;
  bool? get active => throw _privateConstructorUsedError;
  String get tags => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RestaurantConfigModelCopyWith<RestaurantConfigModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RestaurantConfigModelCopyWith<$Res> {
  factory $RestaurantConfigModelCopyWith(RestaurantConfigModel value,
          $Res Function(RestaurantConfigModel) then) =
      _$RestaurantConfigModelCopyWithImpl<$Res, RestaurantConfigModel>;
  @useResult
  $Res call(
      {String address,
      String ip,
      String name,
      bool orderOnline,
      int style,
      bool? isLocal,
      bool? active,
      String tags});
}

/// @nodoc
class _$RestaurantConfigModelCopyWithImpl<$Res,
        $Val extends RestaurantConfigModel>
    implements $RestaurantConfigModelCopyWith<$Res> {
  _$RestaurantConfigModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? address = null,
    Object? ip = null,
    Object? name = null,
    Object? orderOnline = null,
    Object? style = null,
    Object? isLocal = freezed,
    Object? active = freezed,
    Object? tags = null,
  }) {
    return _then(_value.copyWith(
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      ip: null == ip
          ? _value.ip
          : ip // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      orderOnline: null == orderOnline
          ? _value.orderOnline
          : orderOnline // ignore: cast_nullable_to_non_nullable
              as bool,
      style: null == style
          ? _value.style
          : style // ignore: cast_nullable_to_non_nullable
              as int,
      isLocal: freezed == isLocal
          ? _value.isLocal
          : isLocal // ignore: cast_nullable_to_non_nullable
              as bool?,
      active: freezed == active
          ? _value.active
          : active // ignore: cast_nullable_to_non_nullable
              as bool?,
      tags: null == tags
          ? _value.tags
          : tags // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RestaurantConfigModelImplCopyWith<$Res>
    implements $RestaurantConfigModelCopyWith<$Res> {
  factory _$$RestaurantConfigModelImplCopyWith(
          _$RestaurantConfigModelImpl value,
          $Res Function(_$RestaurantConfigModelImpl) then) =
      __$$RestaurantConfigModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String address,
      String ip,
      String name,
      bool orderOnline,
      int style,
      bool? isLocal,
      bool? active,
      String tags});
}

/// @nodoc
class __$$RestaurantConfigModelImplCopyWithImpl<$Res>
    extends _$RestaurantConfigModelCopyWithImpl<$Res,
        _$RestaurantConfigModelImpl>
    implements _$$RestaurantConfigModelImplCopyWith<$Res> {
  __$$RestaurantConfigModelImplCopyWithImpl(_$RestaurantConfigModelImpl _value,
      $Res Function(_$RestaurantConfigModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? address = null,
    Object? ip = null,
    Object? name = null,
    Object? orderOnline = null,
    Object? style = null,
    Object? isLocal = freezed,
    Object? active = freezed,
    Object? tags = null,
  }) {
    return _then(_$RestaurantConfigModelImpl(
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      ip: null == ip
          ? _value.ip
          : ip // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      orderOnline: null == orderOnline
          ? _value.orderOnline
          : orderOnline // ignore: cast_nullable_to_non_nullable
              as bool,
      style: null == style
          ? _value.style
          : style // ignore: cast_nullable_to_non_nullable
              as int,
      isLocal: freezed == isLocal
          ? _value.isLocal
          : isLocal // ignore: cast_nullable_to_non_nullable
              as bool?,
      active: freezed == active
          ? _value.active
          : active // ignore: cast_nullable_to_non_nullable
              as bool?,
      tags: null == tags
          ? _value.tags
          : tags // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class _$RestaurantConfigModelImpl
    with DiagnosticableTreeMixin
    implements _RestaurantConfigModel {
  const _$RestaurantConfigModelImpl(
      {required this.address,
      required this.ip,
      required this.name,
      required this.orderOnline,
      required this.style,
      this.isLocal,
      this.active,
      this.tags = ''});

  factory _$RestaurantConfigModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$RestaurantConfigModelImplFromJson(json);

  @override
  final String address;
  @override
  final String ip;
  @override
  final String name;
  @override
  final bool orderOnline;
  @override
  final int style;
  @override
  final bool? isLocal;
  @override
  final bool? active;
  @override
  @JsonKey()
  final String tags;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'RestaurantConfigModel(address: $address, ip: $ip, name: $name, orderOnline: $orderOnline, style: $style, isLocal: $isLocal, active: $active, tags: $tags)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'RestaurantConfigModel'))
      ..add(DiagnosticsProperty('address', address))
      ..add(DiagnosticsProperty('ip', ip))
      ..add(DiagnosticsProperty('name', name))
      ..add(DiagnosticsProperty('orderOnline', orderOnline))
      ..add(DiagnosticsProperty('style', style))
      ..add(DiagnosticsProperty('isLocal', isLocal))
      ..add(DiagnosticsProperty('active', active))
      ..add(DiagnosticsProperty('tags', tags));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RestaurantConfigModelImpl &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.ip, ip) || other.ip == ip) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.orderOnline, orderOnline) ||
                other.orderOnline == orderOnline) &&
            (identical(other.style, style) || other.style == style) &&
            (identical(other.isLocal, isLocal) || other.isLocal == isLocal) &&
            (identical(other.active, active) || other.active == active) &&
            (identical(other.tags, tags) || other.tags == tags));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, address, ip, name, orderOnline,
      style, isLocal, active, tags);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RestaurantConfigModelImplCopyWith<_$RestaurantConfigModelImpl>
      get copyWith => __$$RestaurantConfigModelImplCopyWithImpl<
          _$RestaurantConfigModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RestaurantConfigModelImplToJson(
      this,
    );
  }
}

abstract class _RestaurantConfigModel implements RestaurantConfigModel {
  const factory _RestaurantConfigModel(
      {required final String address,
      required final String ip,
      required final String name,
      required final bool orderOnline,
      required final int style,
      final bool? isLocal,
      final bool? active,
      final String tags}) = _$RestaurantConfigModelImpl;

  factory _RestaurantConfigModel.fromJson(Map<String, dynamic> json) =
      _$RestaurantConfigModelImpl.fromJson;

  @override
  String get address;
  @override
  String get ip;
  @override
  String get name;
  @override
  bool get orderOnline;
  @override
  int get style;
  @override
  bool? get isLocal;
  @override
  bool? get active;
  @override
  String get tags;
  @override
  @JsonKey(ignore: true)
  _$$RestaurantConfigModelImplCopyWith<_$RestaurantConfigModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}

RestaurantFeatureConfigModel _$RestaurantFeatureConfigModelFromJson(
    Map<String, dynamic> json) {
  return _RestaurantFeatureConfigModel.fromJson(json);
}

/// @nodoc
mixin _$RestaurantFeatureConfigModel {
  bool get useKds => throw _privateConstructorUsedError;
  bool get useReception => throw _privateConstructorUsedError;
  bool get autoOrder => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RestaurantFeatureConfigModelCopyWith<RestaurantFeatureConfigModel>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RestaurantFeatureConfigModelCopyWith<$Res> {
  factory $RestaurantFeatureConfigModelCopyWith(
          RestaurantFeatureConfigModel value,
          $Res Function(RestaurantFeatureConfigModel) then) =
      _$RestaurantFeatureConfigModelCopyWithImpl<$Res,
          RestaurantFeatureConfigModel>;
  @useResult
  $Res call({bool useKds, bool useReception, bool autoOrder});
}

/// @nodoc
class _$RestaurantFeatureConfigModelCopyWithImpl<$Res,
        $Val extends RestaurantFeatureConfigModel>
    implements $RestaurantFeatureConfigModelCopyWith<$Res> {
  _$RestaurantFeatureConfigModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? useKds = null,
    Object? useReception = null,
    Object? autoOrder = null,
  }) {
    return _then(_value.copyWith(
      useKds: null == useKds
          ? _value.useKds
          : useKds // ignore: cast_nullable_to_non_nullable
              as bool,
      useReception: null == useReception
          ? _value.useReception
          : useReception // ignore: cast_nullable_to_non_nullable
              as bool,
      autoOrder: null == autoOrder
          ? _value.autoOrder
          : autoOrder // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RestaurantFeatureConfigModelImplCopyWith<$Res>
    implements $RestaurantFeatureConfigModelCopyWith<$Res> {
  factory _$$RestaurantFeatureConfigModelImplCopyWith(
          _$RestaurantFeatureConfigModelImpl value,
          $Res Function(_$RestaurantFeatureConfigModelImpl) then) =
      __$$RestaurantFeatureConfigModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool useKds, bool useReception, bool autoOrder});
}

/// @nodoc
class __$$RestaurantFeatureConfigModelImplCopyWithImpl<$Res>
    extends _$RestaurantFeatureConfigModelCopyWithImpl<$Res,
        _$RestaurantFeatureConfigModelImpl>
    implements _$$RestaurantFeatureConfigModelImplCopyWith<$Res> {
  __$$RestaurantFeatureConfigModelImplCopyWithImpl(
      _$RestaurantFeatureConfigModelImpl _value,
      $Res Function(_$RestaurantFeatureConfigModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? useKds = null,
    Object? useReception = null,
    Object? autoOrder = null,
  }) {
    return _then(_$RestaurantFeatureConfigModelImpl(
      useKds: null == useKds
          ? _value.useKds
          : useKds // ignore: cast_nullable_to_non_nullable
              as bool,
      useReception: null == useReception
          ? _value.useReception
          : useReception // ignore: cast_nullable_to_non_nullable
              as bool,
      autoOrder: null == autoOrder
          ? _value.autoOrder
          : autoOrder // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class _$RestaurantFeatureConfigModelImpl
    with DiagnosticableTreeMixin
    implements _RestaurantFeatureConfigModel {
  const _$RestaurantFeatureConfigModelImpl(
      {this.useKds = false, this.useReception = false, this.autoOrder = false});

  factory _$RestaurantFeatureConfigModelImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$RestaurantFeatureConfigModelImplFromJson(json);

  @override
  @JsonKey()
  final bool useKds;
  @override
  @JsonKey()
  final bool useReception;
  @override
  @JsonKey()
  final bool autoOrder;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'RestaurantFeatureConfigModel(useKds: $useKds, useReception: $useReception, autoOrder: $autoOrder)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'RestaurantFeatureConfigModel'))
      ..add(DiagnosticsProperty('useKds', useKds))
      ..add(DiagnosticsProperty('useReception', useReception))
      ..add(DiagnosticsProperty('autoOrder', autoOrder));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RestaurantFeatureConfigModelImpl &&
            (identical(other.useKds, useKds) || other.useKds == useKds) &&
            (identical(other.useReception, useReception) ||
                other.useReception == useReception) &&
            (identical(other.autoOrder, autoOrder) ||
                other.autoOrder == autoOrder));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, useKds, useReception, autoOrder);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RestaurantFeatureConfigModelImplCopyWith<
          _$RestaurantFeatureConfigModelImpl>
      get copyWith => __$$RestaurantFeatureConfigModelImplCopyWithImpl<
          _$RestaurantFeatureConfigModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RestaurantFeatureConfigModelImplToJson(
      this,
    );
  }
}

abstract class _RestaurantFeatureConfigModel
    implements RestaurantFeatureConfigModel {
  const factory _RestaurantFeatureConfigModel(
      {final bool useKds,
      final bool useReception,
      final bool autoOrder}) = _$RestaurantFeatureConfigModelImpl;

  factory _RestaurantFeatureConfigModel.fromJson(Map<String, dynamic> json) =
      _$RestaurantFeatureConfigModelImpl.fromJson;

  @override
  bool get useKds;
  @override
  bool get useReception;
  @override
  bool get autoOrder;
  @override
  @JsonKey(ignore: true)
  _$$RestaurantFeatureConfigModelImplCopyWith<
          _$RestaurantFeatureConfigModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}
