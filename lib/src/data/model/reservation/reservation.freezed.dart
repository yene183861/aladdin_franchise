// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'reservation.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ReservationModel _$ReservationModelFromJson(Map<String, dynamic> json) {
  return _ReservationModel.fromJson(json);
}

/// @nodoc
mixin _$ReservationModel {
  dynamic get id => throw _privateConstructorUsedError;
  ReservationCustomerModel? get customer => throw _privateConstructorUsedError;
  @JsonKey(fromJson: ParsingUtils.parseInt)
  int get status => throw _privateConstructorUsedError;
  String get statusName => throw _privateConstructorUsedError;
  String get reservationDate => throw _privateConstructorUsedError;
  String get startTime => throw _privateConstructorUsedError;
  String get endTime => throw _privateConstructorUsedError;
  String? get table => throw _privateConstructorUsedError;
  @JsonKey(fromJson: ParsingUtils.parseBool)
  bool get isOnline => throw _privateConstructorUsedError;
  @JsonKey(fromJson: ParsingUtils.parseListInt)
  List<int>? get tableId => throw _privateConstructorUsedError;
  String? get saleName => throw _privateConstructorUsedError;
  String? get saleCode => throw _privateConstructorUsedError;
  bool get isUpdate => throw _privateConstructorUsedError;
  @JsonKey(includeFromJson: false, includeToJson: false)
  Map<String, dynamic>? get rawData => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ReservationModelCopyWith<ReservationModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReservationModelCopyWith<$Res> {
  factory $ReservationModelCopyWith(
          ReservationModel value, $Res Function(ReservationModel) then) =
      _$ReservationModelCopyWithImpl<$Res, ReservationModel>;
  @useResult
  $Res call(
      {dynamic id,
      ReservationCustomerModel? customer,
      @JsonKey(fromJson: ParsingUtils.parseInt) int status,
      String statusName,
      String reservationDate,
      String startTime,
      String endTime,
      String? table,
      @JsonKey(fromJson: ParsingUtils.parseBool) bool isOnline,
      @JsonKey(fromJson: ParsingUtils.parseListInt) List<int>? tableId,
      String? saleName,
      String? saleCode,
      bool isUpdate,
      @JsonKey(includeFromJson: false, includeToJson: false)
      Map<String, dynamic>? rawData});

  $ReservationCustomerModelCopyWith<$Res>? get customer;
}

/// @nodoc
class _$ReservationModelCopyWithImpl<$Res, $Val extends ReservationModel>
    implements $ReservationModelCopyWith<$Res> {
  _$ReservationModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? customer = freezed,
    Object? status = null,
    Object? statusName = null,
    Object? reservationDate = null,
    Object? startTime = null,
    Object? endTime = null,
    Object? table = freezed,
    Object? isOnline = null,
    Object? tableId = freezed,
    Object? saleName = freezed,
    Object? saleCode = freezed,
    Object? isUpdate = null,
    Object? rawData = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as dynamic,
      customer: freezed == customer
          ? _value.customer
          : customer // ignore: cast_nullable_to_non_nullable
              as ReservationCustomerModel?,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as int,
      statusName: null == statusName
          ? _value.statusName
          : statusName // ignore: cast_nullable_to_non_nullable
              as String,
      reservationDate: null == reservationDate
          ? _value.reservationDate
          : reservationDate // ignore: cast_nullable_to_non_nullable
              as String,
      startTime: null == startTime
          ? _value.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as String,
      endTime: null == endTime
          ? _value.endTime
          : endTime // ignore: cast_nullable_to_non_nullable
              as String,
      table: freezed == table
          ? _value.table
          : table // ignore: cast_nullable_to_non_nullable
              as String?,
      isOnline: null == isOnline
          ? _value.isOnline
          : isOnline // ignore: cast_nullable_to_non_nullable
              as bool,
      tableId: freezed == tableId
          ? _value.tableId
          : tableId // ignore: cast_nullable_to_non_nullable
              as List<int>?,
      saleName: freezed == saleName
          ? _value.saleName
          : saleName // ignore: cast_nullable_to_non_nullable
              as String?,
      saleCode: freezed == saleCode
          ? _value.saleCode
          : saleCode // ignore: cast_nullable_to_non_nullable
              as String?,
      isUpdate: null == isUpdate
          ? _value.isUpdate
          : isUpdate // ignore: cast_nullable_to_non_nullable
              as bool,
      rawData: freezed == rawData
          ? _value.rawData
          : rawData // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $ReservationCustomerModelCopyWith<$Res>? get customer {
    if (_value.customer == null) {
      return null;
    }

    return $ReservationCustomerModelCopyWith<$Res>(_value.customer!, (value) {
      return _then(_value.copyWith(customer: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ReservationModelImplCopyWith<$Res>
    implements $ReservationModelCopyWith<$Res> {
  factory _$$ReservationModelImplCopyWith(_$ReservationModelImpl value,
          $Res Function(_$ReservationModelImpl) then) =
      __$$ReservationModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {dynamic id,
      ReservationCustomerModel? customer,
      @JsonKey(fromJson: ParsingUtils.parseInt) int status,
      String statusName,
      String reservationDate,
      String startTime,
      String endTime,
      String? table,
      @JsonKey(fromJson: ParsingUtils.parseBool) bool isOnline,
      @JsonKey(fromJson: ParsingUtils.parseListInt) List<int>? tableId,
      String? saleName,
      String? saleCode,
      bool isUpdate,
      @JsonKey(includeFromJson: false, includeToJson: false)
      Map<String, dynamic>? rawData});

  @override
  $ReservationCustomerModelCopyWith<$Res>? get customer;
}

/// @nodoc
class __$$ReservationModelImplCopyWithImpl<$Res>
    extends _$ReservationModelCopyWithImpl<$Res, _$ReservationModelImpl>
    implements _$$ReservationModelImplCopyWith<$Res> {
  __$$ReservationModelImplCopyWithImpl(_$ReservationModelImpl _value,
      $Res Function(_$ReservationModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? customer = freezed,
    Object? status = null,
    Object? statusName = null,
    Object? reservationDate = null,
    Object? startTime = null,
    Object? endTime = null,
    Object? table = freezed,
    Object? isOnline = null,
    Object? tableId = freezed,
    Object? saleName = freezed,
    Object? saleCode = freezed,
    Object? isUpdate = null,
    Object? rawData = freezed,
  }) {
    return _then(_$ReservationModelImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as dynamic,
      customer: freezed == customer
          ? _value.customer
          : customer // ignore: cast_nullable_to_non_nullable
              as ReservationCustomerModel?,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as int,
      statusName: null == statusName
          ? _value.statusName
          : statusName // ignore: cast_nullable_to_non_nullable
              as String,
      reservationDate: null == reservationDate
          ? _value.reservationDate
          : reservationDate // ignore: cast_nullable_to_non_nullable
              as String,
      startTime: null == startTime
          ? _value.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as String,
      endTime: null == endTime
          ? _value.endTime
          : endTime // ignore: cast_nullable_to_non_nullable
              as String,
      table: freezed == table
          ? _value.table
          : table // ignore: cast_nullable_to_non_nullable
              as String?,
      isOnline: null == isOnline
          ? _value.isOnline
          : isOnline // ignore: cast_nullable_to_non_nullable
              as bool,
      tableId: freezed == tableId
          ? _value._tableId
          : tableId // ignore: cast_nullable_to_non_nullable
              as List<int>?,
      saleName: freezed == saleName
          ? _value.saleName
          : saleName // ignore: cast_nullable_to_non_nullable
              as String?,
      saleCode: freezed == saleCode
          ? _value.saleCode
          : saleCode // ignore: cast_nullable_to_non_nullable
              as String?,
      isUpdate: null == isUpdate
          ? _value.isUpdate
          : isUpdate // ignore: cast_nullable_to_non_nullable
              as bool,
      rawData: freezed == rawData
          ? _value._rawData
          : rawData // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class _$ReservationModelImpl extends _ReservationModel {
  _$ReservationModelImpl(
      {this.id,
      this.customer,
      @JsonKey(fromJson: ParsingUtils.parseInt) this.status = 1,
      this.statusName = '',
      this.reservationDate = '2026-01-01',
      this.startTime = '08:00',
      this.endTime = '10:00',
      this.table,
      @JsonKey(fromJson: ParsingUtils.parseBool) this.isOnline = false,
      @JsonKey(fromJson: ParsingUtils.parseListInt)
      final List<int>? tableId = const [],
      this.saleName,
      this.saleCode,
      this.isUpdate = false,
      @JsonKey(includeFromJson: false, includeToJson: false)
      final Map<String, dynamic>? rawData})
      : _tableId = tableId,
        _rawData = rawData,
        super._();

  factory _$ReservationModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ReservationModelImplFromJson(json);

  @override
  final dynamic id;
  @override
  final ReservationCustomerModel? customer;
  @override
  @JsonKey(fromJson: ParsingUtils.parseInt)
  final int status;
  @override
  @JsonKey()
  final String statusName;
  @override
  @JsonKey()
  final String reservationDate;
  @override
  @JsonKey()
  final String startTime;
  @override
  @JsonKey()
  final String endTime;
  @override
  final String? table;
  @override
  @JsonKey(fromJson: ParsingUtils.parseBool)
  final bool isOnline;
  final List<int>? _tableId;
  @override
  @JsonKey(fromJson: ParsingUtils.parseListInt)
  List<int>? get tableId {
    final value = _tableId;
    if (value == null) return null;
    if (_tableId is EqualUnmodifiableListView) return _tableId;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final String? saleName;
  @override
  final String? saleCode;
  @override
  @JsonKey()
  final bool isUpdate;
  final Map<String, dynamic>? _rawData;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  Map<String, dynamic>? get rawData {
    final value = _rawData;
    if (value == null) return null;
    if (_rawData is EqualUnmodifiableMapView) return _rawData;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  String toString() {
    return 'ReservationModel(id: $id, customer: $customer, status: $status, statusName: $statusName, reservationDate: $reservationDate, startTime: $startTime, endTime: $endTime, table: $table, isOnline: $isOnline, tableId: $tableId, saleName: $saleName, saleCode: $saleCode, isUpdate: $isUpdate, rawData: $rawData)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ReservationModelImpl &&
            const DeepCollectionEquality().equals(other.id, id) &&
            (identical(other.customer, customer) ||
                other.customer == customer) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.statusName, statusName) ||
                other.statusName == statusName) &&
            (identical(other.reservationDate, reservationDate) ||
                other.reservationDate == reservationDate) &&
            (identical(other.startTime, startTime) ||
                other.startTime == startTime) &&
            (identical(other.endTime, endTime) || other.endTime == endTime) &&
            (identical(other.table, table) || other.table == table) &&
            (identical(other.isOnline, isOnline) ||
                other.isOnline == isOnline) &&
            const DeepCollectionEquality().equals(other._tableId, _tableId) &&
            (identical(other.saleName, saleName) ||
                other.saleName == saleName) &&
            (identical(other.saleCode, saleCode) ||
                other.saleCode == saleCode) &&
            (identical(other.isUpdate, isUpdate) ||
                other.isUpdate == isUpdate) &&
            const DeepCollectionEquality().equals(other._rawData, _rawData));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      customer,
      status,
      statusName,
      reservationDate,
      startTime,
      endTime,
      table,
      isOnline,
      const DeepCollectionEquality().hash(_tableId),
      saleName,
      saleCode,
      isUpdate,
      const DeepCollectionEquality().hash(_rawData));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ReservationModelImplCopyWith<_$ReservationModelImpl> get copyWith =>
      __$$ReservationModelImplCopyWithImpl<_$ReservationModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ReservationModelImplToJson(
      this,
    );
  }
}

abstract class _ReservationModel extends ReservationModel {
  factory _ReservationModel(
      {final dynamic id,
      final ReservationCustomerModel? customer,
      @JsonKey(fromJson: ParsingUtils.parseInt) final int status,
      final String statusName,
      final String reservationDate,
      final String startTime,
      final String endTime,
      final String? table,
      @JsonKey(fromJson: ParsingUtils.parseBool) final bool isOnline,
      @JsonKey(fromJson: ParsingUtils.parseListInt) final List<int>? tableId,
      final String? saleName,
      final String? saleCode,
      final bool isUpdate,
      @JsonKey(includeFromJson: false, includeToJson: false)
      final Map<String, dynamic>? rawData}) = _$ReservationModelImpl;
  _ReservationModel._() : super._();

  factory _ReservationModel.fromJson(Map<String, dynamic> json) =
      _$ReservationModelImpl.fromJson;

  @override
  dynamic get id;
  @override
  ReservationCustomerModel? get customer;
  @override
  @JsonKey(fromJson: ParsingUtils.parseInt)
  int get status;
  @override
  String get statusName;
  @override
  String get reservationDate;
  @override
  String get startTime;
  @override
  String get endTime;
  @override
  String? get table;
  @override
  @JsonKey(fromJson: ParsingUtils.parseBool)
  bool get isOnline;
  @override
  @JsonKey(fromJson: ParsingUtils.parseListInt)
  List<int>? get tableId;
  @override
  String? get saleName;
  @override
  String? get saleCode;
  @override
  bool get isUpdate;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  Map<String, dynamic>? get rawData;
  @override
  @JsonKey(ignore: true)
  _$$ReservationModelImplCopyWith<_$ReservationModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
