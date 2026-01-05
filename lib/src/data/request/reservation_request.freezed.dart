// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'reservation_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ReservationRequestModel _$ReservationRequestModelFromJson(
    Map<String, dynamic> json) {
  return _ReservationRequestModel.fromJson(json);
}

/// @nodoc
mixin _$ReservationRequestModel {
  int get restaurantId => throw _privateConstructorUsedError;
  @JsonKey(toJson: ParsingUtils.formatDateTime)
  DateTime get reservationDateStart => throw _privateConstructorUsedError;
  @JsonKey(toJson: ParsingUtils.formatDateTime)
  DateTime get reservationDateEnd => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ReservationRequestModelCopyWith<ReservationRequestModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReservationRequestModelCopyWith<$Res> {
  factory $ReservationRequestModelCopyWith(ReservationRequestModel value,
          $Res Function(ReservationRequestModel) then) =
      _$ReservationRequestModelCopyWithImpl<$Res, ReservationRequestModel>;
  @useResult
  $Res call(
      {int restaurantId,
      @JsonKey(toJson: ParsingUtils.formatDateTime)
      DateTime reservationDateStart,
      @JsonKey(toJson: ParsingUtils.formatDateTime)
      DateTime reservationDateEnd});
}

/// @nodoc
class _$ReservationRequestModelCopyWithImpl<$Res,
        $Val extends ReservationRequestModel>
    implements $ReservationRequestModelCopyWith<$Res> {
  _$ReservationRequestModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? restaurantId = null,
    Object? reservationDateStart = null,
    Object? reservationDateEnd = null,
  }) {
    return _then(_value.copyWith(
      restaurantId: null == restaurantId
          ? _value.restaurantId
          : restaurantId // ignore: cast_nullable_to_non_nullable
              as int,
      reservationDateStart: null == reservationDateStart
          ? _value.reservationDateStart
          : reservationDateStart // ignore: cast_nullable_to_non_nullable
              as DateTime,
      reservationDateEnd: null == reservationDateEnd
          ? _value.reservationDateEnd
          : reservationDateEnd // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ReservationRequestModelImplCopyWith<$Res>
    implements $ReservationRequestModelCopyWith<$Res> {
  factory _$$ReservationRequestModelImplCopyWith(
          _$ReservationRequestModelImpl value,
          $Res Function(_$ReservationRequestModelImpl) then) =
      __$$ReservationRequestModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int restaurantId,
      @JsonKey(toJson: ParsingUtils.formatDateTime)
      DateTime reservationDateStart,
      @JsonKey(toJson: ParsingUtils.formatDateTime)
      DateTime reservationDateEnd});
}

/// @nodoc
class __$$ReservationRequestModelImplCopyWithImpl<$Res>
    extends _$ReservationRequestModelCopyWithImpl<$Res,
        _$ReservationRequestModelImpl>
    implements _$$ReservationRequestModelImplCopyWith<$Res> {
  __$$ReservationRequestModelImplCopyWithImpl(
      _$ReservationRequestModelImpl _value,
      $Res Function(_$ReservationRequestModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? restaurantId = null,
    Object? reservationDateStart = null,
    Object? reservationDateEnd = null,
  }) {
    return _then(_$ReservationRequestModelImpl(
      restaurantId: null == restaurantId
          ? _value.restaurantId
          : restaurantId // ignore: cast_nullable_to_non_nullable
              as int,
      reservationDateStart: null == reservationDateStart
          ? _value.reservationDateStart
          : reservationDateStart // ignore: cast_nullable_to_non_nullable
              as DateTime,
      reservationDateEnd: null == reservationDateEnd
          ? _value.reservationDateEnd
          : reservationDateEnd // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class _$ReservationRequestModelImpl extends _ReservationRequestModel {
  _$ReservationRequestModelImpl(
      {required this.restaurantId,
      @JsonKey(toJson: ParsingUtils.formatDateTime)
      required this.reservationDateStart,
      @JsonKey(toJson: ParsingUtils.formatDateTime)
      required this.reservationDateEnd})
      : super._();

  factory _$ReservationRequestModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ReservationRequestModelImplFromJson(json);

  @override
  final int restaurantId;
  @override
  @JsonKey(toJson: ParsingUtils.formatDateTime)
  final DateTime reservationDateStart;
  @override
  @JsonKey(toJson: ParsingUtils.formatDateTime)
  final DateTime reservationDateEnd;

  @override
  String toString() {
    return 'ReservationRequestModel(restaurantId: $restaurantId, reservationDateStart: $reservationDateStart, reservationDateEnd: $reservationDateEnd)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ReservationRequestModelImpl &&
            (identical(other.restaurantId, restaurantId) ||
                other.restaurantId == restaurantId) &&
            (identical(other.reservationDateStart, reservationDateStart) ||
                other.reservationDateStart == reservationDateStart) &&
            (identical(other.reservationDateEnd, reservationDateEnd) ||
                other.reservationDateEnd == reservationDateEnd));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, restaurantId, reservationDateStart, reservationDateEnd);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ReservationRequestModelImplCopyWith<_$ReservationRequestModelImpl>
      get copyWith => __$$ReservationRequestModelImplCopyWithImpl<
          _$ReservationRequestModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ReservationRequestModelImplToJson(
      this,
    );
  }
}

abstract class _ReservationRequestModel extends ReservationRequestModel {
  factory _ReservationRequestModel(
          {required final int restaurantId,
          @JsonKey(toJson: ParsingUtils.formatDateTime)
          required final DateTime reservationDateStart,
          @JsonKey(toJson: ParsingUtils.formatDateTime)
          required final DateTime reservationDateEnd}) =
      _$ReservationRequestModelImpl;
  _ReservationRequestModel._() : super._();

  factory _ReservationRequestModel.fromJson(Map<String, dynamic> json) =
      _$ReservationRequestModelImpl.fromJson;

  @override
  int get restaurantId;
  @override
  @JsonKey(toJson: ParsingUtils.formatDateTime)
  DateTime get reservationDateStart;
  @override
  @JsonKey(toJson: ParsingUtils.formatDateTime)
  DateTime get reservationDateEnd;
  @override
  @JsonKey(ignore: true)
  _$$ReservationRequestModelImplCopyWith<_$ReservationRequestModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}
