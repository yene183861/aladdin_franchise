import 'package:aladdin_franchise/src/utils/date_time.dart';
import 'package:aladdin_franchise/src/utils/parsing_util.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'reservation_request.freezed.dart';
part 'reservation_request.g.dart';

@freezed
class ReservationRequestModel with _$ReservationRequestModel {
  @JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
  factory ReservationRequestModel({
    required int restaurantId,
    @JsonKey(toJson: ParsingUtils.formatDateTime) required DateTime reservationDateStart,
    @JsonKey(toJson: ParsingUtils.formatDateTime) required DateTime reservationDateEnd,
  }) = _ReservationRequestModel;
  ReservationRequestModel._();
  String toParamRequest() {
    return 'restaurant_id=$restaurantId'
        '&reservation_date_start=${DateTimeUtils.instance.dateFormatYYYYMMDD.format(reservationDateStart)}'
        '&reservation_date_end=${DateTimeUtils.instance.dateFormatYYYYMMDD.format(reservationDateEnd)}';
  }

  factory ReservationRequestModel.fromJson(Map<String, Object?> json) =>
      _$ReservationRequestModelFromJson(json);
}
