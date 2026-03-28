import 'package:aladdin_franchise/generated/l10n.dart';
import 'package:aladdin_franchise/src/configs/app.dart';
import 'package:aladdin_franchise/src/configs/color.dart';
import 'package:aladdin_franchise/src/configs/text_style.dart';
import 'package:aladdin_franchise/src/features/widgets/gap.dart';
import 'package:aladdin_franchise/src/models/history_order.dart';
import 'package:aladdin_franchise/src/utils/app_util.dart';
import 'package:aladdin_franchise/src/utils/date_time.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OrderCard extends ConsumerWidget {
  const OrderCard({super.key, required this.item, this.onTap, this.onTapPrint});
  final HistoryOrderModel item;
  final VoidCallback? onTap;
  final VoidCallback? onTapPrint;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(14, 14, 14, 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(item.orderCode,
                                style: AppTextStyle.bold(
                                    rawFontSize: AppConfig.defaultRawTextSize + 1.0)),
                            const Gap(12),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                              decoration: BoxDecoration(
                                color: item.status.color.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                item.status.title,
                                style: AppTextStyle.bold(
                                    color: item.status.color,
                                    rawFontSize: AppConfig.defaultRawTextSize - 1.0),
                              ),
                            ),
                          ],
                        ),
                        const Gap(8),
                        Text(
                          '${S.current.table} ${item.tableName} • ${DateTimeUtils.formatToString(
                            time: item.timeCreated,
                            newPattern: DateTimePatterns.dateTimeNotSecond,
                          )}',
                          style: AppTextStyle.regular(color: Colors.grey[500]),
                        ),
                        if (item.coupons.isNotEmpty) ...[
                          const Gap(8),
                          Text.rich(
                            TextSpan(
                              text: 'Mã giảm: ',
                              children: [
                                TextSpan(
                                  text: item.coupons.map((e) => e.name).toList().join(', '),
                                ),
                              ],
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: AppTextStyle.regular(color: Colors.grey[500]),
                          ),
                        ],
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        AppUtils.formatCurrency(
                            value: item.price?.getTotalPriceFinal(), symbol: 'đ'),
                        style: AppTextStyle.bold(rawFontSize: AppConfig.defaultRawTextSize + 1.0)
                            .copyWith(
                          color: item.status == OrderStatusEnum.cancelled ? Colors.grey[400] : null,
                          decoration: item.status == OrderStatusEnum.cancelled
                              ? TextDecoration.lineThrough
                              : TextDecoration.none,
                          decorationColor: Colors.grey[400],
                          decorationThickness: 2,
                        ),
                      ),
                      const Gap(8),
                      Text(
                        item.orderType == AppConfig.orderOfflineValue
                            ? S.current.orderOffline
                            : S.current.orderOnline,
                        style: AppTextStyle.regular(color: Colors.grey[500]),
                      ),
                      const Gap(4),
                      if ((item.customer?.name ?? '').trim().isNotEmpty) ...[
                        const Gap(8),
                        Text(
                          '${(item.customer?.name ?? '').trim()} - ${(item.customer?.phone ?? '').trim()}',
                          style: AppTextStyle.regular(),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),
            const Divider(),
            _buildCardActions(),
          ],
        ),
      ),
    );
  }

  Widget _buildCardActions() {
    bool printAction = [OrderStatusEnum.waiting, OrderStatusEnum.completed].contains(item.status);
    return Padding(
      padding: const EdgeInsets.fromLTRB(14, 8, 8, 8),
      child: Row(
        children: [
          Expanded(
            child: InkWell(
              onTap: printAction ? onTapPrint : onTap,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (printAction) ...[
                    Icon(Icons.print_outlined, size: 16, color: Colors.grey[600]),
                    const Gap(8),
                  ],
                  Text(
                    printAction ? 'IN LẠI HÓA ĐƠN' : 'Xem chi tiết',
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Tooltip(
            message: 'Xem chi tiết',
            child: GestureDetector(
              onTap: onTap,
              child: Container(
                width: 40,
                height: 36,
                decoration: BoxDecoration(
                  color: AppColors.mainColor,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Icon(
                  Icons.chevron_right,
                  color: Colors.white,
                  size: 22,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
