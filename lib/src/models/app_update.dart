import 'package:aladdin_franchise/src/configs/app.dart';
import 'package:aladdin_franchise/src/core/storages/local.dart';
import 'package:aladdin_franchise/src/utils/app_log.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_update.freezed.dart';
part 'app_update.g.dart';

@freezed
class AppUpdateModel with _$AppUpdateModel {
  @JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
  const factory AppUpdateModel({
    required String version,
    @Default('') String note,
    @Default('') String apkLink,
    @Default('') String windowsLink,
    @JsonKey(fromJson: dateTimeFromDynamic) required DateTime timeRelease,
    @Default(true) bool active,
    @Default(0) int versionCode,
    @Default([]) List<dynamic> only,
    @Default(false) bool isRequired,
  }) = _AppUpdateModel;

  factory AppUpdateModel.fromJson(Map<String, dynamic> json) => _$AppUpdateModelFromJson(json);

  const AppUpdateModel._();

  bool get checkEnable {
    var restaurantId = LocalStorage.getKeepRestaurantId();
    return (active &&
        (version != AppConfig.appVersion) &&
        (versionCode > AppConfig.versionCode) &&
        (only.isEmpty || only.contains(restaurantId)));
  }

  bool get checkEnableWindows => checkEnable && windowsLink.isNotEmpty;
  bool get checkEnableAndroid => checkEnable && apkLink.isNotEmpty;
}

DateTime dateTimeFromDynamic(dynamic timeRelease) {
  if (timeRelease.runtimeType == Timestamp) {
    return timeRelease.toDate();
  } else {
    return DateTime.parse(timeRelease.toString());
  }
}

@freezed
class AppUpdateNew with _$AppUpdateNew {
  @JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
  const factory AppUpdateNew({
    @Default('') String version,
    @Default('') String note,
    DateTime? timeRelease,
    @Default(false) bool active,
    @Default('') String mobileAppLink,
    @Default('') String desktopAppLink,
    @Default(0) int versionCode,
    @Default([]) List<dynamic> only,
    @Default(false) bool isRequired,
  }) = _AppUpdateNew;

  factory AppUpdateNew.fromJson(Map<String, dynamic> json) => _$AppUpdateNewFromJson(json);

  const AppUpdateNew._();

  bool get checkEnable {
    var restaurantId = LocalStorage.getKeepRestaurantId();
    return (active &&
        (version != AppConfig.appVersion) &&
        (versionCode > AppConfig.versionCode) &&
        (only.isEmpty || only.contains(restaurantId)));
  }
}

/// Dùng để trả về khi check update cho cả android và windows
///
/// Đang dùng 2 cái độc lập nên tạo 1 cái để dùng chung
class AppUpdateResult {
  final bool isEnable;
  final bool isRequired;

  const AppUpdateResult({
    this.isEnable = false,
    this.isRequired = false,
  });

  @override
  String toString() {
    return "isEnable: $isEnable | isRequired: $isRequired";
  }
}
