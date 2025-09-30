import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'ip_order.freezed.dart';
part 'ip_order.g.dart';

@freezed
class IpOrderModel with _$IpOrderModel {
  @JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
  const factory IpOrderModel({
    required String ip,
    required int port,
    required int type,
    @Default('Máy in') String name,
  }) = _IpOrderModel;

  factory IpOrderModel.fromJson(Map<String, dynamic> json) =>
      _$IpOrderModelFromJson(json);

  static String getModelInterface() {
    return '''required String ip,
    required int port,
    required int type,
    ''';
  }

  const IpOrderModel._();

  String messageConnectFail() => "Không kết nối được máy in\n"
      "- $name ($ip:$port)\n"
      "${"Vui lòng kiểm tra & đảm bảo".toUpperCase()}\n"
      "- Tablet và máy tính đã kết nối mạng Order\n"
      "- Máy in đã bật và không bị kẹt giấy\n"
      "- Dây mạng kết nối với máy in đã sáng";
}
