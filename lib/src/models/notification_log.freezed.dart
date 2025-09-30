// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'notification_log.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

NotificationLogModel _$NotificationLogModelFromJson(Map<String, dynamic> json) {
  return _NotificationLogModel.fromJson(json);
}

/// @nodoc
mixin _$NotificationLogModel {
  DateTime get createAt => throw _privateConstructorUsedError;
  String get error => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get logo => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $NotificationLogModelCopyWith<NotificationLogModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NotificationLogModelCopyWith<$Res> {
  factory $NotificationLogModelCopyWith(NotificationLogModel value,
          $Res Function(NotificationLogModel) then) =
      _$NotificationLogModelCopyWithImpl<$Res, NotificationLogModel>;
  @useResult
  $Res call({DateTime createAt, String error, String title, String logo});
}

/// @nodoc
class _$NotificationLogModelCopyWithImpl<$Res,
        $Val extends NotificationLogModel>
    implements $NotificationLogModelCopyWith<$Res> {
  _$NotificationLogModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? createAt = null,
    Object? error = null,
    Object? title = null,
    Object? logo = null,
  }) {
    return _then(_value.copyWith(
      createAt: null == createAt
          ? _value.createAt
          : createAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      error: null == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      logo: null == logo
          ? _value.logo
          : logo // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$NotificationLogModelImplCopyWith<$Res>
    implements $NotificationLogModelCopyWith<$Res> {
  factory _$$NotificationLogModelImplCopyWith(_$NotificationLogModelImpl value,
          $Res Function(_$NotificationLogModelImpl) then) =
      __$$NotificationLogModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({DateTime createAt, String error, String title, String logo});
}

/// @nodoc
class __$$NotificationLogModelImplCopyWithImpl<$Res>
    extends _$NotificationLogModelCopyWithImpl<$Res, _$NotificationLogModelImpl>
    implements _$$NotificationLogModelImplCopyWith<$Res> {
  __$$NotificationLogModelImplCopyWithImpl(_$NotificationLogModelImpl _value,
      $Res Function(_$NotificationLogModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? createAt = null,
    Object? error = null,
    Object? title = null,
    Object? logo = null,
  }) {
    return _then(_$NotificationLogModelImpl(
      createAt: null == createAt
          ? _value.createAt
          : createAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      error: null == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      logo: null == logo
          ? _value.logo
          : logo // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class _$NotificationLogModelImpl
    with DiagnosticableTreeMixin
    implements _NotificationLogModel {
  const _$NotificationLogModelImpl(
      {required this.createAt,
      required this.error,
      required this.title,
      required this.logo});

  factory _$NotificationLogModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$NotificationLogModelImplFromJson(json);

  @override
  final DateTime createAt;
  @override
  final String error;
  @override
  final String title;
  @override
  final String logo;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'NotificationLogModel(createAt: $createAt, error: $error, title: $title, logo: $logo)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'NotificationLogModel'))
      ..add(DiagnosticsProperty('createAt', createAt))
      ..add(DiagnosticsProperty('error', error))
      ..add(DiagnosticsProperty('title', title))
      ..add(DiagnosticsProperty('logo', logo));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NotificationLogModelImpl &&
            (identical(other.createAt, createAt) ||
                other.createAt == createAt) &&
            (identical(other.error, error) || other.error == error) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.logo, logo) || other.logo == logo));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, createAt, error, title, logo);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$NotificationLogModelImplCopyWith<_$NotificationLogModelImpl>
      get copyWith =>
          __$$NotificationLogModelImplCopyWithImpl<_$NotificationLogModelImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$NotificationLogModelImplToJson(
      this,
    );
  }
}

abstract class _NotificationLogModel implements NotificationLogModel {
  const factory _NotificationLogModel(
      {required final DateTime createAt,
      required final String error,
      required final String title,
      required final String logo}) = _$NotificationLogModelImpl;

  factory _NotificationLogModel.fromJson(Map<String, dynamic> json) =
      _$NotificationLogModelImpl.fromJson;

  @override
  DateTime get createAt;
  @override
  String get error;
  @override
  String get title;
  @override
  String get logo;
  @override
  @JsonKey(ignore: true)
  _$$NotificationLogModelImplCopyWith<_$NotificationLogModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}
