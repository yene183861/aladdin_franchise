import 'package:freezed_annotation/freezed_annotation.dart';

part 'floor.freezed.dart';
part 'floor.g.dart';

@freezed
class FloorModel with _$FloorModel {
  @JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
  const factory FloorModel({
    @Default('') String name,
    @Default('') String id,
    @Default(-1) int restaurantId,
    @Default(false) bool isDefault,
  }) = _FloorModel;

  factory FloorModel.fromJson(Map<String, dynamic> json) => _$FloorModelFromJson(json);
}
