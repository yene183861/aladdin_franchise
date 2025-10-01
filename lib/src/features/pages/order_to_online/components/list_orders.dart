import 'package:aladdin_franchise/generated/l10n.dart';
import 'package:aladdin_franchise/src/configs/app.dart';
import 'package:aladdin_franchise/src/features/pages/home/components/menu/list_product.dart';
import 'package:aladdin_franchise/src/features/pages/home/provider.dart';
import 'package:aladdin_franchise/src/features/pages/home/state.dart';
import 'package:aladdin_franchise/src/features/pages/order_to_online/provider.dart';
import 'package:aladdin_franchise/src/features/widgets/gap.dart';
import 'package:aladdin_franchise/src/models/o2o/o2o_order_model.dart';
import 'package:aladdin_franchise/src/utils/size_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:aladdin_franchise/src/configs/color.dart';
import 'package:aladdin_franchise/src/configs/text_style.dart';

class ListOrdersO2O extends ConsumerStatefulWidget {
  const ListOrdersO2O({
    super.key,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ListOrdersO2OState();
}

class _ListOrdersO2OState extends ConsumerState<ListOrdersO2O> {
  final ItemScrollController _scrollController = ItemScrollController();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final data = ref.read(orderToOnlinePageNotifier).orders;
      List<O2OOrderModel> tables = data.keys.toList();
      final orderSelect = ref.read(orderToOnlinePageNotifier).orderSelect;
      var indexItem = tables.indexWhere((e) => e.orderId == orderSelect?.orderId);
      if (indexItem != -1) {
        _scrollController.scrollTo(index: indexItem, duration: const Duration(milliseconds: 10));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final data = ref.watch(orderToOnlinePageNotifier.select((value) => value.orders));
    List<O2OOrderModel> orders = data.keys.toList();
    final orderSelect = ref.watch(orderToOnlinePageNotifier.select((value) => value.orderSelect));
    final showLoadingGetData =
        ref.watch(orderToOnlinePageNotifier.select((value) => value.showLoadingGetData));
    final getO2ODataState = ref.watch(homeProvider.select((value) => value.getO2ODataState));
    bool isSmallDevice = AppDeviceSizeUtil.checkSmallDevice(context);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final data = ref.read(orderToOnlinePageNotifier).orders;
      List<O2OOrderModel> tables = data.keys.toList();
      final orderSelect = ref.read(orderToOnlinePageNotifier).orderSelect;
      var indexItem = tables.indexWhere((e) => e.orderId == orderSelect?.orderId);
      if (indexItem != -1) {
        _scrollController.scrollTo(index: indexItem, duration: const Duration(milliseconds: 300));
      }
    });

    switch (getO2ODataState.status) {
      case PageCommonState.error:
      case PageCommonState.loading:
        if (showLoadingGetData) {
          return ScrollablePositionedList.separated(
            scrollDirection: isSmallDevice ? Axis.horizontal : Axis.vertical,
            padding: isSmallDevice ? const EdgeInsets.symmetric(horizontal: 8, vertical: 4) : null,
            itemScrollController: _scrollController,
            itemCount: 6,
            itemBuilder: (context, index) {
              if (isSmallDevice) {
                return ShimmerLoading(
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    width: 70,
                    height: 50,
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: AppConfig.borderRadiusSecond,
                    ),
                  ),
                );
              }

              return ShimmerLoading(
                child: Container(
                  // margin: const EdgeInsets.symmetric(vertical: 4),
                  width: 80,
                  height: 100,
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    // borderRadius: AppConfig.borderRadiusSecond,
                  ),
                ),
              );
            },
            separatorBuilder: (context, index) => isSmallDevice ? const Gap(8) : const Gap(4),
          );
        }
      default:
    }

    return ScrollablePositionedList.separated(
      scrollDirection: isSmallDevice ? Axis.horizontal : Axis.vertical,
      padding: isSmallDevice ? const EdgeInsets.symmetric(horizontal: 8, vertical: 4) : null,
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
            ref.read(orderToOnlinePageNotifier.notifier).changeOrderSelect(order);
          },
          child: Container(
            constraints: BoxConstraints(minHeight: isSmallDevice ? 24 : 100.0),
            padding: EdgeInsets.symmetric(
                horizontal: isSmallDevice ? 24 : 20, vertical: isSmallDevice ? 0 : 20),
            decoration: BoxDecoration(
              color: selected
                  ? (isSmallDevice ? AppColors.mainColor : Colors.grey.shade300)
                  : Colors.white,
              borderRadius: BorderRadius.circular(isSmallDevice ? 12 : 0),
              border: isSmallDevice && !selected ? Border.all(color: AppColors.mainColor) : null,
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
                          style: selected ? AppTextStyle.bold() : AppTextStyle.regular(),
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
