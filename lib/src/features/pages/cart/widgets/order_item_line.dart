import 'dart:math';

import 'package:aladdin_franchise/generated/l10n.dart';
import 'package:aladdin_franchise/src/configs/app.dart';
import 'package:aladdin_franchise/src/configs/color.dart';
import 'package:aladdin_franchise/src/configs/dev_config.dart';
import 'package:aladdin_franchise/src/configs/text_style.dart';
import 'package:aladdin_franchise/src/features/pages/cart/provider.dart';
import 'package:aladdin_franchise/src/features/pages/home/components/menu/view.dart';
import 'package:aladdin_franchise/src/features/widgets/button/icon_button.dart';
import 'package:aladdin_franchise/src/features/widgets/gap.dart';
import 'package:aladdin_franchise/src/features/widgets/image.dart';
import 'package:aladdin_franchise/src/features/widgets/textfield_simple.dart';
import 'package:aladdin_franchise/src/models/product.dart';
import 'package:aladdin_franchise/src/utils/app_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CartOrderLine extends ConsumerWidget {
  const CartOrderLine({
    super.key,
    required this.item,
    this.allowEnterNote = false,
    this.onTap,
    this.selected = false,
  });

  final ProductModel item;
  final bool allowEnterNote;

  final Function(ProductModel)? onTap;

  final bool selected;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool newUI = DevConfig.newUI;
    // var lockedOrder = ref.watch(homeProvider.select((value) => value.lockedOrder));
    return InkWell(
      onTap: () {
        onTap?.call(item);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: selected ? Colors.blue : Colors.grey.shade200, width: 1.5),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: allowEnterNote ? CrossAxisAlignment.start : CrossAxisAlignment.center,
          children: [
            AppImageCacheNetworkWidget(
              imageUrl: item.image ?? '',
              width: 50,
              height: 50,
              borderRadius: BorderRadius.circular(12),
            ),
            const Gap(8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            Flexible(
                                fit: allowEnterNote ? FlexFit.loose : FlexFit.tight,
                                child: Text(
                                  item.getNameView(),
                                  style: AppTextStyle.bold(),
                                )),
                            if (!newUI) ...[
                              const Gap(8),
                              Text.rich(
                                TextSpan(
                                  children: [
                                    if (allowEnterNote) const TextSpan(text: '( '),
                                    TextSpan(
                                      text: AppUtils.formatCurrency(
                                          value: double.tryParse(item.unitPrice) ?? 0, symbol: 'đ'),
                                      style: AppTextStyle.bold(
                                        rawFontSize: AppConfig.defaultRawTextSize - 0.5,
                                      ),
                                    ),
                                    const TextSpan(text: ' / '),
                                    TextSpan(
                                      text: item.getUnitView(),
                                    ),
                                    if (allowEnterNote) const TextSpan(text: ' )'),
                                  ],
                                  style: AppTextStyle.medium(
                                    color: Colors.grey,
                                    rawFontSize: AppConfig.defaultRawTextSize - 1.5,
                                  ),
                                ),
                              ),
                            ] else
                              Text(
                                AppUtils.formatCurrency(
                                    value: (double.tryParse(item.unitPrice) ?? 0) *
                                        (item.numberSelecting - item.quantityPromotion),
                                    symbol: 'đ'),
                                style: AppTextStyle.bold(
                                  color: AppColors.mainColor,
                                  rawFontSize: AppConfig.defaultRawTextSize - 0.5,
                                ),
                              ),
                          ],
                        ),
                      ),
                      if (allowEnterNote) _totalAmount(),
                    ],
                  ),
                  const Gap(8),
                  if (newUI) ...[
                    Text(
                      'x${item.numberSelecting} ${item.getUnitView()}',
                      style: AppTextStyle.regular(
                        color: Colors.grey.shade400,
                        rawFontSize: AppConfig.defaultRawTextSize - 0.5,
                      ),
                    ),
                    const Gap(4),
                    Row(
                      children: [
                        AppIconButton(
                          icon: Icons.remove,
                          borderRadius: BorderRadius.circular(12),
                          onTap: () {
                            ref.read(cartPageProvider.notifier).addProductToCart(
                                item.copyWith(numberSelecting: max(0, item.numberSelecting - 1)));
                          },
                        ),
                        // _qtyButton(
                        //   Icons.remove,
                        //   () {
                        //     ref.read(cartPageProvider.notifier).addProductToCart(
                        //         item.copyWith(numberSelecting: max(0, item.numberSelecting - 1)));
                        //   },
                        // ),
                        // Container(
                        //   padding: const EdgeInsets.symmetric(horizontal: 8),
                        //   width: 40 + 8 * 2,
                        //   alignment: Alignment.center,
                        //   child: AppTextFormField(
                        //     initialValue: item.numberSelecting.toString(),
                        //     textAlign: TextAlign.center,
                        //     fillColor: Colors.transparent,
                        //     contentPadding: EdgeInsets.zero,
                        //     maxLength: 2,
                        //     minLines: 1,
                        //     maxLines: 1,
                        //   ),
                        // ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Text(
                            item.numberSelecting.toString(),
                            style: AppTextStyle.bold(),
                          ),
                        ),
                        AppIconButton(
                          icon: Icons.add,
                          borderRadius: BorderRadius.circular(12),
                          onTap: () {
                            ref.read(cartPageProvider.notifier).addProductToCart(
                                item.copyWith(numberSelecting: max(0, item.numberSelecting + 1)));
                          },
                        ),
                        // _qtyButton(
                        //   Icons.add,
                        //   () {
                        //     ref.read(cartPageProvider.notifier).addProductToCart(
                        //         item.copyWith(numberSelecting: max(0, item.numberSelecting + 1)));
                        //   },
                        // ),
                      ],
                    ),
                  ] else ...[
                    IntrinsicHeight(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: allowEnterNote
                                ? AppTextFormField(
                                    key: ValueKey(item.id),
                                    contentPadding:
                                        const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                    hintText: S.current.note,
                                    initialValue: item.note,
                                    onChanged: (value) {
                                      ref.read(cartPageProvider.notifier).onChangeNoteProduct(
                                            item.id,
                                            value.trim(),
                                          );
                                    },
                                  )
                                : _totalAmount(),
                          ),
                          const Gap(12),
                          Container(
                            decoration: BoxDecoration(
                              color: const Color(0xFFf1f4fa),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: Colors.grey.shade300),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 8,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                _qtyButton(
                                  Icons.remove,
                                  () {
                                    ref.read(cartPageProvider.notifier).addProductToCart(
                                        item.copyWith(
                                            numberSelecting: max(0, item.numberSelecting - 1)));
                                  },
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8),
                                  child: Text(
                                    item.numberSelecting.toString(),
                                    style: AppTextStyle.bold(),
                                  ),
                                ),
                                _qtyButton(
                                  Icons.add,
                                  () {
                                    ref.read(cartPageProvider.notifier).addProductToCart(
                                        item.copyWith(
                                            numberSelecting: max(0, item.numberSelecting + 1)));
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _totalAmount() {
    return Text.rich(TextSpan(children: [
      TextSpan(
        text: '${S.current.total_amount}:  ',
        style: AppTextStyle.medium(
          color: Colors.grey,
          rawFontSize: AppConfig.defaultRawTextSize - 1.5,
        ),
      ),
      TextSpan(
        text: AppUtils.formatCurrency(
            value: (double.tryParse(item.unitPrice) ?? 0) *
                (item.numberSelecting - item.quantityPromotion),
            symbol: 'đ'),
        style: AppTextStyle.bold(
          color: AppColors.mainColor,
          rawFontSize: AppConfig.defaultRawTextSize - 0.5,
        ),
      ),
    ]));
  }

  Widget _qtyButton(IconData icon, VoidCallback onTap) {
    return InkWell(
      borderRadius: BorderRadius.circular(8),
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(1),
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, size: 16),
      ),
    );
  }
}
