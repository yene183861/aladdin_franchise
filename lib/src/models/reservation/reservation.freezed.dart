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
  @JsonKey(fromJson: numberFromDataString)
  int get status => throw _privateConstructorUsedError;
  String get statusName => throw _privateConstructorUsedError;

  /// format yyyy-MM-dd
  String get reservationDate => throw _privateConstructorUsedError;

  /// format: 20:00
  String get startTime => throw _privateConstructorUsedError;

  /// format: 20:00
  String get endTime => throw _privateConstructorUsedError;
  String? get table => throw _privateConstructorUsedError;
  @JsonKey(fromJson: numberFromDataString)
  int get guest => throw _privateConstructorUsedError; //
  @JsonKey(fromJson: numberFromDataString)
  int? get amountAdult => throw _privateConstructorUsedError;
  @JsonKey(fromJson: numberFromDataString)
  int? get amountChildren => throw _privateConstructorUsedError;
  @JsonKey(fromJson: boolFromDataString)
  bool get hasBirthday => throw _privateConstructorUsedError;
  String? get rejectReason => throw _privateConstructorUsedError;

  /// true là đặt mang về, fasle nhà ăn tại nhà hàng
  @JsonKey(fromJson: boolFromDataString)
  bool get isOnline => throw _privateConstructorUsedError;
  @JsonKey(fromJson: listIntFromDataString)
  List<int>? get tableId => throw _privateConstructorUsedError;
  String? get infoOrder =>
      throw _privateConstructorUsedError; //// true là tạo từ sale... false là tạo từ lễ tân
  @JsonKey(fromJson: boolFromDataString)
  bool get fromSale => throw _privateConstructorUsedError;
  String? get note => throw _privateConstructorUsedError;

  /// trường này chỉ sử dụng cho update, true - thay đổi ngày sang ngày khác, false - ngược lại
  @JsonKey(fromJson: boolFromDataString)
  bool? get isUpdate => throw _privateConstructorUsedError;

  /// cho việc make đơn bàn
  String? get saleName => throw _privateConstructorUsedError;
  String? get saleCode => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;

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
      @JsonKey(fromJson: numberFromDataString) int status,
      String statusName,
      String reservationDate,
      String startTime,
      String endTime,
      String? table,
      @JsonKey(fromJson: numberFromDataString) int guest,
      @JsonKey(fromJson: numberFromDataString) int? amountAdult,
      @JsonKey(fromJson: numberFromDataString) int? amountChildren,
      @JsonKey(fromJson: boolFromDataString) bool hasBirthday,
      String? rejectReason,
      @JsonKey(fromJson: boolFromDataString) bool isOnline,
      @JsonKey(fromJson: listIntFromDataString) List<int>? tableId,
      String? infoOrder,
      @JsonKey(fromJson: boolFromDataString) bool fromSale,
      String? note,
      @JsonKey(fromJson: boolFromDataString) bool? isUpdate,
      String? saleName,
      String? saleCode,
      DateTime? createdAt});

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
    Object? guest = null,
    Object? amountAdult = freezed,
    Object? amountChildren = freezed,
    Object? hasBirthday = null,
    Object? rejectReason = freezed,
    Object? isOnline = null,
    Object? tableId = freezed,
    Object? infoOrder = freezed,
    Object? fromSale = null,
    Object? note = freezed,
    Object? isUpdate = freezed,
    Object? saleName = freezed,
    Object? saleCode = freezed,
    Object? createdAt = freezed,
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
      guest: null == guest
          ? _value.guest
          : guest // ignore: cast_nullable_to_non_nullable
              as int,
      amountAdult: freezed == amountAdult
          ? _value.amountAdult
          : amountAdult // ignore: cast_nullable_to_non_nullable
              as int?,
      amountChildren: freezed == amountChildren
          ? _value.amountChildren
          : amountChildren // ignore: cast_nullable_to_non_nullable
              as int?,
      hasBirthday: null == hasBirthday
          ? _value.hasBirthday
          : hasBirthday // ignore: cast_nullable_to_non_nullable
              as bool,
      rejectReason: freezed == rejectReason
          ? _value.rejectReason
          : rejectReason // ignore: cast_nullable_to_non_nullable
              as String?,
      isOnline: null == isOnline
          ? _value.isOnline
          : isOnline // ignore: cast_nullable_to_non_nullable
              as bool,
      tableId: freezed == tableId
          ? _value.tableId
          : tableId // ignore: cast_nullable_to_non_nullable
              as List<int>?,
      infoOrder: freezed == infoOrder
          ? _value.infoOrder
          : infoOrder // ignore: cast_nullable_to_non_nullable
              as String?,
      fromSale: null == fromSale
          ? _value.fromSale
          : fromSale // ignore: cast_nullable_to_non_nullable
              as bool,
      note: freezed == note
          ? _value.note
          : note // ignore: cast_nullable_to_non_nullable
              as String?,
      isUpdate: freezed == isUpdate
          ? _value.isUpdate
          : isUpdate // ignore: cast_nullable_to_non_nullable
              as bool?,
      saleName: freezed == saleName
          ? _value.saleName
          : saleName // ignore: cast_nullable_to_non_nullable
              as String?,
      saleCode: freezed == saleCode
          ? _value.saleCode
          : saleCode // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
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
      @JsonKey(fromJson: numberFromDataString) int status,
      String statusName,
      String reservationDate,
      String startTime,
      String endTime,
      String? table,
      @JsonKey(fromJson: numberFromDataString) int guest,
      @JsonKey(fromJson: numberFromDataString) int? amountAdult,
      @JsonKey(fromJson: numberFromDataString) int? amountChildren,
      @JsonKey(fromJson: boolFromDataString) bool hasBirthday,
      String? rejectReason,
      @JsonKey(fromJson: boolFromDataString) bool isOnline,
      @JsonKey(fromJson: listIntFromDataString) List<int>? tableId,
      String? infoOrder,
      @JsonKey(fromJson: boolFromDataString) bool fromSale,
      String? note,
      @JsonKey(fromJson: boolFromDataString) bool? isUpdate,
      String? saleName,
      String? saleCode,
      DateTime? createdAt});

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
    Object? guest = null,
    Object? amountAdult = freezed,
    Object? amountChildren = freezed,
    Object? hasBirthday = null,
    Object? rejectReason = freezed,
    Object? isOnline = null,
    Object? tableId = freezed,
    Object? infoOrder = freezed,
    Object? fromSale = null,
    Object? note = freezed,
    Object? isUpdate = freezed,
    Object? saleName = freezed,
    Object? saleCode = freezed,
    Object? createdAt = freezed,
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
      guest: null == guest
          ? _value.guest
          : guest // ignore: cast_nullable_to_non_nullable
              as int,
      amountAdult: freezed == amountAdult
          ? _value.amountAdult
          : amountAdult // ignore: cast_nullable_to_non_nullable
              as int?,
      amountChildren: freezed == amountChildren
          ? _value.amountChildren
          : amountChildren // ignore: cast_nullable_to_non_nullable
              as int?,
      hasBirthday: null == hasBirthday
          ? _value.hasBirthday
          : hasBirthday // ignore: cast_nullable_to_non_nullable
              as bool,
      rejectReason: freezed == rejectReason
          ? _value.rejectReason
          : rejectReason // ignore: cast_nullable_to_non_nullable
              as String?,
      isOnline: null == isOnline
          ? _value.isOnline
          : isOnline // ignore: cast_nullable_to_non_nullable
              as bool,
      tableId: freezed == tableId
          ? _value._tableId
          : tableId // ignore: cast_nullable_to_non_nullable
              as List<int>?,
      infoOrder: freezed == infoOrder
          ? _value.infoOrder
          : infoOrder // ignore: cast_nullable_to_non_nullable
              as String?,
      fromSale: null == fromSale
          ? _value.fromSale
          : fromSale // ignore: cast_nullable_to_non_nullable
              as bool,
      note: freezed == note
          ? _value.note
          : note // ignore: cast_nullable_to_non_nullable
              as String?,
      isUpdate: freezed == isUpdate
          ? _value.isUpdate
          : isUpdate // ignore: cast_nullable_to_non_nullable
              as bool?,
      saleName: freezed == saleName
          ? _value.saleName
          : saleName // ignore: cast_nullable_to_non_nullable
              as String?,
      saleCode: freezed == saleCode
          ? _value.saleCode
          : saleCode // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class _$ReservationModelImpl extends _ReservationModel {
  _$ReservationModelImpl(
      {required this.id,
      this.customer,
      @JsonKey(fromJson: numberFromDataString) this.status = 1,
      this.statusName = '',
      required this.reservationDate,
      required this.startTime,
      required this.endTime,
      this.table,
      @JsonKey(fromJson: numberFromDataString) this.guest = 1,
      @JsonKey(fromJson: numberFromDataString) this.amountAdult,
      @JsonKey(fromJson: numberFromDataString) this.amountChildren,
      @JsonKey(fromJson: boolFromDataString) this.hasBirthday = false,
      this.rejectReason = '',
      @JsonKey(fromJson: boolFromDataString) this.isOnline = false,
      @JsonKey(fromJson: listIntFromDataString)
      final List<int>? tableId = const [],
      this.infoOrder = '',
      @JsonKey(fromJson: boolFromDataString) this.fromSale = false,
      this.note = '',
      @JsonKey(fromJson: boolFromDataString) this.isUpdate,
      this.saleName,
      this.saleCode,
      this.createdAt})
      : _tableId = tableId,
        super._();

  factory _$ReservationModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ReservationModelImplFromJson(json);

  @override
  final dynamic id;
  @override
  final ReservationCustomerModel? customer;
  @override
  @JsonKey(fromJson: numberFromDataString)
  final int status;
  @override
  @JsonKey()
  final String statusName;

  /// format yyyy-MM-dd
  @override
  final String reservationDate;

  /// format: 20:00
  @override
  final String startTime;

  /// format: 20:00
  @override
  final String endTime;
  @override
  final String? table;
  @override
  @JsonKey(fromJson: numberFromDataString)
  final int guest;
