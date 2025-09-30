import 'package:aladdin_franchise/src/utils/date_time.dart';
import 'package:equatable/equatable.dart';

class GetReservationParam extends Equatable {
  final int retaurantId;
  final DateTime startDate;
  final DateTime endDate;

  const GetReservationParam({
    required this.retaurantId,
    required this.startDate,
    required this.endDate,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {};
    map['restaurant_id'] = retaurantId;
    map['reservation_date_start'] =
        DateTimeUtils.instance.dateFormatYYYYMMDD.format(startDate);
    map['reservation_date_end'] =
        DateTimeUtils.instance.dateFormatYYYYMMDD.format(endDate);
    return map;
  }

  String toParamRequest() {
    return 'restaurant_id=$retaurantId&reservation_date_start=${DateTimeUtils.instance.dateFormatYYYYMMDD.format(startDate)}&reservation_date_end=${DateTimeUtils.instance.dateFormatYYYYMMDD.format(endDate)}';
  }

  @override
  List<Object?> get props => [retaurantId, startDate, endDate];
}
