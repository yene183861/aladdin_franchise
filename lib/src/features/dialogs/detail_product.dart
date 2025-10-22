import 'package:aladdin_franchise/src/configs/app.dart';
import 'package:aladdin_franchise/src/configs/color.dart';
import 'package:aladdin_franchise/src/configs/text_style.dart';
import 'package:aladdin_franchise/src/features/dialogs/view_image.dart';
import 'package:aladdin_franchise/src/features/widgets/button_cir_icon_menu.dart';
import 'package:aladdin_franchise/src/features/widgets/gap.dart';
import 'package:aladdin_franchise/src/features/widgets/image.dart';
import 'package:aladdin_franchise/src/models/combo_item.dart';
import 'package:aladdin_franchise/src/models/product.dart';
import 'package:aladdin_franchise/src/utils/product_helper.dart';
import 'package:aladdin_franchise/src/utils/size_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../generated/l10n.dart';

void showDetailProductWidget({
  required BuildContext context,
  required ProductModel product,
}) {
  showDialog(
    context: context,
    useRootNavigator: false,
    barrierDismissible: true,
    builder: (context) => _DetailProductWidget(
      product: product,
    ),
  );
}

class _DetailProductWidget extends StatelessWidget {
  final ProductModel product;
  const _DetailProductWidget({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const double valueRadius = 12;
    List<ComboItemModel>? comboItems = ProductHelper().getComboDescription(product);
    bool isSmallDevice = AppDeviceSizeUtil.checkSmallDevice(context);

    return FractionallySizedBox(
      widthFactor: isSmallDevice ? 0.97 : 0.5,
      heightFactor: 0.95,
      child: AlertDialog(
        contentPadding: const EdgeInsets.all(0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(valueRadius),
        ),
        content: Stack(
          alignment: Alignment.topRight,
          children: [
            ProductDetailWidget(
              product: product,
              valueRadius: valueRadius,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ButtonCirMenuWidget(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icons.close,
                color: Colors.black54,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ProductDetailWidget extends StatelessWidget {
  const ProductDetailWidget({
    super.key,
    this.valueRadius = 12,
    required this.product,
  });

  final double valueRadius;
  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    List<ComboItemModel>? comboItems = ProductHelper().getComboDescription(product);
    return SingleChildScrollView(
      child: SizedBox(
        width: double.maxFinite,
        child: Column(
          children: [
            SizedBox(
              height: 30.w,
              width: double.maxFinite,
              child: AppImageCacheNetworkWidget(
                imageUrl: product.image ?? "",
                fit: BoxFit.fitHeight,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(valueRadius),
                  topRight: Radius.circular(valueRadius),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          (product.getNameView()).toUpperCase(),
                          maxLines: 5,
                          textAlign: TextAlign.left,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyle.bold(),
                        ),
                      ),
                      const GapW(8),
                      Text.rich(
                        TextSpan(
                          text: AppConfig.formatCurrency()
                              .format(double.tryParse(product.unitPrice ?? "0")),
                          style: AppTextStyle.bold(
                            color: AppColors.redColor,
                            fontWeight: FontWeight.w600,
                            fontStyle: FontStyle.italic,
                          ),
                          children: [
                            WidgetSpan(
                              alignment: PlaceholderAlignment.middle, // dùng middle thôi
                              child: Baseline(
                                baseline: 20,
                                baselineType: TextBaseline.alphabetic,
                                child: Text(" / ${product.unit}",
                                    style: AppTextStyle.regular(
                                      color: Colors.grey,
                                      rawFontSize: AppConfig.defaultRawTextSize - 1.0,
                                    )),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    S.current.detail,
                    style: AppTextStyle.bold(
                      color: AppColors.mainColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 8),
                  comboItems == null
                      ? Html(
                          data: product.description ?? S.current.noInfo,
                        )
                      : ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: comboItems.length,
                          itemBuilder: (BuildContext context, int index) {
                            var comboItem = comboItems[index];
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: ListTile(
                                dense: true,
                                title: Text(
                                  "${comboItem.getNameView()} (${S.current.quantityCut}: ${comboItem.quantity ?? 1})",
                                  style: AppTextStyle.regular(),
                                ),
                                trailing: InkWell(
                                  onTap: () {
                                    showImageWidget(
                                      context: context,
                                      imageUrl: comboItem.image ?? '',
                                    );
                                  },
                                  child: AppImageCacheNetworkWidget(
                                    width: 100,
                                    height: 50,
                                    imageUrl: comboItem.image ?? '',
                                    memCacheHeight: 250,
                                    memCacheWidth: 350,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
