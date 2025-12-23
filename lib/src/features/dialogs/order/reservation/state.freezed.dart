// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ReservationSectionState {
  ReservationModel? get reservationSelect => throw _privateConstructorUsedError;
  ReservationModel? get reservationInit => throw _privateConstructorUsedError;
  String get textSearch => throw _privateConstructorUsedError;
  TypeOrderEnum? get typeOrder => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ReservationSectionStateCopyWith<ReservationSectionState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReservationSectionStateCopyWith<$Res> {
  factory $ReservationSectionStateCopyWith(ReservationSectionState value,
          $Res Function(ReservationSectionState) then) =
      _$ReservationSectionStateCopyWithImpl<$Res, ReservationSectionState>;
  @useResult
  $Res call(
      {ReservationModel? reservationSelect,
      ReservationModel? reservationInit,
      String textSearch,
      TypeOrderEnum? typeOrder});

  $ReservationModelCopyWith<$Res>? get reservationSelect;
  $ReservationModelCopyWith<$Res>? get reservationInit;
}

/// @nodoc
class _$ReservationSectionStateCopyWithImpl<$Res,
        $Val extends ReservationSectionState>
    implements $ReservationSectionStateCopyWith<$Res> {
  _$ReservationSectionStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? reservationSelect = freezed,
    Object? reservationInit = freezed,
    Object? textSearch = null,
    Object? typeOrder = freezed,
  }) {
    return _then(_value.copyWith(
      reservationSelect: freezed == reservationSelect
          ? _value.reservationSelect
          : reservationSelect // ignore: cast_nullable_to_non_nullable
              as ReservationModel?,
      reservationInit: freezed == reservationInit
          ? _value.reservationInit
          : reservationInit // ignore: cast_nullable_to_non_nullable
              as ReservationModel?,
      textSearch: null == textSearch
          ? _value.textSearch
          : textSearch // ignore: cast_nullable_to_non_nullable
              as String,
      typeOrder: freezed == typeOrder
          ? _value.typeOrder
          : typeOrder // ignore: cast_nullable_to_non_nullable
              as TypeOrderEnum?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $ReservationModelCopyWith<$Res>? get reservationSelect {
    if (_value.reservationSelect == null) {
      return null;
    }

    return $ReservationModelCopyWith<$Res>(_value.reservationSelect!, (value) {
      return _then(_value.copyWith(reservationSelect: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $ReservationModelCopyWith<$Res>? get reservationInit {
    if (_value.reservationInit == null) {
      return null;
    }

    return $ReservationModelCopyWith<$Res>(_value.reservationInit!, (value) {
      return _then(_value.copyWith(reservationInit: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ReservationSectionStateImplCopyWith<$Res>
    implements $ReservationSectionStateCopyWith<$Res> {
  factory _$$ReservationSectionStateImplCopyWith(
          _$ReservationSectionStateImpl value,
          $Res Function(_$ReservationSectionStateImpl) then) =
      __$$ReservationSectionStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {ReservationModel? reservationSelect,
      ReservationModel? reservationInit,
      String textSearch,
      TypeOrderEnum? typeOrder});

  @override
  $ReservationModelCopyWith<$Res>? get reservationSelect;
  @override
  $ReservationModelCopyWith<$Res>? get reservationInit;
}

/// @nodoc
class __$$ReservationSectionStateImplCopyWithImpl<$Res>
    extends _$ReservationSectionStateCopyWithImpl<$Res,
        _$ReservationSectionStateImpl>
    implements _$$ReservationSectionStateImplCopyWith<$Res> {
  __$$ReservationSectionStateImplCopyWithImpl(
      _$ReservationSectionStateImpl _value,
      $Res Function(_$ReservationSectionStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? reservationSelect = freezed,
    Object? reservationInit = freezed,
    Object? textSearch = null,
    Object? typeOrder = freezed,
  }) {
    return _then(_$ReservationSectionStateImpl(
      reservationSelect: freezed == reservationSelect
          ? _value.reservationSelect
          : reservationSelect // ignore: cast_nullable_to_non_nullable
              as ReservationModel?,
      reservationInit: freezed == reservationInit
          ? _value.reservationInit
          : reservationInit // ignore: cast_nullable_to_non_nullable
              as ReservationModel?,
      textSearch: null == textSearch
          ? _value.textSearch
          : textSearch // ignore: cast_nullable_to_non_nullable
              as String,
      typeOrder: freezed == typeOrder
          ? _value.typeOrder
          : typeOrder // ignore: cast_nullable_to_non_nullable
              as TypeOrderEnum?,
    ));
  }
}

/// @nodoc

class _$ReservationSectionStateImpl implements _ReservationSectionState {
  const _$ReservationSectionStateImpl(
      {this.reservationSelect,
      this.reservationInit,
      this.textSearch = '',
      this.typeOrder});

  @override
  final ReservationModel? reservationSelect;
  @override
  final ReservationModel? reservationInit;
  @override
  @JsonKey()
  final String textSearch;
  @override
  final TypeOrderEnum? typeOrder;

  @override
  String toString() {
    return 'ReservationSectionState(reservationSelect: $reservationSelect, reservationInit: $reservationInit, textSearch: $textSearch, typeOrder: $typeOrder)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ReservationSectionStateImpl &&
            (identical(other.reservationSelect, reservationSelect) ||
                other.reservationSelect == reservationSelect) &&
            (identical(other.reservationInit, reservationInit) ||
                other.reservationInit == reservationInit) &&
            (identical(other.textSearch, textSearch) ||
                other.textSearch == textSearch) &&
            (identical(other.typeOrder, typeOrder) ||
                other.typeOrder == typeOrder));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, reservationSelect, reservationInit, textSearch, typeOrder);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ReservationSectionStateImplCopyWith<_$ReservationSectionStateImpl>
      get copyWith => __$$ReservationSectionStateImplCopyWithImpl<
          _$ReservationSectionStateImpl>(this, _$identity);
}

abstract class _ReservationSectionState implements ReservationSectionState {
  const factory _ReservationSectionState(
      {final ReservationModel? reservationSelect,
      final ReservationModel? reservationInit,
      final String textSearch,
      final TypeOrderEnum? typeOrder}) = _$ReservationSectionStateImpl;

  @override
  ReservationModel? get reservationSelect;
  @override
  ReservationModel? get reservationInit;
  @override
  String get textSearch;
  @override
  TypeOrderEnum? get typeOrder;
  @override
  @JsonKey(ignore: true)
  _$$ReservationSectionStateImplCopyWith<_$ReservationSectionStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
