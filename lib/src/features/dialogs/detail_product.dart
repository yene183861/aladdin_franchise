import 'package:aladdin_franchise/src/configs/app.dart';
import 'package:aladdin_franchise/src/configs/color.dart';
import 'package:aladdin_franchise/src/configs/text_style.dart';
import 'package:aladdin_franchise/src/data/enum/windows_method.dart';
import 'package:aladdin_franchise/src/features/dialogs/view_image.dart';
import 'package:aladdin_franchise/src/features/pages/home/provider.dart';
import 'package:aladdin_franchise/src/features/widgets/button_cir_icon_menu.dart';
import 'package:aladdin_franchise/src/features/widgets/gap.dart';
import 'package:aladdin_franchise/src/features/widgets/image.dart';
import 'package:aladdin_franchise/src/models/combo_item.dart';
import 'package:aladdin_franchise/src/models/product.dart';
import 'package:aladdin_franchise/src/utils/app_log.dart';
import 'package:aladdin_franchise/src/utils/app_util.dart';
import 'package:aladdin_franchise/src/utils/product_helper.dart';
import 'package:aladdin_franchise/src/utils/size_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../generated/l10n.dart';

void showDetailProductWidget({
  required BuildContext context,
  required WidgetRef ref,
  required ProductModel product,
}) async {
  ref.read(homeProvider.notifier).syncInfoCustomerPage(
        method: WindowsMethodEnum.detailProduct,
        arguments: product,
      );
  await showDialog(
    context: context,
    useRootNavigator: false,
    barrierDismissible: true,
    builder: (context) => DetailProductDialog(product: product),
  );

  ref.read(homeProvider.notifier).syncInfoCustomerPage(
        method: WindowsMethodEnum.detailProduct,
        arguments: null,
      );
}

class DetailProductDialog extends StatelessWidget {
  final ProductModel product;
  final bool notClose;
  const DetailProductDialog({
    Key? key,
    required this.product,
    this.notClose = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const double valueRadius = 12;
    bool smallDevice = ResponsiveBreakpoints.of(context).smallerOrEqualTo(MOBILE);
    return FractionallySizedBox(
      widthFactor: smallDevice ? 0.97 : 0.5,
      heightFactor: 0.95,
      child: AlertDialog(
        contentPadding: const EdgeInsets.all(0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(valueRadius),
        ),
        content: Stack(
          alignment: Alignment.topRight,
          children: [
            _ProductDetail(
              product: product,
              valueRadius: valueRadius,
            ),
            if (!notClose)
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

class _ProductDetail extends StatelessWidget {
  const _ProductDetail({
    this.valueRadius = 12,
    required this.product,
  });

  final double valueRadius;
  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    List<ComboItemModel>? comboItems = ProductHelper().getComboDescription(product);
    showLogs(comboItems, flags: 'comboItems');
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
                          text: AppUtils.formatCurrency(
                            value: product.unitPrice,
                            symbol: 'đ',
                          ),
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
                                child: Text(" / ${product.getUnitView()}",
                                    style: AppTextStyle.regular(
                                      color: Colors.grey,
                                      rawFontSize: AppConfig.defaultRawTextSize - 0.5,
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
                                      imageUrl: comboItem.image,
                                    );
                                  },
                                  child: AppImageCacheNetworkWidget(
                                    width: 100,
                                    height: 50,
                                    imageUrl: comboItem.image,
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
