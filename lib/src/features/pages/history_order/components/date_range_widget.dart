import 'package:aladdin_franchise/src/configs/color.dart';
import 'package:aladdin_franchise/src/configs/text_style.dart';
import 'package:aladdin_franchise/src/features/pages/history_order/provider.dart';
import 'package:aladdin_franchise/src/features/pages/login/view.dart';
import 'package:aladdin_franchise/src/features/widgets/gap.dart';
import 'package:aladdin_franchise/src/utils/date_time.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HistoryDateRangeWidget extends ConsumerWidget {
  const HistoryDateRangeWidget({super.key, this.textColor});
  final Color? textColor;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var startDate =
        ref.watch(historyOrderPageProvider.select((value) => value.startDate));
    var endDate =
        ref.watch(historyOrderPageProvider.select((value) => value.endDate));
    return InkWell(
        onTap: () async {
          var dateSelect = await showDateRangePicker(
            context: context,
            firstDate: DateTime(1970, 1, 1),
            lastDate: DateTime(2100, 1, 1),
            initialDateRange: DateTimeRange(start: startDate, end: endDate),
          );
          if (dateSelect != null) {
            ref.read(historyOrderPageProvider.notifier).onChangeDate(
                startDate: dateSelect.start, endDate: dateSelect.end);
          }
        },
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            ResponsiveIconWidget(
                iconData: Icons.calendar_month, color: textColor),
            const Gap(4),
            Text(
              '${DateTimeUtils.formatToString(time: startDate, newPattern: DateTimePatterns.date)}'
              '${startDate == endDate ? '' : ' - ${DateTimeUtils.formatToString(time: endDate, newPattern: DateTimePatterns.date)}'}',
              style: AppTextStyle.regular(color: textColor),
            ),
          ],
        ));
  }
}
