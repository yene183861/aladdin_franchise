// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'product_cancel.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ProductCancelModel _$ProductCancelModelFromJson(Map<String, dynamic> json) {
  return _ProductCancelModel.fromJson(json);
}

/// @nodoc
mixin _$ProductCancelModel {
  int get id => throw _privateConstructorUsedError;
  int get menuItemId => throw _privateConstructorUsedError;
  int get quantity => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get note => throw _privateConstructorUsedError;
  String get nameEn => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ProductCancelModelCopyWith<ProductCancelModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProductCancelModelCopyWith<$Res> {
  factory $ProductCancelModelCopyWith(
          ProductCancelModel value, $Res Function(ProductCancelModel) then) =
      _$ProductCancelModelCopyWithImpl<$Res, ProductCancelModel>;
  @useResult
  $Res call(
      {int id,
      int menuItemId,
      int quantity,
      String name,
      String note,
      String nameEn});
}

/// @nodoc
class _$ProductCancelModelCopyWithImpl<$Res, $Val extends ProductCancelModel>
    implements $ProductCancelModelCopyWith<$Res> {
  _$ProductCancelModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? menuItemId = null,
    Object? quantity = null,
    Object? name = null,
    Object? note = null,
    Object? nameEn = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      menuItemId: null == menuItemId
          ? _value.menuItemId
          : menuItemId // ignore: cast_nullable_to_non_nullable
              as int,
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      note: null == note
          ? _value.note
          : note // ignore: cast_nullable_to_non_nullable
              as String,
      nameEn: null == nameEn
          ? _value.nameEn
          : nameEn // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ProductCancelModelImplCopyWith<$Res>
    implements $ProductCancelModelCopyWith<$Res> {
  factory _$$ProductCancelModelImplCopyWith(_$ProductCancelModelImpl value,
          $Res Function(_$ProductCancelModelImpl) then) =
      __$$ProductCancelModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      int menuItemId,
      int quantity,
      String name,
      String note,
      String nameEn});
}

/// @nodoc
class __$$ProductCancelModelImplCopyWithImpl<$Res>
    extends _$ProductCancelModelCopyWithImpl<$Res, _$ProductCancelModelImpl>
    implements _$$ProductCancelModelImplCopyWith<$Res> {
  __$$ProductCancelModelImplCopyWithImpl(_$ProductCancelModelImpl _value,
      $Res Function(_$ProductCancelModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? menuItemId = null,
    Object? quantity = null,
    Object? name = null,
    Object? note = null,
    Object? nameEn = null,
  }) {
    return _then(_$ProductCancelModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      menuItemId: null == menuItemId
          ? _value.menuItemId
          : menuItemId // ignore: cast_nullable_to_non_nullable
              as int,
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      note: null == note
          ? _value.note
          : note // ignore: cast_nullable_to_non_nullable
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
class _$ProductCancelModelImpl extends _ProductCancelModel
    with DiagnosticableTreeMixin {
  const _$ProductCancelModelImpl(
      {required this.id,
      required this.menuItemId,
      this.quantity = 0,
      this.name = '',
      this.note = '',
      this.nameEn = ''})
      : super._();

  factory _$ProductCancelModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProductCancelModelImplFromJson(json);

  @override
  final int id;
  @override
  final int menuItemId;
  @override
  @JsonKey()
  final int quantity;
  @override
  @JsonKey()
  final String name;
  @override
  @JsonKey()
  final String note;
  @override
  @JsonKey()
  final String nameEn;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ProductCancelModel(id: $id, menuItemId: $menuItemId, quantity: $quantity, name: $name, note: $note, nameEn: $nameEn)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'ProductCancelModel'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('menuItemId', menuItemId))
      ..add(DiagnosticsProperty('quantity', quantity))
      ..add(DiagnosticsProperty('name', name))
      ..add(DiagnosticsProperty('note', note))
      ..add(DiagnosticsProperty('nameEn', nameEn));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProductCancelModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.menuItemId, menuItemId) ||
                other.menuItemId == menuItemId) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.note, note) || other.note == note) &&
            (identical(other.nameEn, nameEn) || other.nameEn == nameEn));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, menuItemId, quantity, name, note, nameEn);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ProductCancelModelImplCopyWith<_$ProductCancelModelImpl> get copyWith =>
      __$$ProductCancelModelImplCopyWithImpl<_$ProductCancelModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ProductCancelModelImplToJson(
      this,
    );
  }
}

abstract class _ProductCancelModel extends ProductCancelModel {
  const factory _ProductCancelModel(
      {required final int id,
      required final int menuItemId,
      final int quantity,
      final String name,
      final String note,
      final String nameEn}) = _$ProductCancelModelImpl;
  const _ProductCancelModel._() : super._();

  factory _ProductCancelModel.fromJson(Map<String, dynamic> json) =
      _$ProductCancelModelImpl.fromJson;

  @override
  int get id;
  @override
  int get menuItemId;
  @override
  int get quantity;
  @override
  String get name;
  @override
  String get note;
  @override
  String get nameEn;
  @override
  @JsonKey(ignore: true)
  _$$ProductCancelModelImplCopyWith<_$ProductCancelModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
