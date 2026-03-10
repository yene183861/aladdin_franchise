import 'package:flutter/foundation.dart';

class DevConfig {
  /// tự động gán KH vào đơn sau khi tạo mới KH thành công?
  /// check code
  static bool autoAssignCustomerToOrderAfterCreation = false;

  /// sử dụng mã giảm giá hay nhập số tiền/ % giảm?
  static bool useCoupon = true;

  static bool allowCustomTaxValue = kDebugMode ? true : false;
}
