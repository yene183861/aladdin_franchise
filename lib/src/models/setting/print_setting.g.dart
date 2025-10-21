// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'print_setting.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AppPrintSettingModelImpl _$$AppPrintSettingModelImplFromJson(
        Map<String, dynamic> json) =>
    _$AppPrintSettingModelImpl(
      billReturnType: $enumDecodeNullable(
              _$BillReturnItemTypeEnumEnumMap, json['bill_return_type']) ??
          BillReturnItemTypeEnum.normal,
      appPrinterType: $enumDecodeNullable(
              _$AppPrinterSettingTypeEnumEnumMap, json['app_printer_type']) ??
          AppPrinterSettingTypeEnum.normal,
      billHtmlSetting: json['bill_html_setting'] == null
          ? const BillHtmlSettingModel()
          : BillHtmlSettingModel.fromJson(
              json['bill_html_setting'] as Map<String, dynamic>),
      billReturnSetting: json['bill_return_setting'] == null
          ? const BillReturnSettingModel()
          : BillReturnSettingModel.fromJson(
              json['bill_return_setting'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$AppPrintSettingModelImplToJson(
        _$AppPrintSettingModelImpl instance) =>
    <String, dynamic>{
      'bill_return_type':
          _$BillReturnItemTypeEnumEnumMap[instance.billReturnType]!,
      'app_printer_type':
          _$AppPrinterSettingTypeEnumEnumMap[instance.appPrinterType]!,
      'bill_html_setting': instance.billHtmlSetting.toJson(),
      'bill_return_setting': instance.billReturnSetting.toJson(),
    };

const _$BillReturnItemTypeEnumEnumMap = {
  BillReturnItemTypeEnum.normal: 'normal',
  BillReturnItemTypeEnum.uppercase: 'uppercase',
  BillReturnItemTypeEnum.byHeight: 'byHeight',
};

const _$AppPrinterSettingTypeEnumEnumMap = {
  AppPrinterSettingTypeEnum.normal: 'normal',
  AppPrinterSettingTypeEnum.withHtml: 'withHtml',
};

_$BillHtmlSettingModelImpl _$$BillHtmlSettingModelImplFromJson(
        Map<String, dynamic> json) =>
    _$BillHtmlSettingModelImpl(
      paperSize: $enumDecodeNullable(
              _$PaperSizeSettingEnumEnumMap, json['paperSize']) ??
          PaperSizeSettingEnum.mm80,
      fontSize: (json['fontSize'] as num?)?.toInt() ?? 16,
      messageReturn: json['messageReturn'] as String? ?? '',
    );

Map<String, dynamic> _$$BillHtmlSettingModelImplToJson(
        _$BillHtmlSettingModelImpl instance) =>
    <String, dynamic>{
      'paperSize': _$PaperSizeSettingEnumEnumMap[instance.paperSize]!,
      'fontSize': instance.fontSize,
      'messageReturn': instance.messageReturn,
    };

const _$PaperSizeSettingEnumEnumMap = {
  PaperSizeSettingEnum.mm58: 'mm58',
  PaperSizeSettingEnum.mm80: 'mm80',
  PaperSizeSettingEnum.mm72: 'mm72',
};

_$BillReturnSettingModelImpl _$$BillReturnSettingModelImplFromJson(
        Map<String, dynamic> json) =>
    _$BillReturnSettingModelImpl(
      useOddBill: json['useOddBill'] as bool? ?? false,
      printComboNameInOddBill:
          json['printComboNameInOddBill'] as bool? ?? false,
      useOddBillForItemHasOddBill:
          json['useOddBillForItemHasOddBill'] as bool? ?? false,
    );

Map<String, dynamic> _$$BillReturnSettingModelImplToJson(
        _$BillReturnSettingModelImpl instance) =>
    <String, dynamic>{
      'useOddBill': instance.useOddBill,
      'printComboNameInOddBill': instance.printComboNameInOddBill,
      'useOddBillForItemHasOddBill': instance.useOddBillForItemHasOddBill,
    };
