import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'app.dart';
import 'color.dart';
import 'text_style.dart';

// bool useGreenColor = true;

// final _appBarTheme = AppBarTheme(
//   // backgroundColor: Color(0xffFFFCF3), //Colors.white,
//   backgroundColor: Color(0xFFFDFDFD), //Colors.white,
//   scrolledUnderElevation: 0,
//   elevation: 0,
//   shadowColor: Colors.transparent,
//   titleTextStyle: TextStyle(
//     fontSize: 20,
//     fontWeight: FontWeight.bold,
//     color: AppColors.mainColor,
//   ),
//   iconTheme: IconThemeData(
//     color: AppColors.mainColor,
//   ),
// );

// const _dialogTheme = DialogTheme(
//   surfaceTintColor: Colors.white,
//   backgroundColor: Colors.white,
// );

// const _cardTheme = CardTheme(
//   elevation: 0,
//   color: Colors.white,
// );

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

// const _iconTheme = IconThemeData(
//   size: 24,
// );
// final _inputDecorationTheme = InputDecorationTheme(
//   contentPadding: const EdgeInsets.all(12),
//   fillColor: Color(0XFFF9FAFA),
//   filled: true,
//   enabledBorder: OutlineInputBorder(
//     borderRadius: BorderRadius.circular(8),
//     borderSide: BorderSide(
//       color: Color(0xFFDCDCDC),
//     ),
//   ),
//   disabledBorder: OutlineInputBorder(
//     borderRadius: BorderRadius.circular(8),
//     borderSide: BorderSide(
//       color: Color(0xFFDCDCDC),
//     ),
//   ),
//   border: const OutlineInputBorder(),
//   focusedBorder: OutlineInputBorder(
//     borderRadius: BorderRadius.circular(8),
//     borderSide: BorderSide(
//       color: AppColors.blue,
//     ),
//   ),
// );

// final _buttonThem = ButtonThemeData(
//   minWidth: 120,
//   buttonColor: AppColors.mainColor,
//   shape: RoundedRectangleBorder(
//     borderRadius: BorderRadius.circular(12),
//   ),
// );

// final _filledButtonThemeData = FilledButtonThemeData(
//   style: ButtonStyle(
//     backgroundColor: MaterialStateProperty.all(AppColors.mainColor),
//     foregroundColor: MaterialStateProperty.all(Colors.white),
//   ),
// );

// final _chipTheme = ChipThemeData(
//   side: BorderSide.none,
//   backgroundColor: Colors.white,
//   shape: RoundedRectangleBorder(
//     borderRadius: BorderRadius.circular(50),
//   ),
// );

// final _listTileTheme = ListTileThemeData(
//   tileColor: Colors.white,
// );

// final FloatingActionButtonThemeData _floatingActionButtonThemeData = FloatingActionButtonThemeData(
//   backgroundColor: AppColors.secondColor,
//   foregroundColor: Colors.white,
//   extendedTextStyle: AppTextStyle.semiBold(),
// );

// final _bottomSheetTheme = BottomSheetThemeData(
//   backgroundColor: Color(0xffF5F5F5),
// );

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
    titleTextStyle: AppTextStyle.bold(color: AppColors.white),
  ),
  dialogTheme: DialogTheme(
    shape: RoundedRectangleBorder(borderRadius: AppConfig.borderRadiusMain),
    surfaceTintColor: Colors.grey.shade200,
    backgroundColor: Colors.white,
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
