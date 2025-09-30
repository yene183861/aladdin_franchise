// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'atm_pos.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AtmPosModel _$AtmPosModelFromJson(Map<String, dynamic> json) {
  return _AtmPosModel.fromJson(json);
}

/// @nodoc
mixin _$AtmPosModel {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError; // 1 - tĩnh, 2 - động
  int get setting => throw _privateConstructorUsedError;
  String get url => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AtmPosModelCopyWith<AtmPosModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AtmPosModelCopyWith<$Res> {
  factory $AtmPosModelCopyWith(
          AtmPosModel value, $Res Function(AtmPosModel) then) =
      _$AtmPosModelCopyWithImpl<$Res, AtmPosModel>;
  @useResult
  $Res call({int id, String name, int setting, String url});
}

/// @nodoc
class _$AtmPosModelCopyWithImpl<$Res, $Val extends AtmPosModel>
    implements $AtmPosModelCopyWith<$Res> {
  _$AtmPosModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? setting = null,
    Object? url = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      setting: null == setting
          ? _value.setting
          : setting // ignore: cast_nullable_to_non_nullable
              as int,
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AtmPosModelImplCopyWith<$Res>
    implements $AtmPosModelCopyWith<$Res> {
  factory _$$AtmPosModelImplCopyWith(
          _$AtmPosModelImpl value, $Res Function(_$AtmPosModelImpl) then) =
      __$$AtmPosModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, String name, int setting, String url});
}

/// @nodoc
class __$$AtmPosModelImplCopyWithImpl<$Res>
    extends _$AtmPosModelCopyWithImpl<$Res, _$AtmPosModelImpl>
    implements _$$AtmPosModelImplCopyWith<$Res> {
  __$$AtmPosModelImplCopyWithImpl(
      _$AtmPosModelImpl _value, $Res Function(_$AtmPosModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? setting = null,
    Object? url = null,
  }) {
    return _then(_$AtmPosModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      setting: null == setting
          ? _value.setting
          : setting // ignore: cast_nullable_to_non_nullable
              as int,
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class _$AtmPosModelImpl extends _AtmPosModel with DiagnosticableTreeMixin {
  const _$AtmPosModelImpl(
      {this.id = -1, this.name = '', this.setting = 1, this.url = ''})
      : super._();

  factory _$AtmPosModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$AtmPosModelImplFromJson(json);

  @override
  @JsonKey()
  final int id;
  @override
  @JsonKey()
  final String name;
// 1 - tĩnh, 2 - động
  @override
  @JsonKey()
  final int setting;
  @override
  @JsonKey()
  final String url;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'AtmPosModel(id: $id, name: $name, setting: $setting, url: $url)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'AtmPosModel'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('name', name))
      ..add(DiagnosticsProperty('setting', setting))
      ..add(DiagnosticsProperty('url', url));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AtmPosModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.setting, setting) || other.setting == setting) &&
            (identical(other.url, url) || other.url == url));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, setting, url);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AtmPosModelImplCopyWith<_$AtmPosModelImpl> get copyWith =>
      __$$AtmPosModelImplCopyWithImpl<_$AtmPosModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AtmPosModelImplToJson(
      this,
    );
  }
}

abstract class _AtmPosModel extends AtmPosModel {
  const factory _AtmPosModel(
      {final int id,
      final String name,
      final int setting,
      final String url}) = _$AtmPosModelImpl;
  const _AtmPosModel._() : super._();

  factory _AtmPosModel.fromJson(Map<String, dynamic> json) =
      _$AtmPosModelImpl.fromJson;

  @override
  int get id;
  @override
  String get name;
  @override // 1 - tĩnh, 2 - động
  int get setting;
  @override
  String get url;
  @override
  @JsonKey(ignore: true)
  _$$AtmPosModelImplCopyWith<_$AtmPosModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
