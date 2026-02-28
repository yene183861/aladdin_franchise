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
mixin _$CreateNewOrderDialogState {
  Set<TableModel> get tableSelect =>
      throw _privateConstructorUsedError; // @Default([]) List<int> tableIds,
  CreateNewOrderTabEnum get tabSelect => throw _privateConstructorUsedError;
  ReservationModel? get reservationSelect =>
      throw _privateConstructorUsedError; // @Default(false) bool notifyReservation,
// @Default([]) List<ReservationModel> reservationsAssginTable,
// @Default(false) bool ignoreNotifyReservation,
  TypeOrderEnum? get typeOrder =>
      throw _privateConstructorUsedError; // @Default(false) bool useReservation,
  /// có hiện thông báo lịch đặt k
  bool get notifyReservation => throw _privateConstructorUsedError;

  /// ds các lịch đặt bàn (status = accept + [now; now + 30p]) ứng với ds bàn đang chọn
  List<ReservationModel> get holdingReservations =>
      throw _privateConstructorUsedError;

  /// bỏ qua hiển thị hộp thoại nhắc nhở có lịch đặt
  bool get ignoreReservationWarning => throw _privateConstructorUsedError;
  bool get useReservation => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $CreateNewOrderDialogStateCopyWith<CreateNewOrderDialogState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CreateNewOrderDialogStateCopyWith<$Res> {
  factory $CreateNewOrderDialogStateCopyWith(CreateNewOrderDialogState value,
          $Res Function(CreateNewOrderDialogState) then) =
      _$CreateNewOrderDialogStateCopyWithImpl<$Res, CreateNewOrderDialogState>;
  @useResult
  $Res call(
      {Set<TableModel> tableSelect,
      CreateNewOrderTabEnum tabSelect,
      ReservationModel? reservationSelect,
      TypeOrderEnum? typeOrder,
      bool notifyReservation,
      List<ReservationModel> holdingReservations,
      bool ignoreReservationWarning,
      bool useReservation});

  $ReservationModelCopyWith<$Res>? get reservationSelect;
}

/// @nodoc
class _$CreateNewOrderDialogStateCopyWithImpl<$Res,
        $Val extends CreateNewOrderDialogState>
    implements $CreateNewOrderDialogStateCopyWith<$Res> {
  _$CreateNewOrderDialogStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tableSelect = null,
    Object? tabSelect = null,
    Object? reservationSelect = freezed,
    Object? typeOrder = freezed,
    Object? notifyReservation = null,
    Object? holdingReservations = null,
    Object? ignoreReservationWarning = null,
    Object? useReservation = null,
  }) {
    return _then(_value.copyWith(
      tableSelect: null == tableSelect
          ? _value.tableSelect
          : tableSelect // ignore: cast_nullable_to_non_nullable
              as Set<TableModel>,
      tabSelect: null == tabSelect
          ? _value.tabSelect
          : tabSelect // ignore: cast_nullable_to_non_nullable
              as CreateNewOrderTabEnum,
      reservationSelect: freezed == reservationSelect
          ? _value.reservationSelect
          : reservationSelect // ignore: cast_nullable_to_non_nullable
              as ReservationModel?,
      typeOrder: freezed == typeOrder
          ? _value.typeOrder
          : typeOrder // ignore: cast_nullable_to_non_nullable
              as TypeOrderEnum?,
      notifyReservation: null == notifyReservation
          ? _value.notifyReservation
          : notifyReservation // ignore: cast_nullable_to_non_nullable
              as bool,
      holdingReservations: null == holdingReservations
          ? _value.holdingReservations
          : holdingReservations // ignore: cast_nullable_to_non_nullable
              as List<ReservationModel>,
      ignoreReservationWarning: null == ignoreReservationWarning
          ? _value.ignoreReservationWarning
          : ignoreReservationWarning // ignore: cast_nullable_to_non_nullable
              as bool,
      useReservation: null == useReservation
          ? _value.useReservation
          : useReservation // ignore: cast_nullable_to_non_nullable
              as bool,
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
}

/// @nodoc
abstract class _$$CreateNewOrderDialogStateImplCopyWith<$Res>
    implements $CreateNewOrderDialogStateCopyWith<$Res> {
  factory _$$CreateNewOrderDialogStateImplCopyWith(
          _$CreateNewOrderDialogStateImpl value,
          $Res Function(_$CreateNewOrderDialogStateImpl) then) =
      __$$CreateNewOrderDialogStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {Set<TableModel> tableSelect,
      CreateNewOrderTabEnum tabSelect,
      ReservationModel? reservationSelect,
      TypeOrderEnum? typeOrder,
      bool notifyReservation,
      List<ReservationModel> holdingReservations,
      bool ignoreReservationWarning,
      bool useReservation});

  @override
  $ReservationModelCopyWith<$Res>? get reservationSelect;
}

/// @nodoc
class __$$CreateNewOrderDialogStateImplCopyWithImpl<$Res>
    extends _$CreateNewOrderDialogStateCopyWithImpl<$Res,
        _$CreateNewOrderDialogStateImpl>
    implements _$$CreateNewOrderDialogStateImplCopyWith<$Res> {
  __$$CreateNewOrderDialogStateImplCopyWithImpl(
      _$CreateNewOrderDialogStateImpl _value,
      $Res Function(_$CreateNewOrderDialogStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tableSelect = null,
    Object? tabSelect = null,
    Object? reservationSelect = freezed,
    Object? typeOrder = freezed,
    Object? notifyReservation = null,
    Object? holdingReservations = null,
    Object? ignoreReservationWarning = null,
    Object? useReservation = null,
  }) {
    return _then(_$CreateNewOrderDialogStateImpl(
      tableSelect: null == tableSelect
          ? _value._tableSelect
          : tableSelect // ignore: cast_nullable_to_non_nullable
              as Set<TableModel>,
      tabSelect: null == tabSelect
          ? _value.tabSelect
          : tabSelect // ignore: cast_nullable_to_non_nullable
              as CreateNewOrderTabEnum,
      reservationSelect: freezed == reservationSelect
          ? _value.reservationSelect
          : reservationSelect // ignore: cast_nullable_to_non_nullable
              as ReservationModel?,
      typeOrder: freezed == typeOrder
          ? _value.typeOrder
          : typeOrder // ignore: cast_nullable_to_non_nullable
              as TypeOrderEnum?,
      notifyReservation: null == notifyReservation
          ? _value.notifyReservation
          : notifyReservation // ignore: cast_nullable_to_non_nullable
              as bool,
      holdingReservations: null == holdingReservations
          ? _value._holdingReservations
          : holdingReservations // ignore: cast_nullable_to_non_nullable
              as List<ReservationModel>,
      ignoreReservationWarning: null == ignoreReservationWarning
          ? _value.ignoreReservationWarning
          : ignoreReservationWarning // ignore: cast_nullable_to_non_nullable
              as bool,
      useReservation: null == useReservation
          ? _value.useReservation
          : useReservation // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$CreateNewOrderDialogStateImpl implements _CreateNewOrderDialogState {
  const _$CreateNewOrderDialogStateImpl(
      {final Set<TableModel> tableSelect = const {},
      this.tabSelect = CreateNewOrderTabEnum.table,
      this.reservationSelect,
      this.typeOrder,
      this.notifyReservation = false,
      final List<ReservationModel> holdingReservations = const [],
      this.ignoreReservationWarning = false,
      this.useReservation = false})
      : _tableSelect = tableSelect,
        _holdingReservations = holdingReservations;

  final Set<TableModel> _tableSelect;
  @override
  @JsonKey()
  Set<TableModel> get tableSelect {
    if (_tableSelect is EqualUnmodifiableSetView) return _tableSelect;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableSetView(_tableSelect);
  }

// @Default([]) List<int> tableIds,
  @override
  @JsonKey()
  final CreateNewOrderTabEnum tabSelect;
  @override
  final ReservationModel? reservationSelect;
// @Default(false) bool notifyReservation,
// @Default([]) List<ReservationModel> reservationsAssginTable,
// @Default(false) bool ignoreNotifyReservation,
  @override
  final TypeOrderEnum? typeOrder;
// @Default(false) bool useReservation,
  /// có hiện thông báo lịch đặt k
  @override
  @JsonKey()
  final bool notifyReservation;

  /// ds các lịch đặt bàn (status = accept + [now; now + 30p]) ứng với ds bàn đang chọn
  final List<ReservationModel> _holdingReservations;

  /// ds các lịch đặt bàn (status = accept + [now; now + 30p]) ứng với ds bàn đang chọn
  @override
  @JsonKey()
  List<ReservationModel> get holdingReservations {
    if (_holdingReservations is EqualUnmodifiableListView)
      return _holdingReservations;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_holdingReservations);
  }

  /// bỏ qua hiển thị hộp thoại nhắc nhở có lịch đặt
  @override
  @JsonKey()
  final bool ignoreReservationWarning;
  @override
  @JsonKey()
  final bool useReservation;

  @override
  String toString() {
    return 'CreateNewOrderDialogState(tableSelect: $tableSelect, tabSelect: $tabSelect, reservationSelect: $reservationSelect, typeOrder: $typeOrder, notifyReservation: $notifyReservation, holdingReservations: $holdingReservations, ignoreReservationWarning: $ignoreReservationWarning, useReservation: $useReservation)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CreateNewOrderDialogStateImpl &&
            const DeepCollectionEquality()
                .equals(other._tableSelect, _tableSelect) &&
            (identical(other.tabSelect, tabSelect) ||
                other.tabSelect == tabSelect) &&
            (identical(other.reservationSelect, reservationSelect) ||
                other.reservationSelect == reservationSelect) &&
            (identical(other.typeOrder, typeOrder) ||
                other.typeOrder == typeOrder) &&
            (identical(other.notifyReservation, notifyReservation) ||
                other.notifyReservation == notifyReservation) &&
            const DeepCollectionEquality()
                .equals(other._holdingReservations, _holdingReservations) &&
            (identical(
                    other.ignoreReservationWarning, ignoreReservationWarning) ||
                other.ignoreReservationWarning == ignoreReservationWarning) &&
            (identical(other.useReservation, useReservation) ||
                other.useReservation == useReservation));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_tableSelect),
      tabSelect,
      reservationSelect,
      typeOrder,
      notifyReservation,
      const DeepCollectionEquality().hash(_holdingReservations),
      ignoreReservationWarning,
      useReservation);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CreateNewOrderDialogStateImplCopyWith<_$CreateNewOrderDialogStateImpl>
      get copyWith => __$$CreateNewOrderDialogStateImplCopyWithImpl<
          _$CreateNewOrderDialogStateImpl>(this, _$identity);
}

abstract class _CreateNewOrderDialogState implements CreateNewOrderDialogState {
  const factory _CreateNewOrderDialogState(
      {final Set<TableModel> tableSelect,
      final CreateNewOrderTabEnum tabSelect,
      final ReservationModel? reservationSelect,
      final TypeOrderEnum? typeOrder,
      final bool notifyReservation,
      final List<ReservationModel> holdingReservations,
      final bool ignoreReservationWarning,
      final bool useReservation}) = _$CreateNewOrderDialogStateImpl;

  @override
  Set<TableModel> get tableSelect;
  @override // @Default([]) List<int> tableIds,
  CreateNewOrderTabEnum get tabSelect;
  @override
  ReservationModel? get reservationSelect;
  @override // @Default(false) bool notifyReservation,
// @Default([]) List<ReservationModel> reservationsAssginTable,
// @Default(false) bool ignoreNotifyReservation,
  TypeOrderEnum? get typeOrder;
  @override // @Default(false) bool useReservation,
  /// có hiện thông báo lịch đặt k
  bool get notifyReservation;
  @override

  /// ds các lịch đặt bàn (status = accept + [now; now + 30p]) ứng với ds bàn đang chọn
  List<ReservationModel> get holdingReservations;
  @override

  /// bỏ qua hiển thị hộp thoại nhắc nhở có lịch đặt
  bool get ignoreReservationWarning;
  @override
  bool get useReservation;
  @override
  @JsonKey(ignore: true)
  _$$CreateNewOrderDialogStateImplCopyWith<_$CreateNewOrderDialogStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
