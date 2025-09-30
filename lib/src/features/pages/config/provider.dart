import 'package:aladdin_franchise/src/configs/api.dart';
import 'package:aladdin_franchise/src/configs/enums/enums.dart';
import 'package:aladdin_franchise/src/core/storages/local.dart';
import 'package:aladdin_franchise/src/features/pages/config/state.dart';
import 'package:aladdin_franchise/src/models/restaurant_config.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Author: sondv
/// Created 23/02/2023 at 10:05
final configProvider = StateNotifierProvider.autoDispose<Config2Notifier, ConfigState>((ref) {
  return Config2Notifier();
});

class Config2Notifier extends StateNotifier<ConfigState> {
  Config2Notifier()
      : super(const ConfigState(
          keyword: '',
          pageState: ConfigPageState.normal,
          apiUrl: "",
          styleIds: [],
          styleIdSelected: 1,
          enableOrderOnline: false,
          typeConfig: TypeConfigPage.manual,
        ));
  void changeTypeConfig() {
    var newTypeConfig =
        state.typeConfig == TypeConfigPage.chose ? TypeConfigPage.manual : TypeConfigPage.chose;
    state = state.copyWith(typeConfig: newTypeConfig);
  }

  Future<void> init() async {
    state = state.copyWith(pageState: ConfigPageState.loading);
    final apiUrl = LocalStorage.getApiUrl();
    final styleId = LocalStorage.getStyle();
    final enableOrderOnline = LocalStorage.getEnableOrderOnline();
    var server = ConfigServerRestaurantData.aladdinWeb;
    // if (!kEnableFirebaseAppWindowOnly) {
    //   server = ConfigServerRestaurantData.aladdinWeb;
    // }
    state = state.copyWith(
      apiUrl: apiUrl,
      styleIdSelected: styleId,
      // styleIds: CustomStyle.trademark,
      pageState: ConfigPageState.normal,
      enableOrderOnline: enableOrderOnline,
      server: server,
    );
  }

  void changeStyleSelect(int styleId) {
    state = state.copyWith(styleIdSelected: styleId);
  }

  Future<void> changeEnableOrderOnline(bool value) async {
    state = state.copyWith(enableOrderOnline: value);
  }

  Future<void> saveConfigs(String newApiUrl) async {
    await LocalStorage.setApiUrl(newApiUrl);
    ApiConfig().changeApi(newApiUrl);

    LocalStorage.changeStyle(state.styleIdSelected);
    // CustomStyle().updateStyle(state.styleIdSelected);

    await LocalStorage.setEnableOrderOnline(state.enableOrderOnline);
    await LocalStorage.setRestaurantConfig(null);
    await LocalStorage.clearCache();
  }

  // For chose restaurant

  void changeKeyword(String keyword) {
    state = state.copyWith(keyword: keyword);
  }

  Future<void> onConfirmRestaurantConfig(RestaurantConfigModel restaurant) async {
    await LocalStorage.setApiUrl(restaurant.ip);
    ApiConfig().changeApi(restaurant.ip);

    LocalStorage.changeStyle(restaurant.style);
    // CustomStyle().updateStyle(restaurant.style);

    await LocalStorage.setEnableOrderOnline(restaurant.orderOnline);
    await LocalStorage.setRestaurantConfig(restaurant);
    await LocalStorage.clearCache();
  }

  void onChangeTags(String tag) {
    var tags = List<String>.from(state.tags);
    if (tags.contains(tag)) {
      tags.remove(tag);
    } else {
      tags.add(tag);
    }
    state = state.copyWith(tags: tags);
  }

  void onChangeServer(ConfigServerRestaurantData configRestaurantData) {
    state = state.copyWith(server: configRestaurantData);
  }
}
