// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tag_product.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TagProductModel _$TagProductModelFromJson(Map<String, dynamic> json) {
  return _TagProductModel.fromJson(json);
}

/// @nodoc
mixin _$TagProductModel {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get nameEn => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TagProductModelCopyWith<TagProductModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TagProductModelCopyWith<$Res> {
  factory $TagProductModelCopyWith(
          TagProductModel value, $Res Function(TagProductModel) then) =
      _$TagProductModelCopyWithImpl<$Res, TagProductModel>;
  @useResult
  $Res call({int id, String name, String nameEn});
}

/// @nodoc
class _$TagProductModelCopyWithImpl<$Res, $Val extends TagProductModel>
    implements $TagProductModelCopyWith<$Res> {
  _$TagProductModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? nameEn = null,
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
      nameEn: null == nameEn
          ? _value.nameEn
          : nameEn // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TagProductModelImplCopyWith<$Res>
    implements $TagProductModelCopyWith<$Res> {
  factory _$$TagProductModelImplCopyWith(_$TagProductModelImpl value,
          $Res Function(_$TagProductModelImpl) then) =
      __$$TagProductModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, String name, String nameEn});
}

/// @nodoc
class __$$TagProductModelImplCopyWithImpl<$Res>
    extends _$TagProductModelCopyWithImpl<$Res, _$TagProductModelImpl>
    implements _$$TagProductModelImplCopyWith<$Res> {
  __$$TagProductModelImplCopyWithImpl(
      _$TagProductModelImpl _value, $Res Function(_$TagProductModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? nameEn = null,
  }) {
    return _then(_$TagProductModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      nameEn: null == nameEn
          ? _value.nameEn
          : nameEn // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class _$TagProductModelImpl extends _TagProductModel
    with DiagnosticableTreeMixin {
  const _$TagProductModelImpl(
      {required this.id, required this.name, this.nameEn = ''})
      : super._();

  factory _$TagProductModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$TagProductModelImplFromJson(json);

  @override
  final int id;
  @override
  final String name;
  @override
  @JsonKey()
  final String nameEn;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'TagProductModel(id: $id, name: $name, nameEn: $nameEn)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'TagProductModel'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('name', name))
      ..add(DiagnosticsProperty('nameEn', nameEn));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TagProductModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.nameEn, nameEn) || other.nameEn == nameEn));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, nameEn);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TagProductModelImplCopyWith<_$TagProductModelImpl> get copyWith =>
      __$$TagProductModelImplCopyWithImpl<_$TagProductModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TagProductModelImplToJson(
      this,
    );
  }
}

abstract class _TagProductModel extends TagProductModel {
  const factory _TagProductModel(
      {required final int id,
      required final String name,
      final String nameEn}) = _$TagProductModelImpl;
  const _TagProductModel._() : super._();

  factory _TagProductModel.fromJson(Map<String, dynamic> json) =
      _$TagProductModelImpl.fromJson;

  @override
  int get id;
  @override
  String get name;
  @override
  String get nameEn;
  @override
  @JsonKey(ignore: true)
  _$$TagProductModelImplCopyWith<_$TagProductModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
