import 'package:aladdin_franchise/src/models/data_bill.dart';
import 'package:equatable/equatable.dart';

/// Author: sondv
/// Created 27/03/2024 at 14:30

class ApiBankParam extends Equatable {
  final OrderDataBill orderDataBill;
  final dynamic priceFinal;
  const ApiBankParam(this.orderDataBill, this.priceFinal);

  @override
  List<Object?> get props => [orderDataBill, priceFinal];
}
