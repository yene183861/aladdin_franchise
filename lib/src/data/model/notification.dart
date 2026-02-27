import 'dart:convert';

import 'package:aladdin_franchise/generated/assets.dart';
import 'package:aladdin_franchise/src/configs/color.dart';
import 'package:aladdin_franchise/src/configs/enums/bill_setting.dart';
import 'package:aladdin_franchise/src/data/enum/print_type.dart';
import 'package:aladdin_franchise/src/data/model/restaurant/printer.dart';
import 'package:aladdin_franchise/src/data/request/payment_receipt_print.dart';
import 'package:aladdin_franchise/src/data/response/close_shift.dart';
import 'package:aladdin_franchise/src/models/order.dart';
import 'package:aladdin_franchise/src/models/product.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

part 'notification.freezed.dart';
part 'notification.g.dart';

enum NotificationTypeEnum {
  print,
  other,
  o2oPayment,
  o2oWaiter,
}

extension NotificationTypeEnumExt on NotificationTypeEnum {
  String get icon {
    switch (this) {
      case NotificationTypeEnum.print:
        return Assets.iconsPrinter;
      case NotificationTypeEnum.o2oPayment:
        return Assets.iconsCard;
      case NotificationTypeEnum.o2oWaiter:
        return Assets.iconsTray;
      case NotificationTypeEnum.other:
        return Assets.iconsTray;
      default:
        return Assets.iconsTray;
    }
  }

  Color? get color {
    switch (this) {
      case NotificationTypeEnum.print:
        return Colors.red;
      case NotificationTypeEnum.o2oPayment:
        return AppColors.secondColor;
      case NotificationTypeEnum.o2oWaiter:
        return Color.fromARGB(255, 34, 118, 227);
      case NotificationTypeEnum.other:
        return Colors.white;

      default:
        return null;
    }
  }

  // Color? get readColor {
  //   switch (this) {
  //     case NotificationTypeEnum.print:
  //       return Colors.red;
  //     case NotificationTypeEnum.print:
  //       return Colors.red;
  //     case NotificationTypeEnum.print:
  //       return Colors.red;

  //     default:
  //       return null;
  //   }
  // }

  // Color? get bgColor {
  //   switch (this) {
  //     case NotificationTypeEnum.print:
  //       return Colors.red;
  //     case NotificationTypeEnum.print:
  //       return Colors.red;
  //     case NotificationTypeEnum.print:
  //       return Colors.red;

  //     default:
  //       return null;
  //   }
  // }
}

enum PrintStatusEnum {
  waiting,
  done,
  error,
  noResponse,
}

@freezed
class NotificationModel extends HiveObject with _$NotificationModel {
  @HiveType(typeId: 0, adapterName: 'NotificationModelAdapter')
  factory NotificationModel({
    @Default('') @HiveField(0, defaultValue: '') String title,
    @Default('') @HiveField(1, defaultValue: '') String body,
    @HiveField(2, defaultValue: null) DateTime? datetime,
    @Default(false) @HiveField(3, defaultValue: false) bool read,
    @HiveField(4, defaultValue: null) int? orderId,
    @HiveField(5, defaultValue: null) dynamic data,
    @HiveField(6, defaultValue: null) String? type,
    @Default('') @HiveField(7, defaultValue: '') String id,
    @Default(false) @HiveField(8, defaultValue: false) bool viewed,
  }) = _NotificationModel;
  NotificationModel._();

  NotificationModel markRead() {
    return copyWith(read: true, viewed: true);
  }

  NotificationDataModel? get getDataPrint {
    NotificationDataModel? result;
    try {
      result = NotificationDataModel.fromJson(jsonDecode(data));
    } catch (ex) {
      //
    }

    return result;
  }

  NotificationTypeEnum get getNotiType {
    NotificationTypeEnum result = NotificationTypeEnum.other;
    try {
      result = NotificationTypeEnum.values.byName(type ?? '');
    } catch (ex) {
      //
    }
    return result;
  }

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      _$NotificationModelFromJson(json);
}

@freezed
class NotificationDataModel with _$NotificationDataModel {
  @JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
  factory NotificationDataModel({
    String? id,
    @Default(PrintTypeEnum.order) PrintTypeEnum type,
    @Default(AppPrinterSettingTypeEnum.normal) AppPrinterSettingTypeEnum mode,
    // @Default('') String type,
    // @Default('') String mode,
    CloseShiftResponseModel? closeShiftData,
    PaymentReceiptPrintRequest? paymentData,
    @Default(false) bool useOddBill,
    @Default(false) bool useDefaultPrinters,
    @Default(true) bool totalBill,
    // @Default(true) bool status,
    // @Default(false) bool error,
    String? refId,
    String? senderDeviceId,
    String? handleDeviceId,
    OrderModel? order,
    @Default([]) List<ProductModel> products,
    String? note,
    @Default([]) List<PrinterModel> printers,
    @Default(PrintStatusEnum.done) PrintStatusEnum printStatus,
    String? message,
    String? title,
  }) = _NotificationDataModel;
  NotificationDataModel._();

  factory NotificationDataModel.fromJson(Map<String, dynamic> json) =>
      _$NotificationDataModelFromJson(json);
}
