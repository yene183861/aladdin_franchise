import 'dart:convert';
import 'dart:io';

import 'package:aladdin_franchise/generated/l10n.dart';
import 'package:aladdin_franchise/src/configs/app.dart';
import 'package:aladdin_franchise/src/configs/const.dart';
import 'package:aladdin_franchise/src/configs/enums/app_log_action.dart';
import 'package:aladdin_franchise/src/core/network/api/app_exception.dart';
import 'package:aladdin_franchise/src/core/network/repository/responses/login.dart';
import 'package:aladdin_franchise/src/core/services/send_log/log_service.dart';
import 'package:aladdin_franchise/src/data/enum/language.dart';
import 'package:aladdin_franchise/src/data/model/floor.dart';
import 'package:aladdin_franchise/src/data/model/table_layout_item.dart';
import 'package:aladdin_franchise/src/data/model/table_layout_setting.dart';
import 'package:aladdin_franchise/src/models/customer/customer_policy.dart';
import 'package:aladdin_franchise/src/models/employee_sale.dart';
import 'package:aladdin_franchise/src/models/error_log.dart';
import 'package:aladdin_franchise/src/models/info_policy_checkout.dart';
import 'package:aladdin_franchise/src/models/ip_order.dart';
import 'package:aladdin_franchise/src/models/order.dart';
import 'package:aladdin_franchise/src/models/order_offline/order_offline.dart';
import 'package:aladdin_franchise/src/models/order_time.dart';
import 'package:aladdin_franchise/src/models/product.dart';
import 'package:aladdin_franchise/src/models/product_selecting.dart';
import 'package:aladdin_franchise/src/models/restaurant_config.dart';
import 'package:aladdin_franchise/src/models/setting/app_setting.dart';
import 'package:aladdin_franchise/src/models/setting/print_setting.dart';
import 'package:aladdin_franchise/src/utils/app_log.dart';
import 'package:collection/collection.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class LocalStorage {
  static late SharedPreferences _prefs;
  static Future<void> initialize() async {
    var log = const ErrorLogModel(
      action: AppLogAction.localStorage,
      api: '',
    );
    try {
      _prefs = await SharedPreferences.getInstance();
    } catch (e) {
      LogService.sendLogs(log.copyWith(
          errorMessage: 'Prefs init failed, resetting... $e', createAt: DateTime.now()));
      showLogs('Prefs init failed, resetting... $e');
      try {
        final tempPrefs = await SharedPreferences.getInstance();
        await tempPrefs.clear();
        _prefs = tempPrefs;
      } catch (ex) {
        LogService.sendLogs(
            log.copyWith(errorMessage: 'Prefs recovery failed: $ex', createAt: DateTime.now()));
        showLogs('Prefs recovery failed: $ex');
        _prefs = await SharedPreferences.getInstance();
      }
    }
  }

  static const String _tokenKey = "token";
  static const String _dataLoginKey = "data_login";
  static const String _productsSelectingKey = "products_selecting_key";
  static const String _apiUrlConfig = "api_url_config";
  static const String _policyForCheckout = "policy_for_checkout";
  static const String _appStyle = "app_style";
  static const String _orderTime = "order_time";
  static const String _deviceId = "device_id";
  static const String _enableOrderOnline = 'enable_order_online';
  static const String _typeOrderWaiter = "type_order_waiter";
  static const String _restaurantConfig = "restaurant_config";
  static const String _languageLocal = "language_local";
  static const String _keepRestaurantId = "keep_restaurant_id";
  static const String _makeDeviceId = "make_device_id";
  static const String _checkDeviceAppUpdate = "check_device_app_update";
  static const String _lastReloadMenu = "last_reload_menu";
  static const String _orderOffline = "order_offline";
  static const String _imageOrder = "image_order";
  static const String _firebaseStatus = "firebase_status";
  static const String _notePerOrderItem = "note_per_order_item";
  static const String _customerLanguageLocal = "customer_language_local";
  // static const String _employeeSaleForOrder = "employee_sale_for_order";
  static const String _printers = "printers";
  // static const String _applyAgainOnlyCoupon = "apply_again_only_coupon";
  static const String printSetting = "print_setting";
  static const String appSetting = "app_setting";

  static const String tableLayout = "table_layout";
  static const String floors = "floors";
  static const String tableLayoutSetting = "table_layout_setting";

  static const String orderItemSelecting = "order_item_selecting";
  static const String _printerDevice = "printer_device";

  static String getToken() {
    return _prefs.getString(_tokenKey) ?? "";
  }

  static Future<void> setToken(String token) async {
    await _prefs.setString(_tokenKey, token);
  }

  static LoginResponse? getDataLogin() {
    var json = _prefs.getString(_dataLoginKey);
    return json == null ? null : LoginResponse.fromJson(jsonDecode(json));
  }

  static Future<void> setDataLogin(LoginResponse loginRepository) async {
    int restaurantId = loginRepository.restaurant?.id ?? -1;
    await _prefs.setString(_dataLoginKey, jsonEncode(loginRepository));
    await _prefs.setInt(_keepRestaurantId, restaurantId);
  }

  static int getKeepRestaurantId() {
    var restaurantId = _prefs.getInt(_keepRestaurantId);
    return restaurantId ?? -1;
  }

  static List<ProductSelectingModel> getProductsSelecting() {
    var json = _prefs.getString(_productsSelectingKey) ?? "[]";
    return List<ProductSelectingModel>.from(
        jsonDecode(json).map<ProductSelectingModel>((e) => ProductSelectingModel.fromJson(e)));
  }

  static void addProductsSelecting(int orderId, ProductModel productModel) async {
    var data = getProductsSelecting();
    // Check sự tồn tại của đơn hàng, nếu chưa có thì tạo mới
    if (data.any((element) => element.orderId == orderId)) {
      var psOrder = data.firstWhere((element) => element.orderId == orderId);
      // kiểm tra xem món đã có trong đơn chưa, nếu có thì +1
      // Nếu chưa thì add mới
      if (psOrder.products.any((element) => element.id == productModel.id)) {
        var product = psOrder.products.firstWhere((element) => element.id == productModel.id);
        var products = List<ProductModel>.from(data[data.indexOf(psOrder)].products);
        var productUpdate = product.copyWith(numberSelecting: product.numberSelecting + 1);
        products[products.indexOf(product)] = productUpdate;
        data[data.indexOf(psOrder)] = data[data.indexOf(psOrder)].copyWith(products: products);
      } else {
        var products = List<ProductModel>.from(data[data.indexOf(psOrder)].products);
        products.add(productModel.copyWith(numberSelecting: 1));
        data[data.indexOf(psOrder)] = data[data.indexOf(psOrder)].copyWith(products: products);
      }
    } else {
      data.add(ProductSelectingModel(
          orderId: orderId, products: [productModel.copyWith(numberSelecting: 1)]));
    }
    await _prefs.setString(_productsSelectingKey, jsonEncode(data));
  }

  static void removeProductsSelecting(int orderId, ProductModel productModel) async {
    var data = getProductsSelecting();
    // lấy đơn hàng
    var psOrder = data.firstWhere((element) => element.orderId == orderId);
    // Trừ số lượng món -1
    var product = psOrder.products.firstWhereOrNull((element) => element.id == productModel.id);
    if (product == null) return;
    if (product.numberSelecting > 1) {
      var products = List<ProductModel>.from(data[data.indexOf(psOrder)].products);
      var productUpdate = product.copyWith(numberSelecting: product.numberSelecting - 1);
      products[products.indexOf(product)] = productUpdate;
      data[data.indexOf(psOrder)] = data[data.indexOf(psOrder)].copyWith(products: products);
    }
    await _prefs.setString(_productsSelectingKey, jsonEncode(data));
  }

  static void deleteProductsSelecting(int orderId, ProductModel productModel) async {
    var data = getProductsSelecting();
    // lấy đơn hàng
    var psOrder = data.firstWhere((element) => element.orderId == orderId);
    // lấy ra sản phẩm cần xoá bỏ
    var product = psOrder.products.firstWhereOrNull((element) => element.id == productModel.id);
    if (product == null) return;
    var products = List<ProductModel>.from(data[data.indexOf(psOrder)].products);
    products.remove(product);
    data[data.indexOf(psOrder)] = data[data.indexOf(psOrder)].copyWith(products: products);
    await _prefs.setString(_productsSelectingKey, jsonEncode(data));
  }

  static void updateProductsSelecting(int orderId, ProductModel productModel,
      {int? quantity, String? note}) async {
    // tránh trường hợp nhấn luôn ạ :((
    if (quantity != null) {
      addProductsSelecting(orderId, productModel);
    }
    var data = getProductsSelecting();
    // lấy đơn hàng
    var psOrder = data.firstWhere((element) => element.orderId == orderId);
    // Cập nhật số lượng
    var product = psOrder.products.firstWhere((element) => element.id == productModel.id);
    var products = List<ProductModel>.from(data[data.indexOf(psOrder)].products);
    var productUpdate = product.copyWith(
      numberSelecting: quantity ?? product.numberSelecting,
      note: note,
    );
    products[products.indexOf(product)] = productUpdate;
    data[data.indexOf(psOrder)] = data[data.indexOf(psOrder)].copyWith(products: products);
    await _prefs.setString(_productsSelectingKey, jsonEncode(data));
  }

  static void updateQuantityProductsSelecting(
      int orderId, ProductModel productModel, int quantity) async {
    if (quantity == 0) {
      deleteProductsSelecting(orderId, productModel);
      return;
    }
    var data = getProductsSelecting();
    // lấy đơn hàng
    var psOrder = data.firstWhere((element) => element.orderId == orderId);
    var product = psOrder.products.firstWhereOrNull((element) => element.id == productModel.id);
    if (product == null) return;

    var products = List<ProductModel>.from(data[data.indexOf(psOrder)].products);
    var productUpdate = product.copyWith(numberSelecting: quantity);
    products[products.indexOf(product)] = productUpdate;
    data[data.indexOf(psOrder)] = data[data.indexOf(psOrder)].copyWith(products: products);
    await _prefs.setString(_productsSelectingKey, jsonEncode(data));
  }

  static void deleteOrder(int orderId) async {
    var data = getProductsSelecting();
    // lấy đơn hàng
    var psOrder = data.firstWhereOrNull((element) => element.orderId == orderId);
    if (psOrder != null) {
      data.remove(psOrder);
    }
    await _prefs.setString(_productsSelectingKey, jsonEncode(data));
  }

  static String getApiUrl() {
    return _prefs.getString(_apiUrlConfig) ?? "";
  }

  static Future<void> setApiUrl(String apiUrl) async {
    await _prefs.setString(_apiUrlConfig, apiUrl);
  }

  // Policy checkout
  static List<InfoPolicyCheckoutModel> getPolicyCheckout() {
    var json = _prefs.getString(_policyForCheckout) ?? "[]";
    return List<InfoPolicyCheckoutModel>.from(
        jsonDecode(json).map<InfoPolicyCheckoutModel>((e) => InfoPolicyCheckoutModel.fromJson(e)));
  }

  static void updatePolicyCheckout(int orderId, InfoPolicyCheckoutModel infoPolicyCheckout) async {
    var data = getPolicyCheckout();
    // Check sự tồn tại của đơn hàng, nếu chưa có thì tạo mới
    if (data.any((element) => element.orderId == orderId)) {
      var policy = data.firstWhere((element) => element.orderId == orderId);
      data[data.indexOf(policy)] = infoPolicyCheckout;
    } else {
      data.add(infoPolicyCheckout);
    }
    await _prefs.setString(_policyForCheckout, jsonEncode(data));
  }

  static Future<void> deletePolicy(int orderId) async {
    var data = getPolicyCheckout();
    var checkoutOrder = data.firstWhereOrNull((element) => element.orderId == orderId);
    if (checkoutOrder != null) {
      data.remove(checkoutOrder);
    }
    await _prefs.setString(_policyForCheckout, jsonEncode(data));
  }

  static Future<void> clearCache() async {
    await _prefs.setString(_policyForCheckout, "[]");
    await _prefs.setString(_productsSelectingKey, "[]");
    await _prefs.setString(_orderTime, "[]");
    await _prefs.setStringList(_orderOffline, []);
    await _prefs.setStringList(_imageOrder, []);
  }

  static Future<void> logout() async {
    await LocalStorage.setToken("");
    await clearPrinters();
    await clearNotePerOrderItem();
    // await clearApplyAgainOnlyCoupon();
    await clearOrderItemSelecting();
  }

  static void changeStyle(int styleId) async {
    await _prefs.setInt(_appStyle, styleId);
  }

  static int getStyle() {
    return _prefs.getInt(_appStyle) ?? 0;
  }

  /// order time
  // get order time
  static List<OrderTimeModel> getOrderTimes() {
    var json = _prefs.getString(_orderTime) ?? "[]";
    return List<OrderTimeModel>.from(
        jsonDecode(json).map<OrderTimeModel>((e) => OrderTimeModel.fromJson(e)));
  }

  // cập nhật order time
  static void updateOrderTime(int orderId, ProductOrderTimeModel productOrderTime) async {
    var data = getOrderTimes();
    // Check sự tồn tại của đơn hàng, nếu chưa có thì tạo mới
    if (data.any((element) => element.orderId == orderId)) {
      var pOrderTime = data.firstWhere((element) => element.orderId == orderId);
      // thêm sản phẩm vào order
      var products = List<ProductOrderTimeModel>.from(data[data.indexOf(pOrderTime)].products);
      products.add(productOrderTime);
      data[data.indexOf(pOrderTime)] = data[data.indexOf(pOrderTime)].copyWith(products: products);
    } else {
      data.add(OrderTimeModel(orderId: orderId, products: [productOrderTime]));
    }
    await _prefs.setString(_orderTime, jsonEncode(data));
  }

  // xoá bỏ order time
  static Future<void> deleteOrderTime(int orderId) async {
    var data = getOrderTimes();
    // lấy đơn hàng
    var pOrderTime = data.firstWhereOrNull((element) => element.orderId == orderId);
    if (pOrderTime != null) {
      data.remove(pOrderTime);
    }
    showLog('done $orderId', flags: 'deleteOrderTime');
    await _prefs.setString(_orderTime, jsonEncode(data));
  }

  // Lấy thông tin lịch sử gọi món của 1 món ăn
  static List<ProductOrderTimeModel> getOrderTimeForProduct(int orderId, int productId) {
    var data = getOrderTimes();
    List<ProductOrderTimeModel> result = [];
    if (data.any((element) => element.orderId == orderId)) {
      var pOrderTime = data.firstWhere((element) => element.orderId == orderId);
      for (var element in pOrderTime.products) {
        if (element.productId == productId) {
          result.add(element);
        }
      }
    }
    result.sort((a, b) => b.time.compareTo(a.time));
    return result;
  }

  static int? getDeviceId() {
    return _prefs.getInt(_deviceId);
  }

  static Future<void> setDeviceId(int id) async {
    await _prefs.setInt(_deviceId, id);
  }

  /// Check nhà hàng có cho phép bán ONLINE hay không
  ///
  /// -> true: Có bán online
  ///
  /// -> false: Không bán online
  static bool getEnableOrderOnline() {
    return _prefs.getBool(_enableOrderOnline) ?? false;
  }

  static Future<void> setEnableOrderOnline(bool isEnable) async {
    await _prefs.setBool(_enableOrderOnline, isEnable);
  }

  static int getTypeOrderWaiter() {
    return _prefs.getInt(_typeOrderWaiter) ?? AppConfig.orderOfflineValue;
  }

  static Future<void> setTypeOrderWaiter(int type) async {
    await _prefs.setInt(_typeOrderWaiter, type);
  }

  static RestaurantConfigModel? getRestaurantConfig() {
    try {
      var json = _prefs.getString(_restaurantConfig);
      return json == null ? null : RestaurantConfigModel.fromJson(jsonDecode(json));
    } catch (ex) {
      return null;
    }
  }

  static Future<void> setRestaurantConfig(RestaurantConfigModel? restaurantConfigModel) async {
    if (restaurantConfigModel == null) {
      await _prefs.remove(_restaurantConfig);
    }
    await _prefs.setString(_restaurantConfig, jsonEncode(restaurantConfigModel));
  }

  /// True => POS dùng với KDS
  ///
  /// False => POS mặc định
  static bool getKdsStatus() {
    var dataLogin = getDataLogin();
    return dataLogin?.restaurant?.posStatus ?? false;
  }

  static AppLanguageEnum getLanguageLocal() {
    return AppLanguageEnum.values
        .byName(_prefs.getString(_languageLocal) ?? AppLanguageEnum.vi.name);
  }

  static Future<void> setLanguageLocal(AppLanguageEnum value) async {
    await _prefs.setString(_languageLocal, value.name);
  }

  // Đánh giá trải nghiệm khách hàng

  // static List<CustomerRatingSaveLocal> _getCustomerRatingSave() {
  //   final json = _prefs.getString(_customerRatingByOrder) ?? "[]";
  //   return List<CustomerRatingSaveLocal>.from(jsonDecode(json)
  //       .map<CustomerRatingSaveLocal>(
  //           (e) => CustomerRatingSaveLocal.fromJson(e)));
  // }

  // static List<CustomerRating>? getCustomerRatingByOrder(int orderId) {
  //   final all = _getCustomerRatingSave();
  //   final rating =
  //       all.firstWhereOrNull((element) => element.orderId == orderId);
  //   return rating?.customerRating;
  // }

  // static Future<void> updateCustomerRating(
  //     int orderId, List<CustomerRating> ratings) async {
  //   final all = _getCustomerRatingSave();
  //   final ratingOld =
  //       all.firstWhereOrNull((element) => element.orderId == orderId);

  //   if (ratingOld == null) {
  //     // tạo mới nếu chưa có
  //     all.add(CustomerRatingSaveLocal(
  //       orderId: orderId,
  //       customerRating: ratings,
  //     ));
  //   } else {
  //     // cập nhật đánh giá
  //     all[all.indexOf(ratingOld)] = ratingOld.copyWith(customerRating: ratings);
  //   }
  //   await _prefs.setString(_customerRatingByOrder, jsonEncode(all));
  // }

  // static Future<void> deleteCustomerRating(int orderId) async {
  //   final all = _getCustomerRatingSave();
  //   all.removeWhere((element) => element.orderId == orderId);
  //   await _prefs.setString(_customerRatingByOrder, jsonEncode(all));
  // }

  /// Lọc-Kiểm món đang chọn khi có thay đổi menu bán
  static Future<void> updateProductSelectingReloadMenu(List<ProductModel> allProducts) async {
    try {
      var psOrders = getProductsSelecting();
      if (psOrders.isNotEmpty) {
        showLog("Check món đang chọn", flags: "ReloadMenu");
        for (var psOrder in psOrders) {
          var productOfOrder = List<ProductModel>.from(psOrder.products);
          for (var product in psOrder.products) {
            final productValid =
                allProducts.firstWhereOrNull((element) => element.id == product.id);
            if (productValid != null) {
              // Cập nhật lại thông tin món
              final productUpdate = productValid.copyWith(
                numberSelecting: product.numberSelecting,
                note: product.note,
              );
              productOfOrder[productOfOrder.indexOf(product)] = productUpdate;
            } else {
              // Xoá bỏ món đang chọn
              productOfOrder.remove(product);
            }
          }
          psOrders[psOrders.indexOf(psOrder)] = psOrder.copyWith(products: productOfOrder);
        }
        await _prefs.setString(_productsSelectingKey, jsonEncode(psOrders));
      }
    } catch (ex) {
      throw AppException.fromMessage(S.current.error_reload_menu_check_product_selecting);
    }
  }

  // make device id
  static String getMakeDeviceId() {
    return _prefs.getString(_makeDeviceId) ?? '';
  }

  // check firebase status
  static bool getFirebaseStatus() {
    if (Platform.isAndroid) {
      return true;
    }
    return _prefs.getBool(_firebaseStatus) ?? true;
  }

  static Future<void> initializeDeviceConfig() async {
    // device id
    if (getMakeDeviceId().isEmpty) {
      final makeDeviceId = const Uuid().v1();
      _prefs.setString(_makeDeviceId, makeDeviceId);
    }
    // firebase status
    if (_prefs.getBool(_firebaseStatus) == null) {
      _prefs.setBool(_firebaseStatus, true);
    }
  }

  // device app update
  static String? getDeviceAppUpdate() {
    return _prefs.getString(_checkDeviceAppUpdate);
  }

  static Future<void> setDeviceAppUpdate() async {
    _prefs.setString(_checkDeviceAppUpdate, AppConfig.appVersion);
  }

  /// Port của Redis
  static int getPortRedis() {
    var dataLogin = getDataLogin();
    return dataLogin?.redisPort ?? kRedisPortDefault;
  }

  static Future<void> setLastReloadMenu() async {
    await _prefs.setString(_lastReloadMenu, DateTime.now().toString());
  }

  static DateTime getLastReloadMenu() {
    final timeSave = _prefs.getString(_lastReloadMenu);
    if (timeSave == null) {
      return DateTime.now();
    }
    return DateTime.parse(timeSave);
  }

  // order offline

  static List<OrderOffline> getOrderOffline() {
    try {
      final dataRaw = _prefs.getStringList(_orderOffline) ?? [];
      final results = dataRaw.map((e) => OrderOffline.fromJson(jsonDecode(e))).toList();
      return results;
    } catch (ex) {
      return [];
    }
  }

  static Future<void> updateOrderOffline(OrderOffline orderOffline) async {
    try {
      List<OrderOffline> orders = getOrderOffline();
      final now = DateTime.now();
      // Loại bỏ đơn hàng >= 24h
      orders.removeWhere((element) => now.difference(element.lastUpdate).inHours >= 24);

      // Kiểm tra sự tồn tại của đơn bàn
      // Tồn tại => ghi đè dữ liệu
      // Đơn mới => thêm vào
      final orderExistIndex = orders.indexWhere((e) => e.order.id == orderOffline.order.id);
      if (orderExistIndex == -1) {
        orders.add(orderOffline);
      } else {
        orders[orderExistIndex] = orderOffline;
      }

      orders.sort((a, b) => b.lastUpdate.compareTo(a.lastUpdate));
      // chỉ giữ lại 30 đơn bàn gần nhất
      if (orders.length >= 29) {
        orders = orders.take(30).toList();
      }

      await _prefs.setStringList(_orderOffline, orders.map((e) => jsonEncode(e)).toList());
    } catch (ex) {
      showLog(ex, flags: 'LC-updateOrderOffline');
    }
  }

  // Image order payment
  // static List<ImageOrderLocal> getAllImageOrder() {
  //   try {
  //     final dataRaw = _prefs.getStringList(_imageOrder) ?? [];
  //     final images =
  //         dataRaw.map((e) => ImageOrderLocal.fromJson(jsonDecode(e))).toList();
  //     return images;
  //   } catch (ex) {
  //     showLog(ex, flags: 'getAllImageOrder');
  //     return [];
  //   }
  // }

  // static List<String> getImageByOrder(int orderId) {
  //   try {
  //     final images = getAllImageOrder();
  //     final imageByOrder =
  //         images.firstWhereOrNull((element) => element.orderId == orderId);
  //     return imageByOrder?.paths ?? [];
  //   } catch (ex) {
  //     showLog(ex, flags: 'getImageByOrder');
  //     return [];
  //   }
  // }

  // static Future<void> updateImageByOrder(
  //   int orderId,
  //   List<String> newPaths,
  // ) async {
  //   try {
  //     final images = List<ImageOrderLocal>.from(getAllImageOrder());
  //     ImageOrderLocal? imageByOrder =
  //         images.firstWhereOrNull((element) => element.orderId == orderId);
  //     if (imageByOrder == null) {
  //       imageByOrder = ImageOrderLocal(orderId: orderId);
  //       images.add(imageByOrder);
  //     } else {
  //       imageByOrder = imageByOrder.copyWith(paths: newPaths);
  //     }
  //     final index = images.indexWhere((element) => element.orderId == orderId);
  //     if (index != -1) {
  //       images[index] = imageByOrder;
  //     }
  //     await _prefs.setStringList(
  //         _imageOrder, images.map((e) => jsonEncode(e)).toList());
  //   } catch (ex) {
  //     showLog(ex, flags: 'updateImageByOrder');
  //   }
  // }

  // static Future<void> deleteImageByOrder(
  //   int orderId,
  // ) async {
  //   try {
  //     final images = List<ImageOrderLocal>.from(getAllImageOrder());
  //     images.removeWhere((element) => element.orderId == orderId);
  //     await _prefs.setStringList(
  //         _imageOrder, images.map((e) => jsonEncode(e)).toList());
  //   } catch (ex) {
  //     //
  //   }
  // }

  static Future<void> saveNotePerOrderItem({
    required OrderModel order,
    required Map<String, String> notes,
  }) async {
    Map<String, dynamic> data = {};
    try {
      var raw = _prefs.getString(_notePerOrderItem);
      data = raw == null || raw.isEmpty ? <String, Map<String, String>>{} : jsonDecode(raw);
    } catch (ex) {
      //
    }
    Map<String, Map<String, String>> t = data.map((key, value) {
      return MapEntry(
        key,
        value is! Map
            ? value.map((key, v) => MapEntry(
                  key,
                  v.toString(),
                ))
            : <String, String>{},
      );
    });

    t[order.id.toString()] = notes;

    await _prefs.setString(_notePerOrderItem, jsonEncode(t));
  }

  static Map<String, String>? getNotePerOrderItem({required OrderModel order}) {
    Map<String, dynamic> data = {};
    try {
      var raw = _prefs.getString(_notePerOrderItem);
      data = raw == null || raw.isEmpty ? <String, Map<String, String>>{} : jsonDecode(raw);
    } catch (ex) {
      //
    }

    Map<String, dynamic> value = data[order.id.toString()] ?? <String, dynamic>{};
    Map<String, String> t = value.map((key, value) {
      if (value is Map) {
        return MapEntry(
          key,
          (value).toString(),
        );
      } else {
        //

        return MapEntry(
          key,
          (value).toString(),
        );
      }
    });

    return t;
  }

  static Future<void> deleteNotePerOrderItem({required OrderModel order}) async {
    Map<String, dynamic> data = {};
    try {
      var raw = _prefs.getString(_notePerOrderItem);
      data = raw == null || raw.isEmpty ? <String, Map<String, String>>{} : jsonDecode(raw);
    } catch (ex) {
      //
    }
    Map<String, Map<String, String>> t = data.map((key, value) {
      return MapEntry(
        key,
        value is! Map
            ? value.map((key, v) => MapEntry(
                  key,
                  v.toString(),
                ))
            : <String, String>{},
      );
    });

    t.remove(order.id.toString());

    await _prefs.setString(_notePerOrderItem, jsonEncode(t));
    return;
  }

  static Future<void> clearNotePerOrderItem() async {
    await _prefs.remove(_notePerOrderItem);
  }

  static AppLanguageEnum getCustomerLanguageLocal() {
    return AppLanguageEnum.values
        .byName(_prefs.getString(_customerLanguageLocal) ?? getLanguageLocal().name);
  }

  static Future<void> setCustomerLanguageLocal(AppLanguageEnum value) async {
    await _prefs.setString(_customerLanguageLocal, value.name);
  }

  // static Future<void> saveEmployeeSaleForOrder({
  //   required OrderModel order,
  //   required EmployeeSaleModel sale,
  // }) async {
  //   Map<String, dynamic> data = {};
  //   try {
  //     var raw = _prefs.getString(_employeeSaleForOrder);

  //     data = raw == null || raw.trim().isEmpty ? {} : jsonDecode(raw);
  //     Map<String, EmployeeSaleModel> result = {};
  //     data.forEach(
  //       (key, value) {
  //         result[key] = EmployeeSaleModel.fromJson(value);
  //       },
  //     );

  //     result[order.getOrderMisc().toString()] = sale;

  //     final res = await _prefs.setString(_employeeSaleForOrder, jsonEncode(result));
  //     showLogs(res, flags: 'res saveEmployeeSaleForOrder');
  //   } catch (ex) {
  //     _sendLog(
  //       title: 'saveEmployeeSaleForOrder',
  //       ex: ex,
  //     );
  //     showLogs(ex.toString(), flags: 'error save saveEmployeeSaleForOrder');
  //     //
  //   }
  // }

  // static EmployeeSaleModel? getEmployeeSaleForOrder({required OrderModel order}) {
  //   Map<String, dynamic> data = {};
  //   try {
  //     var raw = _prefs.getString(_employeeSaleForOrder);
  //     data = raw == null || raw.isEmpty ? {} : jsonDecode(raw);
  //     return data[order.getOrderMisc()] == null
  //         ? null
  //         : EmployeeSaleModel.fromJson(data[order.getOrderMisc()]);
  //   } catch (ex) {
  //     _sendLog(
  //       title: 'getEmployeeSaleForOrder',
  //       ex: ex,
  //     );
  //     showLogs(ex, flags: 'getEmployeeSaleForOrder');
  //     //
  //     return null;
  //   }
  // }

  // static Future<void> deleteEmployeeSaleForOrder({required OrderModel order}) async {
  //   Map<String, dynamic> data = {};
  //   try {
  //     var raw = _prefs.getString(_employeeSaleForOrder);
  //     data = raw == null || raw.isEmpty ? {} : jsonDecode(raw);

  //     data.remove(order.getOrderMisc());
  //     await _prefs.setString(_employeeSaleForOrder, jsonEncode(data));
  //     return;
  //   } catch (ex) {
  //     _sendLog(
  //       title: 'deleteEmployeeSaleForOrder',
  //       ex: ex,
  //     );
  //     showLogs(ex, flags: 'deleteEmployeeSaleForOrder');
  //     //
  //   }
  // }

  // static Future<void> clearEmployeeSaleForOrder() async {
  //   try {
  //     await _prefs.remove(_employeeSaleForOrder);
  //   } catch (ex) {
  //     _sendLog(
  //       title: 'clearEmployeeSaleForOrder',
  //       ex: ex,
  //     );
  //     //
  //   }
  // }

  static List<IpOrderModel> getPrinters() {
    try {
      var json = _prefs.getString(_printers) ?? "[]";
      return List<IpOrderModel>.from(
          jsonDecode(json).map<IpOrderModel>((e) => IpOrderModel.fromJson(e)));
    } catch (ex) {
      _sendLog(
        title: 'getPrinters',
        ex: ex,
      );
      return [];
    }
  }

  static Future<void> savePrinter(IpOrderModel printer) async {
    try {
      List<IpOrderModel> data = List<IpOrderModel>.from(getPrinters());

      var item = data.firstWhereOrNull((e) => e.ip == printer.ip && e.port == printer.port);
      if (item != null) {
        if (item != printer) {
          var index = data.indexOf(item);
          if (index != -1) {
            data[index] = printer;
            await _prefs.setString(_printers, jsonEncode(data));
          }
        }
      } else {
        data.add(printer);
        await _prefs.setString(_printers, jsonEncode(data));
      }
    } catch (ex) {
      _sendLog(
        title: 'savePrinter',
        ex: ex,
      );
      //
    }
  }

  static Future<void> saveListPrinters(List<IpOrderModel> printers) async {
    for (var print in printers) {
      try {
        await savePrinter(print);
      } catch (ex) {
        _sendLog(
          title: 'saveListPrinters',
          ex: ex,
        );
        //
      }
    }
  }

  static Future<void> deletePrinter(IpOrderModel printer) async {
    try {
      List<IpOrderModel> data = List<IpOrderModel>.from(getPrinters());

      var item = data.firstWhereOrNull((e) => e.ip == printer.ip && e.port == printer.port);
      if (item != null) {
        data.remove(item);
        await _prefs.setString(_printers, jsonEncode(data));
      }
    } catch (ex) {
      _sendLog(
        title: 'deletePrinter - DELETE máy in',
        ex: ex,
      );
      //
    }
  }

  static Future<void> clearPrinters() async {
    try {
      await _prefs.remove(_printers);
    } catch (ex) {
      _sendLog(
        title: 'clearPrinters - CLEAR ds máy in',
        ex: ex,
      );
      //
    }
  }

  // static Future<Map<String, List<CustomerPolicyModel>>> _getApplyAgainOnlyCoupon() async {
  //   Map<String, dynamic> data = {};
  //   try {
  //     var raw = _prefs.getString(_applyAgainOnlyCoupon);
  //     data = raw == null || raw.trim().isEmpty ? {} : jsonDecode(raw);
  //     Map<String, List<CustomerPolicyModel>> result = {};
  //     data.forEach(
  //       (key, value) {
  //         var res = (value as List).map((e) => CustomerPolicyModel.fromJson(e)).toList();
  //         if (res.isNotEmpty) {
  //           result[key] = res;
  //         }
  //       },
  //     );

  //     return result;
  //   } catch (ex) {
  //     _sendLog(
  //       title: '_getApplyAgainOnlyCoupon - GET ds mã giảm only cần xóa đi áp dụng lại',
  //       ex: ex,
  //     );
  //     showLogs(ex.toString(), flags: 'error _getApplyAgainOnlyCoupon');
  //     //
  //     return {};
  //   }
  // }

  // static Future<void> saveApplyAgainOnlyCoupon({
  //   required OrderModel order,
  //   List<CustomerPolicyModel> coupons = const [],
  // }) async {
  //   try {
  //     Map<String, List<CustomerPolicyModel>> result = await _getApplyAgainOnlyCoupon();
  //     result[order.id.toString()] = coupons;

  //     await _prefs.setString(_applyAgainOnlyCoupon, jsonEncode(result));
  //   } catch (ex) {
  //     _sendLog(
  //       title:
  //           'saveApplyAgainOnlyCoupon - SAVE ds mã giảm only cần xóa đi áp dụng lại (đối với order)',
  //       ex: ex,
  //     );
  //     showLogs(ex.toString(), flags: 'error saveApplyAgainOnlyCoupon');
  //     //
  //   }
  // }

  // static Future<List<CustomerPolicyModel>> getApplyAgainOnlyCouponForOrder(
  //     {required OrderModel order}) async {
  //   try {
  //     Map<String, List<CustomerPolicyModel>> result = await _getApplyAgainOnlyCoupon();

  //     return result[order.id.toString()] ?? [];
  //   } catch (ex) {
  //     _sendLog(
  //       title:
  //           'getApplyAgainOnlyCouponForOrder - GET ds mã giảm only cần xóa đi áp dụng lại (đối với order)',
  //       ex: ex,
  //     );
  //     showLogs(ex, flags: 'getApplyAgainOnlyCouponForOrder');
  //     //
  //     return [];
  //   }
  // }

  // static Future<void> deleteApplyAgainOnlyCouponForOrder({required OrderModel order}) async {
  //   try {
  //     Map<String, List<CustomerPolicyModel>> result = await _getApplyAgainOnlyCoupon();

  //     result.remove(order.id.toString());
  //     await _prefs.setString(_applyAgainOnlyCoupon, jsonEncode(result));
  //     return;
  //   } catch (ex) {
  //     _sendLog(
  //       title:
  //           'deleteApplyAgainOnlyCouponForOrder - DELETE các mã giảm only cần xóa đi áp dụng lại (đối với order)',
  //       ex: ex,
  //     );
  //     showLogs(ex, flags: 'deleteApplyAgainOnlyCouponForOrder');
  //     //
  //   }
  // }

  // static Future<void> clearApplyAgainOnlyCoupon() async {
  //   try {
  //     await _prefs.remove(_applyAgainOnlyCoupon);
  //     return;
  //   } catch (ex) {
  //     _sendLog(
  //       title: 'clearApplyAgainOnlyCoupon - CLEAR các mã giảm only cần xóa đi áp dụng lại',
  //       ex: ex,
  //     );
  //   }
  // }

  static void _sendLog({
    required String title,
    dynamic ex,
  }) {
    ErrorLogModel log = ErrorLogModel(
      action: AppLogAction.localStorage,
      errorMessage: '$title\n'
          '${ex.toString()}',
      createAt: DateTime.now(),
    );
    LogService.sendLogs(log);
  }

  /// setting
  static AppPrintSettingModel getPrintSetting() {
    var json = _prefs.getString(printSetting);
    return json == null
        ? const AppPrintSettingModel()
        : AppPrintSettingModel.fromJson(jsonDecode(json));
  }

  static Future<void> setPrintSetting(AppPrintSettingModel setting) async {
    await _prefs.setString(printSetting, jsonEncode(setting));
  }

  static AppSettingModel getAppSetting() {
    var json = _prefs.getString(appSetting);
    return json == null ? const AppSettingModel() : AppSettingModel.fromJson(jsonDecode(json));
  }

  static Future<void> setAppSetting(AppSettingModel setting) async {
    await _prefs.setString(appSetting, jsonEncode(setting));
  }

  /// layout bàn NH
  static Future<bool> setTableLayout(List<TableLayoutItemModel> items) async {
    try {
      if (items.isEmpty) {
        return _prefs.remove(tableLayout);
      }
      return await _prefs.setString(tableLayout, jsonEncode(items));
    } catch (ex) {
      return false;
    }
  }

  static List<TableLayoutItemModel> getTableLayout() {
    var json = _prefs.getString(tableLayout) ?? "[]";
    return List<TableLayoutItemModel>.from(
        jsonDecode(json).map<TableLayoutItemModel>((e) => TableLayoutItemModel.fromJson(e)));
  }

  /// Ds tầng
  static List<FloorModel> getFloors() {
    var json = _prefs.getString(floors) ?? "[]";
    return List<FloorModel>.from(jsonDecode(json).map<FloorModel>((e) => FloorModel.fromJson(e)));
  }

  static Future<bool> setFloors(List<FloorModel> items) async {
    try {
      if (items.isEmpty) {
        return _prefs.remove(floors);
      }
      return await _prefs.setString(floors, jsonEncode(items));
    } catch (ex) {
      return false;
    }
  }

  /// cấu hình mỗi item layout bàn
  static List<TableLayoutSettingModel> getTableLayoutSetting() {
    var json = _prefs.getString(tableLayoutSetting) ?? "[]";
    return List<TableLayoutSettingModel>.from(
        jsonDecode(json).map<TableLayoutSettingModel>((e) => TableLayoutSettingModel.fromJson(e)));
  }

  static Future<bool> setTableLayoutSetting(List<TableLayoutSettingModel> items) async {
    try {
      if (items.isEmpty) {
        return _prefs.remove(tableLayoutSetting);
      }
      return await _prefs.setString(tableLayoutSetting, jsonEncode(items));
    } catch (ex) {
      return false;
    }
  }

  static Map<String, Map<String, int>> getOrderItemSelecting() {
    try {
      var raw = _prefs.getString(orderItemSelecting) ?? '{}';
      var decode = jsonDecode(raw);
      Map<String, Map<String, int>> result = {};
      (decode as Map).forEach(
        (key, value) {
          result[key] = Map<String, int>.from(value);
        },
      );
      return result;
    } catch (ex) {
      showLogs(ex, flags: 'getOrderItemSelecting');
      return {};
    }
  }

  static Map<String, int> getOrderItemSelectingForOrder(int orderId) {
    var data = getOrderItemSelecting();
    return data[orderId.toString()] ?? {};
  }

  static Future<bool> setOrderItemSelectingForOrder(
      {required int orderId, required Map<String, int> data}) async {
    try {
      var allData = Map<String, Map<String, int>>.from(getOrderItemSelecting());
      if (data.isEmpty) {
        allData.remove(orderId.toString());
      } else {
        allData[orderId.toString()] = data;
      }
      await _prefs.setString(orderItemSelecting, jsonEncode(allData));
      return true;
    } catch (ex) {
      showLogs(ex, flags: 'setOrderItemSelectingForOrder');
      return false;
    }
  }

  static Future<void> clearOrderItemSelecting() async {
    try {
      await _prefs.remove(orderItemSelecting);
    } catch (ex) {
      //
    }
  }

  static bool getPrinterDevice() {
    return _prefs.getBool(_printerDevice) ?? false;
  }

  static Future<void> setPrinterDevice(bool value) async {
    await _prefs.setBool(_printerDevice, value);
  }
}
