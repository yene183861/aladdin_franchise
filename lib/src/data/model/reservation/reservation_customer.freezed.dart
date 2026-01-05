// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'reservation_customer.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ReservationCustomerModel _$ReservationCustomerModelFromJson(
    Map<String, dynamic> json) {
  return _ReservationCustomerModel.fromJson(json);
}

/// @nodoc
mixin _$ReservationCustomerModel {
  dynamic get id => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  String? get phoneNumber => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ReservationCustomerModelCopyWith<ReservationCustomerModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReservationCustomerModelCopyWith<$Res> {
  factory $ReservationCustomerModelCopyWith(ReservationCustomerModel value,
          $Res Function(ReservationCustomerModel) then) =
      _$ReservationCustomerModelCopyWithImpl<$Res, ReservationCustomerModel>;
  @useResult
  $Res call({dynamic id, String? name, String? phoneNumber});
}

/// @nodoc
class _$ReservationCustomerModelCopyWithImpl<$Res,
        $Val extends ReservationCustomerModel>
    implements $ReservationCustomerModelCopyWith<$Res> {
  _$ReservationCustomerModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? phoneNumber = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as dynamic,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      phoneNumber: freezed == phoneNumber
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ReservationCustomerModelImplCopyWith<$Res>
    implements $ReservationCustomerModelCopyWith<$Res> {
  factory _$$ReservationCustomerModelImplCopyWith(
          _$ReservationCustomerModelImpl value,
          $Res Function(_$ReservationCustomerModelImpl) then) =
      __$$ReservationCustomerModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({dynamic id, String? name, String? phoneNumber});
}

/// @nodoc
class __$$ReservationCustomerModelImplCopyWithImpl<$Res>
    extends _$ReservationCustomerModelCopyWithImpl<$Res,
        _$ReservationCustomerModelImpl>
    implements _$$ReservationCustomerModelImplCopyWith<$Res> {
  __$$ReservationCustomerModelImplCopyWithImpl(
      _$ReservationCustomerModelImpl _value,
      $Res Function(_$ReservationCustomerModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? phoneNumber = freezed,
  }) {
    return _then(_$ReservationCustomerModelImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as dynamic,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      phoneNumber: freezed == phoneNumber
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class _$ReservationCustomerModelImpl extends _ReservationCustomerModel {
  _$ReservationCustomerModelImpl({this.id, this.name, this.phoneNumber})
      : super._();

  factory _$ReservationCustomerModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ReservationCustomerModelImplFromJson(json);

  @override
  final dynamic id;
  @override
  final String? name;
  @override
  final String? phoneNumber;

  @override
  String toString() {
    return 'ReservationCustomerModel(id: $id, name: $name, phoneNumber: $phoneNumber)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ReservationCustomerModelImpl &&
            const DeepCollectionEquality().equals(other.id, id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.phoneNumber, phoneNumber) ||
                other.phoneNumber == phoneNumber));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(id), name, phoneNumber);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ReservationCustomerModelImplCopyWith<_$ReservationCustomerModelImpl>
      get copyWith => __$$ReservationCustomerModelImplCopyWithImpl<
          _$ReservationCustomerModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ReservationCustomerModelImplToJson(
      this,
    );
  }
}

abstract class _ReservationCustomerModel extends ReservationCustomerModel {
  factory _ReservationCustomerModel(
      {final dynamic id,
      final String? name,
      final String? phoneNumber}) = _$ReservationCustomerModelImpl;
  _ReservationCustomerModel._() : super._();

  factory _ReservationCustomerModel.fromJson(Map<String, dynamic> json) =
      _$ReservationCustomerModelImpl.fromJson;

  @override
  dynamic get id;
  @override
  String? get name;
  @override
  String? get phoneNumber;
  @override
  @JsonKey(ignore: true)
  _$$ReservationCustomerModelImplCopyWith<_$ReservationCustomerModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}
