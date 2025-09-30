import 'dart:core';

import 'package:aladdin_franchise/src/configs/const.dart';
import 'package:aladdin_franchise/src/core/storages/local.dart';
import 'package:aladdin_franchise/src/models/category.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// check is Android
bool kCheckAndroidPlatform = true;
bool kCheckIsDeviceSmall = false;

//
bool kEnableFirebaseAppWindowOnly = true;

/// token xác thực waiter
String kToken = "";

/// Xác định hình thức bán hàng
int kTypeOrder = 0;

/// Kiểu ngôn ngữ hiển thị
String kAppLanguageLocal = AppLanguageLocal.vietnamese;

/// devices Id
String kDeviceId = '';

final appConfig = AppConfig();

class AppConfig {
  static bool useFranchise = true;
  static bool initHomeProvider = false;
  static const String companyName = "Aladdin.,JSC";
  static const String appName = "APOS Franchise";
  // app version & version code phải giống trong /android/app/build.gradle
  // lấy thông tin phiên bản đang bị lỗi trên windows nên config trong này nhé ~_~
  static const String appVersion = "V1.0.0";
  static const int versionCode = 1;
  static const String appUpdateFileName = "apos-franchise-update.apk";
  final String urlHelp =
      "https://sites.google.com/aladdin-jsc.com/aladdin-pos-docs?usp=sharing";

  static const List<String> reasonCancelItem = [
    "Khách chọn nhầm",
    "Khách báo huỷ",
    "Hết món",
    "Món ra trễ",
  ];

  final List<String> ratingPayment = [
    "Đồ ăn ngon",
    "Không gian thoải mái",
    "Thái độ nhân viên tốt",
    "Phục vụ nhanh",
  ];

  /// 1 - Online
  static const int orderOnlineValue = 1;

  /// 2 - Offline
  static const int orderOfflineValue = 2;

  final String codeSecurity = kDebugMode ? "1" : "400501";
  final String keyConfig = "config";

  static NumberFormat formatCurrency({bool isCustomerPage = false}) {
    // var localCode =
    // isCustomerPage
    //     ? LocalStorage.getCustomerLanguageLocal()
    //     : LocalStorage.getLanguageLocal();
    return NumberFormat.simpleCurrency(locale: 'vi');
  }

  final allCategory = const CategoryModel(id: -1, title: "TẤT CẢ");
  final dateFormatYYYYMMDD = DateFormat("yyyy-MM-dd");
  final dateFormatDDMMYYYY = DateFormat("dd-MM-yyyy");
  final dateFormatHhMmSsDDMMYYYY = DateFormat("HH:mm:ss | dd-MM-yyyy");
  final dateFormatDDMMYYYYHhMmSs = DateFormat("dd-MM-yyyy HH:mm");
  final dateFormatHhMmSs = DateFormat("HH:mm:ss");
  static final navigatorKey = GlobalKey<NavigatorState>();
  final String codeVerifyDefault = '123123';

  // gender
  /// [0] => male (Nam)
  ///
  /// [1] => female (Nữ)
  final List<String> gender = [
    "male",
    "female",
  ];

  /// Tạm thời lấy tài khoản set cứng
  // String getVietQRBank({
  //   required UserBankModel userBank,
  //   required num amount,
  //   required String addInfo,
  // }) {
  //   return "https://img.vietqr.io/image/${userBank.bankBin}-${userBank.bankNumber}-qr_only.png?amount=$amount&addInfo=$addInfo";
  // }

  String getNameByStatus(int? status) {
    switch (status) {
      case 1:
        return "Mới gọi";
      case 2:
        return "Trong bếp";
      case 3:
        return "Đang nấu";
      case 4:
        return "Đã nấu xong";
      case 5:
        return "Đã kiểm đồ";
      case 6:
        return "Đã mang lên";
      default:
        return "Không xác định";
    }
  }

  static BorderRadius borderRadiusMain = BorderRadius.circular(12);
  static BorderRadius borderRadiusSecond = BorderRadius.circular(8);
  static double sizeBorderRadiusMain = 12;
  static double sizeBorderRadiusSecond = 8;

  static Color gray50 = const Color(0xFFFAFAFA);
  static ShapeBorder shapeBorderMain =
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(12));
  static ShapeBorder shapeBorderSecond =
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(8));
}

class NetworkMessageConfig {
  static const String unexpected = "Có lỗi xảy ra, vui lòng thử lại";
  static const String checkPingNetwork =
      "Mạng không xác định, vui lòng kiểm tra lại kết nối và thử lại";
  static const String connectionTimeout = 'Request Timeout';
}

class NetworkCodeConfig {
  static const int unexpected = 3198;

  /// 408
  static const int requestTimeout = 408;

  /// 200
  static const int ok = 200;

  /// 401
  static const int unauthorized = 401;

  /// 423
  static const int locked = 423;

  /// 500
  static const int internalServerError = 500;
}

enum CancelDishInOrderStatus { success, cancelNotInBill, error }

enum FindCustomerStatus { success, notFound, error }

// Demo Bank
// const List<UserBankModel> kUserBank = [
//   UserBankModel(
//     title: 'TPBank 1',
//     fullName: "TRAN THANH MAI",
//     bankNumber: "88880255004",
//     bankName: "TP Bank",
//     bankBin: "970423",
//     useInvoice: false,
//   ),
//   UserBankModel(
//     title: 'TPBank 2',
//     fullName: "TRAN THANH MAI",
//     bankNumber: "66660255004",
//     bankName: "TP Bank",
//     bankBin: "970423",
//     useInvoice: false,
//   ),
//   UserBankModel(
//     title: 'VNPay 1',
//     fullName: "ALADDIN 1",
//     bankNumber: "88886666666",
//     bankName: "VNPay",
//     bankBin: "970415",
//     useInvoice: true,
//   ),
//   UserBankModel(
//     title: 'VNPay 2',
//     fullName: "ALADDIN 2",
//     bankNumber: "6666888888",
//     bankName: "VNPay",
//     bankBin: "970415",
//     useInvoice: true,
//   ),
// ];

enum RestaurantStyle {
  other,
  btqm,
  longwang,
  btap,
  tianlong,
  haiSuPotRice,
}
