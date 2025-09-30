import 'dart:math';
import 'dart:ui';

import 'package:aladdin_franchise/generated/l10n.dart';
import 'package:aladdin_franchise/src/configs/app.dart';
import 'package:aladdin_franchise/src/models/customer/customer.dart';
import 'package:aladdin_franchise/src/models/customer/customer_policy.dart';
import 'package:aladdin_franchise/src/models/data_bill.dart';
import 'package:aladdin_franchise/src/models/product.dart';
import 'package:aladdin_franchise/src/models/product_checkout.dart';
import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'history_order.freezed.dart';
part 'history_order.g.dart';

enum OrderStatusEnum {
  processing,
  waiting,
  completed,
  cancelled,
}

OrderStatusEnum _convertOrderStatusEnum(int type) {
  switch (type) {
    case 15:
      return OrderStatusEnum.processing;
    case 16:
      return OrderStatusEnum.waiting;
    case 20:
      return OrderStatusEnum.completed;
    case 10:
      return OrderStatusEnum.cancelled;

    default:
      return OrderStatusEnum.processing;
  }
}

extension OrderStatusEnumEx on OrderStatusEnum {
  Color get color {
    switch (this) {
      case OrderStatusEnum.processing:
        return Color(0xFF3abaf4);
      case OrderStatusEnum.waiting:
        return Color(0xFF6777ef);
      case OrderStatusEnum.completed:
        return Colors.green;
      case OrderStatusEnum.cancelled:
        return Color.fromARGB(255, 82, 85, 107);
      default:
        return Color(0xFF3abaf4);
    }
  }

  int get type {
    switch (this) {
      case OrderStatusEnum.processing:
        return 15;
      case OrderStatusEnum.waiting:
        return 16;
      case OrderStatusEnum.completed:
        return 20;
      case OrderStatusEnum.cancelled:
        return 10;
      default:
        return 15;
    }
  }

  String get title {
    switch (this) {
      case OrderStatusEnum.processing:
        return S.current.processing;
      case OrderStatusEnum.waiting:
        return S.current.waiting_payment;
      case OrderStatusEnum.completed:
        return S.current.complete;
      case OrderStatusEnum.cancelled:
        return S.current.cancel;
      default:
        return S.current.processing;
    }
  }
}

@freezed
class HistoryOrderModel with _$HistoryOrderModel {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory HistoryOrderModel({
    @Default('') String orderCode,
    @Default('') String tableName,
    // đang k có
    @Default('') String notes,
    DateTime? orderCreated,
    @Default(15) int orderStatus,
    @Default('') String orderStatusName,
    @Default(HistoryOrderExcuteModel()) HistoryOrderExcuteModel orderExcute,
    CustomerModel? customer,
    @Default([]) List<CustomerPolicyModel> coupons,
    PriceDataBill? price,
    @Default([]) List<ProductCheckoutHistoryModel> orderItems,
    @Default([]) List<ProductCheckoutHistoryModel> orderHistories,
    @Default(AppConfig.orderOfflineValue) int orderType,
  }) = _HistoryOrderModel;

  factory HistoryOrderModel.fromJson(Map<String, dynamic> json) =>
      _$HistoryOrderModelFromJson(json);

  const HistoryOrderModel._();

  OrderStatusEnum get status => _convertOrderStatusEnum(orderStatus);

  DateTime? get timeCreated => orderCreated?.toLocal();
}

@freezed
class HistoryOrderExcuteModel with _$HistoryOrderExcuteModel {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory HistoryOrderExcuteModel({
    @Default(0) int flag,
    @Default(0) int order,
  }) = _HistoryOrderExcuteModel;

  factory HistoryOrderExcuteModel.fromJson(Map<String, dynamic> json) =>
      _$HistoryOrderExcuteModelFromJson(json);

  const HistoryOrderExcuteModel._();
}

@freezed
class HistoryOrderProductModel with _$HistoryOrderProductModel {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory HistoryOrderProductModel({
    int? id,
    @Default('') String name,
    @Default('') String codeProduct,
    @Default('-1') String quantity,
    @Default('0') String unitPrice,
    int? printerType,
    @Default(0) int timesOrder,
    @Default('') String notes,
  }) = _HistoryOrderProductModel;

  factory HistoryOrderProductModel.fromJson(Map<String, dynamic> json) =>
      _$HistoryOrderProductModelFromJson(json);

  const HistoryOrderProductModel._();

  int get getQuantity => int.tryParse(quantity) ?? 0;

  double get price => double.tryParse(unitPrice) ?? 0.0;
}
