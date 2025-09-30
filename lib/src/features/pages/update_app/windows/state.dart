/// Author: sondv
/// Created 02/12/2023 at 10:02

import 'dart:io';

import 'package:aladdin_franchise/src/configs/enums/enums.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'state.freezed.dart';

enum UpdateAppWindowsEvent {
  normal,
  downloading,
  error,
  complete,
  openInstaller,
  openInstallerError
}

@freezed
class UpdateAppWindowsState with _$UpdateAppWindowsState {
  const factory UpdateAppWindowsState({
    @Default(UpdateAppWindowsEvent.normal) UpdateAppWindowsEvent events,
    @Default('') String errorMessage,
    File? fileDownload,
    @Default(ConfigServerRestaurantData.aladdinWeb)
    ConfigServerRestaurantData server,
  }) = _UpdateAppWindowsState;
}
