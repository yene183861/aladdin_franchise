import 'package:aladdin_franchise/src/configs/enums/enums.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'state.freezed.dart';

@freezed
class UpdateAppAndroidState with _$UpdateAppAndroidState {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory UpdateAppAndroidState({
    required bool isDownloading,
    required double downloadProgress,
    required String saveFolder,
    String? taskId,
    @Default(ConfigServerRestaurantData.aladdinWeb)
    ConfigServerRestaurantData server,
  }) = _UpdateAppAndroidState;
}
