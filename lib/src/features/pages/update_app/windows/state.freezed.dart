// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$UpdateAppWindowsState {
  UpdateAppWindowsEvent get events => throw _privateConstructorUsedError;
  String get errorMessage => throw _privateConstructorUsedError;
  File? get fileDownload => throw _privateConstructorUsedError;
  ConfigServerRestaurantData get server => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $UpdateAppWindowsStateCopyWith<UpdateAppWindowsState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UpdateAppWindowsStateCopyWith<$Res> {
  factory $UpdateAppWindowsStateCopyWith(UpdateAppWindowsState value,
          $Res Function(UpdateAppWindowsState) then) =
      _$UpdateAppWindowsStateCopyWithImpl<$Res, UpdateAppWindowsState>;
  @useResult
  $Res call(
      {UpdateAppWindowsEvent events,
      String errorMessage,
      File? fileDownload,
      ConfigServerRestaurantData server});
}

/// @nodoc
class _$UpdateAppWindowsStateCopyWithImpl<$Res,
        $Val extends UpdateAppWindowsState>
    implements $UpdateAppWindowsStateCopyWith<$Res> {
  _$UpdateAppWindowsStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? events = null,
    Object? errorMessage = null,
    Object? fileDownload = freezed,
    Object? server = null,
  }) {
    return _then(_value.copyWith(
      events: null == events
          ? _value.events
          : events // ignore: cast_nullable_to_non_nullable
              as UpdateAppWindowsEvent,
      errorMessage: null == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String,
      fileDownload: freezed == fileDownload
          ? _value.fileDownload
          : fileDownload // ignore: cast_nullable_to_non_nullable
              as File?,
      server: null == server
          ? _value.server
          : server // ignore: cast_nullable_to_non_nullable
              as ConfigServerRestaurantData,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UpdateAppWindowsStateImplCopyWith<$Res>
    implements $UpdateAppWindowsStateCopyWith<$Res> {
  factory _$$UpdateAppWindowsStateImplCopyWith(
          _$UpdateAppWindowsStateImpl value,
          $Res Function(_$UpdateAppWindowsStateImpl) then) =
      __$$UpdateAppWindowsStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {UpdateAppWindowsEvent events,
      String errorMessage,
      File? fileDownload,
      ConfigServerRestaurantData server});
}

/// @nodoc
class __$$UpdateAppWindowsStateImplCopyWithImpl<$Res>
    extends _$UpdateAppWindowsStateCopyWithImpl<$Res,
        _$UpdateAppWindowsStateImpl>
    implements _$$UpdateAppWindowsStateImplCopyWith<$Res> {
  __$$UpdateAppWindowsStateImplCopyWithImpl(_$UpdateAppWindowsStateImpl _value,
      $Res Function(_$UpdateAppWindowsStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? events = null,
    Object? errorMessage = null,
    Object? fileDownload = freezed,
    Object? server = null,
  }) {
    return _then(_$UpdateAppWindowsStateImpl(
      events: null == events
          ? _value.events
          : events // ignore: cast_nullable_to_non_nullable
              as UpdateAppWindowsEvent,
      errorMessage: null == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String,
      fileDownload: freezed == fileDownload
          ? _value.fileDownload
          : fileDownload // ignore: cast_nullable_to_non_nullable
              as File?,
      server: null == server
          ? _value.server
          : server // ignore: cast_nullable_to_non_nullable
              as ConfigServerRestaurantData,
    ));
  }
}

/// @nodoc

class _$UpdateAppWindowsStateImpl
    with DiagnosticableTreeMixin
    implements _UpdateAppWindowsState {
  const _$UpdateAppWindowsStateImpl(
      {this.events = UpdateAppWindowsEvent.normal,
      this.errorMessage = '',
      this.fileDownload,
      this.server = ConfigServerRestaurantData.aladdinWeb});

  @override
  @JsonKey()
  final UpdateAppWindowsEvent events;
  @override
  @JsonKey()
  final String errorMessage;
  @override
  final File? fileDownload;
  @override
  @JsonKey()
  final ConfigServerRestaurantData server;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'UpdateAppWindowsState(events: $events, errorMessage: $errorMessage, fileDownload: $fileDownload, server: $server)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'UpdateAppWindowsState'))
      ..add(DiagnosticsProperty('events', events))
      ..add(DiagnosticsProperty('errorMessage', errorMessage))
      ..add(DiagnosticsProperty('fileDownload', fileDownload))
      ..add(DiagnosticsProperty('server', server));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UpdateAppWindowsStateImpl &&
            (identical(other.events, events) || other.events == events) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage) &&
            (identical(other.fileDownload, fileDownload) ||
                other.fileDownload == fileDownload) &&
            (identical(other.server, server) || other.server == server));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, events, errorMessage, fileDownload, server);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UpdateAppWindowsStateImplCopyWith<_$UpdateAppWindowsStateImpl>
      get copyWith => __$$UpdateAppWindowsStateImplCopyWithImpl<
          _$UpdateAppWindowsStateImpl>(this, _$identity);
}

abstract class _UpdateAppWindowsState implements UpdateAppWindowsState {
  const factory _UpdateAppWindowsState(
      {final UpdateAppWindowsEvent events,
      final String errorMessage,
      final File? fileDownload,
      final ConfigServerRestaurantData server}) = _$UpdateAppWindowsStateImpl;

  @override
  UpdateAppWindowsEvent get events;
  @override
  String get errorMessage;
  @override
  File? get fileDownload;
  @override
  ConfigServerRestaurantData get server;
  @override
  @JsonKey(ignore: true)
  _$$UpdateAppWindowsStateImplCopyWith<_$UpdateAppWindowsStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
