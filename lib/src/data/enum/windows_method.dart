enum WindowsMethodEnum {
  closeApp,
  linkZaloOA,
  payment,
  data,
  payoo,
  changeOrderProduct,
  language,

  customer,
  price,
  paymentMethod,
  productCheckout,
  completeNote,
  kitchenNote,
}

extension WindowsMethodEnumEx on WindowsMethodEnum {
  String get key {
    switch (this) {
      case WindowsMethodEnum.closeApp:
        return 'close_app';
      case WindowsMethodEnum.linkZaloOA:
        return 'link_zalo_oa';
      case WindowsMethodEnum.payment:
        return 'payment';
      case WindowsMethodEnum.data:
        return 'data';
      case WindowsMethodEnum.payoo:
        return 'payoo';
      case WindowsMethodEnum.changeOrderProduct:
        return 'change_order_product';
      case WindowsMethodEnum.language:
        return 'language';
      case WindowsMethodEnum.customer:
        return 'customer';
      case WindowsMethodEnum.price:
        return 'price';
      case WindowsMethodEnum.paymentMethod:
        return 'paymentMethod';
      case WindowsMethodEnum.productCheckout:
        return 'productCheckout';
      case WindowsMethodEnum.completeNote:
        return 'completeNote';
      case WindowsMethodEnum.kitchenNote:
        return 'kitchenNote';
    }
  }
}
