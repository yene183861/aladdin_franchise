// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'product.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ProductResponse _$ProductResponseFromJson(Map<String, dynamic> json) {
  return _ProductResponse.fromJson(json);
}

/// @nodoc
mixin _$ProductResponse {
  ProductResponseData get data => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ProductResponseCopyWith<ProductResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProductResponseCopyWith<$Res> {
  factory $ProductResponseCopyWith(
          ProductResponse value, $Res Function(ProductResponse) then) =
      _$ProductResponseCopyWithImpl<$Res, ProductResponse>;
  @useResult
  $Res call({ProductResponseData data});

  $ProductResponseDataCopyWith<$Res> get data;
}

/// @nodoc
class _$ProductResponseCopyWithImpl<$Res, $Val extends ProductResponse>
    implements $ProductResponseCopyWith<$Res> {
  _$ProductResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = null,
  }) {
    return _then(_value.copyWith(
      data: null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as ProductResponseData,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $ProductResponseDataCopyWith<$Res> get data {
    return $ProductResponseDataCopyWith<$Res>(_value.data, (value) {
      return _then(_value.copyWith(data: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ProductResponseImplCopyWith<$Res>
    implements $ProductResponseCopyWith<$Res> {
  factory _$$ProductResponseImplCopyWith(_$ProductResponseImpl value,
          $Res Function(_$ProductResponseImpl) then) =
      __$$ProductResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({ProductResponseData data});

  @override
  $ProductResponseDataCopyWith<$Res> get data;
}

/// @nodoc
class __$$ProductResponseImplCopyWithImpl<$Res>
    extends _$ProductResponseCopyWithImpl<$Res, _$ProductResponseImpl>
    implements _$$ProductResponseImplCopyWith<$Res> {
  __$$ProductResponseImplCopyWithImpl(
      _$ProductResponseImpl _value, $Res Function(_$ProductResponseImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = null,
  }) {
    return _then(_$ProductResponseImpl(
      data: null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as ProductResponseData,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class _$ProductResponseImpl
    with DiagnosticableTreeMixin
    implements _ProductResponse {
  const _$ProductResponseImpl({required this.data});

  factory _$ProductResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProductResponseImplFromJson(json);

  @override
  final ProductResponseData data;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ProductResponse(data: $data)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'ProductResponse'))
      ..add(DiagnosticsProperty('data', data));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProductResponseImpl &&
            (identical(other.data, data) || other.data == data));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, data);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ProductResponseImplCopyWith<_$ProductResponseImpl> get copyWith =>
      __$$ProductResponseImplCopyWithImpl<_$ProductResponseImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ProductResponseImplToJson(
      this,
    );
  }
}

abstract class _ProductResponse implements ProductResponse {
  const factory _ProductResponse({required final ProductResponseData data}) =
      _$ProductResponseImpl;

  factory _ProductResponse.fromJson(Map<String, dynamic> json) =
      _$ProductResponseImpl.fromJson;

  @override
  ProductResponseData get data;
  @override
  @JsonKey(ignore: true)
  _$$ProductResponseImplCopyWith<_$ProductResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ProductResponseData _$ProductResponseDataFromJson(Map<String, dynamic> json) {
  return _ProductResponseData.fromJson(json);
}

/// @nodoc
mixin _$ProductResponseData {
  int get status => throw _privateConstructorUsedError;
  List<ProductModel>? get data => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ProductResponseDataCopyWith<ProductResponseData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProductResponseDataCopyWith<$Res> {
  factory $ProductResponseDataCopyWith(
          ProductResponseData value, $Res Function(ProductResponseData) then) =
      _$ProductResponseDataCopyWithImpl<$Res, ProductResponseData>;
  @useResult
  $Res call({int status, List<ProductModel>? data});
}

/// @nodoc
class _$ProductResponseDataCopyWithImpl<$Res, $Val extends ProductResponseData>
    implements $ProductResponseDataCopyWith<$Res> {
  _$ProductResponseDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? data = freezed,
  }) {
    return _then(_value.copyWith(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as int,
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as List<ProductModel>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ProductResponseDataImplCopyWith<$Res>
    implements $ProductResponseDataCopyWith<$Res> {
  factory _$$ProductResponseDataImplCopyWith(_$ProductResponseDataImpl value,
          $Res Function(_$ProductResponseDataImpl) then) =
      __$$ProductResponseDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int status, List<ProductModel>? data});
}

/// @nodoc
class __$$ProductResponseDataImplCopyWithImpl<$Res>
    extends _$ProductResponseDataCopyWithImpl<$Res, _$ProductResponseDataImpl>
    implements _$$ProductResponseDataImplCopyWith<$Res> {
  __$$ProductResponseDataImplCopyWithImpl(_$ProductResponseDataImpl _value,
      $Res Function(_$ProductResponseDataImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? data = freezed,
  }) {
    return _then(_$ProductResponseDataImpl(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as int,
      data: freezed == data
          ? _value._data
          : data // ignore: cast_nullable_to_non_nullable
              as List<ProductModel>?,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class _$ProductResponseDataImpl
    with DiagnosticableTreeMixin
    implements _ProductResponseData {
  const _$ProductResponseDataImpl(
      {required this.status, final List<ProductModel>? data})
      : _data = data;

  factory _$ProductResponseDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProductResponseDataImplFromJson(json);

  @override
  final int status;
  final List<ProductModel>? _data;
  @override
  List<ProductModel>? get data {
    final value = _data;
    if (value == null) return null;
    if (_data is EqualUnmodifiableListView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ProductResponseData(status: $status, data: $data)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'ProductResponseData'))
      ..add(DiagnosticsProperty('status', status))
      ..add(DiagnosticsProperty('data', data));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProductResponseDataImpl &&
            (identical(other.status, status) || other.status == status) &&
            const DeepCollectionEquality().equals(other._data, _data));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, status, const DeepCollectionEquality().hash(_data));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ProductResponseDataImplCopyWith<_$ProductResponseDataImpl> get copyWith =>
      __$$ProductResponseDataImplCopyWithImpl<_$ProductResponseDataImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ProductResponseDataImplToJson(
      this,
    );
  }
}

abstract class _ProductResponseData implements ProductResponseData {
  const factory _ProductResponseData(
      {required final int status,
      final List<ProductModel>? data}) = _$ProductResponseDataImpl;

  factory _ProductResponseData.fromJson(Map<String, dynamic> json) =
      _$ProductResponseDataImpl.fromJson;

  @override
  int get status;
  @override
  List<ProductModel>? get data;
  @override
  @JsonKey(ignore: true)
  _$$ProductResponseDataImplCopyWith<_$ProductResponseDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
