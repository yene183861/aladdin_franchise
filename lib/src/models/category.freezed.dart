// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'category.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

CategoryModel _$CategoryModelFromJson(Map<String, dynamic> json) {
  return _CategoryModel.fromJson(json);
}

/// @nodoc
mixin _$CategoryModel {
  dynamic get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String? get slug => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  String? get image => throw _privateConstructorUsedError;
  List<SubCategoryModel>? get children => throw _privateConstructorUsedError;
  Map<String, dynamic> get language => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CategoryModelCopyWith<CategoryModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CategoryModelCopyWith<$Res> {
  factory $CategoryModelCopyWith(
          CategoryModel value, $Res Function(CategoryModel) then) =
      _$CategoryModelCopyWithImpl<$Res, CategoryModel>;
  @useResult
  $Res call(
      {dynamic id,
      String title,
      String? slug,
      String? description,
      String? image,
      List<SubCategoryModel>? children,
      Map<String, dynamic> language});
}

/// @nodoc
class _$CategoryModelCopyWithImpl<$Res, $Val extends CategoryModel>
    implements $CategoryModelCopyWith<$Res> {
  _$CategoryModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? title = null,
    Object? slug = freezed,
    Object? description = freezed,
    Object? image = freezed,
    Object? children = freezed,
    Object? language = null,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as dynamic,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      slug: freezed == slug
          ? _value.slug
          : slug // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      image: freezed == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String?,
      children: freezed == children
          ? _value.children
          : children // ignore: cast_nullable_to_non_nullable
              as List<SubCategoryModel>?,
      language: null == language
          ? _value.language
          : language // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CategoryModelImplCopyWith<$Res>
    implements $CategoryModelCopyWith<$Res> {
  factory _$$CategoryModelImplCopyWith(
          _$CategoryModelImpl value, $Res Function(_$CategoryModelImpl) then) =
      __$$CategoryModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {dynamic id,
      String title,
      String? slug,
      String? description,
      String? image,
      List<SubCategoryModel>? children,
      Map<String, dynamic> language});
}

/// @nodoc
class __$$CategoryModelImplCopyWithImpl<$Res>
    extends _$CategoryModelCopyWithImpl<$Res, _$CategoryModelImpl>
    implements _$$CategoryModelImplCopyWith<$Res> {
  __$$CategoryModelImplCopyWithImpl(
      _$CategoryModelImpl _value, $Res Function(_$CategoryModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? title = null,
    Object? slug = freezed,
    Object? description = freezed,
    Object? image = freezed,
    Object? children = freezed,
    Object? language = null,
  }) {
    return _then(_$CategoryModelImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as dynamic,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      slug: freezed == slug
          ? _value.slug
          : slug // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      image: freezed == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String?,
      children: freezed == children
          ? _value._children
          : children // ignore: cast_nullable_to_non_nullable
              as List<SubCategoryModel>?,
      language: null == language
          ? _value._language
          : language // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class _$CategoryModelImpl extends _CategoryModel with DiagnosticableTreeMixin {
  const _$CategoryModelImpl(
      {this.id,
      required this.title,
      this.slug,
      this.description,
      this.image,
      final List<SubCategoryModel>? children,
      final Map<String, dynamic> language = const {}})
      : _children = children,
        _language = language,
        super._();

  factory _$CategoryModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$CategoryModelImplFromJson(json);

  @override
  final dynamic id;
  @override
  final String title;
  @override
  final String? slug;
  @override
  final String? description;
  @override
  final String? image;
  final List<SubCategoryModel>? _children;
  @override
  List<SubCategoryModel>? get children {
    final value = _children;
    if (value == null) return null;
    if (_children is EqualUnmodifiableListView) return _children;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final Map<String, dynamic> _language;
  @override
  @JsonKey()
  Map<String, dynamic> get language {
    if (_language is EqualUnmodifiableMapView) return _language;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_language);
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'CategoryModel(id: $id, title: $title, slug: $slug, description: $description, image: $image, children: $children, language: $language)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'CategoryModel'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('title', title))
      ..add(DiagnosticsProperty('slug', slug))
      ..add(DiagnosticsProperty('description', description))
      ..add(DiagnosticsProperty('image', image))
      ..add(DiagnosticsProperty('children', children))
      ..add(DiagnosticsProperty('language', language));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CategoryModelImpl &&
            const DeepCollectionEquality().equals(other.id, id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.slug, slug) || other.slug == slug) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.image, image) || other.image == image) &&
            const DeepCollectionEquality().equals(other._children, _children) &&
            const DeepCollectionEquality().equals(other._language, _language));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      title,
      slug,
      description,
      image,
      const DeepCollectionEquality().hash(_children),
      const DeepCollectionEquality().hash(_language));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CategoryModelImplCopyWith<_$CategoryModelImpl> get copyWith =>
      __$$CategoryModelImplCopyWithImpl<_$CategoryModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CategoryModelImplToJson(
      this,
    );
  }
}

abstract class _CategoryModel extends CategoryModel {
  const factory _CategoryModel(
      {final dynamic id,
      required final String title,
      final String? slug,
      final String? description,
      final String? image,
      final List<SubCategoryModel>? children,
      final Map<String, dynamic> language}) = _$CategoryModelImpl;
  const _CategoryModel._() : super._();

  factory _CategoryModel.fromJson(Map<String, dynamic> json) =
      _$CategoryModelImpl.fromJson;

