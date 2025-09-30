// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'error_log.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ErrorLogModel _$ErrorLogModelFromJson(Map<String, dynamic> json) {
  return _ErrorLogModel.fromJson(json);
}

/// @nodoc
mixin _$ErrorLogModel {
  @JsonKey(toJson: _actionToName)
  AppLogAction get action => throw _privateConstructorUsedError;
  UserModel? get waiter => throw _privateConstructorUsedError;
  String? get ipConfig => throw _privateConstructorUsedError;
  String? get ipNetwork => throw _privateConstructorUsedError;
  String? get wifiName => throw _privateConstructorUsedError;
  String? get errorMessage => throw _privateConstructorUsedError;
  dynamic get createAt => throw _privateConstructorUsedError;
  OrderModel? get order => throw _privateConstructorUsedError;
  String? get api => throw _privateConstructorUsedError;
  dynamic get request => throw _privateConstructorUsedError;
  dynamic get response => throw _privateConstructorUsedError;
  dynamic get modelInterface => throw _privateConstructorUsedError;
  String? get appVersion => throw _privateConstructorUsedError;
  int? get deviceId => throw _privateConstructorUsedError;
  int? get waiterId => throw _privateConstructorUsedError;
  String? get makeDeviceId => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ErrorLogModelCopyWith<ErrorLogModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ErrorLogModelCopyWith<$Res> {
  factory $ErrorLogModelCopyWith(
          ErrorLogModel value, $Res Function(ErrorLogModel) then) =
      _$ErrorLogModelCopyWithImpl<$Res, ErrorLogModel>;
  @useResult
  $Res call(
      {@JsonKey(toJson: _actionToName) AppLogAction action,
      UserModel? waiter,
      String? ipConfig,
      String? ipNetwork,
      String? wifiName,
      String? errorMessage,
      dynamic createAt,
      OrderModel? order,
      String? api,
      dynamic request,
      dynamic response,
      dynamic modelInterface,
      String? appVersion,
      int? deviceId,
      int? waiterId,
      String? makeDeviceId});

  $UserModelCopyWith<$Res>? get waiter;
  $OrderModelCopyWith<$Res>? get order;
}

/// @nodoc
class _$ErrorLogModelCopyWithImpl<$Res, $Val extends ErrorLogModel>
    implements $ErrorLogModelCopyWith<$Res> {
  _$ErrorLogModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? action = null,
    Object? waiter = freezed,
    Object? ipConfig = freezed,
    Object? ipNetwork = freezed,
    Object? wifiName = freezed,
    Object? errorMessage = freezed,
    Object? createAt = freezed,
    Object? order = freezed,
    Object? api = freezed,
    Object? request = freezed,
    Object? response = freezed,
    Object? modelInterface = freezed,
    Object? appVersion = freezed,
    Object? deviceId = freezed,
    Object? waiterId = freezed,
    Object? makeDeviceId = freezed,
  }) {
    return _then(_value.copyWith(
      action: null == action
          ? _value.action
          : action // ignore: cast_nullable_to_non_nullable
              as AppLogAction,
      waiter: freezed == waiter
          ? _value.waiter
          : waiter // ignore: cast_nullable_to_non_nullable
              as UserModel?,
      ipConfig: freezed == ipConfig
          ? _value.ipConfig
          : ipConfig // ignore: cast_nullable_to_non_nullable
              as String?,
      ipNetwork: freezed == ipNetwork
          ? _value.ipNetwork
          : ipNetwork // ignore: cast_nullable_to_non_nullable
              as String?,
      wifiName: freezed == wifiName
          ? _value.wifiName
          : wifiName // ignore: cast_nullable_to_non_nullable
              as String?,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      createAt: freezed == createAt
          ? _value.createAt
          : createAt // ignore: cast_nullable_to_non_nullable
              as dynamic,
      order: freezed == order
          ? _value.order
          : order // ignore: cast_nullable_to_non_nullable
              as OrderModel?,
      api: freezed == api
          ? _value.api
          : api // ignore: cast_nullable_to_non_nullable
              as String?,
      request: freezed == request
          ? _value.request
          : request // ignore: cast_nullable_to_non_nullable
              as dynamic,
      response: freezed == response
          ? _value.response
          : response // ignore: cast_nullable_to_non_nullable
              as dynamic,
      modelInterface: freezed == modelInterface
          ? _value.modelInterface
          : modelInterface // ignore: cast_nullable_to_non_nullable
              as dynamic,
      appVersion: freezed == appVersion
          ? _value.appVersion
          : appVersion // ignore: cast_nullable_to_non_nullable
              as String?,
      deviceId: freezed == deviceId
          ? _value.deviceId
          : deviceId // ignore: cast_nullable_to_non_nullable
              as int?,
      waiterId: freezed == waiterId
          ? _value.waiterId
          : waiterId // ignore: cast_nullable_to_non_nullable
              as int?,
      makeDeviceId: freezed == makeDeviceId
          ? _value.makeDeviceId
          : makeDeviceId // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $UserModelCopyWith<$Res>? get waiter {
    if (_value.waiter == null) {
      return null;
    }

    return $UserModelCopyWith<$Res>(_value.waiter!, (value) {
      return _then(_value.copyWith(waiter: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $OrderModelCopyWith<$Res>? get order {
    if (_value.order == null) {
      return null;
    }

    return $OrderModelCopyWith<$Res>(_value.order!, (value) {
      return _then(_value.copyWith(order: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ErrorLogModelImplCopyWith<$Res>
    implements $ErrorLogModelCopyWith<$Res> {
  factory _$$ErrorLogModelImplCopyWith(
          _$ErrorLogModelImpl value, $Res Function(_$ErrorLogModelImpl) then) =
      __$$ErrorLogModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(toJson: _actionToName) AppLogAction action,
      UserModel? waiter,
      String? ipConfig,
      String? ipNetwork,
      String? wifiName,
      String? errorMessage,
      dynamic createAt,
      OrderModel? order,
      String? api,
      dynamic request,
      dynamic response,
      dynamic modelInterface,
      String? appVersion,
      int? deviceId,
      int? waiterId,
      String? makeDeviceId});

  @override
  $UserModelCopyWith<$Res>? get waiter;
  @override
  $OrderModelCopyWith<$Res>? get order;
}

/// @nodoc
class __$$ErrorLogModelImplCopyWithImpl<$Res>
    extends _$ErrorLogModelCopyWithImpl<$Res, _$ErrorLogModelImpl>
    implements _$$ErrorLogModelImplCopyWith<$Res> {
  __$$ErrorLogModelImplCopyWithImpl(
      _$ErrorLogModelImpl _value, $Res Function(_$ErrorLogModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? action = null,
    Object? waiter = freezed,
    Object? ipConfig = freezed,
    Object? ipNetwork = freezed,
    Object? wifiName = freezed,
    Object? errorMessage = freezed,
    Object? createAt = freezed,
    Object? order = freezed,
    Object? api = freezed,
    Object? request = freezed,
    Object? response = freezed,
    Object? modelInterface = freezed,
    Object? appVersion = freezed,
    Object? deviceId = freezed,
    Object? waiterId = freezed,
    Object? makeDeviceId = freezed,
  }) {
    return _then(_$ErrorLogModelImpl(
      action: null == action
          ? _value.action
          : action // ignore: cast_nullable_to_non_nullable
              as AppLogAction,
      waiter: freezed == waiter
          ? _value.waiter
          : waiter // ignore: cast_nullable_to_non_nullable
              as UserModel?,
      ipConfig: freezed == ipConfig
          ? _value.ipConfig
          : ipConfig // ignore: cast_nullable_to_non_nullable
              as String?,
      ipNetwork: freezed == ipNetwork
          ? _value.ipNetwork
          : ipNetwork // ignore: cast_nullable_to_non_nullable
              as String?,
      wifiName: freezed == wifiName
          ? _value.wifiName
          : wifiName // ignore: cast_nullable_to_non_nullable
              as String?,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      createAt: freezed == createAt
          ? _value.createAt
          : createAt // ignore: cast_nullable_to_non_nullable
              as dynamic,
      order: freezed == order
          ? _value.order
          : order // ignore: cast_nullable_to_non_nullable
              as OrderModel?,
      api: freezed == api
          ? _value.api
          : api // ignore: cast_nullable_to_non_nullable
              as String?,
      request: freezed == request
          ? _value.request
          : request // ignore: cast_nullable_to_non_nullable
              as dynamic,
      response: freezed == response
          ? _value.response
          : response // ignore: cast_nullable_to_non_nullable
              as dynamic,
      modelInterface: freezed == modelInterface
          ? _value.modelInterface
          : modelInterface // ignore: cast_nullable_to_non_nullable
              as dynamic,
      appVersion: freezed == appVersion
          ? _value.appVersion
          : appVersion // ignore: cast_nullable_to_non_nullable
              as String?,
      deviceId: freezed == deviceId
          ? _value.deviceId
          : deviceId // ignore: cast_nullable_to_non_nullable
              as int?,
      waiterId: freezed == waiterId
          ? _value.waiterId
          : waiterId // ignore: cast_nullable_to_non_nullable
              as int?,
      makeDeviceId: freezed == makeDeviceId
          ? _value.makeDeviceId
          : makeDeviceId // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class _$ErrorLogModelImpl
    with DiagnosticableTreeMixin
    implements _ErrorLogModel {
  const _$ErrorLogModelImpl(
      {@JsonKey(toJson: _actionToName) required this.action,
      this.waiter,
      this.ipConfig,
      this.ipNetwork,
      this.wifiName,
      this.errorMessage,
      this.createAt,
      this.order,
      this.api,
      this.request,
      this.response,
      this.modelInterface,
      this.appVersion,
      this.deviceId,
      this.waiterId,
      this.makeDeviceId});

  factory _$ErrorLogModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ErrorLogModelImplFromJson(json);

  @override
  @JsonKey(toJson: _actionToName)
  final AppLogAction action;
  @override
  final UserModel? waiter;
  @override
  final String? ipConfig;
  @override
  final String? ipNetwork;
  @override
  final String? wifiName;
  @override
  final String? errorMessage;
  @override
  final dynamic createAt;
  @override
  final OrderModel? order;
  @override
  final String? api;
  @override
  final dynamic request;
  @override
  final dynamic response;
  @override
  final dynamic modelInterface;
  @override
  final String? appVersion;
  @override
  final int? deviceId;
  @override
  final int? waiterId;
  @override
  final String? makeDeviceId;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ErrorLogModel(action: $action, waiter: $waiter, ipConfig: $ipConfig, ipNetwork: $ipNetwork, wifiName: $wifiName, errorMessage: $errorMessage, createAt: $createAt, order: $order, api: $api, request: $request, response: $response, modelInterface: $modelInterface, appVersion: $appVersion, deviceId: $deviceId, waiterId: $waiterId, makeDeviceId: $makeDeviceId)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'ErrorLogModel'))
      ..add(DiagnosticsProperty('action', action))
      ..add(DiagnosticsProperty('waiter', waiter))
      ..add(DiagnosticsProperty('ipConfig', ipConfig))
      ..add(DiagnosticsProperty('ipNetwork', ipNetwork))
      ..add(DiagnosticsProperty('wifiName', wifiName))
      ..add(DiagnosticsProperty('errorMessage', errorMessage))
      ..add(DiagnosticsProperty('createAt', createAt))
      ..add(DiagnosticsProperty('order', order))
      ..add(DiagnosticsProperty('api', api))
      ..add(DiagnosticsProperty('request', request))
      ..add(DiagnosticsProperty('response', response))
      ..add(DiagnosticsProperty('modelInterface', modelInterface))
      ..add(DiagnosticsProperty('appVersion', appVersion))
      ..add(DiagnosticsProperty('deviceId', deviceId))
      ..add(DiagnosticsProperty('waiterId', waiterId))
      ..add(DiagnosticsProperty('makeDeviceId', makeDeviceId));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ErrorLogModelImpl &&
            (identical(other.action, action) || other.action == action) &&
            (identical(other.waiter, waiter) || other.waiter == waiter) &&
            (identical(other.ipConfig, ipConfig) ||
                other.ipConfig == ipConfig) &&
            (identical(other.ipNetwork, ipNetwork) ||
                other.ipNetwork == ipNetwork) &&
            (identical(other.wifiName, wifiName) ||
                other.wifiName == wifiName) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage) &&
            const DeepCollectionEquality().equals(other.createAt, createAt) &&
            (identical(other.order, order) || other.order == order) &&
            (identical(other.api, api) || other.api == api) &&
            const DeepCollectionEquality().equals(other.request, request) &&
            const DeepCollectionEquality().equals(other.response, response) &&
            const DeepCollectionEquality()
                .equals(other.modelInterface, modelInterface) &&
            (identical(other.appVersion, appVersion) ||
                other.appVersion == appVersion) &&
            (identical(other.deviceId, deviceId) ||
                other.deviceId == deviceId) &&
            (identical(other.waiterId, waiterId) ||
                other.waiterId == waiterId) &&
            (identical(other.makeDeviceId, makeDeviceId) ||
                other.makeDeviceId == makeDeviceId));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      action,
      waiter,
      ipConfig,
      ipNetwork,
      wifiName,
      errorMessage,
      const DeepCollectionEquality().hash(createAt),
      order,
      api,
      const DeepCollectionEquality().hash(request),
      const DeepCollectionEquality().hash(response),
      const DeepCollectionEquality().hash(modelInterface),
      appVersion,
      deviceId,
      waiterId,
      makeDeviceId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ErrorLogModelImplCopyWith<_$ErrorLogModelImpl> get copyWith =>
      __$$ErrorLogModelImplCopyWithImpl<_$ErrorLogModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ErrorLogModelImplToJson(
      this,
    );
  }
}

abstract class _ErrorLogModel implements ErrorLogModel {
  const factory _ErrorLogModel(
      {@JsonKey(toJson: _actionToName) required final AppLogAction action,
      final UserModel? waiter,
      final String? ipConfig,
      final String? ipNetwork,
      final String? wifiName,
      final String? errorMessage,
      final dynamic createAt,
      final OrderModel? order,
      final String? api,
      final dynamic request,
      final dynamic response,
      final dynamic modelInterface,
      final String? appVersion,
      final int? deviceId,
      final int? waiterId,
      final String? makeDeviceId}) = _$ErrorLogModelImpl;

  factory _ErrorLogModel.fromJson(Map<String, dynamic> json) =
      _$ErrorLogModelImpl.fromJson;

  @override
  @JsonKey(toJson: _actionToName)
  AppLogAction get action;
  @override
  UserModel? get waiter;
  @override
  String? get ipConfig;
  @override
  String? get ipNetwork;
  @override
  String? get wifiName;
  @override
  String? get errorMessage;
  @override
  dynamic get createAt;
  @override
  OrderModel? get order;
  @override
  String? get api;
  @override
  dynamic get request;
  @override
  dynamic get response;
  @override
  dynamic get modelInterface;
  @override
  String? get appVersion;
  @override
  int? get deviceId;
  @override
  int? get waiterId;
  @override
  String? get makeDeviceId;
  @override
  @JsonKey(ignore: true)
  _$$ErrorLogModelImplCopyWith<_$ErrorLogModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
