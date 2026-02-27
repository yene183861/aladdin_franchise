import 'package:aladdin_franchise/generated/l10n.dart';

enum ReasonCancelItemEnum {
  customerSelectMistake,
  customerRequestCancel,
  outOfStock,
  dishServedLate,
}

extension ReasonCancelItemEnumExt on ReasonCancelItemEnum {
  String get title {
    switch (this) {
      case ReasonCancelItemEnum.customerSelectMistake:
        return S.current.customer_select_mistake;
      case ReasonCancelItemEnum.customerRequestCancel:
        return S.current.customer_request_cancel;
      case ReasonCancelItemEnum.outOfStock:
        return S.current.out_of_stock;
      case ReasonCancelItemEnum.dishServedLate:
        return S.current.dish_served_late;
      default:
        return '';
    }
  }

  String get key {
    switch (this) {
      case ReasonCancelItemEnum.customerSelectMistake:
        return 'Khách chọn nhầm';
      case ReasonCancelItemEnum.customerRequestCancel:
        return 'Khách báo huỷ';
      case ReasonCancelItemEnum.outOfStock:
        return 'Hết món';
      case ReasonCancelItemEnum.dishServedLate:
        return 'Món ra trễ';
      default:
        return '';
    }
  }
}
