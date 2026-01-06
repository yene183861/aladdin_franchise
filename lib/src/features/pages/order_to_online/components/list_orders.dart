import 'package:aladdin_franchise/generated/l10n.dart';

import 'package:aladdin_franchise/src/features/pages/order_to_online/provider.dart';
import 'package:aladdin_franchise/src/features/widgets/gap.dart';
import 'package:aladdin_franchise/src/data/model/o2o/o2o_order_model.dart';
import 'package:aladdin_franchise/src/utils/size_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:aladdin_franchise/src/configs/color.dart';
import 'package:aladdin_franchise/src/configs/text_style.dart';

class ListOrdersO2O extends ConsumerStatefulWidget {
  const ListOrdersO2O({
    super.key,
    this.o2oData = const {},
  });

  final Map<O2OOrderModel, Map<String, dynamic>> o2oData;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ListOrdersO2OState();
}

class _ListOrdersO2OState extends ConsumerState<ListOrdersO2O> {
  final ItemScrollController _scrollController = ItemScrollController();
  Map<O2OOrderModel, Map<String, dynamic>> data = {};
  @override
  void initState() {
    super.initState();
    data = Map<O2OOrderModel, Map<String, dynamic>>.from(widget.o2oData);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      List<O2OOrderModel> tables = data.keys.toList();
      final orderSelect = ref.read(orderToOnlinePageProvider).orderSelect;
      var indexItem =
          tables.indexWhere((e) => e.orderId == orderSelect?.orderId);
      if (indexItem != -1) {
        _scrollController.scrollTo(
            index: indexItem, duration: const Duration(milliseconds: 10));
      } else {
        ref.read(orderToOnlinePageProvider.notifier).changeOrderSelect(null);
      }
    });
  }

  @override
  void didUpdateWidget(covariant ListOrdersO2O oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.o2oData != oldWidget.o2oData) {
      setState(() {
        data = Map<O2OOrderModel, Map<String, dynamic>>.from(widget.o2oData);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    List<O2OOrderModel> orders = data.keys.toList();
    final orderSelect = ref
        .watch(orderToOnlinePageProvider.select((value) => value.orderSelect));

    bool isSmallDevice = AppDeviceSizeUtil.checkSmallDevice(context);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      List<O2OOrderModel> tables = data.keys.toList();
      final orderSelect = ref.read(orderToOnlinePageProvider).orderSelect;
      var indexItem =
          tables.indexWhere((e) => e.orderId == orderSelect?.orderId);
      if (indexItem != -1) {
        _scrollController.scrollTo(
            index: indexItem, duration: const Duration(milliseconds: 300));
      } else {
        ref.read(orderToOnlinePageProvider.notifier).changeOrderSelect(null);
      }
    });

    // switch (getO2ODataState.status) {
    //   case PageCommonState.error:
    //   case PageCommonState.loading:
    //     if (showLoadingGetData) {
    //       return ScrollablePositionedList.separated(
    //         scrollDirection: isSmallDevice ? Axis.horizontal : Axis.vertical,
    //         padding: isSmallDevice
    //             ? const EdgeInsets.symmetric(horizontal: 8, vertical: 4)
    //             : null,
    //         itemScrollController: _scrollController,
    //         itemCount: 6,
    //         itemBuilder: (context, index) {
    //           if (isSmallDevice) {
    //             return ShimmerLoading(
    //               child: Container(
    //                 margin: const EdgeInsets.symmetric(vertical: 4),
    //                 width: 70,
    //                 height: 50,
    //                 decoration: BoxDecoration(
    //                   color: AppColors.white,
    //                   borderRadius: AppConfig.borderRadiusSecond,
    //                 ),
    //               ),
    //             );
    //           }

    //           return ShimmerLoading(
    //             child: Container(
    //               // margin: const EdgeInsets.symmetric(vertical: 4),
    //               width: 80,
    //               height: 100,
    //               decoration: BoxDecoration(
    //                 color: AppColors.white,
    //                 // borderRadius: AppConfig.borderRadiusSecond,
    //               ),
    //             ),
    //           );
    //         },
    //         separatorBuilder: (context, index) =>
    //             isSmallDevice ? const Gap(8) : const Gap(4),
    //       );
    //     }
    //   default:
    // }

    return ScrollablePositionedList.separated(
      scrollDirection: isSmallDevice ? Axis.horizontal : Axis.vertical,
      padding: isSmallDevice
          ? const EdgeInsets.symmetric(horizontal: 8, vertical: 4)
          : null,
      itemScrollController: _scrollController,
      itemCount: orders.length,
      itemBuilder: (context, index) {
        final order = orders[index];
        bool selected = order == orderSelect;
        int count = 0;
        try {
          count = data[order]?['count'] ?? 0;
        } catch (ex) {
          //
        }
        return InkWell(
          onTap: () {
            ref
                .read(orderToOnlinePageProvider.notifier)
                .changeOrderSelect(order);
          },
          child: Container(
            constraints: BoxConstraints(minHeight: isSmallDevice ? 24 : 100.0),
            padding: EdgeInsets.symmetric(
                horizontal: isSmallDevice ? 24 : 20,
                vertical: isSmallDevice ? 0 : 20),
            decoration: BoxDecoration(
              color: selected
                  ? (isSmallDevice ? AppColors.mainColor : Colors.grey.shade300)
                  : Colors.white,
              borderRadius: BorderRadius.circular(isSmallDevice ? 12 : 0),
              border: isSmallDevice && !selected
                  ? Border.all(color: AppColors.mainColor)
                  : null,
            ),
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                isSmallDevice
                    ? Text(
                        '${S.current.table} ${order.tableName}',
                        style: selected
                            ? AppTextStyle.bold(color: Colors.white)
                            : AppTextStyle.regular(),
                      )
                    : Flexible(
                        child: Text(
                          '${S.current.table} ${order.tableName}',
                          style: selected
                              ? AppTextStyle.bold()
                              : AppTextStyle.regular(),
                        ),
                      ),
                if (count > 0) ...[
                  const GapW(6),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.redColor,
                    ),
                    child: Text(
                      count <= 99 ? count.toString() : '99+',
                      style: AppTextStyle.bold(color: Colors.white),
                    ),
                  ),
                ]
              ],
            ),
          ),
        );
      },
      separatorBuilder: (context, index) => isSmallDevice
          ? const Gap(8)
          : Divider(
              height: 1,
              color: Colors.grey.shade200,
            ),
    );
  }
}
