// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'login.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

LoginResponse _$LoginResponseFromJson(Map<String, dynamic> json) {
  return _LoginResponse.fromJson(json);
}

/// @nodoc
mixin _$LoginResponse {
  int? get status => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;

  /// pendding
  @JsonKey(name: 'data')
  UserModel? get user => throw _privateConstructorUsedError;
  String? get token => throw _privateConstructorUsedError;
  RestaurantModel? get restaurant => throw _privateConstructorUsedError;
  int? get waiterId => throw _privateConstructorUsedError;
  List<CustomerRating> get questionRatings =>
      throw _privateConstructorUsedError;
  @JsonKey(name: 'portraits')
  List<CustomerPortrait> get customerPortraits =>
      throw _privateConstructorUsedError;
  int get redisPort => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $LoginResponseCopyWith<LoginResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LoginResponseCopyWith<$Res> {
  factory $LoginResponseCopyWith(
          LoginResponse value, $Res Function(LoginResponse) then) =
      _$LoginResponseCopyWithImpl<$Res, LoginResponse>;
  @useResult
  $Res call(
      {int? status,
      String? message,
      @JsonKey(name: 'data') UserModel? user,
      String? token,
      RestaurantModel? restaurant,
      int? waiterId,
      List<CustomerRating> questionRatings,
      @JsonKey(name: 'portraits') List<CustomerPortrait> customerPortraits,
      int redisPort});

  $UserModelCopyWith<$Res>? get user;
  $RestaurantModelCopyWith<$Res>? get restaurant;
}

/// @nodoc
class _$LoginResponseCopyWithImpl<$Res, $Val extends LoginResponse>
    implements $LoginResponseCopyWith<$Res> {
  _$LoginResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = freezed,
    Object? message = freezed,
    Object? user = freezed,
    Object? token = freezed,
    Object? restaurant = freezed,
    Object? waiterId = freezed,
    Object? questionRatings = null,
    Object? customerPortraits = null,
    Object? redisPort = null,
  }) {
    return _then(_value.copyWith(
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as int?,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      user: freezed == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as UserModel?,
      token: freezed == token
          ? _value.token
          : token // ignore: cast_nullable_to_non_nullable
              as String?,
      restaurant: freezed == restaurant
          ? _value.restaurant
          : restaurant // ignore: cast_nullable_to_non_nullable
              as RestaurantModel?,
      waiterId: freezed == waiterId
          ? _value.waiterId
          : waiterId // ignore: cast_nullable_to_non_nullable
              as int?,
      questionRatings: null == questionRatings
          ? _value.questionRatings
          : questionRatings // ignore: cast_nullable_to_non_nullable
              as List<CustomerRating>,
      customerPortraits: null == customerPortraits
          ? _value.customerPortraits
          : customerPortraits // ignore: cast_nullable_to_non_nullable
              as List<CustomerPortrait>,
      redisPort: null == redisPort
          ? _value.redisPort
          : redisPort // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $UserModelCopyWith<$Res>? get user {
    if (_value.user == null) {
      return null;
    }

    return $UserModelCopyWith<$Res>(_value.user!, (value) {
      return _then(_value.copyWith(user: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $RestaurantModelCopyWith<$Res>? get restaurant {
    if (_value.restaurant == null) {
      return null;
    }

    return $RestaurantModelCopyWith<$Res>(_value.restaurant!, (value) {
      return _then(_value.copyWith(restaurant: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$LoginResponseImplCopyWith<$Res>
    implements $LoginResponseCopyWith<$Res> {
  factory _$$LoginResponseImplCopyWith(
          _$LoginResponseImpl value, $Res Function(_$LoginResponseImpl) then) =
      __$$LoginResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? status,
      String? message,
      @JsonKey(name: 'data') UserModel? user,
      String? token,
      RestaurantModel? restaurant,
      int? waiterId,
      List<CustomerRating> questionRatings,
      @JsonKey(name: 'portraits') List<CustomerPortrait> customerPortraits,
      int redisPort});

  @override
  $UserModelCopyWith<$Res>? get user;
  @override
  $RestaurantModelCopyWith<$Res>? get restaurant;
}

/// @nodoc
class __$$LoginResponseImplCopyWithImpl<$Res>
    extends _$LoginResponseCopyWithImpl<$Res, _$LoginResponseImpl>
    implements _$$LoginResponseImplCopyWith<$Res> {
  __$$LoginResponseImplCopyWithImpl(
      _$LoginResponseImpl _value, $Res Function(_$LoginResponseImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = freezed,
    Object? message = freezed,
    Object? user = freezed,
    Object? token = freezed,
    Object? restaurant = freezed,
    Object? waiterId = freezed,
    Object? questionRatings = null,
    Object? customerPortraits = null,
    Object? redisPort = null,
  }) {
    return _then(_$LoginResponseImpl(
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as int?,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      user: freezed == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as UserModel?,
      token: freezed == token
          ? _value.token
          : token // ignore: cast_nullable_to_non_nullable
              as String?,
      restaurant: freezed == restaurant
          ? _value.restaurant
          : restaurant // ignore: cast_nullable_to_non_nullable
              as RestaurantModel?,
      waiterId: freezed == waiterId
          ? _value.waiterId
          : waiterId // ignore: cast_nullable_to_non_nullable
              as int?,
      questionRatings: null == questionRatings
          ? _value._questionRatings
          : questionRatings // ignore: cast_nullable_to_non_nullable
              as List<CustomerRating>,
      customerPortraits: null == customerPortraits
          ? _value._customerPortraits
          : customerPortraits // ignore: cast_nullable_to_non_nullable
              as List<CustomerPortrait>,
      redisPort: null == redisPort
          ? _value.redisPort
          : redisPort // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class _$LoginResponseImpl
    with DiagnosticableTreeMixin
    implements _LoginResponse {
  const _$LoginResponseImpl(
      {required this.status,
      this.message,
      @JsonKey(name: 'data') this.user,
      this.token,
      this.restaurant,
      this.waiterId,
      final List<CustomerRating> questionRatings = const [],
      @JsonKey(name: 'portraits')
      final List<CustomerPortrait> customerPortraits = const [],
      this.redisPort = kRedisPortDefault})
      : _questionRatings = questionRatings,
        _customerPortraits = customerPortraits;

  factory _$LoginResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$LoginResponseImplFromJson(json);

  @override
  final int? status;
  @override
  final String? message;

  /// pendding
  @override
  @JsonKey(name: 'data')
  final UserModel? user;
  @override
  final String? token;
  @override
  final RestaurantModel? restaurant;
  @override
  final int? waiterId;
  final List<CustomerRating> _questionRatings;
  @override
  @JsonKey()
  List<CustomerRating> get questionRatings {
    if (_questionRatings is EqualUnmodifiableListView) return _questionRatings;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_questionRatings);
  }

  final List<CustomerPortrait> _customerPortraits;
  @override
  @JsonKey(name: 'portraits')
  List<CustomerPortrait> get customerPortraits {
    if (_customerPortraits is EqualUnmodifiableListView)
      return _customerPortraits;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_customerPortraits);
  }

  @override
  @JsonKey()
  final int redisPort;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'LoginResponse(status: $status, message: $message, user: $user, token: $token, restaurant: $restaurant, waiterId: $waiterId, questionRatings: $questionRatings, customerPortraits: $customerPortraits, redisPort: $redisPort)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'LoginResponse'))
      ..add(DiagnosticsProperty('status', status))
      ..add(DiagnosticsProperty('message', message))
      ..add(DiagnosticsProperty('user', user))
      ..add(DiagnosticsProperty('token', token))
      ..add(DiagnosticsProperty('restaurant', restaurant))
      ..add(DiagnosticsProperty('waiterId', waiterId))
      ..add(DiagnosticsProperty('questionRatings', questionRatings))
      ..add(DiagnosticsProperty('customerPortraits', customerPortraits))
      ..add(DiagnosticsProperty('redisPort', redisPort));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoginResponseImpl &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.user, user) || other.user == user) &&
            (identical(other.token, token) || other.token == token) &&
            (identical(other.restaurant, restaurant) ||
                other.restaurant == restaurant) &&
            (identical(other.waiterId, waiterId) ||
                other.waiterId == waiterId) &&
            const DeepCollectionEquality()
                .equals(other._questionRatings, _questionRatings) &&
            const DeepCollectionEquality()
                .equals(other._customerPortraits, _customerPortraits) &&
            (identical(other.redisPort, redisPort) ||
                other.redisPort == redisPort));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      status,
      message,
      user,
      token,
      restaurant,
      waiterId,
      const DeepCollectionEquality().hash(_questionRatings),
      const DeepCollectionEquality().hash(_customerPortraits),
      redisPort);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LoginResponseImplCopyWith<_$LoginResponseImpl> get copyWith =>
      __$$LoginResponseImplCopyWithImpl<_$LoginResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LoginResponseImplToJson(
      this,
    );
  }
}

abstract class _LoginResponse implements LoginResponse {
  const factory _LoginResponse(
      {required final int? status,
      final String? message,
      @JsonKey(name: 'data') final UserModel? user,
      final String? token,
      final RestaurantModel? restaurant,
      final int? waiterId,
      final List<CustomerRating> questionRatings,
      @JsonKey(name: 'portraits')
      final List<CustomerPortrait> customerPortraits,
      final int redisPort}) = _$LoginResponseImpl;

  factory _LoginResponse.fromJson(Map<String, dynamic> json) =
      _$LoginResponseImpl.fromJson;

  @override
  int? get status;
  @override
  String? get message;
  @override

  /// pendding
  @JsonKey(name: 'data')
  UserModel? get user;
  @override
  String? get token;
  @override
  RestaurantModel? get restaurant;
  @override
  int? get waiterId;
  @override
  List<CustomerRating> get questionRatings;
  @override
  @JsonKey(name: 'portraits')
  List<CustomerPortrait> get customerPortraits;
  @override
  int get redisPort;
  @override
  @JsonKey(ignore: true)
  _$$LoginResponseImplCopyWith<_$LoginResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
