// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'close_shift.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CloseShiftResponseModelImpl _$$CloseShiftResponseModelImplFromJson(
        Map<String, dynamic> json) =>
    _$CloseShiftResponseModelImpl(
      infoPrint: json['infoPrint'] == null
          ? null
          : IpOrderModel.fromJson(json['infoPrint'] as Map<String, dynamic>),
      openShift: json['open_shift'] == null
          ? null
          : DateTime.parse(json['open_shift'] as String),
      lockShift: json['lock_shift'] == null
          ? null
          : DateTime.parse(json['lock_shift'] as String),
      shiftName: json['shift_name'] as String? ?? '',
      openingBalances: (json['opening_balances'] as num?)?.toDouble() ?? 0,
      totalAmount: (json['total_amount'] as num?)?.toDouble() ?? 0,
      discountMoney: (json['discount_money'] as num?)?.toDouble() ?? 0,
      percentBill: (json['percent_bill'] as num?)?.toDouble() ?? 0,
      countInvoice: (json['count_invoice'] as num?)?.toInt() ?? 0,
      endofshiftBalance: (json['endofshift_balance'] as num?)?.toDouble() ?? 0,
      cashierName: json['cashier_name'] as String? ?? '',
      totalPayment: json['total_payment'],
    );

Map<String, dynamic> _$$CloseShiftResponseModelImplToJson(
        _$CloseShiftResponseModelImpl instance) =>
    <String, dynamic>{
      'infoPrint': instance.infoPrint?.toJson(),
      'open_shift': instance.openShift?.toIso8601String(),
      'lock_shift': instance.lockShift?.toIso8601String(),
      'shift_name': instance.shiftName,
      'opening_balances': instance.openingBalances,
      'total_amount': instance.totalAmount,
      'discount_money': instance.discountMoney,
      'percent_bill': instance.percentBill,
      'count_invoice': instance.countInvoice,
      'endofshift_balance': instance.endofshiftBalance,
      'cashier_name': instance.cashierName,
      'total_payment': instance.totalPayment,
    };
