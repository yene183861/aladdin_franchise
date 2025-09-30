// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_update.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AppUpdateModel _$AppUpdateModelFromJson(Map<String, dynamic> json) {
  return _AppUpdateModel.fromJson(json);
}

/// @nodoc
mixin _$AppUpdateModel {
  String get version => throw _privateConstructorUsedError;
  String get note => throw _privateConstructorUsedError;
  String get apkLink => throw _privateConstructorUsedError;
  String get windowsLink => throw _privateConstructorUsedError;
  @JsonKey(fromJson: dateTimeFromDynamic)
  DateTime get timeRelease => throw _privateConstructorUsedError;
  bool get active => throw _privateConstructorUsedError;
  int get versionCode => throw _privateConstructorUsedError;
  List<dynamic> get only => throw _privateConstructorUsedError;
  bool get isRequired => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AppUpdateModelCopyWith<AppUpdateModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppUpdateModelCopyWith<$Res> {
  factory $AppUpdateModelCopyWith(
          AppUpdateModel value, $Res Function(AppUpdateModel) then) =
      _$AppUpdateModelCopyWithImpl<$Res, AppUpdateModel>;
  @useResult
  $Res call(
      {String version,
      String note,
      String apkLink,
      String windowsLink,
      @JsonKey(fromJson: dateTimeFromDynamic) DateTime timeRelease,
      bool active,
      int versionCode,
      List<dynamic> only,
      bool isRequired});
}

/// @nodoc
class _$AppUpdateModelCopyWithImpl<$Res, $Val extends AppUpdateModel>
    implements $AppUpdateModelCopyWith<$Res> {
  _$AppUpdateModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? version = null,
    Object? note = null,
    Object? apkLink = null,
    Object? windowsLink = null,
    Object? timeRelease = null,
    Object? active = null,
    Object? versionCode = null,
    Object? only = null,
    Object? isRequired = null,
  }) {
    return _then(_value.copyWith(
      version: null == version
          ? _value.version
          : version // ignore: cast_nullable_to_non_nullable
              as String,
      note: null == note
          ? _value.note
          : note // ignore: cast_nullable_to_non_nullable
              as String,
      apkLink: null == apkLink
          ? _value.apkLink
          : apkLink // ignore: cast_nullable_to_non_nullable
              as String,
      windowsLink: null == windowsLink
          ? _value.windowsLink
          : windowsLink // ignore: cast_nullable_to_non_nullable
              as String,
      timeRelease: null == timeRelease
          ? _value.timeRelease
          : timeRelease // ignore: cast_nullable_to_non_nullable
              as DateTime,
      active: null == active
          ? _value.active
          : active // ignore: cast_nullable_to_non_nullable
              as bool,
      versionCode: null == versionCode
          ? _value.versionCode
          : versionCode // ignore: cast_nullable_to_non_nullable
              as int,
      only: null == only
          ? _value.only
          : only // ignore: cast_nullable_to_non_nullable
              as List<dynamic>,
      isRequired: null == isRequired
          ? _value.isRequired
          : isRequired // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AppUpdateModelImplCopyWith<$Res>
    implements $AppUpdateModelCopyWith<$Res> {
  factory _$$AppUpdateModelImplCopyWith(_$AppUpdateModelImpl value,
          $Res Function(_$AppUpdateModelImpl) then) =
      __$$AppUpdateModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String version,
      String note,
      String apkLink,
      String windowsLink,
      @JsonKey(fromJson: dateTimeFromDynamic) DateTime timeRelease,
      bool active,
      int versionCode,
      List<dynamic> only,
      bool isRequired});
}

/// @nodoc
class __$$AppUpdateModelImplCopyWithImpl<$Res>
    extends _$AppUpdateModelCopyWithImpl<$Res, _$AppUpdateModelImpl>
    implements _$$AppUpdateModelImplCopyWith<$Res> {
  __$$AppUpdateModelImplCopyWithImpl(
      _$AppUpdateModelImpl _value, $Res Function(_$AppUpdateModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? version = null,
    Object? note = null,
    Object? apkLink = null,
    Object? windowsLink = null,
    Object? timeRelease = null,
    Object? active = null,
    Object? versionCode = null,
    Object? only = null,
    Object? isRequired = null,
  }) {
    return _then(_$AppUpdateModelImpl(
      version: null == version
          ? _value.version
          : version // ignore: cast_nullable_to_non_nullable
              as String,
      note: null == note
          ? _value.note
          : note // ignore: cast_nullable_to_non_nullable
              as String,
      apkLink: null == apkLink
          ? _value.apkLink
          : apkLink // ignore: cast_nullable_to_non_nullable
              as String,
      windowsLink: null == windowsLink
          ? _value.windowsLink
          : windowsLink // ignore: cast_nullable_to_non_nullable
              as String,
      timeRelease: null == timeRelease
          ? _value.timeRelease
          : timeRelease // ignore: cast_nullable_to_non_nullable
              as DateTime,
      active: null == active
          ? _value.active
          : active // ignore: cast_nullable_to_non_nullable
              as bool,
      versionCode: null == versionCode
          ? _value.versionCode
          : versionCode // ignore: cast_nullable_to_non_nullable
              as int,
      only: null == only
          ? _value._only
          : only // ignore: cast_nullable_to_non_nullable
              as List<dynamic>,
      isRequired: null == isRequired
          ? _value.isRequired
          : isRequired // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class _$AppUpdateModelImpl extends _AppUpdateModel
    with DiagnosticableTreeMixin {
  const _$AppUpdateModelImpl(
      {required this.version,
      this.note = '',
      this.apkLink = '',
      this.windowsLink = '',
      @JsonKey(fromJson: dateTimeFromDynamic) required this.timeRelease,
      this.active = true,
      this.versionCode = 0,
      final List<dynamic> only = const [],
      this.isRequired = false})
      : _only = only,
        super._();

  factory _$AppUpdateModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$AppUpdateModelImplFromJson(json);

  @override
  final String version;
  @override
  @JsonKey()
  final String note;
  @override
  @JsonKey()
  final String apkLink;
  @override
  @JsonKey()
  final String windowsLink;
  @override
  @JsonKey(fromJson: dateTimeFromDynamic)
  final DateTime timeRelease;
  @override
  @JsonKey()
  final bool active;
  @override
  @JsonKey()
  final int versionCode;
  final List<dynamic> _only;
  @override
  @JsonKey()
  List<dynamic> get only {
    if (_only is EqualUnmodifiableListView) return _only;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_only);
  }

  @override
  @JsonKey()
  final bool isRequired;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'AppUpdateModel(version: $version, note: $note, apkLink: $apkLink, windowsLink: $windowsLink, timeRelease: $timeRelease, active: $active, versionCode: $versionCode, only: $only, isRequired: $isRequired)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'AppUpdateModel'))
      ..add(DiagnosticsProperty('version', version))
      ..add(DiagnosticsProperty('note', note))
      ..add(DiagnosticsProperty('apkLink', apkLink))
      ..add(DiagnosticsProperty('windowsLink', windowsLink))
      ..add(DiagnosticsProperty('timeRelease', timeRelease))
      ..add(DiagnosticsProperty('active', active))
      ..add(DiagnosticsProperty('versionCode', versionCode))
      ..add(DiagnosticsProperty('only', only))
      ..add(DiagnosticsProperty('isRequired', isRequired));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AppUpdateModelImpl &&
            (identical(other.version, version) || other.version == version) &&
            (identical(other.note, note) || other.note == note) &&
            (identical(other.apkLink, apkLink) || other.apkLink == apkLink) &&
            (identical(other.windowsLink, windowsLink) ||
                other.windowsLink == windowsLink) &&
            (identical(other.timeRelease, timeRelease) ||
                other.timeRelease == timeRelease) &&
            (identical(other.active, active) || other.active == active) &&
            (identical(other.versionCode, versionCode) ||
                other.versionCode == versionCode) &&
            const DeepCollectionEquality().equals(other._only, _only) &&
            (identical(other.isRequired, isRequired) ||
                other.isRequired == isRequired));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      version,
      note,
      apkLink,
      windowsLink,
      timeRelease,
      active,
      versionCode,
      const DeepCollectionEquality().hash(_only),
      isRequired);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AppUpdateModelImplCopyWith<_$AppUpdateModelImpl> get copyWith =>
      __$$AppUpdateModelImplCopyWithImpl<_$AppUpdateModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AppUpdateModelImplToJson(
      this,
    );
  }
}

abstract class _AppUpdateModel extends AppUpdateModel {
  const factory _AppUpdateModel(
      {required final String version,
      final String note,
      final String apkLink,
      final String windowsLink,
      @JsonKey(fromJson: dateTimeFromDynamic)
      required final DateTime timeRelease,
      final bool active,
      final int versionCode,
      final List<dynamic> only,
      final bool isRequired}) = _$AppUpdateModelImpl;
  const _AppUpdateModel._() : super._();

  factory _AppUpdateModel.fromJson(Map<String, dynamic> json) =
      _$AppUpdateModelImpl.fromJson;

  @override
  String get version;
  @override
  String get note;
  @override
  String get apkLink;
  @override
  String get windowsLink;
  @override
  @JsonKey(fromJson: dateTimeFromDynamic)
  DateTime get timeRelease;
  @override
  bool get active;
  @override
  int get versionCode;
  @override
  List<dynamic> get only;
  @override
  bool get isRequired;
  @override
  @JsonKey(ignore: true)
  _$$AppUpdateModelImplCopyWith<_$AppUpdateModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

AppUpdateNew _$AppUpdateNewFromJson(Map<String, dynamic> json) {
  return _AppUpdateNew.fromJson(json);
}

/// @nodoc
mixin _$AppUpdateNew {
  String get version => throw _privateConstructorUsedError;
  String get note => throw _privateConstructorUsedError;
  DateTime? get timeRelease => throw _privateConstructorUsedError;
  bool get active => throw _privateConstructorUsedError;
  String get mobileAppLink => throw _privateConstructorUsedError;
  String get desktopAppLink => throw _privateConstructorUsedError;
  int get versionCode => throw _privateConstructorUsedError;
  List<dynamic> get only => throw _privateConstructorUsedError;
  bool get isRequired => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AppUpdateNewCopyWith<AppUpdateNew> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppUpdateNewCopyWith<$Res> {
  factory $AppUpdateNewCopyWith(
          AppUpdateNew value, $Res Function(AppUpdateNew) then) =
      _$AppUpdateNewCopyWithImpl<$Res, AppUpdateNew>;
  @useResult
  $Res call(
      {String version,
      String note,
      DateTime? timeRelease,
      bool active,
      String mobileAppLink,
      String desktopAppLink,
      int versionCode,
      List<dynamic> only,
      bool isRequired});
}

/// @nodoc
class _$AppUpdateNewCopyWithImpl<$Res, $Val extends AppUpdateNew>
    implements $AppUpdateNewCopyWith<$Res> {
  _$AppUpdateNewCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? version = null,
    Object? note = null,
    Object? timeRelease = freezed,
    Object? active = null,
    Object? mobileAppLink = null,
    Object? desktopAppLink = null,
    Object? versionCode = null,
    Object? only = null,
    Object? isRequired = null,
  }) {
    return _then(_value.copyWith(
      version: null == version
          ? _value.version
          : version // ignore: cast_nullable_to_non_nullable
              as String,
      note: null == note
          ? _value.note
          : note // ignore: cast_nullable_to_non_nullable
              as String,
      timeRelease: freezed == timeRelease
          ? _value.timeRelease
          : timeRelease // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      active: null == active
          ? _value.active
          : active // ignore: cast_nullable_to_non_nullable
              as bool,
      mobileAppLink: null == mobileAppLink
          ? _value.mobileAppLink
          : mobileAppLink // ignore: cast_nullable_to_non_nullable
              as String,
      desktopAppLink: null == desktopAppLink
          ? _value.desktopAppLink
          : desktopAppLink // ignore: cast_nullable_to_non_nullable
              as String,
      versionCode: null == versionCode
          ? _value.versionCode
          : versionCode // ignore: cast_nullable_to_non_nullable
              as int,
      only: null == only
          ? _value.only
          : only // ignore: cast_nullable_to_non_nullable
              as List<dynamic>,
      isRequired: null == isRequired
          ? _value.isRequired
          : isRequired // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AppUpdateNewImplCopyWith<$Res>
    implements $AppUpdateNewCopyWith<$Res> {
  factory _$$AppUpdateNewImplCopyWith(
          _$AppUpdateNewImpl value, $Res Function(_$AppUpdateNewImpl) then) =
      __$$AppUpdateNewImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String version,
      String note,
      DateTime? timeRelease,
      bool active,
      String mobileAppLink,
      String desktopAppLink,
      int versionCode,
      List<dynamic> only,
      bool isRequired});
}

/// @nodoc
class __$$AppUpdateNewImplCopyWithImpl<$Res>
    extends _$AppUpdateNewCopyWithImpl<$Res, _$AppUpdateNewImpl>
    implements _$$AppUpdateNewImplCopyWith<$Res> {
  __$$AppUpdateNewImplCopyWithImpl(
      _$AppUpdateNewImpl _value, $Res Function(_$AppUpdateNewImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? version = null,
    Object? note = null,
    Object? timeRelease = freezed,
    Object? active = null,
    Object? mobileAppLink = null,
    Object? desktopAppLink = null,
    Object? versionCode = null,
    Object? only = null,
    Object? isRequired = null,
  }) {
    return _then(_$AppUpdateNewImpl(
      version: null == version
          ? _value.version
          : version // ignore: cast_nullable_to_non_nullable
              as String,
      note: null == note
          ? _value.note
          : note // ignore: cast_nullable_to_non_nullable
              as String,
      timeRelease: freezed == timeRelease
          ? _value.timeRelease
          : timeRelease // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      active: null == active
          ? _value.active
          : active // ignore: cast_nullable_to_non_nullable
              as bool,
      mobileAppLink: null == mobileAppLink
          ? _value.mobileAppLink
          : mobileAppLink // ignore: cast_nullable_to_non_nullable
              as String,
      desktopAppLink: null == desktopAppLink
          ? _value.desktopAppLink
          : desktopAppLink // ignore: cast_nullable_to_non_nullable
              as String,
      versionCode: null == versionCode
          ? _value.versionCode
          : versionCode // ignore: cast_nullable_to_non_nullable
              as int,
      only: null == only
          ? _value._only
          : only // ignore: cast_nullable_to_non_nullable
              as List<dynamic>,
      isRequired: null == isRequired
          ? _value.isRequired
          : isRequired // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class _$AppUpdateNewImpl extends _AppUpdateNew with DiagnosticableTreeMixin {
  const _$AppUpdateNewImpl(
      {this.version = '',
      this.note = '',
      this.timeRelease,
      this.active = false,
      this.mobileAppLink = '',
      this.desktopAppLink = '',
      this.versionCode = 0,
      final List<dynamic> only = const [],
      this.isRequired = false})
      : _only = only,
        super._();

  factory _$AppUpdateNewImpl.fromJson(Map<String, dynamic> json) =>
      _$$AppUpdateNewImplFromJson(json);

  @override
  @JsonKey()
  final String version;
  @override
  @JsonKey()
  final String note;
  @override
  final DateTime? timeRelease;
  @override
  @JsonKey()
  final bool active;
  @override
  @JsonKey()
  final String mobileAppLink;
  @override
  @JsonKey()
  final String desktopAppLink;
  @override
  @JsonKey()
  final int versionCode;
  final List<dynamic> _only;
  @override
  @JsonKey()
  List<dynamic> get only {
    if (_only is EqualUnmodifiableListView) return _only;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_only);
  }

  @override
  @JsonKey()
  final bool isRequired;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'AppUpdateNew(version: $version, note: $note, timeRelease: $timeRelease, active: $active, mobileAppLink: $mobileAppLink, desktopAppLink: $desktopAppLink, versionCode: $versionCode, only: $only, isRequired: $isRequired)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'AppUpdateNew'))
      ..add(DiagnosticsProperty('version', version))
      ..add(DiagnosticsProperty('note', note))
      ..add(DiagnosticsProperty('timeRelease', timeRelease))
      ..add(DiagnosticsProperty('active', active))
      ..add(DiagnosticsProperty('mobileAppLink', mobileAppLink))
      ..add(DiagnosticsProperty('desktopAppLink', desktopAppLink))
      ..add(DiagnosticsProperty('versionCode', versionCode))
      ..add(DiagnosticsProperty('only', only))
      ..add(DiagnosticsProperty('isRequired', isRequired));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AppUpdateNewImpl &&
            (identical(other.version, version) || other.version == version) &&
            (identical(other.note, note) || other.note == note) &&
            (identical(other.timeRelease, timeRelease) ||
                other.timeRelease == timeRelease) &&
            (identical(other.active, active) || other.active == active) &&
            (identical(other.mobileAppLink, mobileAppLink) ||
                other.mobileAppLink == mobileAppLink) &&
            (identical(other.desktopAppLink, desktopAppLink) ||
                other.desktopAppLink == desktopAppLink) &&
            (identical(other.versionCode, versionCode) ||
                other.versionCode == versionCode) &&
            const DeepCollectionEquality().equals(other._only, _only) &&
            (identical(other.isRequired, isRequired) ||
                other.isRequired == isRequired));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      version,
      note,
      timeRelease,
      active,
      mobileAppLink,
      desktopAppLink,
      versionCode,
      const DeepCollectionEquality().hash(_only),
      isRequired);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AppUpdateNewImplCopyWith<_$AppUpdateNewImpl> get copyWith =>
      __$$AppUpdateNewImplCopyWithImpl<_$AppUpdateNewImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AppUpdateNewImplToJson(
      this,
    );
  }
}

abstract class _AppUpdateNew extends AppUpdateNew {
  const factory _AppUpdateNew(
      {final String version,
      final String note,
      final DateTime? timeRelease,
      final bool active,
      final String mobileAppLink,
      final String desktopAppLink,
      final int versionCode,
      final List<dynamic> only,
      final bool isRequired}) = _$AppUpdateNewImpl;
  const _AppUpdateNew._() : super._();

  factory _AppUpdateNew.fromJson(Map<String, dynamic> json) =
      _$AppUpdateNewImpl.fromJson;

  @override
  String get version;
  @override
  String get note;
  @override
  DateTime? get timeRelease;
  @override
  bool get active;
  @override
  String get mobileAppLink;
  @override
  String get desktopAppLink;
  @override
  int get versionCode;
  @override
  List<dynamic> get only;
  @override
  bool get isRequired;
  @override
  @JsonKey(ignore: true)
  _$$AppUpdateNewImplCopyWith<_$AppUpdateNewImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
