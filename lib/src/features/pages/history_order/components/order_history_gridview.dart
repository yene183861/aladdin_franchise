import 'package:aladdin_franchise/generated/assets.dart';
import 'package:aladdin_franchise/src/configs/app.dart';
import 'package:aladdin_franchise/src/configs/text_style.dart';
import 'package:aladdin_franchise/src/features/widgets/app_icon_widget.dart';
import 'package:aladdin_franchise/src/features/widgets/gap.dart';
import 'package:aladdin_franchise/src/models/history_order.dart';
import 'package:aladdin_franchise/src/utils/app_util.dart';
import 'package:aladdin_franchise/src/utils/date_time.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OrderHistoryGridView extends ConsumerWidget {
  const OrderHistoryGridView({
    super.key,
    this.data = const [],
    this.onTapPrintBill,
    this.onTapItem,
    this.childAspectRatio = 0.75,
  });
  final List<HistoryOrderModel> data;
  final Future<bool> Function({
    required HistoryOrderModel item,
    required BuildContext context,
    required WidgetRef ref,
    bool? completeBillAction,
  })? onTapPrintBill;

  final Function({
    required HistoryOrderModel item,
    required WidgetRef ref,
    required BuildContext context,
  })? onTapItem;
  final double childAspectRatio;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GridView.builder(
      padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 200,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        childAspectRatio: childAspectRatio,
      ),
      itemBuilder: (BuildContext context, int index) {
        var item = data[index];
        return InkWell(
          onTap: () {
            onTapItem?.call(item: item, ref: ref, context: context);
          },
          child: Card(
            color: Colors.grey.shade100,
            key: ValueKey(item.orderCode),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                        decoration: BoxDecoration(
                          // color: Colors.grey.shade200,
                          color: Colors.white,
                          borderRadius: AppConfig.borderRadiusSecond,
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      ResponsiveIconWidget(
                                        iconData: item.orderType == 1 ? null : CupertinoIcons.home,
                                        svgPath: item.orderType == 1 ? Assets.iconsTakeAway : null,
                                        color: item.orderType == 1 ? Colors.blue : Colors.orange,
                                        iconSize: 18,
                                      ),
                                      const Gap(8),
                                      Expanded(
                                        child: Text(
                                          '# ${item.tableName}',
                                          style: AppTextStyle.bold(
                                            rawFontSize: AppConfig.defaultRawTextSize - 1,
                                          ),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      const Gap(8),
                                      Text.rich(
                                        TextSpan(
                                          text: item.orderItems.length.toString(),
                                          children: [
                                            TextSpan(
                                              text: ' món',
                                              style: AppTextStyle.regular(
                                                rawFontSize: AppConfig.defaultRawTextSize - 1.5,
                                              ),
                                            ),
                                          ],
                                          style: AppTextStyle.bold(
                                            rawFontSize: AppConfig.defaultRawTextSize - 1.5,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const Gap(4),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: FittedBox(
                                          fit: BoxFit.scaleDown,
                                          child: Text(
                                            DateTimeUtils.formatToString(
                                              time: item.orderCreated,
                                              newPattern: 'dd/MM/yyyy\nHH:mm:ss',
                                            ),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: AppTextStyle.regular(
                                              rawFontSize: AppConfig.defaultRawTextSize - 1.5,
                                              color: Colors.grey.shade600,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        padding:
                                            const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                                        decoration: BoxDecoration(
                                            color: item.status.color.withOpacity(0.15),
                                            borderRadius: AppConfig.borderRadiusSecond),
                                        child: Text(
                                          item.status.title,
                                          textAlign: TextAlign.end,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: AppTextStyle.bold(
                                            color: item.status.color,
                                            rawFontSize: AppConfig.defaultRawTextSize - 1.5,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )),
                    const Gap(4),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                      width: double.maxFinite,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: AppConfig.borderRadiusSecond,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _LinePriceWidget(
                            title: 'Tổng tiền',
                            value: item.price?.totalPrice ?? 0,
                          ),
                          _LinePriceWidget(
                            title: 'Thuế',
                            value: item.price?.totalPriceTax ?? 0,
                          ),
                          _LinePriceWidget(
                            title: 'Giảm giá',
                            value: item.price?.totalPriceVoucher ?? 0,
                          ),
                          _LinePriceWidget(
                            title: 'Thành tiền',
                            value: item.price?.totalPriceFinal ?? 0,
                          ),
                        ],
                      ),
                    ),
                    const Gap(4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if ([
                          OrderStatusEnum.waiting,
                          OrderStatusEnum.completed,
                        ].contains(item.status)) ...[
                          InkWell(
                            onTap: () {
                              onTapItem?.call(
                                context: context,
                                item: item,
                                ref: ref,
                              );
                            },
                            borderRadius: AppConfig.borderRadiusSecond,
                            child: Container(
                              width: 28,
                              height: 28,
                              padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                color: Colors.grey.shade300,
                                borderRadius: AppConfig.borderRadiusSecond,
                              ),
                              child: const ResponsiveIconWidget(
                                iconData: Icons.info_outline,
                              ),
                            ),
                          ),
                          const Gap(4),
                          InkWell(
                            onTap: () {
                              onTapPrintBill?.call(
                                context: context,
                                ref: ref,
                                item: item,
                                completeBillAction: false,
                              );
                            },
                            borderRadius: AppConfig.borderRadiusSecond,
                            child: Container(
                              width: 28,
                              height: 28,
                              padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                color: Colors.grey.shade300,
                                borderRadius: AppConfig.borderRadiusSecond,
                              ),
                              child: const ResponsiveIconWidget(
                                iconData: Icons.print,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
      itemCount: data.length,
    );
  }
}

class _LinePriceWidget extends StatelessWidget {
  const _LinePriceWidget({
    super.key,
    required this.title,
    required this.value,
  });

  final String title;
  final dynamic value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          '$title: ',
          style: AppTextStyle.regular(
            rawFontSize: AppConfig.defaultRawTextSize - 1.5,
          ),
        ),
        Expanded(
          child: Text(
            AppUtils.formatCurrency(value: value, symbol: 'đ'),
            textAlign: TextAlign.right,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyle.regular(
              rawFontSize: AppConfig.defaultRawTextSize - 1.0,
            ),
          ),
        ),
      ],
    );
  }
}
