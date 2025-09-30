import 'package:aladdin_franchise/src/configs/enums/bill_setting.dart';
import 'package:aladdin_franchise/src/core/storages/local.dart';
import 'package:aladdin_franchise/src/core/storages/provider.dart';
import 'package:aladdin_franchise/src/models/app_setting.dart';

import 'state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final settingsPageProvider =
    StateNotifierProvider.autoDispose<SettingsPageNotifier, SettingsPageState>(
        (ref) {
  return SettingsPageNotifier(ref);
});

class SettingsPageNotifier extends StateNotifier<SettingsPageState> {
  SettingsPageNotifier(this.ref)
      : super(const SettingsPageState(
          menuSelect: SettingPageMenuEnum.bill,
        ));
  final Ref ref;
  void initialize() {
    var settings = LocalStorage.getAppSettings();
    state = state.copyWith(appSettings: settings);
  }

  void onChangeSetting({
    // bool? noticeCancel,
    // bool? noticeConfirmLocation,
    // bool? noticeKitchenDone,
    BillReturnItemTypeEnum? billReturnType,
    // double? boxSizeView,
    // String? audioDishCancel,
    // String? audioDishConfirmLocation,
    // String? audioKitchenDone,
    // ColorSetting? backgroundColor,
    // ColorSetting? lineSelectColor,
    AppPrinterSettingTypeEnum? appPrinterType,
    BillHtmlSettingModel? billHtmlSetting,
    BillReturnSettingModel? billReturnSetting,
  }) {
    var settings = state.appSettings.copyWith(
      // noticeKitchenCancel:
      //     noticeCancel ?? state.appSettings.noticeKitchenCancel,
      // noticeKitchenConfirmLocation: noticeConfirmLocation ??
      //     state.appSettings.noticeKitchenConfirmLocation,
      // noticeKitchenDone:
      //     noticeKitchenDone ?? state.appSettings.noticeKitchenDone,
      // boxSizeView: boxSizeView ?? state.appSettings.boxSizeView,
      billReturnType: billReturnType ?? state.appSettings.billReturnType,
      // audioDishCancel: audioDishCancel ?? state.appSettings.audioDishCancel,
      // audioDishConfirmLocation: audioDishConfirmLocation ??
      //     state.appSettings.audioDishConfirmLocation,
      // audioKitchenDone: audioKitchenDone ?? state.appSettings.audioKitchenDone,
      // backgroundColor: backgroundColor ?? state.appSettings.backgroundColor,
      // lineSelectColor: lineSelectColor ?? state.appSettings.lineSelectColor,
      appPrinterType: appPrinterType ?? state.appSettings.appPrinterType,
      billHtmlSetting: billHtmlSetting ?? state.appSettings.billHtmlSetting,
      billReturnSetting:
          billReturnSetting ?? state.appSettings.billReturnSetting,
    );
    state = state.copyWith(appSettings: settings);
    LocalStorage.setAppSettings(settings);
    ref.invalidate(appSettingsProvider);
  }

  void changeMenuSelect(SettingPageMenuEnum menu) {
    state = state.copyWith(menuSelect: menu);
  }
}
