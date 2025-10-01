// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'combo_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ComboItemModel _$ComboItemModelFromJson(Map<String, dynamic> json) {
  return _ComboItemModel.fromJson(json);
}

/// @nodoc
mixin _$ComboItemModel {
  int? get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get nameEn => throw _privateConstructorUsedError;
  String get image => throw _privateConstructorUsedError;
  int get quantity => throw _privateConstructorUsedError;

  /// check trường này
  int? get printerType => throw _privateConstructorUsedError;

  /// check trường này
  String get unit => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ComboItemModelCopyWith<ComboItemModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ComboItemModelCopyWith<$Res> {
  factory $ComboItemModelCopyWith(
          ComboItemModel value, $Res Function(ComboItemModel) then) =
      _$ComboItemModelCopyWithImpl<$Res, ComboItemModel>;
  @useResult
  $Res call(
      {int? id,
      String name,
      String nameEn,
      String image,
      int quantity,
      int? printerType,
      String unit});
}

/// @nodoc
class _$ComboItemModelCopyWithImpl<$Res, $Val extends ComboItemModel>
    implements $ComboItemModelCopyWith<$Res> {
  _$ComboItemModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = null,
    Object? nameEn = null,
    Object? image = null,
    Object? quantity = null,
    Object? printerType = freezed,
    Object? unit = null,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      nameEn: null == nameEn
          ? _value.nameEn
          : nameEn // ignore: cast_nullable_to_non_nullable
              as String,
      image: null == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String,
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as int,
      printerType: freezed == printerType
          ? _value.printerType
          : printerType // ignore: cast_nullable_to_non_nullable
              as int?,
      unit: null == unit
          ? _value.unit
          : unit // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ComboItemModelImplCopyWith<$Res>
    implements $ComboItemModelCopyWith<$Res> {
  factory _$$ComboItemModelImplCopyWith(_$ComboItemModelImpl value,
          $Res Function(_$ComboItemModelImpl) then) =
      __$$ComboItemModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? id,
      String name,
      String nameEn,
      String image,
      int quantity,
      int? printerType,
      String unit});
}

/// @nodoc
class __$$ComboItemModelImplCopyWithImpl<$Res>
    extends _$ComboItemModelCopyWithImpl<$Res, _$ComboItemModelImpl>
    implements _$$ComboItemModelImplCopyWith<$Res> {
  __$$ComboItemModelImplCopyWithImpl(
      _$ComboItemModelImpl _value, $Res Function(_$ComboItemModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = null,
    Object? nameEn = null,
    Object? image = null,
    Object? quantity = null,
    Object? printerType = freezed,
    Object? unit = null,
  }) {
    return _then(_$ComboItemModelImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      nameEn: null == nameEn
          ? _value.nameEn
          : nameEn // ignore: cast_nullable_to_non_nullable
              as String,
      image: null == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String,
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as int,
      printerType: freezed == printerType
          ? _value.printerType
          : printerType // ignore: cast_nullable_to_non_nullable
              as int?,
      unit: null == unit
          ? _value.unit
          : unit // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class _$ComboItemModelImpl extends _ComboItemModel
    with DiagnosticableTreeMixin {
  const _$ComboItemModelImpl(
      {this.id,
      this.name = '',
      this.nameEn = '',
      this.image = '',
      this.quantity = 1,
      this.printerType,
      this.unit = ''})
      : super._();

  factory _$ComboItemModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ComboItemModelImplFromJson(json);

  @override
  final int? id;
  @override
  @JsonKey()
  final String name;
  @override
  @JsonKey()
  final String nameEn;
  @override
  @JsonKey()
  final String image;
  @override
  @JsonKey()
  final int quantity;

  /// check trường này
  @override
  final int? printerType;

  /// check trường này
  @override
  @JsonKey()
  final String unit;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ComboItemModel(id: $id, name: $name, nameEn: $nameEn, image: $image, quantity: $quantity, printerType: $printerType, unit: $unit)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'ComboItemModel'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('name', name))
      ..add(DiagnosticsProperty('nameEn', nameEn))
      ..add(DiagnosticsProperty('image', image))
      ..add(DiagnosticsProperty('quantity', quantity))
      ..add(DiagnosticsProperty('printerType', printerType))
      ..add(DiagnosticsProperty('unit', unit));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ComboItemModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.nameEn, nameEn) || other.nameEn == nameEn) &&
            (identical(other.image, image) || other.image == image) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity) &&
            (identical(other.printerType, printerType) ||
                other.printerType == printerType) &&
            (identical(other.unit, unit) || other.unit == unit));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, name, nameEn, image, quantity, printerType, unit);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ComboItemModelImplCopyWith<_$ComboItemModelImpl> get copyWith =>
      __$$ComboItemModelImplCopyWithImpl<_$ComboItemModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ComboItemModelImplToJson(
      this,
    );
  }
}

abstract class _ComboItemModel extends ComboItemModel {
  const factory _ComboItemModel(
      {final int? id,
      final String name,
      final String nameEn,
      final String image,
      final int quantity,
      final int? printerType,
      final String unit}) = _$ComboItemModelImpl;
  const _ComboItemModel._() : super._();

  factory _ComboItemModel.fromJson(Map<String, dynamic> json) =
      _$ComboItemModelImpl.fromJson;

  @override
  int? get id;
  @override
  String get name;
  @override
  String get nameEn;
  @override
  String get image;
  @override
  int get quantity;
  @override

  /// check trường này
  int? get printerType;
  @override

  /// check trường này
  String get unit;
  @override
  @JsonKey(ignore: true)
  _$$ComboItemModelImplCopyWith<_$ComboItemModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
