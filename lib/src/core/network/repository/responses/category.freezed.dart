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

CategoryResponseData _$CategoryResponseDataFromJson(Map<String, dynamic> json) {
  return _CategoryResponseData.fromJson(json);
}

/// @nodoc
mixin _$CategoryResponseData {
  int get status => throw _privateConstructorUsedError;
  List<CategoryModel> get data => throw _privateConstructorUsedError;
  List<TagProductModel>? get tags => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CategoryResponseDataCopyWith<CategoryResponseData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CategoryResponseDataCopyWith<$Res> {
  factory $CategoryResponseDataCopyWith(CategoryResponseData value,
          $Res Function(CategoryResponseData) then) =
      _$CategoryResponseDataCopyWithImpl<$Res, CategoryResponseData>;
  @useResult
  $Res call(
      {int status, List<CategoryModel> data, List<TagProductModel>? tags});
}

/// @nodoc
class _$CategoryResponseDataCopyWithImpl<$Res,
        $Val extends CategoryResponseData>
    implements $CategoryResponseDataCopyWith<$Res> {
  _$CategoryResponseDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? data = null,
    Object? tags = freezed,
  }) {
    return _then(_value.copyWith(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as int,
      data: null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as List<CategoryModel>,
      tags: freezed == tags
          ? _value.tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<TagProductModel>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CategoryResponseDataImplCopyWith<$Res>
    implements $CategoryResponseDataCopyWith<$Res> {
  factory _$$CategoryResponseDataImplCopyWith(_$CategoryResponseDataImpl value,
          $Res Function(_$CategoryResponseDataImpl) then) =
      __$$CategoryResponseDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int status, List<CategoryModel> data, List<TagProductModel>? tags});
}

/// @nodoc
class __$$CategoryResponseDataImplCopyWithImpl<$Res>
    extends _$CategoryResponseDataCopyWithImpl<$Res, _$CategoryResponseDataImpl>
    implements _$$CategoryResponseDataImplCopyWith<$Res> {
  __$$CategoryResponseDataImplCopyWithImpl(_$CategoryResponseDataImpl _value,
      $Res Function(_$CategoryResponseDataImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? data = null,
    Object? tags = freezed,
  }) {
    return _then(_$CategoryResponseDataImpl(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as int,
      data: null == data
          ? _value._data
          : data // ignore: cast_nullable_to_non_nullable
              as List<CategoryModel>,
      tags: freezed == tags
          ? _value._tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<TagProductModel>?,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class _$CategoryResponseDataImpl
    with DiagnosticableTreeMixin
    implements _CategoryResponseData {
  const _$CategoryResponseDataImpl(
      {required this.status,
      required final List<CategoryModel> data,
      final List<TagProductModel>? tags})
      : _data = data,
        _tags = tags;

  factory _$CategoryResponseDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$CategoryResponseDataImplFromJson(json);

  @override
  final int status;
  final List<CategoryModel> _data;
  @override
  List<CategoryModel> get data {
    if (_data is EqualUnmodifiableListView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_data);
  }

  final List<TagProductModel>? _tags;
  @override
  List<TagProductModel>? get tags {
    final value = _tags;
    if (value == null) return null;
    if (_tags is EqualUnmodifiableListView) return _tags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'CategoryResponseData(status: $status, data: $data, tags: $tags)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'CategoryResponseData'))
      ..add(DiagnosticsProperty('status', status))
      ..add(DiagnosticsProperty('data', data))
      ..add(DiagnosticsProperty('tags', tags));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CategoryResponseDataImpl &&
            (identical(other.status, status) || other.status == status) &&
            const DeepCollectionEquality().equals(other._data, _data) &&
            const DeepCollectionEquality().equals(other._tags, _tags));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      status,
      const DeepCollectionEquality().hash(_data),
      const DeepCollectionEquality().hash(_tags));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CategoryResponseDataImplCopyWith<_$CategoryResponseDataImpl>
      get copyWith =>
          __$$CategoryResponseDataImplCopyWithImpl<_$CategoryResponseDataImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CategoryResponseDataImplToJson(
      this,
    );
  }
}

abstract class _CategoryResponseData implements CategoryResponseData {
  const factory _CategoryResponseData(
      {required final int status,
      required final List<CategoryModel> data,
      final List<TagProductModel>? tags}) = _$CategoryResponseDataImpl;

  factory _CategoryResponseData.fromJson(Map<String, dynamic> json) =
      _$CategoryResponseDataImpl.fromJson;

  @override
  int get status;
  @override
  List<CategoryModel> get data;
  @override
  List<TagProductModel>? get tags;
  @override
  @JsonKey(ignore: true)
  _$$CategoryResponseDataImplCopyWith<_$CategoryResponseDataImpl>
      get copyWith => throw _privateConstructorUsedError;
}
