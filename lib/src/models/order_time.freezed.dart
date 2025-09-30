// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'order_time.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

OrderTimeModel _$OrderTimeModelFromJson(Map<String, dynamic> json) {
  return _OrderTimeModel.fromJson(json);
}

/// @nodoc
mixin _$OrderTimeModel {
  int get orderId => throw _privateConstructorUsedError;
  List<ProductOrderTimeModel> get products =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $OrderTimeModelCopyWith<OrderTimeModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OrderTimeModelCopyWith<$Res> {
  factory $OrderTimeModelCopyWith(
          OrderTimeModel value, $Res Function(OrderTimeModel) then) =
      _$OrderTimeModelCopyWithImpl<$Res, OrderTimeModel>;
  @useResult
  $Res call({int orderId, List<ProductOrderTimeModel> products});
}

/// @nodoc
class _$OrderTimeModelCopyWithImpl<$Res, $Val extends OrderTimeModel>
    implements $OrderTimeModelCopyWith<$Res> {
  _$OrderTimeModelCopyWithImpl(this._value, this._then);

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
              as List<ProductOrderTimeModel>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$OrderTimeModelImplCopyWith<$Res>
    implements $OrderTimeModelCopyWith<$Res> {
  factory _$$OrderTimeModelImplCopyWith(_$OrderTimeModelImpl value,
          $Res Function(_$OrderTimeModelImpl) then) =
      __$$OrderTimeModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int orderId, List<ProductOrderTimeModel> products});
}

