import 'package:aladdin_franchise/generated/l10n.dart';
import 'package:aladdin_franchise/src/configs/app.dart';
import 'package:aladdin_franchise/src/configs/color.dart';
import 'package:aladdin_franchise/src/configs/text_style.dart';
import 'package:aladdin_franchise/src/features/dialogs/detail_product.dart';
import 'package:aladdin_franchise/src/features/dialogs/message.dart';
import 'package:aladdin_franchise/src/features/pages/home/provider.dart';
import 'package:aladdin_franchise/src/features/pages/home/components/menu/tag_view.dart';
import 'package:aladdin_franchise/src/features/widgets/gap.dart';
import 'package:aladdin_franchise/src/features/widgets/image.dart';
import 'package:aladdin_franchise/src/models/product.dart';
import 'package:aladdin_franchise/src/models/tag_product.dart';
import 'package:aladdin_franchise/src/utils/app_util.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shimmer/shimmer.dart';

class ProductBoxWidget extends ConsumerWidget {
  const ProductBoxWidget({super.key, required this.product});
  final ProductModel product;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var productsSelected =
        ref.watch(homeProvider.select((value) => value.productsSelected));
    var productsSelecting =
        ref.watch(homeProvider.select((value) => value.productsSelecting));

    int ordered = (productsSelected
            .firstWhereOrNull((e) => e.id == product.id)
            ?.numberSelecting ??
        0);

    int ordering = productsSelecting
            .firstWhereOrNull((e) => e.id == product.id)
            ?.numberSelecting ??
        0;
    var listTags = ref.watch(homeProvider.select((value) => value.tags));
    List<TagProductModel> tags = [];
    for (var element in listTags) {
      if ((product.tags ?? []).contains(element.id)) {
        tags.add(element);
      }
    }
    return InkWell(
      onTap: () async {
        if (product.outOfStock == true) return;
        if (ref.read(homeProvider).orderSelect != null) {
          ref
              .read(homeProvider.notifier)
              .addProductToCart(product: product.copyWith(numberSelecting: 1));
        }
      },
      onLongPress: () {
        showDetailProductWidget(context: context, product: product, ref: ref);
      },
      child: Stack(
        children: [
          Container(
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.grey.shade100),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: AppImageCacheNetworkWidget(
                    imageUrl: product.image ?? '',
                    fit: BoxFit.cover,
                  ),
                ),
                const Gap(8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    product.getNameView(),
                    style: AppTextStyle.bold(),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                  ),
                ),
                Text.rich(
                  TextSpan(
                    text: AppUtils.formatCurrency(
                        value: product.unitPrice, symbol: 'đ'),
                    style: AppTextStyle.bold(
                      color: AppColors.redColor,
                      fontWeight: FontWeight.w600,
                      fontStyle: FontStyle.italic,
                      rawFontSize: AppConfig.defaultRawTextSize - 1.0,
                    ),
                    children: [
                      TextSpan(
                        text: " / ${product.unit.trim()}",
                        style: AppTextStyle.regular(
                          color: Colors.grey,
                          rawFontSize: AppConfig.defaultRawTextSize - 1.0,
                        ),
                      ),
                    ],
                  ),
                ),
                const Gap(4),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Row(
                    children: [
                      if (ordered > 0)
                        Text.rich(
                          TextSpan(
                            text: 'Đã gọi: ',
                            children: [
                              TextSpan(
                                text: ordered > 1000
                                    ? '1000+'
                                    : ordered.toString(),
                              ),
                            ],
                          ),
                          style: AppTextStyle.regular(
                            rawFontSize: AppConfig.defaultRawTextSize - 1.0,
                            fontStyle: FontStyle.italic,
                            color: Colors.grey,
                          ),
                        ),
                      Expanded(
                        child: Text.rich(
                          textAlign: TextAlign.end,
                          TextSpan(
                            text: ordering > 0
                                ? '${S.current.quantityCut}: '
                                : '',
                            children: [
                              TextSpan(
                                text: ordering < 1
                                    ? ''
                                    : ordering > 1000
                                        ? '1000+'
                                        : ordering.toString(),
                                style: AppTextStyle.bold(
                                  rawFontSize:
                                      AppConfig.defaultRawTextSize - 1.0,
                                ),
                              ),
                            ],
                          ),
                          style: AppTextStyle.regular(
                            rawFontSize: AppConfig.defaultRawTextSize - 1.0,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                const Gap(4),
              ],
            ),
          ),
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: tags.map((e) => TagViewWidget(tag: e)).toList(),
          ),
          if (product.outOfStock == true) const ProductOutOfStockCircleWidget()
        ],
      ),
    );
  }
}

class ProductOutOfStockCircleWidget extends StatelessWidget {
  const ProductOutOfStockCircleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: CircleAvatar(
        backgroundColor: Colors.white54,
        radius: 50,
        child: CircleAvatar(
          radius: 46,
          backgroundColor: Colors.black54,
          child: Text(
            S.current.out_of_dish,
            style: AppTextStyle.bold(
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

class ProductBoxLoadingWidget extends ConsumerWidget {
  const ProductBoxLoadingWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      clipBehavior: Clip.hardEdge,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.grey.shade100,
      ),
      child: const Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: AppShimmerLoading(
              margin: EdgeInsets.symmetric(horizontal: 8),
              borderRadius: 12,
            ),
          ),
          Gap(12),
          AppShimmerLoading(margin: EdgeInsets.symmetric(horizontal: 8)),
          Gap(4),
          AppShimmerLoading(width: 60),
          Gap(8),
          AppShimmerLoading(margin: EdgeInsets.symmetric(horizontal: 28)),
          Gap(8),
        ],
      ),
    );
  }
}

class AppShimmerLoading extends StatelessWidget {
  const AppShimmerLoading({
    super.key,
    this.baseColor,
    this.highlightColor,
    this.width,
    this.margin,
    this.borderRadius,
    this.child,
  });

  final Color? baseColor;
  final Color? highlightColor;
  final double? width;
  final EdgeInsetsGeometry? margin;
  final double? borderRadius;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: baseColor ?? Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: child ??
          Container(
            margin: margin ?? EdgeInsets.zero,
            width: width ?? double.maxFinite,
            decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(borderRadius ?? 4)),
            child: Text(
              '',
              style: AppTextStyle.bold(),
            ),
          ),
    );
  }
}
