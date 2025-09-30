import 'dart:math';

import 'package:aladdin_franchise/src/configs/app.dart';
import 'package:aladdin_franchise/src/configs/const.dart';
import 'package:aladdin_franchise/src/utils/language.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'product_checkout.freezed.dart';
part 'product_checkout.g.dart';

@freezed
class ProductCheckoutModel with _$ProductCheckoutModel {
  @JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
  const factory ProductCheckoutModel({
    required int id,
    required int quantity,
    required String unitPrice,
    required String name,
    required String unit,
    @Default(0.0) double tax,
    @Default(0.0) double totalOrdered,
    @Default(0) int quantityCancel,
    int? printerType,
    @Default(0) int quantityCompleted,
    @Default(ProductCancelType.directly) int cancelType,
    @Default('') String nameEn,
    @Default('') String codeProduct,
    @Default({}) Map<String, dynamic> language,
    @Default(0) int quantityPromotion,
  }) = _ProductCheckoutModel;

  factory ProductCheckoutModel.fromJson(Map<String, dynamic> json) =>
      _$ProductCheckoutModelFromJson(json);

  const ProductCheckoutModel._();

  String getNameView() {
    final result = AppLanguageUtils().getNameComplex(language);
    return result.isEmpty ? name : result;
  }

  String getUnitView() {
    final result = AppLanguageUtils().getUnitComplex(language);
    return result.isEmpty ? unit : result;
  }

  double getUnitPriceNum() => double.tryParse(unitPrice) ?? 0;
  double getTax() => tax < 1 ? tax * 100 : tax;

  int getQuantityFinal() => max(0, quantity - quantityPromotion);

  String get taxView {
    var _tax = getTax();
    return (_tax == _tax.toInt() ? _tax.toInt() : _tax).toString();
  }

  static String getModelInterface() {
    return '''required int id,
    required int quantity,
    required String unitPrice,
    required String name,
    required String unit,
    required double tax,
    required double totalOrdered,
    required int quantityCancel,
    int? printerType,
    ''';
  }
}

@freezed
class ProductCheckoutHistoryModel with _$ProductCheckoutHistoryModel {
  @JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
  const factory ProductCheckoutHistoryModel({
    @Default(0) int id,
    @Default('') String name,
    @Default('') @JsonKey(name: 'name_name') String nameEn,
    @Default('') String price,
    @Default('') String dollarSign,
    @Default(0) int count,
    @Default(0.0) double totalPrice,
    @Default('') String unit,
    @Default('') String tax,
    @Default('') String codeProduct,
    int? printerType,
    // dùng trong (order_histories)
    int? timesOrder,
  }) = _ProductCheckoutHistoryModel;

  factory ProductCheckoutHistoryModel.fromJson(Map<String, dynamic> json) =>
      _$ProductCheckoutHistoryModelFromJson(json);

  const ProductCheckoutHistoryModel._();
  String getNameView() => kAppLanguageLocal == AppLanguageLocal.vietnamese
      ? name
      : nameEn.trim().isEmpty
          ? name
          : nameEn;
  double getPrice() => double.tryParse(price) ?? 0.0;
  double getTax() => (double.tryParse(tax) ?? 0.0);

  // static String getModelInterface() {
  //   return '''required int id,
  //   required int quantity,
  //   required String unitPrice,
  //   required String name,
  //   required String unit,
  //   required double tax,
  //   required double totalOrdered,
  //   required int quantityCancel,
  //   int? printerType,
  //   ''';
  // }
}
