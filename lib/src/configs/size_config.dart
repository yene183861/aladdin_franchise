import 'package:flutter/material.dart';

class SizeConfig {
  /// độ rộng để có thể hiển thị tất cả
  static double get largeDeviceWidth => 1280.0;

  /// độ rộng để có thể hiện cả thông tin thanh toán bàn
  /// nhưng cần căn chỉnh lại top menu action (bỏ logo, ticket)
  /// chưa suy nghĩ được nên để cái này ở đâu
  static double get mediumDeviceWidth => 1024.0;

  /// chiều cao tối thiểu để có thể hiển thị ds món
  static double get mediumDeviceHeight => 768.0;

  /// kt hiển thị đầy đủ
  static Size fullSize() => Size(largeDeviceWidth, mediumDeviceHeight);
}
