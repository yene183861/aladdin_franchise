import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:aladdin_franchise/generated/l10n.dart';
import 'package:aladdin_franchise/src/configs/app.dart';
import 'package:aladdin_franchise/src/configs/color.dart';
import 'package:aladdin_franchise/src/configs/text_style.dart';
import 'package:aladdin_franchise/src/features/pages/history_order/provider.dart';
import 'package:aladdin_franchise/src/features/pages/home/provider.dart';
import 'package:aladdin_franchise/src/features/pages/home/state.dart';
import 'package:aladdin_franchise/src/features/widgets/app_error_simple.dart';
import 'package:aladdin_franchise/src/features/widgets/app_loading_simple.dart';
import 'package:aladdin_franchise/src/features/widgets/button_cancel.dart';
import 'package:aladdin_franchise/src/features/widgets/button_simple.dart';
import 'package:aladdin_franchise/src/features/widgets/custom_checkbox.dart';
import 'package:aladdin_franchise/src/features/widgets/gap.dart';
import 'package:aladdin_franchise/src/features/widgets/textfield_simple.dart';
import 'package:aladdin_franchise/src/models/customer/cusomter_portrait.dart';
import 'package:aladdin_franchise/src/models/history_order.dart';
import 'package:aladdin_franchise/src/models/product_checkout.dart';
import 'package:aladdin_franchise/src/utils/app_log.dart';
import 'package:aladdin_franchise/src/utils/app_util.dart';
import 'package:aladdin_franchise/src/utils/date_time.dart';
import 'package:aladdin_franchise/src/utils/navigator.dart';
import 'package:aladdin_franchise/src/utils/size_util.dart';
import 'package:aladdin_franchise/src/utils/text_util.dart';
import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:two_dimensional_scrollables/two_dimensional_scrollables.dart';

import 'order_detail_body.dart';

class HistoryOrderDetailDialog extends ConsumerStatefulWidget {
  const HistoryOrderDetailDialog({
    super.key,
    required this.item,
    this.completeBillAction,
  });
  final HistoryOrderModel item;

  final Future<bool> Function()? completeBillAction;
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HistoryOrderDetailDialogState();
}

class _HistoryOrderDetailDialogState extends ConsumerState<HistoryOrderDetailDialog> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(historyOrderPageProvider.notifier).getDetailOrder();
    });
  }

  @override
  Widget build(BuildContext context) {
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
              child: HistoryOrderDetailBody(item: widget.item),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ButtonCancelWidget(
                  textAction: S.current.close,
                  onPressed: () {
                    pop(context);
                  },
                ),
                if (widget.item.status == OrderStatusEnum.waiting)
                  Consumer(builder: (context, ref, child) {
                    var statusLoading = ref.watch(
                        historyOrderPageProvider.select((value) => value.getOrderDetailState));
                    if (statusLoading.status == PageCommonState.success) {
                      return ButtonSimpleWidget(
                        textAction: S.current.complete_order,
                        onPressed: () async {
                          var refreshData = await widget.completeBillAction?.call();
                          if (refreshData ?? false) {
                            pop(context);
                          }
                        },
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

class ConfirmPrintBillAgain extends StatefulWidget {
  const ConfirmPrintBillAgain({super.key, this.onSave});

  final Function(bool)? onSave;

  @override
  State<ConfirmPrintBillAgain> createState() => _ConfirmPrintBillAgainState();
}

class _ConfirmPrintBillAgainState extends State<ConfirmPrintBillAgain> {
  bool printNumberOfPeople = false;

  void _onChange() {
    setState(() {
      printNumberOfPeople = !printNumberOfPeople;
      widget.onSave?.call(printNumberOfPeople);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onChange,
      child: Row(
        children: [
          CustomCheckbox(
            onChange: _onChange,
            checked: printNumberOfPeople,
          ),
          const Gap(4),
          Flexible(child: Text(S.current.print_number_of_people)),
        ],
      ),
    );
  }
}
