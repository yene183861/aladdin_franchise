import 'package:aladdin_franchise/src/configs/enums/enums.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'state.freezed.dart';
part 'state.g.dart';

enum ConfigPageState { normal, loading }

enum TypeConfigPage { chose, manual }

@freezed
class ConfigState with _$ConfigState {
  @JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
  const factory ConfigState({
    required String keyword,
    required ConfigPageState pageState,
    required String apiUrl,
    required int styleIdSelected,
    required List<int> styleIds,
    required bool enableOrderOnline,
    required TypeConfigPage typeConfig,
    @Default([]) List<String> tags,
    @Default(ConfigServerRestaurantData.aladdinWeb)
    ConfigServerRestaurantData server,
  }) = _ConfigState;

  factory ConfigState.fromJson(Map<String, dynamic> json) =>
      _$ConfigStateFromJson(json);
}
