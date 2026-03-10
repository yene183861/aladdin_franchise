import 'package:aladdin_franchise/generated/l10n.dart';
import 'package:aladdin_franchise/src/configs/app.dart';
import 'package:aladdin_franchise/src/configs/text_style.dart';
import 'package:aladdin_franchise/src/core/storages/local.dart';
import 'package:aladdin_franchise/src/features/pages/checkout/provider_test.dart';
import 'package:aladdin_franchise/src/features/widgets/dialog/title_with_close_icon.dart';

import 'package:aladdin_franchise/src/features/widgets/empty_data_widget.dart';

import 'package:aladdin_franchise/src/features/widgets/gap.dart';
import 'package:aladdin_franchise/src/models/order_history.dart';
import 'package:aladdin_franchise/src/utils/date_time.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

void showHistoryOrderItemDialog(BuildContext context) async {
  await showDialog(
    context: context,
    builder: (context) {
      return const FractionallySizedBox(
        widthFactor: 0.8,
        child: _HistoryOrderItemDialog(),
      );
    },
  );
}

class _HistoryOrderItemDialog extends StatelessWidget {
  const _HistoryOrderItemDialog();

  @override
  Widget build(BuildContext context) {
    return Dialog(
        child: Column(
      children: [
        const Gap(12),
        TitleWithCloseIconDialog(
          title: S.current.order_history,
          icon: Icons.history,
          padding: const EdgeInsets.symmetric(horizontal: 16),
        ),
        Flexible(
          child: Consumer(builder: (context, ref, child) {
            var orderHistoryData =
                ref.watch(checkoutProvider.select((value) => value.orderHistory));
            var dataView = List<OrderHistory>.from(orderHistoryData);
            dataView.sort((a, b) => b.createdAt.compareTo(a.createdAt));
            if (dataView.isEmpty) {
              return const EmptyDataWidget();
            }
            return ScrollablePositionedList.separated(
              itemBuilder: (context, index) {
                var orderTime = dataView[index];
                bool isCancel = orderTime.products.any((e) => e.cancel);
                return Card(
                  elevation: 0,
                  shadowColor: Colors.white,
                  color: Colors.grey.shade50,
                  shape: RoundedRectangleBorder(
                    borderRadius: AppConfig.borderRadiusMain,
                  ),
                  child: Column(
                    children: [
                      ListTile(
                        leading: const Icon(Icons.tag),
                        tileColor: isCancel ? Colors.red.shade50 : Colors.blueGrey.shade50,
                        title: Text(
                          "${S.current.turn} ${orderTime.timesOrder} ${isCancel ? "- ${S.current.cancelDish}" : ""}",
                          style: AppTextStyle.medium(),
                        ),
                        subtitle: orderTime.notes.isEmpty
                            ? null
                            : Text(
                                orderTime.notes,
                                style: AppTextStyle.regular(color: Colors.grey),
                              ),
                        trailing: Text(
                          DateTimeUtils.formatToString(
                              time: orderTime.createdAt,
                              newPattern: DateTimePatterns.dateTimeHHmmssddMMyyyy),
                          style:
                              AppTextStyle.regular(rawFontSize: AppConfig.defaultRawTextSize - 1.0),
                        ),
                      ),
                      ...orderTime.products.map(
                        (e) => Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: ListTile(
                                  title: Text(
                                    e.getNameView(),
                                    style: AppTextStyle.medium(),
                                  ),
                                  subtitle: e.notes.isEmpty
                                      ? null
                                      : Text(
                                          e.notes,
                                          style: AppTextStyle.regular(
                                            color: Colors.grey,
                                            rawFontSize: AppConfig.defaultRawTextSize - 1.0,
                                          ),
                                        ),
                                  trailing: Text(
                                    "${S.current.quantityCut}: ${e.quantity}",
                                    style: AppTextStyle.regular(),
                                  ),
                                ),
                              ),
                              LocalStorage.getKdsStatus()
                                  ? Expanded(
                                      flex: 1,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          Text(
                                            e.cancel
                                                ? S.current.cancel
                                                : appConfig.getNameByStatus(e.status),
                                            style: AppTextStyle.medium(),
                                          ),
                                          const Gap(12),
                                        ],
                                      ),
                                    )
                                  : Container(),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
              separatorBuilder: (context, index) => const Gap(4),
              itemCount: dataView.length,
            );
          }),
        ),
      ],
    ));
  }
}