  @override
  dynamic get id;
  @override
  String get title;
  @override
  String? get slug;
  @override
  String? get description;
  @override
  String? get image;
  @override
  List<SubCategoryModel>? get children;
  @override
  Map<String, dynamic> get language;
  @override
  @JsonKey(ignore: true)
  _$$CategoryModelImplCopyWith<_$CategoryModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SubCategoryModel _$SubCategoryModelFromJson(Map<String, dynamic> json) {
  return _SubCategoryModel.fromJson(json);
}

/// @nodoc
mixin _$SubCategoryModel {
  int get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String? get slug => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  String? get image => throw _privateConstructorUsedError;
  String get titleEn => throw _privateConstructorUsedError;
  Map<String, dynamic> get language => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SubCategoryModelCopyWith<SubCategoryModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SubCategoryModelCopyWith<$Res> {
  factory $SubCategoryModelCopyWith(
          SubCategoryModel value, $Res Function(SubCategoryModel) then) =
      _$SubCategoryModelCopyWithImpl<$Res, SubCategoryModel>;
  @useResult
  $Res call(
      {int id,
      String title,
      String? slug,
      String? description,
      String? image,
      String titleEn,
      Map<String, dynamic> language});
}

/// @nodoc
class _$SubCategoryModelCopyWithImpl<$Res, $Val extends SubCategoryModel>
    implements $SubCategoryModelCopyWith<$Res> {
  _$SubCategoryModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? slug = freezed,
    Object? description = freezed,
    Object? image = freezed,
    Object? titleEn = null,
    Object? language = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      slug: freezed == slug
          ? _value.slug
          : slug // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      image: freezed == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String?,
      titleEn: null == titleEn
          ? _value.titleEn
          : titleEn // ignore: cast_nullable_to_non_nullable
              as String,
      language: null == language
          ? _value.language
          : language // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SubCategoryModelImplCopyWith<$Res>
    implements $SubCategoryModelCopyWith<$Res> {
  factory _$$SubCategoryModelImplCopyWith(_$SubCategoryModelImpl value,
          $Res Function(_$SubCategoryModelImpl) then) =
      __$$SubCategoryModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String title,
      String? slug,
      String? description,
      String? image,
      String titleEn,
      Map<String, dynamic> language});
}

/// @nodoc
class __$$SubCategoryModelImplCopyWithImpl<$Res>
    extends _$SubCategoryModelCopyWithImpl<$Res, _$SubCategoryModelImpl>
    implements _$$SubCategoryModelImplCopyWith<$Res> {
  __$$SubCategoryModelImplCopyWithImpl(_$SubCategoryModelImpl _value,
      $Res Function(_$SubCategoryModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? slug = freezed,
    Object? description = freezed,
    Object? image = freezed,
    Object? titleEn = null,
    Object? language = null,
  }) {
    return _then(_$SubCategoryModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      slug: freezed == slug
          ? _value.slug
          : slug // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      image: freezed == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String?,
      titleEn: null == titleEn
          ? _value.titleEn
          : titleEn // ignore: cast_nullable_to_non_nullable
              as String,
      language: null == language
          ? _value._language
          : language // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class _$SubCategoryModelImpl extends _SubCategoryModel
    with DiagnosticableTreeMixin {
  const _$SubCategoryModelImpl(
      {required this.id,
      required this.title,
      this.slug,
      this.description,
      this.image,
      this.titleEn = '',
      final Map<String, dynamic> language = const {}})
      : _language = language,
        super._();

  factory _$SubCategoryModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$SubCategoryModelImplFromJson(json);

  @override
  final int id;
  @override
  final String title;
  @override
  final String? slug;
  @override
  final String? description;
  @override
  final String? image;
  @override
  @JsonKey()
  final String titleEn;
  final Map<String, dynamic> _language;
  @override
  @JsonKey()
  Map<String, dynamic> get language {
    if (_language is EqualUnmodifiableMapView) return _language;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_language);
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'SubCategoryModel(id: $id, title: $title, slug: $slug, description: $description, image: $image, titleEn: $titleEn, language: $language)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'SubCategoryModel'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('title', title))
      ..add(DiagnosticsProperty('slug', slug))
      ..add(DiagnosticsProperty('description', description))
      ..add(DiagnosticsProperty('image', image))
      ..add(DiagnosticsProperty('titleEn', titleEn))
      ..add(DiagnosticsProperty('language', language));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SubCategoryModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.slug, slug) || other.slug == slug) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.image, image) || other.image == image) &&
            (identical(other.titleEn, titleEn) || other.titleEn == titleEn) &&
            const DeepCollectionEquality().equals(other._language, _language));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, title, slug, description,
      image, titleEn, const DeepCollectionEquality().hash(_language));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SubCategoryModelImplCopyWith<_$SubCategoryModelImpl> get copyWith =>
      __$$SubCategoryModelImplCopyWithImpl<_$SubCategoryModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SubCategoryModelImplToJson(
      this,
    );
  }
}

abstract class _SubCategoryModel extends SubCategoryModel {
  const factory _SubCategoryModel(
      {required final int id,
      required final String title,
      final String? slug,
      final String? description,
      final String? image,
      final String titleEn,
      final Map<String, dynamic> language}) = _$SubCategoryModelImpl;
  const _SubCategoryModel._() : super._();

  factory _SubCategoryModel.fromJson(Map<String, dynamic> json) =
      _$SubCategoryModelImpl.fromJson;

  @override
  int get id;
  @override
  String get title;
  @override
  String? get slug;
  @override
  String? get description;
  @override
  String? get image;
  @override
  String get titleEn;
  @override
  Map<String, dynamic> get language;
  @override
  @JsonKey(ignore: true)
  _$$SubCategoryModelImplCopyWith<_$SubCategoryModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
