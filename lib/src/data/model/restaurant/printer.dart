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
    @Default(false) @JsonKey(includeFromJson: false, includeToJson: false) bool defaultPrinter,
  }) = _PrinterModel;
  const PrinterModel._();

  factory PrinterModel.fromJson(Map<String, dynamic> json) => _$PrinterModelFromJson(json);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is PrinterModel &&
            other.ip == ip &&
            other.port == port &&
            other.type == type &&
            other.name == name &&
            other.typeAreaLocation == typeAreaLocation);
  }

  @override
  int get hashCode => super.hashCode;
}
