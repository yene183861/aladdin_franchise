import 'package:aladdin_franchise/generated/l10n.dart';
import 'package:aladdin_franchise/src/configs/enums/type_order.dart';
import 'package:aladdin_franchise/src/utils/date_time.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'reservation.freezed.dart';
part 'reservation.g.dart';

enum ReservationStatus {
  all,
  pending,
  accept,

  /// process = 15, 16 -  khách đến sử dụng dịch vụ/ chuẩn bị món đơn online => make đơn bàn
  /// APOS: PROCESS - 15, WAITING - 16
  process,

  /// complete = 20 - khách thanh toán thành công/ đơn đã được giao
  complete,
  cancel,
  reject,
}

extension ReservationStatusEx on ReservationStatus {
  int get type {
    switch (this) {
      case ReservationStatus.pending:
        return 1;
      case ReservationStatus.accept:
        return 2;
      case ReservationStatus.cancel:
        return 3;
      case ReservationStatus.reject:
        return 4;
      case ReservationStatus.complete:
        return 20;
      case ReservationStatus.process:
        return 15;
      default:
        return 0;
    }
  }

  String get title {
    switch (this) {
      case ReservationStatus.pending:
        return S.current.pending_reser;
      case ReservationStatus.accept:
        return S.current.accepted_reser;
      case ReservationStatus.cancel:
        return S.current.canceled_reser;
      case ReservationStatus.reject:
        return S.current.rejected_reser;
      case ReservationStatus.complete:
        return S.current.completed_reser;

      case ReservationStatus.process:
        return S.current.processing_reser;
      default:
        return S.current.all;
    }
  }

  Color get color {
    switch (this) {
      case ReservationStatus.pending:
        return const Color(0xFF0F87C7).withOpacity(0.7);
      case ReservationStatus.accept:
        return const Color(0xFFF67F00).withOpacity(0.7);
      case ReservationStatus.cancel:
        return Colors.grey.shade600;
      case ReservationStatus.reject:
        return Colors.grey.shade800;
      case ReservationStatus.complete:
        return const Color(0xFF2F9449);
      case ReservationStatus.process:
        return const Color.fromARGB(255, 219, 56, 11);
      default:
        return Colors.grey;
    }
  }
}

ReservationStatus convertReservationStatus(int type) {
  switch (type) {
    case 1:
      return ReservationStatus.pending;
    case 2:
      return ReservationStatus.accept;
    case 3:
      return ReservationStatus.cancel;
    case 4:
      return ReservationStatus.reject;
    case 20:
      return ReservationStatus.complete;

    case 15:
    case 16:
      return ReservationStatus.process;
    default:
      return ReservationStatus.pending;
  }
}

@freezed
class ReservationModel with _$ReservationModel {
  @JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
  factory ReservationModel({
    required dynamic id,
    ReservationCustomerModel? customer,
    @Default(1) @JsonKey(fromJson: numberFromDataString) int status,
    @Default('') String statusName,

    /// format yyyy-MM-dd
    required String reservationDate,

    /// format: 20:00
    required String startTime,

    /// format: 20:00
    required String endTime,
    String? table,
    @Default(1) @JsonKey(fromJson: numberFromDataString) int guest,
    //
    @JsonKey(fromJson: numberFromDataString) int? amountAdult,
    @JsonKey(fromJson: numberFromDataString) int? amountChildren,
    @Default(false) @JsonKey(fromJson: boolFromDataString) bool hasBirthday,
    @Default('') String? rejectReason,

    /// true là đặt mang về, fasle nhà ăn tại nhà hàng
    @Default(false) @JsonKey(fromJson: boolFromDataString) bool isOnline,
    @Default([]) @JsonKey(fromJson: listIntFromDataString) List<int>? tableId,
    @Default('') String? infoOrder,
    //// true là tạo từ sale... false là tạo từ lễ tân
    @Default(false) @JsonKey(fromJson: boolFromDataString) bool fromSale,
    @Default('') String? note,

    /// trường này chỉ sử dụng cho update, true - thay đổi ngày sang ngày khác, false - ngược lại
    @JsonKey(fromJson: boolFromDataString) bool? isUpdate,

    /// cho việc make đơn bàn
    String? saleName,
    String? saleCode,
    DateTime? createdAt,
  }) = _ReservationModel;

