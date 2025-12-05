enum ReceiptTypeEnum {
  temporaryReceipt,
  paymentReceipt,
}

extension ReceiptTypeEnumEx on ReceiptTypeEnum {
  String get title {
    switch (this) {
      case ReceiptTypeEnum.temporaryReceipt:
        return 'Phiếu tạm tính';
      case ReceiptTypeEnum.paymentReceipt:
        return 'Phiếu thanh toán';
    }
  }

  String get note {
    switch (this) {
      case ReceiptTypeEnum.temporaryReceipt:
        return 'Phiếu không có giá trị thanh toán';
      case ReceiptTypeEnum.paymentReceipt:
        return '';
    }
  }

  bool get showPaymentMethod {
    switch (this) {
      case ReceiptTypeEnum.temporaryReceipt:
        return false;
      case ReceiptTypeEnum.paymentReceipt:
        return true;
    }
  }
}
