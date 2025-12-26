import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_setting.freezed.dart';
part 'app_setting.g.dart';

@freezed
class AppSettingModel with _$AppSettingModel {
  @JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
  const factory AppSettingModel({
    @Default(false) bool couponStatus,
  }) = _AppSettingModel;

  factory AppSettingModel.fromJson(Map<String, dynamic> json) => _$AppSettingModelFromJson(json);
}
