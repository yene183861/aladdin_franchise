/// Cấu hình tuỳ chọn khu vực sử dụng KDS
///
/// - [0] Tất cả khu vực
///
/// - [1] Bar
///
/// - [2] Kitchen
///
/// - [3] Không có khu vực nào, tất cả đều in bill gọi món
class AreaStatus {
  static const int full = 0;
  static const int bar = 1;
  static const int kitchen = 2;
  static const int none = 3;
}

class ProductPrinterType {
  static const int drink = 4;
  static const int food = 2;
}

class ProductCancelType {
  /// Huỷ trực tiếp
  static const int directly = 0;

  /// Xác nhận bới KDS
  static const int viaKDS = 1;

  /// Xác nhận bới Manager
  static const int viaManager = 2;
}

class AppLanguageLocal {
  static const String vietnamese = 'vi';
  static const String english = 'en';
  static const String chinese = 'zh';
}

class RatingQuestionKey {
  static const takeCareOf = 1;
  static const healthy = 2;
  static const price = 3;
  static const space = 4;
  static const speed = 5;
  static const comeBack = 6;
}

class PaymentMethodKey {
  static const int paymentCash = 25;
  static const int paymentATM = 30;
  static const int paymentTransfer = 35;
  static const int inDebt = 40;
  static const int paymentVNPAY = 45;
  static const int paymentSHOPEE = 50;
  static const int paymentGRAB = 55;
}

const String kIgnoreRetryApplyPolicy = "kIgnoreRetryApplyPolicy ";

const int kRedisPortDefault = 6379;

/// misc-update-item-channel
const String kRedisUpdateItemChannel = 'misc-update-item-channel';

/// yêu cầu gọi món mới user-create-order
const String kUserCreateOrderChannel = 'user-create-order';

/// update yêu cầu gọi món user-update-order
const String kUserUpdateOrderChannel = 'user-update-order';

/// gọi thanh toán payment-request-channel
const String kPaymentRequestChannel = 'payment-request-channel';

/// gọi phục vụ call-staff-channel
const String kCallStaffChannel = 'call-staff-channel';

/// chờ thanh toán, đã thanh toán, mở lại bàn o2o
const String kStatusOrderChannel = 'order-change-status';

/// channel cho update 1 item trong yêu cầu có nhiều items
// const String kUserUpdateItemOrderChannel = 'user-create-order-item';

/// channel lock order
const String kLockOrderChannel = 'block-order';
const String kPrintChannel = 'pos-print';
