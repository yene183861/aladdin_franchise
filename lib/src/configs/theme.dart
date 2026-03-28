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

final cnhsAppTheme = ThemeData(
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

class AppTheme {
  static ThemeData cnhsThemeData = ThemeData(
    brightness: Brightness.light,

    colorScheme: ColorScheme(
      brightness: Brightness.light,

      /// 🔥 PRIMARY (brand chính)
      primary: Color(0xFFE64A19),
      onPrimary: Color(0xFFFFFFFF),
      primaryContainer: Color(0xFFFFDBD0),
      onPrimaryContainer: Color(0xFF3A0B00),
      // 🧊 SECONDARY (text phụ / UI phụ)
      secondary: Color(0xFF455A64),
      onSecondary: Color(0xFFFFFFFF),
      secondaryContainer: Color(0xFFC9D6DC),
      onSecondaryContainer: Color(0xFF1B2A30),

      // 🌊 TERTIARY (accent / selected)
      tertiary: Color(0xFF00799C),
      onTertiary: Color(0xFFFFFFFF),
      tertiaryContainer: Color(0xFFC5E7F2),
      onTertiaryContainer: Color(0xFF002F3D),

      // ❌ ERROR
      error: Color(0xFFBA1A1A),
      onError: Color(0xFFFFFFFF),
      errorContainer: Color(0xFFFFDAD6),
      onErrorContainer: Color(0xFF410002),

      // 🧱 BACKGROUND / SURFACE
      background: Color(0xFFF5F5F7),
      onBackground: Color(0xFF1A1A1A),

      surface: Color(0xFFFFFFFF),
      onSurface: Color(0xFF1A1A1A),

      // 🧩 VARIANT (divider, card nhẹ)
      surfaceVariant: Color(0xFFE0E0E0),
      onSurfaceVariant: Color(0xFF444444),

      // 🧊 outline
      outline: Color(0xFFBDBDBD),

      // shadow / overlay
      shadow: Color(0xFF000000),
      scrim: Color(0xFF000000),

      // 🧱 elevation tint (Material 3)
      surfaceTint: Color(0xFFE64A19),
    ),
    // primaryColor: const Color(0xFFE64A19),
    // scaffoldBackgroundColor: Colors.black87,
    // textTheme: const TextTheme(
    //   bodyMedium: TextStyle(color: Color(0xFF1A1A1A)),
    //   bodySmall: TextStyle(color: Color(0xFF1A1A1A)),
    // ),
    // primaryTextTheme: TextTheme(),
    // colorScheme: const ColorScheme.light().copyWith(
    //   primary: AppColors.primary,
    //   secondary: AppColors.primaryDark,
    //   surface: AppColors.surface,
    //   error: AppColors.error,
    // ),
    // textTheme: const TextTheme(
    //   bodyMedium: TextStyle(color: AppColors.textPrimary),
    //   bodySmall: TextStyle(color: AppColors.textSecondary),
    // ),
    // appBarTheme: const AppBarTheme(
    //   backgroundColor: Colors.white,
    //   elevation: 0,
    //   foregroundColor: AppColors.textPrimary,
    // ),
    // elevatedButtonTheme: ElevatedButtonThemeData(
    //   style: ElevatedButton.styleFrom(
    //     backgroundColor: AppColors.primary,
    //     foregroundColor: Colors.white,
    //     shape: RoundedRectangleBorder(
    //       borderRadius: BorderRadius.circular(12),
    //     ),
    //   ),
    // ),
  );
}
