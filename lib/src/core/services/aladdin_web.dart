import 'dart:convert';
import 'dart:io';

import 'package:aladdin_franchise/src/core/network/app_exception.dart';
import 'package:aladdin_franchise/src/models/app_update.dart';
import 'package:aladdin_franchise/src/models/restaurant_config.dart';
import 'package:aladdin_franchise/src/utils/app_log.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

/// Author: sondv
/// Created 02/12/2023 at 09:16

///
class AladdinWebService {
  AladdinWebService._();
  static final AladdinWebService _instance = AladdinWebService._();
  static AladdinWebService get instance => _instance;

  Future<AppUpdateModel> getLatesetVersion() async {
    final url = Uri.parse(
        'https://aladdin-pos.github.io/api/lateset_version_pos_lite.json');
    final defaultHeaders = <String, String>{
      'Content-Type': 'application/json; charset=utf-8',
      'Accept': 'application/json',
    };
    try {
      var response = await http.get(
        url,
        headers: defaultHeaders,
      );
      if (response.statusCode == 200) {
        return AppUpdateModel.fromJson(
            jsonDecode(utf8.decode(response.bodyBytes)));
      }
      throw AppException(statusCode: response.statusCode);
    } catch (ex) {
      showLog(ex);
      if (ex is AppException) rethrow;
      throw AppException(message: ex.toString());
    }
  }

  Future<List<RestaurantConfigModel>> getRestaurantConfig() async {
    final url =
        Uri.parse('https://aladdin-pos.github.io/api/restaurant_config.json');
    final defaultHeaders = <String, String>{
      'Content-Type': 'application/json; charset=utf-8',
      'Accept': 'application/json',
    };
    try {
      var response = await http.get(
        url,
        headers: defaultHeaders,
      );
      if (response.statusCode == 200) {
        return jsonDecode(utf8.decode(response.bodyBytes))
            .map<RestaurantConfigModel>(
                (e) => RestaurantConfigModel.fromJson(e))
            .toList();
      }
      throw AppException(statusCode: response.statusCode);
    } catch (ex) {
      showLog(ex);
      if (ex is AppException) rethrow;
      throw AppException(message: ex.toString());
    }
  }

  Future<List<String>> getRestaurantTags() async {
    final url =
        Uri.parse('https://aladdin-pos.github.io/api/restaurant_tags.json');
    final defaultHeaders = <String, String>{
      'Content-Type': 'application/json; charset=utf-8',
      'Accept': 'application/json',
    };
    try {
      var response = await http.get(
        url,
        headers: defaultHeaders,
      );
      if (response.statusCode == 200) {
        return jsonDecode(utf8.decode(response.bodyBytes))
            .map<String>((e) => e.toString())
            .toList();
      }
      throw AppException(statusCode: response.statusCode);
    } catch (ex) {
      showLog(ex);
      if (ex is AppException) rethrow;
      throw AppException(message: ex.toString());
    }
  }
}

final aladdinWebLatesetVersionProvider =
    FutureProvider.autoDispose<AppUpdateModel>((ref) async {
  showLog("load", flags: 'aladdinWebLatesetVersionProvider');
  return await AladdinWebService.instance.getLatesetVersion();
});

final checkUpdateAppWindowsProvider =
    FutureProvider.autoDispose<AppUpdateResult>((ref) {
  var appUpdate = ref.watch(aladdinWebLatesetVersionProvider);
  return appUpdate.when(
    data: (data) {
      // var data
      showLogs(data, flags: 'data update app');
      return AppUpdateResult(
        isEnable: (Platform.isAndroid
            ? data.checkEnableAndroid
            : data.checkEnableWindows),
        isRequired: data.isRequired,
      );
    },
    error: (e, s) => const AppUpdateResult(),
    loading: () => const AppUpdateResult(),
  );
});

final restaurantConfigAladdinWebProvider =
    FutureProvider.autoDispose<List<RestaurantConfigModel>>((ref) async {
  showLog("load", flags: 'restaurantConfigForWindowsProvider');
  return await AladdinWebService.instance.getRestaurantConfig();
});

/// Lấy danh sách tags nhà hàng thông qua web aladdin pos

final restaurantTagsProvider =
    FutureProvider.autoDispose<List<String>>((ref) async {
  showLog("load", flags: 'restaurantTagsProvider');
  return await AladdinWebService.instance.getRestaurantTags();
});
