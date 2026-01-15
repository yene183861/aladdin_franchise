import 'dart:convert';

import 'package:aladdin_franchise/src/models/combo_item.dart';
import 'package:aladdin_franchise/src/models/order_history.dart';
import 'package:aladdin_franchise/src/models/product.dart';

/// Author: sondv
/// Created 23/02/2023 at 10:05

class ProductHelper {
  /// Nếu là combo trả về List<ComboItemModel>
  /// Nếu món bình thường trả về null
  List<ComboItemModel>? getComboDescription(ProductModel product) {
    List<ComboItemModel>? result;
    try {
      var description = jsonDecode(product.description ?? '');
      result = List<ComboItemModel>.from(
          description.map<ComboItemModel>((e) => ComboItemModel.fromJson(e)));
    } catch (ex) {
      //
    }
    return result;
  }

  static List<ProductHistory> getHistory(List<OrderHistory> orderHistory, int productId) {
    List<ProductHistory> history = [];

    for (var orderTime in orderHistory) {
      for (var product in orderTime.products) {
        if (product.itemId == productId) {
          var productChange = product;
          // Nếu là món huỷ thì lấy ghi chú tổng
          if (product.cancel) {
            productChange = productChange.copyWith(notes: orderTime.notes);
          }
          // Lấy thời gian gọi của lượt
          productChange = productChange.copyWith(timeByOrderHistory: orderTime.createdAt);
          history.add(productChange);
        }
      }
    }

    history.sort((a, b) => b.timesOrder.compareTo(a.timesOrder));

    return history;
  }

  static double parseErrorTaxValue = -1000;

  ///
  /// parse lỗi: => -1000 [parseErrorTaxValue]
  ///
  static double getTaxValue(value) {
    if (value == null) return parseErrorTaxValue;
    double tax = 0.0;
    if (value is num) {
      tax = value * 1.0;
    } else if (value is String) {
      try {
        tax = double.parse(value);
      } catch (ex) {
        return parseErrorTaxValue;
      }
    } else {
      return parseErrorTaxValue;
    }
    return tax;
  }

  static String getTaxView(value) {
    double tax = getTaxValue(value);
    if (tax == parseErrorTaxValue) return '';
    if (tax > 1) {
      tax = tax / 100;
    }

    var intValue = tax.toInt();

    return tax == intValue ? '$intValue%' : '$tax%';
  }
}