//
  @override
  @JsonKey(fromJson: numberFromDataString)
  final int? amountAdult;
  @override
  @JsonKey(fromJson: numberFromDataString)
  final int? amountChildren;
  @override
  @JsonKey(fromJson: boolFromDataString)
  final bool hasBirthday;
  @override
  @JsonKey()
  final String? rejectReason;

  /// true là đặt mang về, fasle nhà ăn tại nhà hàng
  @override
  @JsonKey(fromJson: boolFromDataString)
  final bool isOnline;
  final List<int>? _tableId;
  @override
  @JsonKey(fromJson: listIntFromDataString)
  List<int>? get tableId {
    final value = _tableId;
    if (value == null) return null;
    if (_tableId is EqualUnmodifiableListView) return _tableId;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  @JsonKey()
  final String? infoOrder;
//// true là tạo từ sale... false là tạo từ lễ tân
  @override
  @JsonKey(fromJson: boolFromDataString)
  final bool fromSale;
  @override
  @JsonKey()
  final String? note;

  /// trường này chỉ sử dụng cho update, true - thay đổi ngày sang ngày khác, false - ngược lại
  @override
  @JsonKey(fromJson: boolFromDataString)
  final bool? isUpdate;

  /// cho việc make đơn bàn
  @override
  final String? saleName;
  @override
  final String? saleCode;
  @override
  final DateTime? createdAt;

  @override
  String toString() {
    return 'ReservationModel(id: $id, customer: $customer, status: $status, statusName: $statusName, reservationDate: $reservationDate, startTime: $startTime, endTime: $endTime, table: $table, guest: $guest, amountAdult: $amountAdult, amountChildren: $amountChildren, hasBirthday: $hasBirthday, rejectReason: $rejectReason, isOnline: $isOnline, tableId: $tableId, infoOrder: $infoOrder, fromSale: $fromSale, note: $note, isUpdate: $isUpdate, saleName: $saleName, saleCode: $saleCode, createdAt: $createdAt)';
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
            (identical(other.guest, guest) || other.guest == guest) &&
            (identical(other.amountAdult, amountAdult) ||
                other.amountAdult == amountAdult) &&
            (identical(other.amountChildren, amountChildren) ||
                other.amountChildren == amountChildren) &&
            (identical(other.hasBirthday, hasBirthday) ||
                other.hasBirthday == hasBirthday) &&
            (identical(other.rejectReason, rejectReason) ||
                other.rejectReason == rejectReason) &&
            (identical(other.isOnline, isOnline) ||
                other.isOnline == isOnline) &&
            const DeepCollectionEquality().equals(other._tableId, _tableId) &&
            (identical(other.infoOrder, infoOrder) ||
                other.infoOrder == infoOrder) &&
            (identical(other.fromSale, fromSale) ||
                other.fromSale == fromSale) &&
            (identical(other.note, note) || other.note == note) &&
            (identical(other.isUpdate, isUpdate) ||
                other.isUpdate == isUpdate) &&
            (identical(other.saleName, saleName) ||
                other.saleName == saleName) &&
            (identical(other.saleCode, saleCode) ||
                other.saleCode == saleCode) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        const DeepCollectionEquality().hash(id),
        customer,
        status,
        statusName,
        reservationDate,
        startTime,
        endTime,
        table,
        guest,
        amountAdult,
        amountChildren,
        hasBirthday,
        rejectReason,
        isOnline,
        const DeepCollectionEquality().hash(_tableId),
        infoOrder,
        fromSale,
        note,
        isUpdate,
        saleName,
        saleCode,
        createdAt
      ]);

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
      {required final dynamic id,
      final ReservationCustomerModel? customer,
      @JsonKey(fromJson: numberFromDataString) final int status,
      final String statusName,
      required final String reservationDate,
      required final String startTime,
      required final String endTime,
      final String? table,
      @JsonKey(fromJson: numberFromDataString) final int guest,
      @JsonKey(fromJson: numberFromDataString) final int? amountAdult,
      @JsonKey(fromJson: numberFromDataString) final int? amountChildren,
      @JsonKey(fromJson: boolFromDataString) final bool hasBirthday,
      final String? rejectReason,
      @JsonKey(fromJson: boolFromDataString) final bool isOnline,
      @JsonKey(fromJson: listIntFromDataString) final List<int>? tableId,
      final String? infoOrder,
      @JsonKey(fromJson: boolFromDataString) final bool fromSale,
      final String? note,
      @JsonKey(fromJson: boolFromDataString) final bool? isUpdate,
      final String? saleName,
      final String? saleCode,
      final DateTime? createdAt}) = _$ReservationModelImpl;
  _ReservationModel._() : super._();

  factory _ReservationModel.fromJson(Map<String, dynamic> json) =
      _$ReservationModelImpl.fromJson;

  @override
  dynamic get id;
  @override
  ReservationCustomerModel? get customer;
  @override
  @JsonKey(fromJson: numberFromDataString)
  int get status;
  @override
  String get statusName;
  @override

  /// format yyyy-MM-dd
  String get reservationDate;
  @override

  /// format: 20:00
  String get startTime;
  @override

  /// format: 20:00
  String get endTime;
  @override
  String? get table;
  @override
  @JsonKey(fromJson: numberFromDataString)
  int get guest;
  @override //
  @JsonKey(fromJson: numberFromDataString)
  int? get amountAdult;
  @override
  @JsonKey(fromJson: numberFromDataString)
  int? get amountChildren;
  @override
  @JsonKey(fromJson: boolFromDataString)
  bool get hasBirthday;
  @override
  String? get rejectReason;
  @override

  /// true là đặt mang về, fasle nhà ăn tại nhà hàng
  @JsonKey(fromJson: boolFromDataString)
  bool get isOnline;
  @override
  @JsonKey(fromJson: listIntFromDataString)
  List<int>? get tableId;
  @override
  String? get infoOrder;
  @override //// true là tạo từ sale... false là tạo từ lễ tân
  @JsonKey(fromJson: boolFromDataString)
  bool get fromSale;
  @override
  String? get note;
  @override

  /// trường này chỉ sử dụng cho update, true - thay đổi ngày sang ngày khác, false - ngược lại
  @JsonKey(fromJson: boolFromDataString)
  bool? get isUpdate;
  @override

  /// cho việc make đơn bàn
  String? get saleName;
  @override
  String? get saleCode;
  @override
  DateTime? get createdAt;
  @override
  @JsonKey(ignore: true)
  _$$ReservationModelImplCopyWith<_$ReservationModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ReservationCustomerModel _$ReservationCustomerModelFromJson(
    Map<String, dynamic> json) {
  return _ReservationCustomerModel.fromJson(json);
}

