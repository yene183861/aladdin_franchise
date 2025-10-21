import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_setting.freezed.dart';
part 'app_setting.g.dart';

@freezed
class AppSettingModel with _$AppSettingModel {
  @JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
  const factory AppSettingModel({
    @Default(true) bool useFontScale,
    @Default(1.0) double fontScale,
  }) = _AppSettingModel;

  factory AppSettingModel.fromJson(Map<String, dynamic> json) => _$AppSettingModelFromJson(json);

  const AppSettingModel._();
}
