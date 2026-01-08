import 'package:freezed_annotation/freezed_annotation.dart';

part 'printer.freezed.dart';
part 'printer.g.dart';

/// [active] trạng thái ping máy in
@freezed
class PrinterModel with _$PrinterModel {
  @JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
  const factory PrinterModel({
    String? ip,
    int? port,
    @Default(1) int type,
    @Default('Máy in') String name,
    @Default(1) int typeAreaLocation,
    @Default(true) @JsonKey(includeFromJson: false, includeToJson: false) bool pingStatus,
  }) = _PrinterModel;
  const PrinterModel._();

  factory PrinterModel.fromJson(Map<String, dynamic> json) => _$PrinterModelFromJson(json);
}
