enum DiscoundTypeEnum {
  vnd,
  percent,
}

extension DiscoundTypeEnumEx on DiscoundTypeEnum {
  String get title {
    switch (this) {
      case DiscoundTypeEnum.vnd:
        return 'VND';
      case DiscoundTypeEnum.percent:
        return '%';
      default:
        return '';
    }
  }

  String get key {
    switch (this) {
      case DiscoundTypeEnum.vnd:
        return 'vnd';
      case DiscoundTypeEnum.percent:
        return '%';
      default:
        return '';
    }
  }
}
