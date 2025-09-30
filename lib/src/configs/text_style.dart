import 'package:aladdin_franchise/src/configs/color.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class AppTextStyle {
  /// light w300
  static TextStyle light({double? fontSize, Color? color}) => TextStyle(
        color: color ?? AppColors.text,
        // fontSize: fontSize ?? 14.sp,
        fontSize: fontSize ?? 14,
        fontWeight: FontWeight.w300,
      );

  static TextStyle regular(
          {double? fontSize,
          Color? color,
          FontStyle? fontStyle,
          FontWeight? fontWeight}) =>
      TextStyle(
        color: color ?? AppColors.text,
        // fontSize: fontSize ?? 14.sp,
        fontSize: fontSize ?? 14,
        fontWeight: fontWeight ?? FontWeight.w400,
        fontStyle: fontStyle ?? FontStyle.normal,
      );

  /// medium w500
  static TextStyle medium(
          {double? fontSize, Color? color, FontStyle? fontStyle}) =>
      TextStyle(
        color: color ?? AppColors.text,
        // fontSize: fontSize ?? 14.sp,
        fontSize: fontSize ?? 14,
        fontWeight: FontWeight.w500,
        fontStyle: fontStyle ?? FontStyle.normal,
      );

  /// semiBold w600
  static TextStyle semiBold(
          {double? fontSize, Color? color, FontStyle? fontStyle}) =>
      TextStyle(
        color: color ?? AppColors.text,
        // fontSize: fontSize ?? 14.sp,
        fontSize: fontSize ?? 14,
        fontWeight: FontWeight.w600,
        fontStyle: fontStyle ?? FontStyle.normal,
      );

  /// bold w700
  static TextStyle bold(
          {double? fontSize,
          Color? color,
          FontStyle? fontStyle,
          FontWeight? fontWeight}) =>
      TextStyle(
        color: color ?? AppColors.text,
        // fontSize: fontSize ?? 14.sp,
        fontSize: fontSize ?? 14,
        fontWeight: fontWeight ?? FontWeight.w700,
        fontStyle: fontStyle,
      );

  static TextStyle extraBold({double? fontSize, Color? color}) => TextStyle(
        color: color ?? AppColors.text,
        // fontSize: fontSize ?? 14.sp,
        fontSize: fontSize ?? 14,
        fontWeight: FontWeight.w800,
      );

  static TextStyle black({double? fontSize, Color? color}) => TextStyle(
        color: color ?? AppColors.text,
        // fontSize: fontSize ?? 14.sp,
        fontSize: fontSize ?? 14,
        fontWeight: FontWeight.w900,
      );

  static TextStyle titleBold(
          {double? fontSize,
          Color? color,
          FontStyle? fontStyle,
          FontWeight? fontWeight}) =>
      TextStyle(
        color: color ?? AppColors.text,
        // fontSize: fontSize ?? 14.sp,
        fontSize: fontSize ?? 14,
        fontWeight: fontWeight ?? FontWeight.w700,
        fontStyle: fontStyle,
      );
}
