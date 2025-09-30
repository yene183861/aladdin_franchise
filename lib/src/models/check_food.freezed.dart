// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'check_food.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

CheckFoodModel _$CheckFoodModelFromJson(Map<String, dynamic> json) {
  return _CheckFoodModel.fromJson(json);
}

/// @nodoc
mixin _$CheckFoodModel {
  int get orderId => throw _privateConstructorUsedError;
  int get productId => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CheckFoodModelCopyWith<CheckFoodModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CheckFoodModelCopyWith<$Res> {
  factory $CheckFoodModelCopyWith(
          CheckFoodModel value, $Res Function(CheckFoodModel) then) =
      _$CheckFoodModelCopyWithImpl<$Res, CheckFoodModel>;
  @useResult
  $Res call({int orderId, int productId});
}

/// @nodoc
class _$CheckFoodModelCopyWithImpl<$Res, $Val extends CheckFoodModel>
    implements $CheckFoodModelCopyWith<$Res> {
  _$CheckFoodModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? orderId = null,
    Object? productId = null,
  }) {
    return _then(_value.copyWith(
      orderId: null == orderId
          ? _value.orderId
          : orderId // ignore: cast_nullable_to_non_nullable
              as int,
      productId: null == productId
          ? _value.productId
          : productId // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CheckFoodModelImplCopyWith<$Res>
    implements $CheckFoodModelCopyWith<$Res> {
  factory _$$CheckFoodModelImplCopyWith(_$CheckFoodModelImpl value,
          $Res Function(_$CheckFoodModelImpl) then) =
      __$$CheckFoodModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int orderId, int productId});
}

/// @nodoc
class __$$CheckFoodModelImplCopyWithImpl<$Res>
    extends _$CheckFoodModelCopyWithImpl<$Res, _$CheckFoodModelImpl>
    implements _$$CheckFoodModelImplCopyWith<$Res> {
  __$$CheckFoodModelImplCopyWithImpl(
      _$CheckFoodModelImpl _value, $Res Function(_$CheckFoodModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? orderId = null,
    Object? productId = null,
  }) {
    return _then(_$CheckFoodModelImpl(
      orderId: null == orderId
          ? _value.orderId
          : orderId // ignore: cast_nullable_to_non_nullable
              as int,
      productId: null == productId
          ? _value.productId
          : productId // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class _$CheckFoodModelImpl
    with DiagnosticableTreeMixin
    implements _CheckFoodModel {
  const _$CheckFoodModelImpl({required this.orderId, required this.productId});

  factory _$CheckFoodModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$CheckFoodModelImplFromJson(json);

  @override
  final int orderId;
  @override
  final int productId;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'CheckFoodModel(orderId: $orderId, productId: $productId)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'CheckFoodModel'))
      ..add(DiagnosticsProperty('orderId', orderId))
      ..add(DiagnosticsProperty('productId', productId));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CheckFoodModelImpl &&
            (identical(other.orderId, orderId) || other.orderId == orderId) &&
            (identical(other.productId, productId) ||
                other.productId == productId));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, orderId, productId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CheckFoodModelImplCopyWith<_$CheckFoodModelImpl> get copyWith =>
      __$$CheckFoodModelImplCopyWithImpl<_$CheckFoodModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CheckFoodModelImplToJson(
      this,
    );
  }
}

abstract class _CheckFoodModel implements CheckFoodModel {
  const factory _CheckFoodModel(
      {required final int orderId,
      required final int productId}) = _$CheckFoodModelImpl;

  factory _CheckFoodModel.fromJson(Map<String, dynamic> json) =
      _$CheckFoodModelImpl.fromJson;

  @override
  int get orderId;
  @override
  int get productId;
  @override
  @JsonKey(ignore: true)
  _$$CheckFoodModelImplCopyWith<_$CheckFoodModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
