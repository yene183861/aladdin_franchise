enum PrinterTypeEnum {
  kitchen,
  bar,
  tmp,
  receipt,
  total,
  other,
}

extension PrinterTypeEnumExt on PrinterTypeEnum {
  int get key {
    switch (this) {
      case PrinterTypeEnum.kitchen:
        return 4;
      case PrinterTypeEnum.bar:
        return 2;
      case PrinterTypeEnum.tmp:
      case PrinterTypeEnum.receipt:
        return 1;
      case PrinterTypeEnum.total:
        return 0;
      default:
        return 5;
    }
  }
}
