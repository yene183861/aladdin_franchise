import 'package:aladdin_franchise/src/configs/app.dart';
import 'package:aladdin_franchise/src/configs/color.dart';
import 'package:aladdin_franchise/src/core/storages/local.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class AppTextStyle {
  static bool get _useFontScale => LocalStorage.getAppSetting().useFontScale;

  /// light w300
  ///
  /// [rawFontSize] là giá trị raw, không dùng 14.sp vì có cấu hình
  static TextStyle light({
    double? rawFontSize,
    Color? color,
    FontStyle fontStyle = FontStyle.normal,
    FontWeight fontWeight = FontWeight.w300,
  }) {
    var size = rawFontSize ?? AppConfig.defaultRawTextSize;
    return TextStyle(
      color: color ?? AppColors.textColor,
      fontSize: _useFontScale ? size.sp : size,
      fontWeight: FontWeight.w300,
    );
  }

  ///
  /// [rawFontSize] là giá trị raw, không dùng 14.sp vì có cấu hình
  static TextStyle regular({
    double? rawFontSize,
    Color? color,
    FontStyle fontStyle = FontStyle.normal,
    FontWeight fontWeight = FontWeight.w400,
  }) {
    var size = rawFontSize ?? AppConfig.defaultRawTextSize;
    return TextStyle(
      color: color ?? AppColors.textColor,
      fontSize: _useFontScale ? size.sp : size,
      fontWeight: fontWeight,
      fontStyle: fontStyle,
    );
  }

  /// medium w500
  static TextStyle medium({
    double? rawFontSize,
    Color? color,
    FontStyle fontStyle = FontStyle.normal,
    FontWeight fontWeight = FontWeight.w500,
  }) {
    var size = rawFontSize ?? AppConfig.defaultRawTextSize;
    return TextStyle(
      color: color ?? AppColors.textColor,
      fontSize: _useFontScale ? size.sp : size,
      fontWeight: fontWeight,
      fontStyle: fontStyle,
    );
  }

  /// semiBold w600
  static TextStyle semiBold({
    double? rawFontSize,
    Color? color,
    FontStyle fontStyle = FontStyle.normal,
    FontWeight fontWeight = FontWeight.w600,
  }) {
    var size = rawFontSize ?? AppConfig.defaultRawTextSize;
    return TextStyle(
      color: color ?? AppColors.textColor,
      fontSize: _useFontScale ? size.sp : size,
      fontWeight: fontWeight,
      fontStyle: fontStyle,
    );
  }

  /// bold w700
  static TextStyle bold({
    double? rawFontSize,
    Color? color,
    FontStyle fontStyle = FontStyle.normal,
    FontWeight fontWeight = FontWeight.w700,
  }) {
    var size = rawFontSize ?? AppConfig.defaultRawTextSize;
    return TextStyle(
      color: color ?? AppColors.textColor,
      fontSize: _useFontScale ? size.sp : size,
      fontWeight: fontWeight,
      fontStyle: fontStyle,
    );
  }

  static TextStyle extraBold({
    double? rawFontSize,
    Color? color,
    FontStyle fontStyle = FontStyle.normal,
    FontWeight fontWeight = FontWeight.w800,
  }) {
    var size = rawFontSize ?? AppConfig.defaultRawTextSize;
    return TextStyle(
      color: color ?? AppColors.textColor,
      fontSize: _useFontScale ? size.sp : size,
      fontWeight: fontWeight,
      fontStyle: fontStyle,
    );
  }
}
