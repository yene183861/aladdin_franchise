// ignore_for_file: constant_identifier_names

import 'package:aladdin_franchise/generated/l10n.dart';
import 'package:flutter/material.dart';

enum ProductCheckoutColumnEnum {
  ind,
  name,
  code_product,
  price,
  count,
  tax,
  total_ordered,
}

extension ProductCheckoutColumnEnumExt on ProductCheckoutColumnEnum {
  String get title {
    switch (this) {
      case ProductCheckoutColumnEnum.ind:
        return '#';
      case ProductCheckoutColumnEnum.name:
        return S.current.item;
      case ProductCheckoutColumnEnum.code_product:
        return S.current.code;
      case ProductCheckoutColumnEnum.price:
        return S.current.price;
      case ProductCheckoutColumnEnum.count:
        return S.current.quantity;
      case ProductCheckoutColumnEnum.tax:
        return S.current.tax;
      case ProductCheckoutColumnEnum.total_ordered:
        return S.current.total;
      default:
        return '';
    }
  }

  int get flex {
    switch (this) {
      case ProductCheckoutColumnEnum.ind:
      case ProductCheckoutColumnEnum.tax:
      case ProductCheckoutColumnEnum.count:
      case ProductCheckoutColumnEnum.code_product:
        return 1;
      case ProductCheckoutColumnEnum.name:
        return 3;
      case ProductCheckoutColumnEnum.price:
      case ProductCheckoutColumnEnum.total_ordered:
      default:
        return 2;
    }
  }

  TextAlign get align {
    switch (this) {
      case ProductCheckoutColumnEnum.total_ordered:
        return TextAlign.right;
      default:
        return TextAlign.left;
    }
  }

  EdgeInsetsGeometry get padding {
    switch (this) {
      case ProductCheckoutColumnEnum.name:
        return const EdgeInsets.only(right: 8.0);
      default:
        return EdgeInsets.zero;
    }
  }
}
