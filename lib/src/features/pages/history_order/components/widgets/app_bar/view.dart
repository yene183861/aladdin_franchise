import 'package:aladdin_franchise/generated/l10n.dart';
import 'package:aladdin_franchise/src/configs/app.dart';
import 'package:aladdin_franchise/src/configs/text_style.dart';
import 'package:aladdin_franchise/src/core/network/provider.dart';
import 'package:aladdin_franchise/src/features/pages/history_order/provider.dart';
import 'package:aladdin_franchise/src/features/widgets/gap.dart';
import 'package:aladdin_franchise/src/utils/app_util.dart';
import 'package:aladdin_franchise/src/utils/date_time.dart';
import 'package:aladdin_franchise/src/utils/navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_framework/responsive_framework.dart';

import 'search_field.dart';

class HistoryOrderAppBar extends ConsumerWidget {
  const HistoryOrderAppBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var color = const Color(0xff292929);
    var textColor = Colors.white;
    var secondTextColor = Color(0xFF8888AA);
    bool largerDevice = ResponsiveBreakpoints.of(context).largerThan(TABLET);
    return Container(
      color: color,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          IconButton(
            onPressed: () => pop(context),
            icon: Icon(Icons.arrow_back_rounded, color: textColor),
            hoverColor: Colors.white12,
          ),
          const Gap(12),
          DateRangeSelector(
            textColor: textColor,
            showTitlePage: true,
          ),
          const Gap(16),
          Expanded(
            child: largerDevice ? const HistorySearchField() : const SizedBox.shrink(),
          ),
          const Gap(16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text('Thành tiền:', style: TextStyle(color: secondTextColor, fontSize: 12)),
              Consumer(builder: (context, ref, child) {
                var historyOrder = ref.watch(historyOrderProvider);
                String total = historyOrder.when(
                  data: (data) {
                    var totalMoney = 0.0;
                    for (var element in data) {
                      totalMoney += element.price?.getTotalPriceFinal() ?? 0.0;
                    }

                    return AppUtils.formatCurrency(value: totalMoney);
                  },
                  error: (error, stackTrace) => '********* đ',
                  loading: () => '********* đ',
                );
                return Text(
                  total,
                  style: TextStyle(
                    color: textColor,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5,
                  ),
                );
              }),
            ],
          ),
        ],
      ),
    );
  }
}

class DateRangeSelector extends ConsumerWidget {
  const DateRangeSelector({
    super.key,
    required this.textColor,
    this.showTitlePage = false,
  });

  final Color textColor;

  final bool showTitlePage;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: showTitlePage ? EdgeInsets.zero : const EdgeInsets.fromLTRB(16, 0, 16, 8),
      child: InkWell(
        onTap: () async {
          var state = ref.read(historyOrderPageProvider);
          var dateSelect = await showDateRangePicker(
            context: context,
            firstDate: DateTime(1970, 1, 1),
            lastDate: DateTime(9999, 1, 1),
            initialDateRange: DateTimeRange(start: state.startDate, end: state.endDate),
          );
          if (dateSelect != null) {
            ref
                .read(historyOrderPageProvider.notifier)
                .onChangeDate(startDate: dateSelect.start, endDate: dateSelect.end);
          }
        },
        child: Container(
          padding: showTitlePage
              ? EdgeInsets.zero
              : const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          decoration: showTitlePage ? null : BoxDecoration(color: Colors.grey.shade100),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (showTitlePage) ...[
                Text(
                  S.current.order_of_the_day,
                  style: TextStyle(
                    color: textColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Gap(2),
              ],
              Row(
                children: [
                  Icon(Icons.calendar_today, color: textColor, size: 13),
                  const Gap(8),
                  Consumer(builder: (context, ref, child) {
                    var startDate =
                        ref.watch(historyOrderPageProvider.select((value) => value.startDate));
                    var endDate =
                        ref.watch(historyOrderPageProvider.select((value) => value.endDate));
                    return Text(
                      '${DateTimeUtils.formatToString(time: startDate, newPattern: DateTimePatterns.date)}'
                      '${startDate == endDate ? '' : ' - ${DateTimeUtils.formatToString(time: endDate, newPattern: DateTimePatterns.date)}'}',
                      style: AppTextStyle.bold(
                          color: textColor, rawFontSize: AppConfig.defaultRawTextSize - 0.5),
                    );
                  }),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
