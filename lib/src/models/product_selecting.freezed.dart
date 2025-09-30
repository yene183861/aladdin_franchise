// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'product_selecting.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ProductSelectingModel _$ProductSelectingModelFromJson(
    Map<String, dynamic> json) {
  return _ProductSelectingModel.fromJson(json);
}

/// @nodoc
mixin _$ProductSelectingModel {
  int get orderId => throw _privateConstructorUsedError;
  List<ProductModel> get products => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ProductSelectingModelCopyWith<ProductSelectingModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProductSelectingModelCopyWith<$Res> {
  factory $ProductSelectingModelCopyWith(ProductSelectingModel value,
          $Res Function(ProductSelectingModel) then) =
      _$ProductSelectingModelCopyWithImpl<$Res, ProductSelectingModel>;
  @useResult
  $Res call({int orderId, List<ProductModel> products});
}

/// @nodoc
class _$ProductSelectingModelCopyWithImpl<$Res,
        $Val extends ProductSelectingModel>
    implements $ProductSelectingModelCopyWith<$Res> {
  _$ProductSelectingModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? orderId = null,
    Object? products = null,
  }) {
    return _then(_value.copyWith(
      orderId: null == orderId
          ? _value.orderId
          : orderId // ignore: cast_nullable_to_non_nullable
              as int,
      products: null == products
          ? _value.products
          : products // ignore: cast_nullable_to_non_nullable
              as List<ProductModel>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ProductSelectingModelImplCopyWith<$Res>
    implements $ProductSelectingModelCopyWith<$Res> {
  factory _$$ProductSelectingModelImplCopyWith(
          _$ProductSelectingModelImpl value,
          $Res Function(_$ProductSelectingModelImpl) then) =
      __$$ProductSelectingModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int orderId, List<ProductModel> products});
}

/// @nodoc
class __$$ProductSelectingModelImplCopyWithImpl<$Res>
    extends _$ProductSelectingModelCopyWithImpl<$Res,
        _$ProductSelectingModelImpl>
    implements _$$ProductSelectingModelImplCopyWith<$Res> {
  __$$ProductSelectingModelImplCopyWithImpl(_$ProductSelectingModelImpl _value,
      $Res Function(_$ProductSelectingModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? orderId = null,
    Object? products = null,
  }) {
    return _then(_$ProductSelectingModelImpl(
      orderId: null == orderId
          ? _value.orderId
          : orderId // ignore: cast_nullable_to_non_nullable
              as int,
      products: null == products
          ? _value._products
          : products // ignore: cast_nullable_to_non_nullable
              as List<ProductModel>,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class _$ProductSelectingModelImpl
    with DiagnosticableTreeMixin
    implements _ProductSelectingModel {
  const _$ProductSelectingModelImpl(
      {required this.orderId, required final List<ProductModel> products})
      : _products = products;

  factory _$ProductSelectingModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProductSelectingModelImplFromJson(json);

  @override
  final int orderId;
  final List<ProductModel> _products;
  @override
  List<ProductModel> get products {
    if (_products is EqualUnmodifiableListView) return _products;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_products);
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ProductSelectingModel(orderId: $orderId, products: $products)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'ProductSelectingModel'))
      ..add(DiagnosticsProperty('orderId', orderId))
      ..add(DiagnosticsProperty('products', products));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProductSelectingModelImpl &&
            (identical(other.orderId, orderId) || other.orderId == orderId) &&
            const DeepCollectionEquality().equals(other._products, _products));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, orderId, const DeepCollectionEquality().hash(_products));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ProductSelectingModelImplCopyWith<_$ProductSelectingModelImpl>
      get copyWith => __$$ProductSelectingModelImplCopyWithImpl<
          _$ProductSelectingModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ProductSelectingModelImplToJson(
      this,
    );
  }
}

abstract class _ProductSelectingModel implements ProductSelectingModel {
  const factory _ProductSelectingModel(
          {required final int orderId,
          required final List<ProductModel> products}) =
      _$ProductSelectingModelImpl;

  factory _ProductSelectingModel.fromJson(Map<String, dynamic> json) =
      _$ProductSelectingModelImpl.fromJson;

  @override
  int get orderId;
  @override
  List<ProductModel> get products;
  @override
  @JsonKey(ignore: true)
  _$$ProductSelectingModelImplCopyWith<_$ProductSelectingModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}
