import 'package:freezed_annotation/freezed_annotation.dart';

part 'ticket.freezed.dart';
part 'ticket.g.dart';

@freezed
class TicketModel with _$TicketModel {
  @JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
  const factory TicketModel({
    @Default(-1) int id,
    @Default('') String name,
    DateTime? createdAt,
    @Default(0) int type,
  }) = _TicketModel;

  const TicketModel._();

  factory TicketModel.fromJson(Map<String, dynamic> json) =>
      _$TicketModelFromJson(json);

  static String getModelInterface() {
    return '''
    TicketModel{
    @Default(-1) int id,
    @Default('') String name,
    DateTime? createdAt,
    @Default(0) int type,
    ''';
  }
}
