// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'id_card.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$IDCardModel {
  String get id => throw _privateConstructorUsedError;
  String get firstName => throw _privateConstructorUsedError;
  String get lastName => throw _privateConstructorUsedError;
  DateTime get dob => throw _privateConstructorUsedError;
  String get gender => throw _privateConstructorUsedError;
  String get address => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $IDCardModelCopyWith<IDCardModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $IDCardModelCopyWith<$Res> {
  factory $IDCardModelCopyWith(
          IDCardModel value, $Res Function(IDCardModel) then) =
      _$IDCardModelCopyWithImpl<$Res, IDCardModel>;
  @useResult
  $Res call(
      {String id,
      String firstName,
      String lastName,
      DateTime dob,
      String gender,
      String address});
}

/// @nodoc
class _$IDCardModelCopyWithImpl<$Res, $Val extends IDCardModel>
    implements $IDCardModelCopyWith<$Res> {
  _$IDCardModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? firstName = null,
    Object? lastName = null,
    Object? dob = null,
    Object? gender = null,
    Object? address = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      firstName: null == firstName
          ? _value.firstName
          : firstName // ignore: cast_nullable_to_non_nullable
              as String,
      lastName: null == lastName
          ? _value.lastName
          : lastName // ignore: cast_nullable_to_non_nullable
              as String,
      dob: null == dob
          ? _value.dob
          : dob // ignore: cast_nullable_to_non_nullable
              as DateTime,
      gender: null == gender
          ? _value.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as String,
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$IDCardModelImplCopyWith<$Res>
    implements $IDCardModelCopyWith<$Res> {
  factory _$$IDCardModelImplCopyWith(
          _$IDCardModelImpl value, $Res Function(_$IDCardModelImpl) then) =
      __$$IDCardModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String firstName,
      String lastName,
      DateTime dob,
      String gender,
      String address});
}

/// @nodoc
class __$$IDCardModelImplCopyWithImpl<$Res>
    extends _$IDCardModelCopyWithImpl<$Res, _$IDCardModelImpl>
    implements _$$IDCardModelImplCopyWith<$Res> {
  __$$IDCardModelImplCopyWithImpl(
      _$IDCardModelImpl _value, $Res Function(_$IDCardModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? firstName = null,
    Object? lastName = null,
    Object? dob = null,
    Object? gender = null,
    Object? address = null,
  }) {
    return _then(_$IDCardModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      firstName: null == firstName
          ? _value.firstName
          : firstName // ignore: cast_nullable_to_non_nullable
              as String,
      lastName: null == lastName
          ? _value.lastName
          : lastName // ignore: cast_nullable_to_non_nullable
              as String,
      dob: null == dob
          ? _value.dob
          : dob // ignore: cast_nullable_to_non_nullable
              as DateTime,
      gender: null == gender
          ? _value.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as String,
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _$IDCardModelImpl with DiagnosticableTreeMixin implements _IDCardModel {
  const _$IDCardModelImpl(
      {required this.id,
      required this.firstName,
      required this.lastName,
      required this.dob,
      required this.gender,
      required this.address});

  @override
  final String id;
  @override
  final String firstName;
  @override
  final String lastName;
  @override
  final DateTime dob;
  @override
  final String gender;
  @override
  final String address;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'IDCardModel(id: $id, firstName: $firstName, lastName: $lastName, dob: $dob, gender: $gender, address: $address)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'IDCardModel'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('firstName', firstName))
      ..add(DiagnosticsProperty('lastName', lastName))
      ..add(DiagnosticsProperty('dob', dob))
      ..add(DiagnosticsProperty('gender', gender))
      ..add(DiagnosticsProperty('address', address));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$IDCardModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.firstName, firstName) ||
                other.firstName == firstName) &&
            (identical(other.lastName, lastName) ||
                other.lastName == lastName) &&
            (identical(other.dob, dob) || other.dob == dob) &&
            (identical(other.gender, gender) || other.gender == gender) &&
            (identical(other.address, address) || other.address == address));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, id, firstName, lastName, dob, gender, address);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$IDCardModelImplCopyWith<_$IDCardModelImpl> get copyWith =>
      __$$IDCardModelImplCopyWithImpl<_$IDCardModelImpl>(this, _$identity);
}

abstract class _IDCardModel implements IDCardModel {
  const factory _IDCardModel(
      {required final String id,
      required final String firstName,
      required final String lastName,
      required final DateTime dob,
      required final String gender,
      required final String address}) = _$IDCardModelImpl;

  @override
  String get id;
  @override
  String get firstName;
  @override
  String get lastName;
  @override
  DateTime get dob;
  @override
  String get gender;
  @override
  String get address;
  @override
  @JsonKey(ignore: true)
  _$$IDCardModelImplCopyWith<_$IDCardModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
