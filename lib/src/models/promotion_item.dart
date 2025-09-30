import 'package:aladdin_franchise/src/configs/app.dart';
import 'package:aladdin_franchise/src/configs/const.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'promotion_item.freezed.dart';
part 'promotion_item.g.dart';

@freezed
class PromotionItem with _$PromotionItem {
  @JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
  const factory PromotionItem({
    required int menuItemId,
    required int quantity,
    required String idPolicy,
    @Default('0') String unitPrice,
    @Default('') String name,
    @Default('') String nameEn,
    @Default('') String namePromotion,
    @Default('') String nameEnPromotion,
  }) = _PromotionItem;

  factory PromotionItem.fromJson(Map<String, dynamic> json) =>
      _$PromotionItemFromJson(json);

  const PromotionItem._();

  double getUnitPriceNum() => double.tryParse(unitPrice) ?? 0;

  String getNameView() => kAppLanguageLocal == AppLanguageLocal.vietnamese
      ? name
      : nameEn.trim().isEmpty
          ? name
          : nameEn;

  String getNamePromotionView() =>
      kAppLanguageLocal == AppLanguageLocal.vietnamese
          ? namePromotion
          : nameEnPromotion.trim().isEmpty
              ? namePromotion
              : nameEnPromotion;
}
