import 'package:aladdin_franchise/generated/l10n.dart';
import 'package:aladdin_franchise/src/configs/app.dart';
import 'package:aladdin_franchise/src/configs/color.dart';
import 'package:aladdin_franchise/src/configs/text_style.dart';
import 'package:aladdin_franchise/src/data/model/o2o/o2o_order_model.dart';
import 'package:aladdin_franchise/src/features/widgets/gap.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../provider.dart';

class OrderO2oSidebar extends ConsumerStatefulWidget {
  const OrderO2oSidebar({
    super.key,
    this.o2oData = const {},
  });
  final Map<int, Map<String, dynamic>> o2oData;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _OrderO2oSidebarState();
}

class _OrderO2oSidebarState extends ConsumerState<OrderO2oSidebar> {
  final ItemScrollController _scrollController = ItemScrollController();
  Map<int, Map<String, dynamic>> data = {};

  @override
  void initState() {
    super.initState();
    data = Map<int, Map<String, dynamic>>.from(widget.o2oData);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _onScrollList();
    });
  }

  @override
  void didUpdateWidget(covariant OrderO2oSidebar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.o2oData != oldWidget.o2oData) {
      setState(() {
        data = Map<int, Map<String, dynamic>>.from(widget.o2oData);
      });
    }
  }

  void _onScrollList() {
    List<int> tables = data.keys.toList();
    final orderIdSelect = ref.read(orderToOnlinePageProvider).orderIdSelect;
    var indexItem = tables.indexWhere((e) => e == orderIdSelect);
    if (indexItem != -1) {
      _scrollController.scrollTo(index: indexItem, duration: const Duration(milliseconds: 10));
    } else {
      ref.read(orderToOnlinePageProvider.notifier).changeOrderSelect(null);
    }
  }

  @override
  Widget build(BuildContext context) {
    List<int> orders = data.keys.toList();
    final orderIdSelect =
        ref.watch(orderToOnlinePageProvider.select((value) => value.orderIdSelect));

    bool smallDevice = ResponsiveBreakpoints.of(context).smallerOrEqualTo(MOBILE);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _onScrollList();
    });

    return ScrollablePositionedList.separated(
      scrollDirection: smallDevice ? Axis.horizontal : Axis.vertical,
      padding: smallDevice ? const EdgeInsets.symmetric(horizontal: 8, vertical: 4) : null,
      itemScrollController: _scrollController,
      itemCount: orders.length,
      itemBuilder: (context, index) {
        final orderId = orders[index];
        bool selected = orderId == orderIdSelect;
        int count = 0;
        O2OOrderModel? order;
        try {
          count = data[orderId]?['count'] ?? 0;
          order = data[orderId]?['order'] as O2OOrderModel?;
        } catch (ex) {
          //
        }

        return InkWell(
          onTap: () {
            ref.read(orderToOnlinePageProvider.notifier).changeOrderSelect(orderId);
          },
          borderRadius: AppConfig.borderRadiusMain,
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: selected ? const Color(0xFFFFEBEE) : Colors.white,
              borderRadius: AppConfig.borderRadiusMain,
              border: Border.all(
                color: selected ? AppColors.redColor : Colors.grey.shade200,
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    '${S.current.table} ${order?.tableName ?? ''}',
                    style: AppTextStyle.bold(),
                  ),
                ),
                if (count > 0)
                  CircleAvatar(
                    radius: 12,
                    backgroundColor: AppColors.redColor,
                    child: Text(
                      '$count',
                      style: AppTextStyle.bold(
                        color: Colors.white,
                        rawFontSize: AppConfig.defaultRawTextSize - 1.0,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
      separatorBuilder: (context, index) => const Gap(8),
    );
  }
}
