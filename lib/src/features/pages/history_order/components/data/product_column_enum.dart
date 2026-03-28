// ignore_for_file: constant_identifier_names

import 'package:aladdin_franchise/generated/l10n.dart';
import 'package:flutter/material.dart';

enum ProductColumnEnum {
  order_code,
  table_name,
  order_status,
  customer,
  coupons,
  price,
  order_type,
  order_created,
}

extension ProductColumnEnumEx on ProductColumnEnum {
  // String get title {
  //   switch (this) {
  //     case HistoryItemColumnEnum.order_code:
  //       return S.current.order_code;
  //     case HistoryItemColumnEnum.table_name:
  //       return S.current.table;
  //     case HistoryItemColumnEnum.order_status:
  //       return S.current.status;
  //     case HistoryItemColumnEnum.customer:
  //       return S.current.customers;
  //     case HistoryItemColumnEnum.coupons:
  //       return S.current.voucher;
  //     case HistoryItemColumnEnum.price:
  //       return S.current.total_amount;
  //     case HistoryItemColumnEnum.order_type:
  //       return S.current.method;
  //     case HistoryItemColumnEnum.order_created:
  //       return S.current.time;
  //     default:
  //       return '';
  //   }
  // }

  // int get flex {
  //   switch (this) {
  //     case HistoryItemColumnEnum.order_created:
  //       return 1;
  //     case HistoryItemColumnEnum.order_status:
  //       return 3;
  //     case HistoryItemColumnEnum.order_code:
  //     case HistoryItemColumnEnum.table_name:
  //     case HistoryItemColumnEnum.customer:
  //     case HistoryItemColumnEnum.coupons:
  //     case HistoryItemColumnEnum.price:
  //     default:
  //       return 2;
  //   }
  // }

  // TextAlign get align {
  //   switch (this) {
  //     case HistoryItemColumnEnum.order_created:
  //       return TextAlign.right;
  //     default:
  //       return TextAlign.left;
  //   }
  // }
}
