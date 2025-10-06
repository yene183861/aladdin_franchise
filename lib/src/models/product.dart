import 'package:aladdin_franchise/src/configs/app.dart';
import 'package:aladdin_franchise/src/configs/const.dart';
import 'package:aladdin_franchise/src/utils/app_log.dart';
import 'package:aladdin_franchise/src/utils/language.dart';
import 'package:diacritic/diacritic.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'product.freezed.dart';
part 'product.g.dart';

@freezed
class ProductModel with _$ProductModel {
  @JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
  const factory ProductModel({
    required int id,
    @Default(-1) int categoryId,
    @Default('') String name,
    @Default('') String nameEn,
    @Default({}) Map<String, dynamic> language,
    int? printerType,
    String? slug,
    int? menuNumber,
    @Default("0") String unitPrice,
    @Default(false) bool outOfStock,
    @Default(false) bool internalUse,
    String? discountPrice,
    @Default('') String unit,
    @Default(0.0) double tax,
    String? currencyCode,
    String? image,
    String? description,

    /// dùng nội bộ
    @Default(0)
    @JsonKey(includeToJson: false, includeFromJson: false)
    int numberSelecting,

    ///
    /// dùng nội bộ
    String? noteForProcessOrder,
    List<int>? tags,
    // @Default(true) bool active,

    /// chỉ dùng nội bộ
    @Default(0)
    @JsonKey(includeToJson: false, includeFromJson: false)
    int quantityPromotion,

    // for discount
    @Default(0) @JsonKey(includeToJson: false) int unitPriceDiscount,
    @Default(0) @JsonKey(includeToJson: false) int quantityDiscount,
    @Default(0) @JsonKey(includeToJson: false) int withComboDiscount,
  }) = _ProductModel;

  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      _$ProductModelFromJson(json);

  const ProductModel._();
  String getNameView() {
    final result = AppLanguageUtils().getNameComplex(language);
    return result.isEmpty ? name : result;
  }

  String getUnitView() {
    final result = AppLanguageUtils().getUnitComplex(language);
    return result.isEmpty ? unit : result;
  }

  String getInitials(String text) {
    return text
        .split(RegExp(r'\s+'))
        .where((word) => word.isNotEmpty)
        .map((word) => word[0])
        .join();
  }

  String getShortNameView() => kAppLanguageLocal == AppLanguageLocal.vietnamese
      ? getInitials(name)
      : nameEn.trim().isEmpty
          ? getInitials(name)
          : getInitials(nameEn);
  String getSearchName() => kAppLanguageLocal == AppLanguageLocal.vietnamese
      ? removeDiacritics(name)
      : nameEn.trim().isEmpty
          ? removeDiacritics(nameEn)
          : removeDiacritics(name);
  String getSearchShortName() => getInitials(getSearchName());

  double getUnitPriceNum() => double.tryParse(unitPrice) ?? 0;

  double get getTax {
    // if (tax is double)
    return tax;
    // try {
    //   return double.tryParse(tax) ?? 0.0;
    // } catch (ex) {
    //   return 0.0;
    // }
  }

  static String getModelInterface() {
    return '''required int id,
    String? name,
    String? slug,
    int? menuNumber,
    String? unitPrice,
    String? discountPrice,
    String? currencyCode,
    String? image,
    String? description,
    @Default(0) int numberSelecting,
    String? unit,
    int? printerType,
    dynamic tax,
    required int categoryId,
    ''';
  }
}
