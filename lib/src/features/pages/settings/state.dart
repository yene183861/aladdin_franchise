import 'package:aladdin_franchise/src/models/setting/print_setting.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'state.freezed.dart';

enum SettingPageMenuEnum { audioNotice, boxColSize, bill, color }

@freezed
class SettingsPageState with _$SettingsPageState {
  const factory SettingsPageState({
    @Default(AppPrintSettingModel()) AppPrintSettingModel printSetting,
    @Default(SettingPageMenuEnum.audioNotice) SettingPageMenuEnum menuSelect,
  }) = _SettingsPageState;
}