  ReservationModel._();

  DateTime get startDateTime =>
      DateTimeUtils.parseToDateTimeFromHour(timeStr: startTime, date: date);

  /// convert field reservationDate format: yyyy-MM-dd to DateTime
  DateTime get date => DateTimeUtils.instance.dateFormatYYYYMMDD.parse(reservationDate);

  /// convert field status to enum ReservationStatus
  ReservationStatus get reservationStatus => convertReservationStatus(status);

  /// [
  /// ReservationStatus.process,
  ///  ReservationStatus.complete,
  ///   ReservationStatus.cancel,
  ///  ReservationStatus.reject,
  /// ].contains(reservationStatus)

  // bool get disableUpdateReservation => [
  //       ReservationStatus.process,
  //       ReservationStatus.complete,
  //       ReservationStatus.cancel,
  //       ReservationStatus.reject,
  //     ].contains(reservationStatus);

  TypeOrderEnum get typeOrder => isOnline ? TypeOrderEnum.online : TypeOrderEnum.offline;

  factory ReservationModel.fromJson(Map<String, Object?> json) => _$ReservationModelFromJson(json);

  static String getModelInterface() {
    return '''ReservationModel{
      required dynamic id,
      ReservationCustomerModel? customer,
      @Default(1) int status,
      @Default('') String statusName,
      required String reservationDate,
      required String startTime, /// HH:mm
      required String endTime, /// HH:mm
      String? table,
      @Default(1) int guest,
      int? amountAdult,
      int? amountChildren,
      @Default(false) bool hasBirthday,
      String? rejectReason,
      @Default(false) bool isOnline,
      List<int>? tableId,
      @Default('') String? infoOrder,
      @Default(false) bool fromSale,
      @Default('') String? note,
      bool? isUpdate,
      String? saleName,
      String? saleCode,
      DateTime? createdAt,
    }
    ''';
  }
}

int numberFromDataString(dynamic value) {
  if (value == null) {
    return 0;
  }
  if (value is String) {
    return int.parse(value);
  }
  return value;
}

bool boolFromDataString(dynamic value) {
  if (value == null) {
    return false;
  }
  if (value is String) {
    return bool.parse(value);
  }
  return value;
}

List<int> listIntFromDataString(dynamic value) {
  if (value == null) {
    return [];
  }
  if (value is String) {
    final data = value.replaceAll('[', '').replaceAll(']', '');
    if (data.trim().isEmpty) return [];
    return data.split(',').map((e) => int.parse(e)).toList();
  }
  return List<int>.from(value);
}

@freezed
class ReservationCustomerModel with _$ReservationCustomerModel {
  @JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
  factory ReservationCustomerModel({
    required dynamic id,
    required String name,
    String? firstName,
    required String lastName,
    required String phoneNumber,
    String? dob,
    String? email,
    @JsonKey(fromJson: boolFromDataString) required bool isZaloOa,
  }) = _ReservationCustomerModel;
  ReservationCustomerModel._();

  // String get birthday => (dob != null && dob!.trim().isNotEmpty)
  //     ? TimeUtil.formatFromDateTime(
  //         time: TimeUtil.parseToDateTime(timeStr: dob!, format: DateTimePattern.dateFormatDefault1),
  //         format: DateTimePattern.dateFormatDefault)
  //     : '';

  factory ReservationCustomerModel.fromJson(Map<String, dynamic> json) =>
      _$ReservationCustomerModelFromJson(json);
}
