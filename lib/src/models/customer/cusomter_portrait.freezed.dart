// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'cusomter_portrait.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

CustomerPortrait _$CustomerPortraitFromJson(Map<String, dynamic> json) {
  return _CustomerPortrait.fromJson(json);
}

/// @nodoc
mixin _$CustomerPortrait {
  String get key => throw _privateConstructorUsedError;
  String get value => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CustomerPortraitCopyWith<CustomerPortrait> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CustomerPortraitCopyWith<$Res> {
  factory $CustomerPortraitCopyWith(
          CustomerPortrait value, $Res Function(CustomerPortrait) then) =
      _$CustomerPortraitCopyWithImpl<$Res, CustomerPortrait>;
  @useResult
  $Res call({String key, String value});
}

/// @nodoc
class _$CustomerPortraitCopyWithImpl<$Res, $Val extends CustomerPortrait>
    implements $CustomerPortraitCopyWith<$Res> {
  _$CustomerPortraitCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? key = null,
    Object? value = null,
  }) {
    return _then(_value.copyWith(
      key: null == key
          ? _value.key
          : key // ignore: cast_nullable_to_non_nullable
              as String,
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CustomerPortraitImplCopyWith<$Res>
    implements $CustomerPortraitCopyWith<$Res> {
  factory _$$CustomerPortraitImplCopyWith(_$CustomerPortraitImpl value,
          $Res Function(_$CustomerPortraitImpl) then) =
      __$$CustomerPortraitImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String key, String value});
}

/// @nodoc
class __$$CustomerPortraitImplCopyWithImpl<$Res>
    extends _$CustomerPortraitCopyWithImpl<$Res, _$CustomerPortraitImpl>
    implements _$$CustomerPortraitImplCopyWith<$Res> {
  __$$CustomerPortraitImplCopyWithImpl(_$CustomerPortraitImpl _value,
      $Res Function(_$CustomerPortraitImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? key = null,
    Object? value = null,
  }) {
    return _then(_$CustomerPortraitImpl(
      key: null == key
          ? _value.key
          : key // ignore: cast_nullable_to_non_nullable
              as String,
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class _$CustomerPortraitImpl extends _CustomerPortrait
    with DiagnosticableTreeMixin {
  const _$CustomerPortraitImpl({this.key = "", this.value = ""}) : super._();

  factory _$CustomerPortraitImpl.fromJson(Map<String, dynamic> json) =>
      _$$CustomerPortraitImplFromJson(json);

  @override
  @JsonKey()
  final String key;
  @override
  @JsonKey()
  final String value;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'CustomerPortrait(key: $key, value: $value)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'CustomerPortrait'))
      ..add(DiagnosticsProperty('key', key))
      ..add(DiagnosticsProperty('value', value));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CustomerPortraitImpl &&
            (identical(other.key, key) || other.key == key) &&
            (identical(other.value, value) || other.value == value));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, key, value);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CustomerPortraitImplCopyWith<_$CustomerPortraitImpl> get copyWith =>
      __$$CustomerPortraitImplCopyWithImpl<_$CustomerPortraitImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CustomerPortraitImplToJson(
      this,
    );
  }
}

abstract class _CustomerPortrait extends CustomerPortrait {
  const factory _CustomerPortrait({final String key, final String value}) =
      _$CustomerPortraitImpl;
  const _CustomerPortrait._() : super._();

  factory _CustomerPortrait.fromJson(Map<String, dynamic> json) =
      _$CustomerPortraitImpl.fromJson;

  @override
  String get key;
  @override
  String get value;
  @override
  @JsonKey(ignore: true)
  _$$CustomerPortraitImplCopyWith<_$CustomerPortraitImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
