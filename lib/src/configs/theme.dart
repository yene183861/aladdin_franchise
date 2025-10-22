import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'app.dart';
import 'color.dart';
import 'text_style.dart';

final _textTheme = TextTheme(
  displayLarge: AppTextStyle.regular(),
  displayMedium: AppTextStyle.regular(),
  displaySmall: AppTextStyle.regular(),
  headlineLarge: AppTextStyle.regular(),
  headlineMedium: AppTextStyle.regular(),
  headlineSmall: AppTextStyle.regular(),
  titleLarge: AppTextStyle.regular(),
  titleMedium: AppTextStyle.regular(),
  titleSmall: AppTextStyle.regular(),
  bodyLarge: AppTextStyle.regular(),
  bodyMedium: AppTextStyle.regular(),
  bodySmall: AppTextStyle.regular(),
  labelLarge: AppTextStyle.regular(),
  labelMedium: AppTextStyle.regular(),
  labelSmall: AppTextStyle.regular(),
);

final kAppTheme = ThemeData(
  useMaterial3: true,
  colorScheme: ThemeData().colorScheme.copyWith(primary: AppColors.mainColor),
  bottomSheetTheme: const BottomSheetThemeData(
    constraints: BoxConstraints.tightForFinite(),
  ),
  scaffoldBackgroundColor: Colors.white,
  iconTheme: IconThemeData(size: 18),
  textTheme: _textTheme,
  expansionTileTheme: ExpansionTileThemeData(
    collapsedShape: Border.all(color: Colors.transparent),
  ),
  listTileTheme: ListTileThemeData(
    titleTextStyle: AppTextStyle.bold(),
    subtitleTextStyle: AppTextStyle.regular(),
  ),
  chipTheme: ChipThemeData(
    backgroundColor: Colors.grey.shade200,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(50),
    ),
  ),
  snackBarTheme: SnackBarThemeData(
    contentTextStyle: AppTextStyle.regular(),
  ),
  appBarTheme: AppBarTheme(
    elevation: 0,
    backgroundColor: AppColors.mainColor,
    foregroundColor: Colors.white,
    titleTextStyle:
        AppTextStyle.bold(color: AppColors.white, rawFontSize: AppConfig.defaultRawTextSize + 1.0),
  ),
  dialogTheme: DialogTheme(
    shape: RoundedRectangleBorder(borderRadius: AppConfig.borderRadiusMain),
    surfaceTintColor: Colors.grey.shade200,
    backgroundColor: Colors.white,
    titleTextStyle: AppTextStyle.bold(rawFontSize: AppConfig.defaultRawTextSize + 1.0),
  ),
  inputDecorationTheme: InputDecorationTheme(
    contentPadding: const EdgeInsets.all(16),
    fillColor: Colors.grey.shade100,
    filled: true,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide.none,
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: AppConfig.borderRadiusMain,
      borderSide: BorderSide(
        color: AppColors.mainColor,
      ),
    ),
  ),
  dividerTheme: DividerThemeData(
    color: Colors.grey.shade100,
    thickness: 1.2,
  ),
);