/// @nodoc
mixin _$ReservationCustomerModel {
  dynamic get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String? get firstName => throw _privateConstructorUsedError;
  String get lastName => throw _privateConstructorUsedError;
  String get phoneNumber => throw _privateConstructorUsedError;
  String? get dob => throw _privateConstructorUsedError;
  String? get email => throw _privateConstructorUsedError;
  @JsonKey(fromJson: boolFromDataString)
  bool get isZaloOa => throw _privateConstructorUsedError;

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
  $Res call(
      {dynamic id,
      String name,
      String? firstName,
      String lastName,
      String phoneNumber,
      String? dob,
      String? email,
      @JsonKey(fromJson: boolFromDataString) bool isZaloOa});
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
    Object? name = null,
    Object? firstName = freezed,
    Object? lastName = null,
    Object? phoneNumber = null,
    Object? dob = freezed,
    Object? email = freezed,
    Object? isZaloOa = null,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as dynamic,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      firstName: freezed == firstName
          ? _value.firstName
          : firstName // ignore: cast_nullable_to_non_nullable
              as String?,
      lastName: null == lastName
          ? _value.lastName
          : lastName // ignore: cast_nullable_to_non_nullable
              as String,
      phoneNumber: null == phoneNumber
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String,
      dob: freezed == dob
          ? _value.dob
          : dob // ignore: cast_nullable_to_non_nullable
              as String?,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      isZaloOa: null == isZaloOa
          ? _value.isZaloOa
          : isZaloOa // ignore: cast_nullable_to_non_nullable
              as bool,
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
  $Res call(
      {dynamic id,
      String name,
      String? firstName,
      String lastName,
      String phoneNumber,
      String? dob,
      String? email,
      @JsonKey(fromJson: boolFromDataString) bool isZaloOa});
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
    Object? name = null,
    Object? firstName = freezed,
    Object? lastName = null,
    Object? phoneNumber = null,
    Object? dob = freezed,
    Object? email = freezed,
    Object? isZaloOa = null,
  }) {
    return _then(_$ReservationCustomerModelImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as dynamic,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      firstName: freezed == firstName
          ? _value.firstName
          : firstName // ignore: cast_nullable_to_non_nullable
              as String?,
      lastName: null == lastName
          ? _value.lastName
          : lastName // ignore: cast_nullable_to_non_nullable
              as String,
      phoneNumber: null == phoneNumber
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String,
      dob: freezed == dob
          ? _value.dob
          : dob // ignore: cast_nullable_to_non_nullable
              as String?,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      isZaloOa: null == isZaloOa
          ? _value.isZaloOa
          : isZaloOa // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class _$ReservationCustomerModelImpl extends _ReservationCustomerModel {
  _$ReservationCustomerModelImpl(
      {required this.id,
      required this.name,
      this.firstName,
      required this.lastName,
      required this.phoneNumber,
      this.dob,
      this.email,
      @JsonKey(fromJson: boolFromDataString) required this.isZaloOa})
      : super._();

  factory _$ReservationCustomerModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ReservationCustomerModelImplFromJson(json);

  @override
  final dynamic id;
  @override
  final String name;
  @override
  final String? firstName;
  @override
  final String lastName;
  @override
  final String phoneNumber;
  @override
  final String? dob;
  @override
  final String? email;
  @override
  @JsonKey(fromJson: boolFromDataString)
  final bool isZaloOa;

  @override
  String toString() {
    return 'ReservationCustomerModel(id: $id, name: $name, firstName: $firstName, lastName: $lastName, phoneNumber: $phoneNumber, dob: $dob, email: $email, isZaloOa: $isZaloOa)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ReservationCustomerModelImpl &&
            const DeepCollectionEquality().equals(other.id, id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.firstName, firstName) ||
                other.firstName == firstName) &&
            (identical(other.lastName, lastName) ||
                other.lastName == lastName) &&
            (identical(other.phoneNumber, phoneNumber) ||
                other.phoneNumber == phoneNumber) &&
            (identical(other.dob, dob) || other.dob == dob) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.isZaloOa, isZaloOa) ||
                other.isZaloOa == isZaloOa));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      name,
      firstName,
      lastName,
      phoneNumber,
      dob,
      email,
      isZaloOa);

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
      {required final dynamic id,
      required final String name,
      final String? firstName,
      required final String lastName,
      required final String phoneNumber,
      final String? dob,
      final String? email,
      @JsonKey(fromJson: boolFromDataString)
      required final bool isZaloOa}) = _$ReservationCustomerModelImpl;
  _ReservationCustomerModel._() : super._();

  factory _ReservationCustomerModel.fromJson(Map<String, dynamic> json) =
      _$ReservationCustomerModelImpl.fromJson;

  @override
  dynamic get id;
  @override
  String get name;
  @override
  String? get firstName;
  @override
  String get lastName;
  @override
  String get phoneNumber;
  @override
  String? get dob;
  @override
  String? get email;
  @override
  @JsonKey(fromJson: boolFromDataString)
  bool get isZaloOa;
  @override
  @JsonKey(ignore: true)
  _$$ReservationCustomerModelImplCopyWith<_$ReservationCustomerModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}
