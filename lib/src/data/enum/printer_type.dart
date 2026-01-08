enum PrinterEnum {
  kitchen,
  bar,
  receipt,
  total,
}

extension PrinterEnumExt on PrinterEnum {
  int get key {
    switch (this) {
      case PrinterEnum.kitchen:
        return 4;
      case PrinterEnum.bar:
        return 2;
      case PrinterEnum.receipt:
        return 1;
      default:
        return 0;
    }
  }
}
