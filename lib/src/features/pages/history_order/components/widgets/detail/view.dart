import 'package:aladdin_franchise/generated/l10n.dart';
import 'package:aladdin_franchise/src/configs/app.dart';
import 'package:aladdin_franchise/src/configs/color.dart';
import 'package:aladdin_franchise/src/configs/text_style.dart';
import 'package:aladdin_franchise/src/features/pages/history_order/provider.dart';
import 'package:aladdin_franchise/src/features/pages/home/state.dart';
import 'package:aladdin_franchise/src/features/widgets/button/button_simple.dart';
import 'package:aladdin_franchise/src/features/widgets/button/close_button.dart';
import 'package:aladdin_franchise/src/features/widgets/gap.dart';
import 'package:aladdin_franchise/src/models/history_order.dart';
import 'package:aladdin_franchise/src/models/order.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'order_detail_body.dart';

class HistoryOrderDetailDialog extends ConsumerStatefulWidget {
  const HistoryOrderDetailDialog({
    super.key,
    required this.item,
  });
  final HistoryOrderModel item;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HistoryOrderDetailDialogState();
}

class _HistoryOrderDetailDialogState extends ConsumerState<HistoryOrderDetailDialog> {
  late HistoryOrderNotifier notifier = ref.read(historyOrderPageProvider.notifier);
  OrderModel? order;

  @override
  void initState() {
    super.initState();
    notifier = ref.read(historyOrderPageProvider.notifier);
    var item = widget.item;
    order = notifier.convertToOrderModel(
      id: item.orderExcute.order,
      tableName: item.tableName,
      code: item.orderCode,
      typeOrder: item.orderType,
    );
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (order != null) notifier.getDetailOrder(order!);
    });
  }

  @override
  Widget build(BuildContext context) {
    var item = widget.item;
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    '${S.current.order_detail} - ${widget.item.orderCode}',
                    style: Theme.of(context).dialogTheme.titleTextStyle,
                  ),
                ),
                const Gap(20),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
                  decoration: BoxDecoration(
                    borderRadius: AppConfig.borderRadiusMain,
                    color: widget.item.status.color,
                  ),
                  child: Text(
                    widget.item.status.title,
                    style: AppTextStyle.regular(color: AppColors.white),
                  ),
                )
              ],
            ),
            Expanded(
              child: HistoryOrderDetailBody(item: item),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const AppCloseButton(),
                Consumer(builder: (context, ref, child) {
                  var detail = ref.watch(historyOrderPageProvider.select((value) => value.detail))[
                      item.orderExcute.order];
                  var notifier = ref.read(historyOrderPageProvider.notifier);
                  if (detail?.state.status == PageCommonState.success &&
                      [OrderStatusEnum.waiting, OrderStatusEnum.completed].contains(item.status)) {
                    return Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: ButtonSimpleWidget(
                        textAction: item.status == OrderStatusEnum.waiting
                            ? S.current.complete_order
                            : 'In hoá đơn',
                        onPressed: () async {
                          if (order == null) return;
                          notifier.printReceipt(
                            requireCompleteBill: item.status == OrderStatusEnum.waiting,
                            order: order!,
                          );
                        },
                      ),
                    );
                  }
                  return const SizedBox.shrink();
                })
              ],
            ),
          ],
        ),
      ),
    );
  }
}
