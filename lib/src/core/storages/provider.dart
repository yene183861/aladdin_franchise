import 'dart:ui';

import 'package:aladdin_franchise/generated/l10n.dart';
import 'package:aladdin_franchise/src/configs/api.dart';
import 'package:aladdin_franchise/src/configs/app.dart';
import 'package:aladdin_franchise/src/configs/enums/type_order.dart';
import 'package:aladdin_franchise/src/core/network/repository/responses/login.dart';
import 'package:aladdin_franchise/src/core/storages/local.dart';
import 'package:aladdin_franchise/src/data/enum/language.dart';
import 'package:aladdin_franchise/src/features/pages/home/provider.dart';
import 'package:aladdin_franchise/src/models/product_selecting.dart';
import 'package:aladdin_franchise/src/models/restaurant_config.dart';
import 'package:aladdin_franchise/src/models/setting/app_setting.dart';
import 'package:aladdin_franchise/src/models/setting/print_setting.dart';
import 'package:aladdin_franchise/src/utils/app_log.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:network_info_plus/network_info_plus.dart';

import '../../models/order_time.dart';

/// Kiếm tra xem phần mềm đã được config api chưa
final checkConfigApiProvider = Provider<bool>((ProviderRef<bool> ref) {
  var urlApi = LocalStorage.getApiUrl();
  return urlApi.isNotEmpty;
});

/// Kiếm tra xem người dùng đã đăng nhập ứng dụng chưa
final checkLoginProvider =
    FutureProvider<bool>((FutureProviderRef<bool> ref) async {
  try {
    final String token = LocalStorage.getToken();
    // Lấy thông tin api url
    final urlApi = LocalStorage.getApiUrl();
    ApiConfig().changeApi(urlApi);
    // Get app style
    final styleId = LocalStorage.getStyle();
    // CustomStyle().updateStyle(styleId);
    await Future.delayed(const Duration(milliseconds: 1000));
    return token != "";
  } catch (ex) {
    showLog(ex, flags: "checkLoginProvider");
    return false;
  }
});

/// Lấy danh sách sản phẩm đang chọn của đơn hàng hiện tại
final productsSelectingByOrderProvider =
    Provider.autoDispose<ProductSelectingModel?>(
        (ProviderRef<ProductSelectingModel?> ref) {
  var orderSelect = ref.watch(homeProvider).orderSelect;
  if (orderSelect != null) {
    final psOrders = LocalStorage.getProductsSelecting();
    try {
      return psOrders
          .firstWhere((element) => element.orderId == orderSelect.id);
    } catch (ex) {
      return null;
    }
  }
  return null;
});

/// lấy thông tin của user bao gồm cả thông tin nhà hàng
final userInfoProvider =
    Provider<LoginResponse>((ProviderRef<LoginResponse> ref) {
  final data = LocalStorage.getDataLogin();
  return data ?? const LoginResponse(status: 200);
});

/// Lấy thông tin lịch sử gọi món của 1 món ăn
/// ids[0]: orderId
/// ids[1]: productId
final ProviderFamily<List<ProductOrderTimeModel>, int> orderTimeForProduct =
    Provider.family<List<ProductOrderTimeModel>, int>(
        (ProviderRef<List<ProductOrderTimeModel>> ref, productId) {
  final orderId = ref.watch(homeProvider).orderSelect?.id ?? 0;
  final data = LocalStorage.getOrderTimeForProduct(orderId, productId);
  return data;
});

/// lấy thông tin thiết bị
/// [0]: mã thiết bị
///
/// [1]: ip network thiết bị
///
/// [2]: wifi name
final FutureProvider<List<String>> deviceProvider =
    FutureProvider<List<String>>((FutureProviderRef<List<String>> ref) async {
  final deviceId = LocalStorage.getDeviceId();
  final networkInfo = await NetworkInfo().getWifiIP();
  final wifiName = await NetworkInfo().getWifiName();
  showLog('load', flags: 'deviceProvider');
  return [
    deviceId.toString(),
    networkInfo.toString(),
    wifiName ?? "Không xác định"
  ];
});

/// get type order for waiter
/// 0: DEFAULT
/// 1: ON
/// 2: OFFLINE
final typeOrderWaiterProvider =
    Provider.autoDispose<String>((ProviderRef<String> ref) {
  var type = LocalStorage.getTypeOrderWaiter();
  var typeOrder = "";
  switch (type) {
    case 1:
      typeOrder = S.current.orderOnline;
      break;
    case 2:
      typeOrder = S.current.orderOffline;
      break;
    default:
      typeOrder = S.current.orderOffline;
      break;
  }
  return typeOrder;
});

final enableOrderOnlineProvider = Provider<bool>((ref) {
  return LocalStorage.getEnableOrderOnline();
});

final restaurantConfigLocalProvider = Provider<RestaurantConfigModel?>((ref) {
  return LocalStorage.getRestaurantConfig();
});

final checkUseKDSProvider = Provider.autoDispose<bool>((ref) {
  var dataLogin = LocalStorage.getDataLogin();
  showLog(dataLogin?.restaurant?.posStatus, flags: "checkUseKDS");
  return dataLogin?.restaurant?.posStatus ?? false;
});

final styleAppProvider = Provider.autoDispose<RestaurantStyle>((ref) {
  var styleId = LocalStorage.getStyle();
  switch (styleId) {
    case 0:
      return RestaurantStyle.other;
    case 1:
      return RestaurantStyle.btqm;
    case 2:
      return RestaurantStyle.longwang;
    case 3:
      return RestaurantStyle.btap;
    case 4:
      return RestaurantStyle.tianlong;
    case 5:
      return RestaurantStyle.haiSuPotRice;
    default:
      return RestaurantStyle.other;
  }
});

final languageLocalProvider = Provider<AppLanguageEnum>((ref) {
  var value = LocalStorage.getLanguageLocal();
  kAppLanguageLocal = value.name;
  return value;
});

final customerLanguageLocalProvider = Provider<AppLanguageEnum>((ref) {
  return LocalStorage.getCustomerLanguageLocal();
});
final printSettingProvider = Provider<AppPrintSettingModel>((ref) {
  return LocalStorage.getPrintSetting();
});
final appSettingProvider = Provider<AppSettingModel>((ref) {
  return LocalStorage.getAppSetting();
});
final apiUrlProvider = Provider<String>((ref) {
  return LocalStorage.getApiUrl();
});

final typeOrderProvider = Provider.autoDispose<TypeOrderEnum>((ref) {
  var type = LocalStorage.getTypeOrderWaiter();
  return convertToTypeOrderEnum(type);
});
