enum WindowsMethod {
  closeApp,
  linkZaloOA,
  payment,
  data,
  payoo,
  changeOrderProduct,
  language,
}

extension WindowsMethodEx on WindowsMethod {
  String get value {
    switch (this) {
      case WindowsMethod.closeApp:
        return 'close_app';
      case WindowsMethod.linkZaloOA:
        return 'link_zalo_oa';
      case WindowsMethod.payment:
        return 'payment';
      case WindowsMethod.data:
        return 'data';
      case WindowsMethod.payoo:
        return 'payoo';
      case WindowsMethod.changeOrderProduct:
        return 'change_order_product';
      case WindowsMethod.language:
        return 'language';
    }
  }
}
