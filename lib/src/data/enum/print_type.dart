enum PrintTypeEnum {
  /// gọi món
  order,

  ///huỷ món
  cancel,

  /// QR order
  qr,

  /// thanh toán
  payment,

  /// chốt ca
  closeShift,

  /// qr o2o
  qrO2o,
}

extension PrintTypeEnumExt on PrintTypeEnum {
  String get title {
    switch (this) {
      case PrintTypeEnum.order:
        return 'Gọi món';
      case PrintTypeEnum.cancel:
        return 'Huỷ đồ';
      case PrintTypeEnum.payment:
        return 'In phiếu thanh toán';
      case PrintTypeEnum.closeShift:
        return 'In phiếu chốt ca';
      case PrintTypeEnum.qrO2o:
        return 'In mã gọi đồ tại bàn';
      default:
        return name;
    }
  }
}
