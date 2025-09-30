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
mixin _$UpdateAppAndroidState {
  bool get isDownloading => throw _privateConstructorUsedError;
  double get downloadProgress => throw _privateConstructorUsedError;
  String get saveFolder => throw _privateConstructorUsedError;
  String? get taskId => throw _privateConstructorUsedError;
  ConfigServerRestaurantData get server => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $UpdateAppAndroidStateCopyWith<UpdateAppAndroidState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UpdateAppAndroidStateCopyWith<$Res> {
  factory $UpdateAppAndroidStateCopyWith(UpdateAppAndroidState value,
          $Res Function(UpdateAppAndroidState) then) =
      _$UpdateAppAndroidStateCopyWithImpl<$Res, UpdateAppAndroidState>;
  @useResult
  $Res call(
      {bool isDownloading,
      double downloadProgress,
      String saveFolder,
      String? taskId,
      ConfigServerRestaurantData server});
}

/// @nodoc
class _$UpdateAppAndroidStateCopyWithImpl<$Res,
        $Val extends UpdateAppAndroidState>
    implements $UpdateAppAndroidStateCopyWith<$Res> {
  _$UpdateAppAndroidStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isDownloading = null,
    Object? downloadProgress = null,
    Object? saveFolder = null,
    Object? taskId = freezed,
    Object? server = null,
  }) {
    return _then(_value.copyWith(
      isDownloading: null == isDownloading
          ? _value.isDownloading
          : isDownloading // ignore: cast_nullable_to_non_nullable
              as bool,
      downloadProgress: null == downloadProgress
          ? _value.downloadProgress
          : downloadProgress // ignore: cast_nullable_to_non_nullable
              as double,
      saveFolder: null == saveFolder
          ? _value.saveFolder
          : saveFolder // ignore: cast_nullable_to_non_nullable
              as String,
      taskId: freezed == taskId
          ? _value.taskId
          : taskId // ignore: cast_nullable_to_non_nullable
              as String?,
      server: null == server
          ? _value.server
          : server // ignore: cast_nullable_to_non_nullable
              as ConfigServerRestaurantData,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UpdateAppAndroidStateImplCopyWith<$Res>
    implements $UpdateAppAndroidStateCopyWith<$Res> {
  factory _$$UpdateAppAndroidStateImplCopyWith(
          _$UpdateAppAndroidStateImpl value,
          $Res Function(_$UpdateAppAndroidStateImpl) then) =
      __$$UpdateAppAndroidStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool isDownloading,
      double downloadProgress,
      String saveFolder,
      String? taskId,
      ConfigServerRestaurantData server});
}

/// @nodoc
class __$$UpdateAppAndroidStateImplCopyWithImpl<$Res>
    extends _$UpdateAppAndroidStateCopyWithImpl<$Res,
        _$UpdateAppAndroidStateImpl>
    implements _$$UpdateAppAndroidStateImplCopyWith<$Res> {
  __$$UpdateAppAndroidStateImplCopyWithImpl(_$UpdateAppAndroidStateImpl _value,
      $Res Function(_$UpdateAppAndroidStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isDownloading = null,
    Object? downloadProgress = null,
    Object? saveFolder = null,
    Object? taskId = freezed,
    Object? server = null,
  }) {
    return _then(_$UpdateAppAndroidStateImpl(
      isDownloading: null == isDownloading
          ? _value.isDownloading
          : isDownloading // ignore: cast_nullable_to_non_nullable
              as bool,
      downloadProgress: null == downloadProgress
          ? _value.downloadProgress
          : downloadProgress // ignore: cast_nullable_to_non_nullable
              as double,
      saveFolder: null == saveFolder
          ? _value.saveFolder
          : saveFolder // ignore: cast_nullable_to_non_nullable
              as String,
      taskId: freezed == taskId
          ? _value.taskId
          : taskId // ignore: cast_nullable_to_non_nullable
              as String?,
      server: null == server
          ? _value.server
          : server // ignore: cast_nullable_to_non_nullable
              as ConfigServerRestaurantData,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _$UpdateAppAndroidStateImpl
    with DiagnosticableTreeMixin
    implements _UpdateAppAndroidState {
  const _$UpdateAppAndroidStateImpl(
      {required this.isDownloading,
      required this.downloadProgress,
      required this.saveFolder,
      this.taskId,
      this.server = ConfigServerRestaurantData.aladdinWeb});

  @override
  final bool isDownloading;
  @override
  final double downloadProgress;
  @override
  final String saveFolder;
  @override
  final String? taskId;
  @override
  @JsonKey()
  final ConfigServerRestaurantData server;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'UpdateAppAndroidState(isDownloading: $isDownloading, downloadProgress: $downloadProgress, saveFolder: $saveFolder, taskId: $taskId, server: $server)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'UpdateAppAndroidState'))
      ..add(DiagnosticsProperty('isDownloading', isDownloading))
      ..add(DiagnosticsProperty('downloadProgress', downloadProgress))
      ..add(DiagnosticsProperty('saveFolder', saveFolder))
      ..add(DiagnosticsProperty('taskId', taskId))
      ..add(DiagnosticsProperty('server', server));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UpdateAppAndroidStateImpl &&
            (identical(other.isDownloading, isDownloading) ||
                other.isDownloading == isDownloading) &&
            (identical(other.downloadProgress, downloadProgress) ||
                other.downloadProgress == downloadProgress) &&
            (identical(other.saveFolder, saveFolder) ||
                other.saveFolder == saveFolder) &&
            (identical(other.taskId, taskId) || other.taskId == taskId) &&
            (identical(other.server, server) || other.server == server));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, isDownloading, downloadProgress, saveFolder, taskId, server);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UpdateAppAndroidStateImplCopyWith<_$UpdateAppAndroidStateImpl>
      get copyWith => __$$UpdateAppAndroidStateImplCopyWithImpl<
          _$UpdateAppAndroidStateImpl>(this, _$identity);
}

abstract class _UpdateAppAndroidState implements UpdateAppAndroidState {
  const factory _UpdateAppAndroidState(
      {required final bool isDownloading,
      required final double downloadProgress,
      required final String saveFolder,
      final String? taskId,
      final ConfigServerRestaurantData server}) = _$UpdateAppAndroidStateImpl;

  @override
  bool get isDownloading;
  @override
  double get downloadProgress;
  @override
  String get saveFolder;
  @override
  String? get taskId;
  @override
  ConfigServerRestaurantData get server;
  @override
  @JsonKey(ignore: true)
  _$$UpdateAppAndroidStateImplCopyWith<_$UpdateAppAndroidStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
