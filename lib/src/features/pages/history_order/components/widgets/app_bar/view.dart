import 'package:aladdin_franchise/generated/l10n.dart';
import 'package:aladdin_franchise/src/core/network/provider.dart';
import 'package:aladdin_franchise/src/features/pages/history_order/provider.dart';
import 'package:aladdin_franchise/src/features/widgets/gap.dart';
import 'package:aladdin_franchise/src/features/widgets/textfield_simple.dart';
import 'package:aladdin_franchise/src/utils/app_util.dart';
import 'package:aladdin_franchise/src/utils/date_time.dart';
import 'package:aladdin_franchise/src/utils/navigator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HistoryOrderAppBar extends ConsumerStatefulWidget {
  const HistoryOrderAppBar({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HistoryOrderAppBarState();
}

class _HistoryOrderAppBarState extends ConsumerState<HistoryOrderAppBar> {
  late TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var color = const Color(0xff292929);
    var textColor = Colors.white;
    var secondTextColor = Color(0xFF8888AA);
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
          InkWell(
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  S.current.order_of_the_day,
                  style: TextStyle(
                    color: textColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Gap(2),
                Row(
                  children: [
                    Icon(Icons.calendar_today, color: textColor, size: 13),
                    const Gap(4),
                    Consumer(builder: (context, ref, child) {
                      var startDate =
                          ref.watch(historyOrderPageProvider.select((value) => value.startDate));
                      var endDate =
                          ref.watch(historyOrderPageProvider.select((value) => value.endDate));
                      return Text(
                        '${DateTimeUtils.formatToString(time: startDate, newPattern: DateTimePatterns.date)}'
                        '${startDate == endDate ? '' : ' - ${DateTimeUtils.formatToString(time: endDate, newPattern: DateTimePatterns.date)}'}',
                        style: TextStyle(color: textColor, fontSize: 12),
                      );
                    }),
                  ],
                ),
              ],
            ),
          ),
          const Gap(16),
          Expanded(
            child: Consumer(builder: (context, ref, child) {
              var search = ref.watch(historyOrderPageProvider.select((value) => value.textSearch));
              return AppTextFormField(
                hintText: S.current.search_order_history,
                textController: controller,
                contentPadding: const EdgeInsets.symmetric(vertical: 2, horizontal: 12),
                prefixIcon: const Icon(CupertinoIcons.search),
                suffixIcon: search.trim().isEmpty
                    ? null
                    : GestureDetector(
                        onTap: () {
                          controller.text = '';
                          FocusManager.instance.primaryFocus?.unfocus();
                          ref.read(historyOrderPageProvider.notifier).onChangeTextSearch('');
                        },
                        child: const Icon(CupertinoIcons.clear),
                      ),
                onChanged: (value) {
                  ref.read(historyOrderPageProvider.notifier).onChangeTextSearch(value);
                },
              );
            }),
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
