import 'package:aladdin_franchise/generated/l10n.dart';
import 'package:aladdin_franchise/src/configs/enums/type_order.dart';
import 'package:aladdin_franchise/src/data/enum/reservation_status.dart';
import 'package:aladdin_franchise/src/utils/app_util.dart';
import 'package:aladdin_franchise/src/utils/date_time.dart';
import 'package:aladdin_franchise/src/utils/parsing_util.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'reservation_customer.dart';

part 'reservation.freezed.dart';
part 'reservation.g.dart';

@freezed
class ReservationModel with _$ReservationModel {
  @JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
  factory ReservationModel({
    dynamic id,
    ReservationCustomerModel? customer,
    @Default(1) @JsonKey(fromJson: ParsingUtils.parseInt) int status,
    @Default('') String statusName,
    @Default('2026-01-01') String reservationDate,
    @Default('08:00') String startTime,
    @Default('10:00') String endTime,
    String? table,
    @Default(false) @JsonKey(fromJson: ParsingUtils.parseBool) bool isOnline,
    @Default([]) @JsonKey(fromJson: ParsingUtils.parseListInt) List<int>? tableId,
    String? saleName,
    String? saleCode,
    @Default(false) bool isUpdate,
    @JsonKey(includeFromJson: false, includeToJson: false) Map<String, dynamic>? rawData,
  }) = _ReservationModel;

  ReservationModel._();

  factory ReservationModel.fromJson(Map<String, Object?> json) => _$ReservationModelFromJson(json);

  DateTime get startDateTime =>
      DateTimeUtils.parseToDateTimeFromHour(timeStr: startTime, date: date);

  DateTime get date => DateTimeUtils.instance.dateFormatYYYYMMDD.parse(reservationDate);

  ReservationStatusEnum get reservationStatus => convertToReservationStatusEnum(status);

  TypeOrderEnum get typeOrder => isOnline ? TypeOrderEnum.online : TypeOrderEnum.offline;

  List<String> get listTableName => table?.split(',') ?? [];

  /// chỉ so sánh status, tableId, table để update khi cần
  bool equalsOtherReservation(ReservationModel? other) {
    if (other == null) return false;

    return status != other.status ||
        AppUtils.checkListEqualsIgnoreOrder(tableId ?? [], other.tableId ?? []) ||
        AppUtils.checkListEqualsIgnoreOrder(listTableName, other.listTableName);
  }
}