/// @nodoc
class __$$OrderTimeModelImplCopyWithImpl<$Res>
    extends _$OrderTimeModelCopyWithImpl<$Res, _$OrderTimeModelImpl>
    implements _$$OrderTimeModelImplCopyWith<$Res> {
  __$$OrderTimeModelImplCopyWithImpl(
      _$OrderTimeModelImpl _value, $Res Function(_$OrderTimeModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? orderId = null,
    Object? products = null,
  }) {
    return _then(_$OrderTimeModelImpl(
      orderId: null == orderId
          ? _value.orderId
          : orderId // ignore: cast_nullable_to_non_nullable
              as int,
      products: null == products
          ? _value._products
          : products // ignore: cast_nullable_to_non_nullable
              as List<ProductOrderTimeModel>,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class _$OrderTimeModelImpl
    with DiagnosticableTreeMixin
    implements _OrderTimeModel {
  const _$OrderTimeModelImpl(
      {required this.orderId,
      required final List<ProductOrderTimeModel> products})
      : _products = products;

  factory _$OrderTimeModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$OrderTimeModelImplFromJson(json);

  @override
  final int orderId;
  final List<ProductOrderTimeModel> _products;
  @override
  List<ProductOrderTimeModel> get products {
    if (_products is EqualUnmodifiableListView) return _products;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_products);
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'OrderTimeModel(orderId: $orderId, products: $products)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'OrderTimeModel'))
      ..add(DiagnosticsProperty('orderId', orderId))
      ..add(DiagnosticsProperty('products', products));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OrderTimeModelImpl &&
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
  _$$OrderTimeModelImplCopyWith<_$OrderTimeModelImpl> get copyWith =>
      __$$OrderTimeModelImplCopyWithImpl<_$OrderTimeModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OrderTimeModelImplToJson(
      this,
    );
  }
}

abstract class _OrderTimeModel implements OrderTimeModel {
  const factory _OrderTimeModel(
          {required final int orderId,
          required final List<ProductOrderTimeModel> products}) =
      _$OrderTimeModelImpl;

  factory _OrderTimeModel.fromJson(Map<String, dynamic> json) =
      _$OrderTimeModelImpl.fromJson;

  @override
  int get orderId;
  @override
  List<ProductOrderTimeModel> get products;
  @override
  @JsonKey(ignore: true)
  _$$OrderTimeModelImplCopyWith<_$OrderTimeModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ProductOrderTimeModel _$ProductOrderTimeModelFromJson(
    Map<String, dynamic> json) {
  return _ProductOrderTimeModel.fromJson(json);
}

/// @nodoc
mixin _$ProductOrderTimeModel {
  int get productId => throw _privateConstructorUsedError;
  int get numberOfProduct => throw _privateConstructorUsedError;
  DateTime get time => throw _privateConstructorUsedError;
  String? get note => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ProductOrderTimeModelCopyWith<ProductOrderTimeModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProductOrderTimeModelCopyWith<$Res> {
  factory $ProductOrderTimeModelCopyWith(ProductOrderTimeModel value,
          $Res Function(ProductOrderTimeModel) then) =
      _$ProductOrderTimeModelCopyWithImpl<$Res, ProductOrderTimeModel>;
  @useResult
  $Res call({int productId, int numberOfProduct, DateTime time, String? note});
}

/// @nodoc
class _$ProductOrderTimeModelCopyWithImpl<$Res,
        $Val extends ProductOrderTimeModel>
    implements $ProductOrderTimeModelCopyWith<$Res> {
  _$ProductOrderTimeModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? productId = null,
    Object? numberOfProduct = null,
    Object? time = null,
    Object? note = freezed,
  }) {
    return _then(_value.copyWith(
      productId: null == productId
          ? _value.productId
          : productId // ignore: cast_nullable_to_non_nullable
              as int,
      numberOfProduct: null == numberOfProduct
          ? _value.numberOfProduct
          : numberOfProduct // ignore: cast_nullable_to_non_nullable
              as int,
      time: null == time
          ? _value.time
          : time // ignore: cast_nullable_to_non_nullable
              as DateTime,
      note: freezed == note
          ? _value.note
          : note // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ProductOrderTimeModelImplCopyWith<$Res>
    implements $ProductOrderTimeModelCopyWith<$Res> {
  factory _$$ProductOrderTimeModelImplCopyWith(
          _$ProductOrderTimeModelImpl value,
          $Res Function(_$ProductOrderTimeModelImpl) then) =
      __$$ProductOrderTimeModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int productId, int numberOfProduct, DateTime time, String? note});
}

/// @nodoc
class __$$ProductOrderTimeModelImplCopyWithImpl<$Res>
    extends _$ProductOrderTimeModelCopyWithImpl<$Res,
        _$ProductOrderTimeModelImpl>
    implements _$$ProductOrderTimeModelImplCopyWith<$Res> {
  __$$ProductOrderTimeModelImplCopyWithImpl(_$ProductOrderTimeModelImpl _value,
      $Res Function(_$ProductOrderTimeModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? productId = null,
    Object? numberOfProduct = null,
    Object? time = null,
    Object? note = freezed,
  }) {
    return _then(_$ProductOrderTimeModelImpl(
      productId: null == productId
          ? _value.productId
          : productId // ignore: cast_nullable_to_non_nullable
              as int,
      numberOfProduct: null == numberOfProduct
          ? _value.numberOfProduct
          : numberOfProduct // ignore: cast_nullable_to_non_nullable
              as int,
      time: null == time
          ? _value.time
          : time // ignore: cast_nullable_to_non_nullable
              as DateTime,
      note: freezed == note
          ? _value.note
          : note // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class _$ProductOrderTimeModelImpl
    with DiagnosticableTreeMixin
    implements _ProductOrderTimeModel {
  const _$ProductOrderTimeModelImpl(
      {required this.productId,
      required this.numberOfProduct,
      required this.time,
      required this.note});

  factory _$ProductOrderTimeModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProductOrderTimeModelImplFromJson(json);

  @override
  final int productId;
  @override
  final int numberOfProduct;
  @override
  final DateTime time;
  @override
  final String? note;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ProductOrderTimeModel(productId: $productId, numberOfProduct: $numberOfProduct, time: $time, note: $note)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'ProductOrderTimeModel'))
      ..add(DiagnosticsProperty('productId', productId))
      ..add(DiagnosticsProperty('numberOfProduct', numberOfProduct))
      ..add(DiagnosticsProperty('time', time))
      ..add(DiagnosticsProperty('note', note));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProductOrderTimeModelImpl &&
            (identical(other.productId, productId) ||
                other.productId == productId) &&
            (identical(other.numberOfProduct, numberOfProduct) ||
                other.numberOfProduct == numberOfProduct) &&
            (identical(other.time, time) || other.time == time) &&
            (identical(other.note, note) || other.note == note));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, productId, numberOfProduct, time, note);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ProductOrderTimeModelImplCopyWith<_$ProductOrderTimeModelImpl>
      get copyWith => __$$ProductOrderTimeModelImplCopyWithImpl<
          _$ProductOrderTimeModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ProductOrderTimeModelImplToJson(
      this,
    );
  }
}

abstract class _ProductOrderTimeModel implements ProductOrderTimeModel {
  const factory _ProductOrderTimeModel(
      {required final int productId,
      required final int numberOfProduct,
      required final DateTime time,
      required final String? note}) = _$ProductOrderTimeModelImpl;

  factory _ProductOrderTimeModel.fromJson(Map<String, dynamic> json) =
      _$ProductOrderTimeModelImpl.fromJson;

  @override
  int get productId;
  @override
  int get numberOfProduct;
  @override
  DateTime get time;
  @override
  String? get note;
  @override
  @JsonKey(ignore: true)
  _$$ProductOrderTimeModelImplCopyWith<_$ProductOrderTimeModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}
