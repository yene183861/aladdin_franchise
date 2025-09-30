import 'package:aladdin_franchise/src/configs/color.dart';
import 'package:aladdin_franchise/src/configs/enums/bill_setting.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_esc_pos_utils/flutter_esc_pos_utils.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_setting.freezed.dart';
part 'app_setting.g.dart';

@freezed
class AppSettingModel with _$AppSettingModel {
  @JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
  const factory AppSettingModel({
    // @Default(true) bool noticeKitchenCancel,
    // @Default(true) bool noticeKitchenDone,
    // @Default(true) bool noticeKitchenConfirmLocation,
    // @Default(300) double boxSizeView,
    @Default(BillReturnItemTypeEnum.normal)
    BillReturnItemTypeEnum billReturnType,
    // @Default(AudioService.noticeDefaultKey) String audioDishCancel,
    // @Default(AudioService.noticeDefaultKey) String audioDishConfirmLocation,
    // @Default(AudioService.orderDefaultKey) String audioKitchenDone,
    // @Default(AppColors.colorSettingBackgroundDefault)
    // ColorSetting backgroundColor,
    // @Default(AppColors.colorSettingLineSelectDefault)
    // ColorSetting lineSelectColor,
    @Default(AppPrinterSettingTypeEnum.normal)
    AppPrinterSettingTypeEnum appPrinterType,
    @Default(BillHtmlSettingModel()) BillHtmlSettingModel billHtmlSetting,
    @Default(BillReturnSettingModel()) BillReturnSettingModel billReturnSetting,
    // @Default(OrderHistorySetting()) OrderHistorySetting orderHistorySetting,
  }) = _AppSettingModel;

  factory AppSettingModel.fromJson(Map<String, dynamic> json) =>
      _$AppSettingModelFromJson(json);
}

// @freezed
// class ColorSetting with _$ColorSetting {
//   const factory ColorSetting({
//     @Default(4278190080) int value,
//     @Default(1) double opacity,
//   }) = _ColorSetting;

//   factory ColorSetting.fromJson(Map<String, dynamic> json) =>
//       _$ColorSettingFromJson(json);

//   const ColorSetting._();

//   Color getColor() => Color(value).withOpacity(opacity);
// }

@freezed
class BillHtmlSettingModel with _$BillHtmlSettingModel {
  const factory BillHtmlSettingModel({
    @Default(PaperSizeSettingEnum.mm80) PaperSizeSettingEnum paperSize,
    @Default(16) int fontSize,
    @Default('') String messageReturn,
  }) = _BillHtmlSettingModel;

  factory BillHtmlSettingModel.fromJson(Map<String, dynamic> json) =>
      _$BillHtmlSettingModelFromJson(json);

  const BillHtmlSettingModel._();
}

@freezed
class BillReturnSettingModel with _$BillReturnSettingModel {
  const factory BillReturnSettingModel({
    /// sử dụng bill lẻ
    @Default(false) bool useOddBill,

    /// in tên combo trong bill lẻ
    @Default(false) bool printComboNameInOddBill,

    /// ??
    @Default(false) bool useOddBillForItemHasOddBill,
  }) = _BillReturnSettingModel;

  factory BillReturnSettingModel.fromJson(Map<String, dynamic> json) =>
      _$BillReturnSettingModelFromJson(json);

  const BillReturnSettingModel._();
}

// @freezed
// class OrderHistorySetting with _$OrderHistorySetting {
//   const factory OrderHistorySetting({
//     @Default(EOrderHistoryTypeView.items) EOrderHistoryTypeView viewType,
//     @Default(OrderHistoryFilterItem.all) String filterItem,
//     EOrderStatus? filterOrderStatus,
//   }) = _OrderHistorySetting;

//   factory OrderHistorySetting.fromJson(Map<String, dynamic> json) =>
//       _$OrderHistorySettingFromJson(json);
// }
