enum DiscountTypeEnum {
  vnd,
  percent,
}

extension DiscountTypeEnumEx on DiscountTypeEnum {
  String get title {
    switch (this) {
      case DiscountTypeEnum.vnd:
        return 'VND';
      case DiscountTypeEnum.percent:
        return '%';
      default:
        return '';
    }
  }

  dynamic get key {
    switch (this) {
      case DiscountTypeEnum.vnd:
        return 2;
      case DiscountTypeEnum.percent:
        return 1;
      default:
        return '';
    }
  }
}
