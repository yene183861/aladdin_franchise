import 'package:freezed_annotation/freezed_annotation.dart';

part 'reservation_customer.freezed.dart';
part 'reservation_customer.g.dart';

@freezed
class ReservationCustomerModel with _$ReservationCustomerModel {
  @JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
  factory ReservationCustomerModel({
    dynamic id,
    String? name,
    String? phoneNumber,
  }) = _ReservationCustomerModel;
  ReservationCustomerModel._();

  factory ReservationCustomerModel.fromJson(Map<String, dynamic> json) =>
      _$ReservationCustomerModelFromJson(json);
}
