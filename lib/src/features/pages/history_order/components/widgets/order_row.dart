import 'package:aladdin_franchise/generated/l10n.dart';
import 'package:aladdin_franchise/src/configs/app.dart';
import 'package:aladdin_franchise/src/configs/text_style.dart';
import 'package:aladdin_franchise/src/features/pages/history_order/components/data/item_column_enum.dart';
import 'package:aladdin_franchise/src/features/pages/home/components/menu/widgets/product_box.dart';
import 'package:aladdin_franchise/src/features/widgets/button/icon_button.dart';
import 'package:aladdin_franchise/src/models/history_order.dart';
import 'package:aladdin_franchise/src/utils/app_util.dart';
import 'package:aladdin_franchise/src/utils/date_time.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OrderRow extends ConsumerWidget {
  final HistoryOrderModel item;
  final List<HistoryItemColumnEnum> columns;
  final Color bgColor;
  final bool isTitleColumn;
  final TextStyle style;
  final VoidCallback? onTap;
  final VoidCallback? onTapPrint;

  final bool loading;
  final bool isEven;
  const OrderRow({
    super.key,
    required this.item,
    required this.bgColor,
    required this.columns,
    this.isTitleColumn = false,
    required this.style,
    this.onTap,
    this.loading = false,
    this.isEven = false,
    this.onTapPrint,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var json = item.toJson();
    if (loading) {
      return SizedBox(height: 56, child: isEven ? const AppShimmerLoading() : Container());
    }

    return InkWell(
      onTap: isTitleColumn ? null : onTap,
      child: Container(
        color: bgColor,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            ...columns.map((e) {
              if (isTitleColumn) {
                if (e == HistoryItemColumnEnum.order_type) {
                  return Expanded(
                    flex: e.flex,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(e.title, style: style, textAlign: e.align),
                    ),
                  );
                }

                return Expanded(
                  flex: e.flex,
                  child: Text(e.title, style: style, textAlign: e.align),
                );
              }
              String title = '';
              switch (e) {
                case HistoryItemColumnEnum.order_status:
                  return Expanded(
                    flex: e.flex,
                    child: Wrap(
                      spacing: 6,
                      runSpacing: 6,
                      children: [
                        _StatusBadge(status: item.status),
                        if ([OrderStatusEnum.waiting, OrderStatusEnum.completed]
                                .contains(item.status) &&
                            ((item.price?.getTotalPriceFinal() ?? 0) > 0)) ...[
                          AppIconButton(
                            icon: Icons.print_outlined,
                            padding: const EdgeInsets.all(4),
                            iconSize: 16,
                            onTap: onTapPrint,
                          ),
                        ],
                      ],
                    ),
                  );
                case HistoryItemColumnEnum.customer:
                  title = ((item.customer?.name ?? '').trim().isEmpty &&
                          (item.customer?.phone ?? '').trim().isEmpty)
                      ? ''
                      : '${(item.customer?.name ?? '').trim()} ${(item.customer?.phone ?? '').trim()}';
                  break;
                case HistoryItemColumnEnum.coupons:
                  title = item.coupons.map((e) => e.name).toList().join(', ');
                  break;
                case HistoryItemColumnEnum.price:
                  title = AppUtils.formatCurrency(value: item.price?.getTotalPriceFinal());
                  break;
                case HistoryItemColumnEnum.order_type:
                  title = item.orderType == AppConfig.orderOfflineValue
                      ? S.current.orderOffline
                      : S.current.orderOnline;
                  return Expanded(
                    flex: e.flex,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(title, style: style, textAlign: e.align),
                    ),
                  );

                case HistoryItemColumnEnum.order_created:
                  title = DateTimeUtils.formatToString(
                    time: item.timeCreated,
                    newPattern: DateTimePatterns.dateTimeNotSecond,
                  );
                  break;
                default:
                  title = (json[e.name] ?? '').toString();
              }
              return Expanded(
                flex: e.flex,
                child: Padding(
                  padding: const EdgeInsets.only(left: 0.0),
                  child: Text(
                    title,
                    style: style,
                    textAlign: e.align,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}

class _StatusBadge extends StatelessWidget {
  final OrderStatusEnum status;
  const _StatusBadge({required this.status});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      decoration: BoxDecoration(
        color: status.color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: status.color.withOpacity(0.5),
          width: 1,
        ),
      ),
      child: Text(status.title, style: AppTextStyle.semiBold(color: status.color)),
    );
  }
}
