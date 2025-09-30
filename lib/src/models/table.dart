import 'package:aladdin_franchise/src/configs/app.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'table.freezed.dart';
part 'table.g.dart';

@freezed
class TableModel with _$TableModel {
  @JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
  const factory TableModel({
    required int id,
    String? name,
    int? capacity,
    int? status,
    int? restaurantId,

    /// id của bàn thật ánh xạ với bàn chờ cho TTTM
    /// null nếu là bàn thật
    int? parentId,
    @Default(AppConfig.orderOfflineValue)
    @JsonKey(includeToJson: false, includeFromJson: false)
    int typeOrder,
  }) = _TableModel;

  factory TableModel.fromJson(Map<String, dynamic> json) =>
      _$TableModelFromJson(json);
}
