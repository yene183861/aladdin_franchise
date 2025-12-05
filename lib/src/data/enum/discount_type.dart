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

  String get key {
    switch (this) {
      case DiscountTypeEnum.vnd:
        return 'vnd';
      case DiscountTypeEnum.percent:
        return '%';
      default:
        return '';
    }
  }
}
