import 'package:aladdin_franchise/generated/l10n.dart';
import 'package:flutter/material.dart';

enum CouponColumnEnum {
  ind,
  name,
  total,
}

extension CouponColumnEnumExt on CouponColumnEnum {
  String get title {
    switch (this) {
      case CouponColumnEnum.ind:
        return '#';
      case CouponColumnEnum.name:
        return S.current.item;

      case CouponColumnEnum.total:
        return S.current.total;
      default:
        return '';
    }
  }

  int get flex {
    switch (this) {
      case CouponColumnEnum.ind:
        return 1;
      case CouponColumnEnum.name:
        return 9;
      case CouponColumnEnum.total:
      default:
        return 2;
    }
  }

  TextAlign get align {
    switch (this) {
      case CouponColumnEnum.total:
        return TextAlign.right;
      default:
        return TextAlign.left;
    }
  }

  EdgeInsetsGeometry get padding {
    switch (this) {
      case CouponColumnEnum.name:
        return const EdgeInsets.only(right: 8.0);
      default:
        return EdgeInsets.zero;
    }
  }
}
